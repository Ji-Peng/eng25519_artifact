/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "eng25519_md_identity_meth.h"

#include <openssl/crypto.h>  // OPENSSL_malloc*
#include <openssl/evp.h>
#include <string.h>  // memcpy

#include "debug/debug.h"
#include "ossl/ossl_compat.h"

#define MD_IDENTITY_DATA_INIT_LEN 2048

#ifdef OPENSSL_V102_COMPAT
/* OpenSSL versions before 1.1.0 do not zero md_data after malloc, so we check
 * the len field to make sure it is a multiple of the initial length */
#    define MD_DATA_VALID_LEN_FIELD(d)              \
        (((d->len) >= MD_IDENTITY_DATA_INIT_LEN) && \
         (((d->len) & (MD_IDENTITY_DATA_INIT_LEN - 1)) == 0))
#else
#    define MD_DATA_VALID_LEN_FIELD(d) 1
#endif

/** allocate memory for MD_IDENTITY_DATA */
static int md_identity_init(EVP_MD_CTX *ctx)
{
    verbose("CALLED\n");
    MD_IDENTITY_DATA *data = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(ctx);

    if (data == NULL) {
        // the internal data is preallocated by OpenSSL, with the size
        // specified by EVP_MD_meth_set_app_datasize()
        errorf("EVP_MD_CTX_md_data should never be NULL\n");
        return 0;
    }

    if (data->m != NULL && MD_DATA_VALID_LEN_FIELD(data)) {
        debug("Pre-existing data in md_data\n");
        OPENSSL_clear_free(data->m, data->offset);
    }

    data->m = OPENSSL_zalloc(MD_IDENTITY_DATA_INIT_LEN);
    if (data->m == NULL) {
        errorf("failed to allocate MD_IDENTITY_DATA buffer\n");
        return 0;
    }
    data->len = MD_IDENTITY_DATA_INIT_LEN;
    data->offset = 0;
    return 1;
}

/**
 * 1) check len of MD_IDENTITY_DATA.
 * 2) just copy the data into MD_IDENTITY_DATA.
 */
static int md_identity_update(EVP_MD_CTX *ctx, const void *data, size_t count)
{
    verbose("CALLED\n");
    char do_realloc = 0;

    MD_IDENTITY_DATA *d = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(ctx);
    if (d == NULL) {
        errorf("EVP_MD_CTX_md_data should never be NULL\n");
        return 0;
    }

    // debug("before realloc: d->offset=%llu, count=%lu, d->len=%llu\n", d->offset, count,
    //       d->len);

    while ((d->offset + count) > d->len) {
        do_realloc = 1;
        d->len <<= 1;
    }
    if (do_realloc != 0) {
        d->m = OPENSSL_clear_realloc(d->m, d->offset, d->len);
        if (d->m == NULL) {
            errorf("OPENSSL_clear_realloc failed\n");
            return 0;
        }
    }
    // debug("after realloc: d->offset=%llu, count=%lu, d->len=%llu\n", d->offset, count,
    //       d->len);
    memcpy(d->m + d->offset, data, count);
    d->offset += count;
    return 1;
}

/**
 * The output buffer (md) is externally allocated and limited to
 * EVP_MAX_MD_SIZE, to work around this limitation we use the output buffer to
 * return a MD_IDENTITY_DATA structure.
 */
static int md_identity_final(EVP_MD_CTX *ctx, unsigned char *md)
{
    (void)ctx;
    (void)md;
    errorf("this function should never be called\n");
    return 0;
}

static int md_identity_cleanup(EVP_MD_CTX *ctx)
{
    verbose("CALLED\n");
    MD_IDENTITY_DATA *data = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(ctx);
    if (data == NULL) {
        // the internal data is preallocated by OpenSSL, with the size
        // specified by EVP_MD_meth_set_app_datasize()
        errorf("EVP_MD_CTX_md_data should never be NULL\n");
        return 0;
    }

    if (data->m != NULL) {
        OPENSSL_clear_free(data->m, data->offset);
    }
    data->m = NULL;
    data->len = 0;
    data->offset = 0;

    return 1;
}

