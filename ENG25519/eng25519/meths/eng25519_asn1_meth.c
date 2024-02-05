/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "eng25519_asn1_meth.h"

#include <openssl/ec.h>
#include <openssl/err.h>
#include <openssl/x509.h>
#include <string.h>

#include "debug/debug.h"
#include "eng25519_keypair.h"
#include "ossl/eng25519_err.h"
#include "ossl/eng25519_objects.h"
#include "ossl/ossl_compat.h"

#ifndef OPENSSL_V102_COMPAT
#    define RC_CONST const
#else
#    define RC_CONST
#endif

#define ENG25519_EVP_PKEY_ASN1_FLAGS 0

typedef enum { ENG25519_PUBLIC, ENG25519_PRIVATE } eng25519_key_op_t;

static int eng25519_key_print(BIO *bp, const EVP_PKEY *pkey, int indent, ASN1_PCTX *ctx,
                              eng25519_key_op_t op)
{
    (void)ctx;
    if (pkey == NULL)
        return 0;

    const ENG25519_KEYPAIR *kp = EVP_PKEY_get0(pkey);
    const ENG25519_ECDH_NID_DATA *nid_data = NULL;

    if (op == ENG25519_PRIVATE) {
        if (eng25519_keypair_is_invalid_private(kp)) {
            if (BIO_printf(bp, "%*s<INVALID PRIVATE KEY>\n", indent, "") <= 0)
                return 0;
            return 1;
        }
        nid_data = kp->nid_data;
        if (BIO_printf(bp, "%*s%s Private-key:\n", indent, "", nid_data->name) <= 0)
            return 0;
        if (BIO_printf(bp, "%*spriv:\n", indent, "") <= 0)
            return 0;
        if (ASN1_buf_print(bp, kp->sk, nid_data->sk_bytes, indent + 4) == 0)
            return 0;
    } else {
        if (eng25519_keypair_is_invalid(kp)) {
            if (BIO_printf(bp, "%*s<INVALID PUBLIC KEY>\n", indent, "") <= 0)
                return 0;
            return 1;
        }
        nid_data = kp->nid_data;
        if (BIO_printf(bp, "%*s%s Public-Key:\n", indent, "", nid_data->name) <= 0)
            return 0;
    }
    if (BIO_printf(bp, "%*spub:\n", indent, "") <= 0)
        return 0;
    if (ASN1_buf_print(bp, kp->pk, nid_data->pk_bytes, indent + 4) == 0)
        return 0;
    return 1;
}

static int eng25519_gen_priv_print(BIO *bp, const EVP_PKEY *pkey, int indent,
                                   ASN1_PCTX *ctx)
{
    return eng25519_key_print(bp, pkey, indent, ctx, ENG25519_PRIVATE);
}

static int eng25519_gen_pub_print(BIO *bp, const EVP_PKEY *pkey, int indent,
                                  ASN1_PCTX *ctx)
{
    return eng25519_key_print(bp, pkey, indent, ctx, ENG25519_PUBLIC);
}

static int eng25519_pub_cmp(const EVP_PKEY *a, const EVP_PKEY *b)
{
    const ENG25519_KEYPAIR *akey = EVP_PKEY_get0(a);
    const ENG25519_KEYPAIR *bkey = EVP_PKEY_get0(b);

    const ENG25519_ECDH_NID_DATA *adata = NULL;

    if (eng25519_keypair_is_invalid(akey) || eng25519_keypair_is_invalid(bkey))
        return -2;
    if (akey->nid != bkey->nid)
        return -2;
    adata = eng25519_get_nid_data(akey->nid);
    return !CRYPTO_memcmp(akey->pk, bkey->pk, adata->pk_bytes);
}

/* EVP_PKEY_size returns the maximum size, in bytes, of a signature signed by
 * pkey. For an RSA key, this returns the number of bytes needed to represent
 * the modulus. For an EC key, this returns the maximum size of a DER-encoded
 * ECDSA signature.
 */
static int eng25519_ed25519_size(const EVP_PKEY *pkey)
{
    (void)pkey;
    return Ed25519_SIGN_LENGTH;
}

/* EVP_PKEY_bits returns the "size", in bits, of pkey. For an RSA key, this
 * returns the bit length of the modulus. For an EC key, this returns the bit
 * length of the group order.
 */
static int eng25519_curve25519_bits(const EVP_PKEY *pkey)
{
    (void)pkey;
    return CURVE25519_BITS;
}

static int eng25519_curve25519_security_bits(const EVP_PKEY *pkey)
{
    (void)pkey;
    return CURVE25519_SECURITY_BITS;
}

