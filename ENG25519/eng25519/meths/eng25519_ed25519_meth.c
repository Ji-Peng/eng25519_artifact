/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "meths/eng25519_ed25519_meth.h"

#include <openssl/crypto.h>
#include <openssl/ec.h>
#include <openssl/err.h>
#include <string.h>

#include "debug/debug.h"
#include "eng25519_keypair.h"
#include "meths/eng25519_md_identity_meth.h"
#include "ossl/eng25519_err.h"
#include "ossl/eng25519_objects.h"
#include "ossl/ossl_compat.h"
#include "providers/api/curve25519.h"

typedef ENG25519_KEYPAIR Ed25519_KEYPAIR;

#define ed25519_keypair_new(flags) eng25519_keypair_new(NID_ED25519, (flags))
#define ed25519_keypair_free(kp) eng25519_keypair_free((kp))

int ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk)
{
    verbose("CALLED\n");
    return eng25519_prov_ed25519_sk_to_pk(pk, sk);
}

static int ed25519_keygen(EVP_PKEY_CTX *ctx, EVP_PKEY *pkey)
{
    verbose("CALLED\n");
    (void)ctx;
    Ed25519_KEYPAIR *kp = NULL;

    kp = ed25519_keypair_new(NO_FLAG);
    if (eng25519_keypair_is_invalid_private(kp)) {
        ENG25519err(ENG25519_F_ED25519_KEYGEN, ENG25519_R_INVALID_PRIVATE_KEY);
        return 0;
    }

    if (eng25519_prov_ed25519_keygen(kp) != 1) {
        ENG25519err(ENG25519_F_ED25519_KEYGEN,
                    ENG25519_R_IMPLEMENTATION_BACKEND_UNEXPECTED_RETURN);
        goto err;
    }

    EVP_PKEY_assign(pkey, NID_ED25519, kp);
    return 1;
err:
    if (kp)
        ed25519_keypair_free(kp);
    return 0;
}

static int ed25519_ctrl(EVP_PKEY_CTX *ctx, int type, int p1, void *p2)
{
    (void)ctx;
    (void)p1;
    int md_nid;
    const char *type_str = "";
    switch (type) {
        case EVP_PKEY_CTRL_MD:
            type_str = "EVP_PKEY_CTRL_MD";
            debug("%s (EVP_MD_type: %d)\n", type_str, EVP_MD_type((const EVP_MD *)p2));

            md_nid = EVP_MD_nid(p2);
            if (md_nid == NID_identity_md) {
                return 1;
            }
            errorf("%s: unsupported message digest '%s'\n", type_str, OBJ_nid2ln(md_nid));
            return 0;

        case EVP_PKEY_CTRL_DIGESTINIT:
            type_str = "EVP_PKEY_CTRL_DIGESTINIT";
            debug("%s\n", type_str);
            break;
            ;

        default:
            warn("UNSUPPORTED operation (type=%d).\n", type);
            return -2;
    }
    verbose("STUB (type=%s).\n", type_str);
    return 1;
}

static int ed25519_sign(EVP_PKEY_CTX *ctx, uint8_t *sig, size_t *siglen,
                        const uint8_t *tbs, size_t tbslen)
{
    verbose("CALLED\n");
    const EVP_PKEY *_pkey = NULL;
    const Ed25519_KEYPAIR *kp = NULL;

#ifdef PRINT_CC
    uint64_t start = cycles_now();
#endif

    _pkey = EVP_PKEY_CTX_get0_pkey(ctx);
    if (_pkey == NULL) {
        ENG25519err(ENG25519_F_ED25519_SIGN, ENG25519_R_KEYS_NOT_SET);
        return -1;
    }
    kp = EVP_PKEY_get0(_pkey);
    if (eng25519_keypair_is_invalid_private(kp)) {
        ENG25519err(ENG25519_F_ED25519_SIGN, ENG25519_R_INVALID_PRIVATE_KEY);
        return -1;
    }
    *siglen = Ed25519_SIGN_LENGTH;
    if (sig == NULL) {
        return 1;
    }
    if (eng25519_prov_ed25519_sign(sig, tbs, tbslen, kp->pk, kp->sk) == 0) {
        ENG25519err(ENG25519_F_ED25519_SIGN,
                    ENG25519_R_IMPLEMENTATION_BACKEND_UNEXPECTED_RETURN);
        return -1;
    }

#ifdef PRINT_CC
    uint64_t end = cycles_now();
    fprintf(_dbgstream, "cc of ed25519_sign = %lu\n", end - start);
    fflush(_dbgstream);
#endif

    return 1;
}

static int ed25519_verify(EVP_PKEY_CTX *ctx, const uint8_t *sig, size_t siglen,
                          const uint8_t *tbv, size_t tbvlen)
{
    verbose("CALLED\n");
    const EVP_PKEY *_pkey = NULL;
    const Ed25519_KEYPAIR *kp = NULL;
    int valid = 0;

#ifdef PRINT_CC
    uint64_t start = cycles_now();
#endif

    _pkey = EVP_PKEY_CTX_get0_pkey(ctx);
    if (_pkey == NULL) {
        ENG25519err(ENG25519_F_ED25519_VERIFY, ENG25519_R_KEYS_NOT_SET);
        return -1;
    }
    kp = EVP_PKEY_get0(_pkey);
    if (eng25519_keypair_is_invalid(kp)) {
        ENG25519err(ENG25519_F_ED25519_VERIFY, ENG25519_R_INVALID_KEY);
        return -1;
    }

    if (siglen != Ed25519_SIGN_LENGTH || sig == NULL) {
        ENG25519err(ENG25519_F_ED25519_VERIFY, ENG25519_R_BAD_SIGNATURE);
        return -1;
    }

    valid = eng25519_prov_ed25519_verify(tbv, tbvlen, kp->pk, sig);

#ifdef PRINT_CC
    uint64_t end = cycles_now();
    fprintf(_dbgstream, "cc of ed25519_verify = %lu\n", end - start);
    fflush(_dbgstream);
#endif

    return valid;
}