static int md_identity_copy(EVP_MD_CTX *to, const EVP_MD_CTX *from)
{
    verbose("CALLED\n");
    MD_IDENTITY_DATA *sdata = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(from);
    MD_IDENTITY_DATA *ddata = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(to);

    if (sdata == NULL || ddata == NULL) {
        // the internal data is preallocated by OpenSSL, with the size
        // specified by EVP_MD_meth_set_app_datasize()
        errorf("EVP_MD_CTX_md_data should never be NULL\n");
        return 0;
    }
    if (sdata == ddata) {
        errorf("EVP_MD_CTX should never share the inner data\n");
        return 0;
    }

    if (ddata->m != sdata->m && ddata->m == NULL) {
        md_identity_cleanup(to);
    }

    /** copy the values of offset and len*/
    *ddata = *sdata;
    ddata->m = OPENSSL_malloc(ddata->len);
    if (ddata->m == NULL) {
        errorf("OPENSSL_malloc() failed\n");
        return 0;
    }
    memcpy(ddata->m, sdata->m, sdata->offset);

    /**
     * Why do I set sdata->offset to 0?
     * If not:
     * - I try to benchmark our engine using `openssl speed -engine eng25519 eddsa`.
     * - I found that the ed25519-verify failed.
     * - Let us explore the reasons of the failure.
     * - After reading openssl/apps/speed.c, I summarized the following code sequence:
     * - EVP_MD_CTX *md_ctx = EVP_MD_CTX_new(); EVP_DigestSign(md_ctx,tbslen=20);
     * EVP_DigestSign(md_ctx,tbslen=20); EVP_DigestSign(md_ctx,tbslen=20); ...
     * - I found that md_ctx->md_data->offset+=20 is done each time the EVP_DigestSign is
     * called through print the value of d->offset in md_identity_update function.
     * - Therefore, the i-th EVP_DigestSign call above actually signs data with a length
     * of 20*i bytes. This is contrary to our intention, we originally wanted to sign only
     * 20 bytes of data at a time.
     *
     * It seems that I have to set md_ctx->md_data->offset to 0 after the sign is
     * done.　However it does not work, because in the line 132-140 of
     * openssl/crypto/evp/m_sigver.c, the openssl copies a EVP_MD_CTX *tmp_ctx from md_ctx
     * for calling pmeth->signctx(tmp_ctx->pctx,...). Therefore, we actually set the
     * tmp_ctx->md_data->offset to 0 instead of md_ctx->md_data->offset.
     *
     * In the end, I set sdata->offset to 0 in this function. Considering the fact that
     * when openssl copies tmp_ctx from md_ctx this function will be called.
     * sdata->offset=0 will really set md_ctx->md_data->offset to 0.
     */
    sdata->offset = 0;

    return 1;
}

void eng25519_register_md_identity(EVP_MD *md)
{
    verbose("CALLED\n");
    //    int EVP_MD_meth_set_input_blocksize(EVP_MD *md, int blocksize);

    // We return a MD_IDENTITY_DATA struct pointer to workaround the
    // limitation of EVP_MAX_MD_SIZE for the result of a message digest
    if (!EVP_MD_meth_set_result_size(md, sizeof(MD_IDENTITY_DATA))) {
        errorf("EVP_MD_meth_set_result_size() failed\n");
    }

    // set the size of the internal data buffer
    if (!EVP_MD_meth_set_app_datasize(md, sizeof(MD_IDENTITY_DATA))) {
        errorf("EVP_MD_meth_set_app_datasize() failed\n");
    }

#if 0
    // TODO: study EVP_MD_FLAG_ONESHOT
    // int EVP_MD_meth_set_flags(EVP_MD *md, unsigned long flags);
    if ( !EVP_MD_meth_set_flags(md, EVP_MD_FLAG_ONESHOT) ) {
        errorf("EVP_MD_meth_set_flags() failed\n");
    }
#endif

    if (!EVP_MD_meth_set_init(md, md_identity_init)) {
        errorf("EVP_MD_meth_set_init() failed\n");
    }

    if (!EVP_MD_meth_set_update(md, md_identity_update)) {
        errorf("EVP_MD_meth_set_update() failed\n");
    }

    if (!EVP_MD_meth_set_final(md, md_identity_final)) {
        errorf("EVP_MD_meth_set_final() failed\n");
    }

    if (!EVP_MD_meth_set_copy(md, md_identity_copy)) {
        errorf("EVP_MD_meth_set_copy() failed\n");
    }

    if (!EVP_MD_meth_set_cleanup(md, md_identity_cleanup)) {
        errorf("EVP_MD_meth_set_cleanup() failed\n");
    }

    //    int EVP_MD_meth_set_ctrl(EVP_MD *md, int (*ctrl)(EVP_MD_CTX *ctx, int
    //    cmd, int p1, void *p2));
}