static void eng25519_free(EVP_PKEY *pkey)
{
    ENG25519_KEYPAIR *kp = EVP_PKEY_get0(pkey);

    eng25519_keypair_free(kp);
}

static int eng25519_cmp_parameters(const EVP_PKEY *a, const EVP_PKEY *b)
{
    (void)a;
    (void)b;
    return 1;
}

/**
 * We will handle three cases, i.e., op ==
 * ASN1_PKEY_CTRL_{SET1,GET1}_TLS_ENCPT/ASN1_PKEY_CTRL_DEFAULT_MD_NID.
 *
 * For SET1 case, I guess that this case is used when peer public key is
 * received through a communication channel. And this case is used by the
 * EVP_PKEY_set1_tls_encodedpoint function.
 *
 * For GET1 case, it is used by the EVP_PKEY_get1_tls_encodedpoint function.
 *
 * For DEFAULT_MD_NID case, we use it to get the MD_NID according to the
 * parameter nid. This case is necessary because different digital signature
 * algorithm needs different Message Digest (MD) algorithm.
 */
static int eng25519_gen_ctrl(int nid, EVP_PKEY *pkey, int op, long arg1, void *arg2)
{
    ENG25519_KEYPAIR *kp = NULL;
    const uint8_t *p = NULL;
    const ENG25519_ECDH_NID_DATA *nid_data = eng25519_get_nid_data(nid);
    int pklen = 0;

    switch (op) {
#ifndef OPENSSL_V102_COMPAT
        // FIXME: check if/how this control signals should be handled in 1.0.2
        case ASN1_PKEY_CTRL_SET1_TLS_ENCPT:
            debug("nid: %d, op: ASN1_PKEY_CTRL_SET1_TLS_ENCPT, pklen: %ld\n", nid, arg1);
            p = arg2;
            pklen = arg1;

            if (p == NULL || (size_t)pklen != nid_data->pk_bytes) {
                ENG25519err(ENG25519_F_ASN1_GENERIC_CTRL, ENG25519_R_WRONG_LENGTH);
                return 0;
            }

            kp = eng25519_keypair_new(nid, NO_PRIV_KEY);
            if (eng25519_keypair_is_invalid(kp)) {
                return 0;
            }

            memcpy(kp->pk, p, pklen);

            EVP_PKEY_assign(pkey, nid, kp);
            return 1;

        case ASN1_PKEY_CTRL_GET1_TLS_ENCPT:
            debug("nid: %d, op: ASN1_PKEY_CTRL_GET1_TLS_ENCPT\n", nid);
            kp = EVP_PKEY_get0(pkey);
            if (!eng25519_keypair_is_invalid(kp) && nid == kp->nid) {
                uint8_t **ppt = arg2;
                *ppt = OPENSSL_memdup(kp->pk, nid_data->pk_bytes);
                if (*ppt != NULL)
                    return nid_data->pk_bytes;
            }
            return 0;
#endif
        case ASN1_PKEY_CTRL_DEFAULT_MD_NID:
            debug("nid: %d, op: ASN1_PKEY_CTRL_DEFAULT_MD_NID, ret: %s\n", nid,
                  OBJ_nid2sn(nid_data->default_md_nid));
            *(int *)arg2 = nid_data->default_md_nid;
            /**
             * Regarding the return value.
             * In the libsuola engine implementation, the authors return 2. However, when
             * I integrated libsuola into TLS server with Ed25519-certification, I found
             * that the SSL handshake cannot work. See
             * https://github.com/openssl/openssl/issues/19280 for details.
             *
             * This case is called by EVP_PKEY_get_default_digest_nid() function, which
             * returns 1 if the message digest is advisory (that is other digests can be
             * used) and 2 if it is mandatory (other digests can not be used).  It returns
             * 0 or a negative value for failure. In particular a return value of -2
             * indicates the operation is not supported by the public key algorithm.
             */
            return 1;

        default:
            return -2;
    }
}

/**
 * The private/secret key encoding function.
 * The main APIs we used in this function are i2d_ASN1_OCTET_STRING and
 * PKCS8_pkey_set0.
 * The i2d_ASN1_OCTET_STRING encodes input into DER format.
 * The PKCS8_pkey_set0 encodes input into PKCS8 format.
 */