int EVP_PKEY_CTX_ed25519_set_private(EVP_PKEY_CTX *ctx,
                                     const uint8_t sk[Ed25519_PRIVKEYLEN])
{
    verbose("CALLED\n");
    EVP_PKEY *_pkey = NULL;

    _pkey = EVP_PKEY_CTX_get0_pkey(ctx);
    if (_pkey == NULL) {
        ENG25519err(ENG25519_F_EVP_PKEY_CTX_ED25519_SET_PRIVATE, ENG25519_R_KEYS_NOT_SET);
        return -1;
    }
    return EVP_PKEY_ed25519_set_private(_pkey, sk);
}

int EVP_PKEY_ed25519_set_private(EVP_PKEY *pkey, const uint8_t sk[Ed25519_PRIVKEYLEN])
{
    verbose("CALLED\n");
    Ed25519_KEYPAIR *oldkp = NULL, *newkp = NULL;
    int nid = NID_undef;

    oldkp = EVP_PKEY_get0(pkey);
    if (eng25519_keypair_is_invalid(oldkp)) {
        ENG25519err(ENG25519_F_EVP_PKEY_ED25519_SET_PRIVATE,
                    ENG25519_R_INVALID_PRIVATE_KEY);
        goto err;
    }

    nid = oldkp->nid;

    newkp = ed25519_keypair_new(NO_FLAG);
    if (eng25519_keypair_is_invalid_private(newkp)) {
        ENG25519err(ENG25519_F_EVP_PKEY_ED25519_SET_PRIVATE,
                    ENG25519_R_INVALID_PRIVATE_KEY);
        goto err;
    }

    memcpy(newkp->sk, sk, Ed25519_PRIVKEYLEN);

    if (!ed25519_sk_to_pk(newkp->pk, newkp->sk)) {
        ENG25519err(ENG25519_F_EVP_PKEY_ED25519_SET_PRIVATE, ENG25519_R_CANNOT_DERIVE_PK);
        goto err;
    }

    EVP_PKEY_assign(pkey, nid, newkp);
    /** EVP_PKEY_assign has called free(oldkp) */
    oldkp = NULL;
    return 1;
err:
    if (newkp)
        ed25519_keypair_free(newkp);
    return 0;
}

static int ed25519_signctx(EVP_PKEY_CTX *ctx, uint8_t *sig, size_t *siglen,
                           EVP_MD_CTX *mctx)
{
    verbose("CALLED\n");
    int md_nid = EVP_MD_CTX_type(mctx);

    if (md_nid == NID_identity_md) {
        MD_IDENTITY_DATA *md_data = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(mctx);
        if (md_data == NULL) {
            errorf("md_data should never be NULL\n");
            return 0;
        }
        return ed25519_sign(ctx, sig, siglen, md_data->m, md_data->offset);
    } else {
        errorf("Unsupported MD: '%s'\n", OBJ_nid2ln(md_nid));
        return 0;
    }
}

static int ed25519_verifyctx(EVP_PKEY_CTX *ctx, const uint8_t *sig, int siglen,
                             EVP_MD_CTX *mctx)
{
    verbose("CALLED\n");
    int md_nid = EVP_MD_CTX_type(mctx);

    if (md_nid == NID_identity_md) {
        MD_IDENTITY_DATA *md_data = (MD_IDENTITY_DATA *)EVP_MD_CTX_md_data(mctx);
        if (md_data == NULL) {
            errorf("md_data should never be NULL\n");
            return 0;
        }
        return ed25519_verify(ctx, sig, siglen, md_data->m, md_data->offset);
    } else {
        errorf("Unsupported MD: '%s'\n", OBJ_nid2ln(md_nid));
        return 0;
    }
}

static int ed25519_ctx_copy(EVP_PKEY_CTX *dst, EVP_PKEY_CTX *src)
{
    (void)dst;
    (void)src;
    debug("STUB\n");
    return 1;
}

void eng25519_register_ed25519(EVP_PKEY_METHOD *pmeth)
{
    EVP_PKEY_meth_set_keygen(pmeth, NULL, ed25519_keygen);
    EVP_PKEY_meth_set_sign(pmeth, NULL, ed25519_sign);
    EVP_PKEY_meth_set_verify(pmeth, NULL, ed25519_verify);
    EVP_PKEY_meth_set_ctrl(pmeth, ed25519_ctrl, NULL);

    EVP_PKEY_meth_set_signctx(pmeth, NULL, ed25519_signctx);
    EVP_PKEY_meth_set_verifyctx(pmeth, NULL, ed25519_verifyctx);

    EVP_PKEY_meth_set_copy(pmeth, ed25519_ctx_copy);
}