static int eng25519_gen_priv_encode(int nid, PKCS8_PRIV_KEY_INFO *p8,
                                    const EVP_PKEY *pkey)
{
    int penclen;
    int ret = 0;
    uint8_t *penc = NULL;
    char *tmp_buf = NULL;
    ASN1_OCTET_STRING oct;
    const ENG25519_KEYPAIR *kp = EVP_PKEY_get0(pkey);
    const ENG25519_ECDH_NID_DATA *nid_data = eng25519_get_nid_data(nid);

    if (nid_data == NULL) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_ENCODE, ENG25519_R_MISSING_NID_DATA);
        return 0;
    }
    if (eng25519_keypair_is_invalid(kp) || kp->nid != nid) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_ENCODE, ENG25519_R_INVALID_PRIVATE_KEY);
        return 0;
    }

    tmp_buf = OPENSSL_secure_malloc(nid_data->sk_bytes);
    if (NULL == tmp_buf) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_ENCODE, ERR_R_MALLOC_FAILURE);
        return 0;
    }

    oct.data = memcpy(tmp_buf, kp->sk, nid_data->sk_bytes);
    oct.length = nid_data->sk_bytes;
    oct.flags = 0;

    penclen = i2d_ASN1_OCTET_STRING(&oct, &penc);
    if (penclen < 0) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_ENCODE, ERR_R_MALLOC_FAILURE);
        ret = 0;
        goto err;
    }

    if (!PKCS8_pkey_set0(p8, OBJ_nid2obj(nid), 0, V_ASN1_UNDEF, NULL, penc, penclen)) {
        OPENSSL_clear_free(penc, penclen);
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_ENCODE, ERR_R_MALLOC_FAILURE);
        ret = 0;
        goto err;
    }

    ret = 1;
err:
    if (tmp_buf)
        OPENSSL_secure_free(tmp_buf);
    return ret;
}

/**
 * The private/secret key decoding function.
 * The main APIs we used in this function are PKCS8_pkey_get0 and
 * d2i_ASN1_OCTET_STRING.
 * Using PKCS8_pkey_get0 we can get PKCS8-format private key, and convert it
 * into ASN1 string with d2i_ASN1_OCTET_STRING.
 */
static int eng25519_gen_priv_decode(int nid, EVP_PKEY *pkey,
                                    RC_CONST PKCS8_PRIV_KEY_INFO *p8)
{
    int plen;
    const uint8_t *p;
    ASN1_OCTET_STRING *oct = NULL;
    RC_CONST X509_ALGOR *palg;
    ENG25519_KEYPAIR *kp = NULL;

    const ENG25519_ECDH_NID_DATA *nid_data = eng25519_get_nid_data(nid);
    if (nid_data == NULL) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_DECODE, ENG25519_R_MISSING_NID_DATA);
        return 0;
    }

    if (!PKCS8_pkey_get0(NULL, &p, &plen, &palg, p8))
        return 0;

    oct = d2i_ASN1_OCTET_STRING(NULL, &p, plen);
    if (oct == NULL) {
        p = NULL;
        plen = 0;
    } else {
        p = ASN1_STRING_get0_data(oct);
        plen = ASN1_STRING_length(oct);
    }

    if (palg != NULL) {
        int ptype;

        /* Algorithm parameters must be absent */
        X509_ALGOR_get0(NULL, &ptype, NULL, palg);
        if (ptype != V_ASN1_UNDEF) {
            ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_DECODE, ENG25519_R_INVALID_ENCODING);
            return 0;
        }
    }

    if (p == NULL || (size_t)plen != nid_data->sk_bytes) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_DECODE, ENG25519_R_WRONG_LENGTH);
        return 0;
    }

    kp = eng25519_keypair_new(nid, NO_FLAG);
    if (eng25519_keypair_is_invalid_private(kp)) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PRIV_DECODE, ENG25519_R_INVALID_PRIVATE_KEY);
        return 0;
    }

    memcpy(kp->sk, p, nid_data->sk_bytes);

    ASN1_OCTET_STRING_free(oct);
    oct = NULL;
    p = NULL;
    plen = 0;

    // Generate corresponding public key
    if (1 != (nid_data->sk_to_pk)(kp->pk, kp->sk)) {
        eng25519_keypair_free(kp);
        return 0;
    }

    EVP_PKEY_assign(pkey, nid, kp);

    return 1;
}

/**
 * The public key encoding function.
 */
static int eng25519_gen_pub_encode(int nid, X509_PUBKEY *pk, const EVP_PKEY *pkey)
{
    uint8_t *penc;
    const ENG25519_KEYPAIR *kp = EVP_PKEY_get0(pkey);
    const ENG25519_ECDH_NID_DATA *nid_data = eng25519_get_nid_data(nid);

    if (eng25519_keypair_is_invalid(kp) || kp->nid != nid) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_ENCODE, ENG25519_R_INVALID_KEY);
        return 0;
    }

    if (nid_data == NULL) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_ENCODE, ENG25519_R_MISSING_NID_DATA);
        return 0;
    }

    penc = OPENSSL_memdup(kp->pk, nid_data->pk_bytes);
    if (penc == NULL) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_ENCODE, ERR_R_MALLOC_FAILURE);
        return 0;
    }

    if (!X509_PUBKEY_set0_param(pk, OBJ_nid2obj(nid), V_ASN1_UNDEF, NULL, penc,
                                nid_data->pk_bytes)) {
        OPENSSL_free(penc);
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_ENCODE, ERR_R_MALLOC_FAILURE);
        return 0;
    }
    return 1;
}

/**
 * The public key decoding function.
 */
static int eng25519_gen_pub_decode(int nid, EVP_PKEY *pkey, X509_PUBKEY *pubkey)
{
    const unsigned char *p;
    int pklen;
    X509_ALGOR *palg;
    ENG25519_KEYPAIR *kp = NULL;
    const ENG25519_ECDH_NID_DATA *nid_data = eng25519_get_nid_data(nid);

    if (nid_data == NULL) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_DECODE, ENG25519_R_MISSING_NID_DATA);
        return 0;
    }

    if (!X509_PUBKEY_get0_param(NULL, &p, &pklen, &palg, pubkey))
        return 0;

    if (palg != NULL) {
        int ptype;

        /* Algorithm parameters must be absent */
        X509_ALGOR_get0(NULL, &ptype, NULL, palg);
        if (ptype != V_ASN1_UNDEF) {
            ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_DECODE, ENG25519_R_INVALID_ENCODING);
            return 0;
        }
    }

    if (p == NULL || (size_t)pklen != nid_data->pk_bytes) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_DECODE, ENG25519_R_WRONG_LENGTH);
        return 0;
    }

    kp = eng25519_keypair_new(nid, NO_PRIV_KEY);
    if (eng25519_keypair_is_invalid(kp)) {
        ENG25519err(ENG25519_F_ASN1_GENERIC_PUB_DECODE, ENG25519_R_INVALID_KEY);
        return 0;
    }

    memcpy(kp->pk, p, pklen);

    EVP_PKEY_assign(pkey, nid, kp);
    return 1;
}

#define ___debug_concrete(___NAME, ___NID, ___STRING) \
    verbose("CALLED:\tNID(%d/%s)\t-> \"%s\"\n", ___NID, OBJ_nid2sn(___NID), ___STRING);

#define DECLARE_ENG25519_CONCRETE_FUNCTIONS(___NAME, ___NID, ___STRING)                  \
    static int eng25519_##___NAME##_ctrl(EVP_PKEY *pkey, int op, long arg1, void *arg2)  \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_ctrl(___NID, pkey, op, arg1, arg2);                          \
    };                                                                                   \
    static int eng25519_##___NAME##_priv_encode(PKCS8_PRIV_KEY_INFO *p8,                 \
                                                const EVP_PKEY *pkey)                    \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_priv_encode(___NID, p8, pkey);                               \
    };                                                                                   \
    static int eng25519_##___NAME##_priv_decode(EVP_PKEY *pkey,                          \
                                                RC_CONST PKCS8_PRIV_KEY_INFO *p8)        \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_priv_decode(___NID, pkey, p8);                               \
    };                                                                                   \
    static int eng25519_##___NAME##_priv_print(BIO *bp, const EVP_PKEY *pkey,            \
                                               int indent, ASN1_PCTX *ctx)               \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_priv_print(bp, pkey, indent, ctx);                           \
    };                                                                                   \
    static int eng25519_##___NAME##_pub_encode(X509_PUBKEY *pk, const EVP_PKEY *pkey)    \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_pub_encode(___NID, pk, pkey);                                \
    };                                                                                   \
    static int eng25519_##___NAME##_pub_decode(EVP_PKEY *pkey, X509_PUBKEY *pubkey)      \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_pub_decode(___NID, pkey, pubkey);                            \
    };                                                                                   \
    static int eng25519_##___NAME##_pub_print(BIO *bp, const EVP_PKEY *pkey, int indent, \
                                              ASN1_PCTX *ctx)                            \
    {                                                                                    \
        ___debug_concrete(___NAME, ___NID, ___STRING);                                   \
        return eng25519_gen_pub_print(bp, pkey, indent, ctx);                            \
    };

DECLARE_ENG25519_CONCRETE_FUNCTIONS(X25519, NID_X25519, (OBJ_nid2sn(NID_X25519)));
DECLARE_ENG25519_CONCRETE_FUNCTIONS(ed25519, NID_ED25519, (OBJ_nid2sn(NID_ED25519)));

static int eng25519_ed25519_item_verify(EVP_MD_CTX *ctx, const ASN1_ITEM *it, void *asn,
                                        X509_ALGOR *sigalg, ASN1_BIT_STRING *str,
                                        EVP_PKEY *pkey)
{
    (void)it;
    (void)asn;
    (void)str;
    verbose("CALLED\n");
    const ASN1_OBJECT *obj;
    int ptype;

    X509_ALGOR_get0(&obj, &ptype, NULL, sigalg);
    /* Sanity check: make sure it is ED25519 with absent parameters */
    if (OBJ_obj2nid(obj) != NID_ED25519 || ptype != V_ASN1_UNDEF) {
        ENG25519err(ENG25519_F_ASN1_ED25519_ITEM_VERIFY, ENG25519_R_INVALID_ENCODING);
        return 0;
    }

    if (!EVP_DigestVerifyInit(ctx, NULL, NULL, NULL, pkey))
        return 0;

    return 2;
}

static int eng25519_ed25519_item_sign(EVP_MD_CTX *ctx, const ASN1_ITEM *it, void *asn,
                                      X509_ALGOR *alg1, X509_ALGOR *alg2,
                                      ASN1_BIT_STRING *str)
{
    (void)ctx;
    (void)it;
    (void)asn;
    (void)str;
    verbose("CALLED\n");
    /* Set algorithms identifiers */
    X509_ALGOR_set0(alg1, OBJ_nid2obj(NID_ED25519), V_ASN1_UNDEF, NULL);
    if (alg2)
        X509_ALGOR_set0(alg2, OBJ_nid2obj(NID_ED25519), V_ASN1_UNDEF, NULL);
    /* Algorithm identifiers set: just sign */
    return 3;
}

/*
 * Called from eng25519.c:eng25519_register_ameth():
 * eng25519_register_asn1_meth(NID_X25519, &ameth, "ED25519", "ED25519");
 * ameth is guaranteed to be non-NULL and unsupported nid are already filtered
 * out.
 * We will bind encode/decode/cmp/print/ctrl functions.
 */
int eng25519_register_asn1_meth(int nid, EVP_PKEY_ASN1_METHOD **ameth,
                                const char *pem_str, const char *info)
{
    debug("REGISTER AMETH NID(%d/%s):%s:%s\n", nid, OBJ_nid2sn(nid), pem_str, info);

    *ameth = EVP_PKEY_asn1_new(nid, ENG25519_EVP_PKEY_ASN1_FLAGS, pem_str, info);
    if (!*ameth)
        return 0;

    if (nid == NID_X25519) {
        debug("USING eng25519_X25519_* functions\n");
        EVP_PKEY_asn1_set_public(
            *ameth, eng25519_X25519_pub_decode, eng25519_X25519_pub_encode,
            eng25519_pub_cmp, eng25519_X25519_pub_print, NULL, eng25519_curve25519_bits);
        EVP_PKEY_asn1_set_private(*ameth, eng25519_X25519_priv_decode,
                                  eng25519_X25519_priv_encode,
                                  eng25519_X25519_priv_print);
        EVP_PKEY_asn1_set_ctrl(*ameth, eng25519_X25519_ctrl);
    } else if (nid == NID_ED25519) {
        debug("USING eng25519_ed25519_* functions\n");
        EVP_PKEY_asn1_set_public(*ameth, eng25519_ed25519_pub_decode,
                                 eng25519_ed25519_pub_encode, eng25519_pub_cmp,
                                 eng25519_ed25519_pub_print, eng25519_ed25519_size,
                                 eng25519_curve25519_bits);
        EVP_PKEY_asn1_set_private(*ameth, eng25519_ed25519_priv_decode,
                                  eng25519_ed25519_priv_encode,
                                  eng25519_ed25519_priv_print);
        EVP_PKEY_asn1_set_ctrl(*ameth, eng25519_ed25519_ctrl);

        EVP_PKEY_asn1_set_item(*ameth, eng25519_ed25519_item_verify,
                               eng25519_ed25519_item_sign);
    }

    EVP_PKEY_asn1_set_param(*ameth, 0, 0, 0, 0, eng25519_cmp_parameters, 0);
#ifndef OPENSSL_V102_COMPAT
    EVP_PKEY_asn1_set_security_bits(*ameth, eng25519_curve25519_security_bits);
#endif /* OPENSSL_V102_COMPAT */
    EVP_PKEY_asn1_set_free(*ameth, eng25519_free);

    return 1;
}