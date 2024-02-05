/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "eng25519_x25519_meth.h"

#include <openssl/crypto.h>
#include <openssl/ec.h>
#include <openssl/err.h>

#include "debug/debug.h"
#include "eng25519_keypair.h"
#include "ossl/eng25519_err.h"
#include "ossl/eng25519_objects.h"
#include "providers/api/curve25519.h"

typedef ENG25519_KEYPAIR X25519_KEYPAIR;

#define X25519_keypair_new(flags) eng25519_keypair_new(NID_X25519, (flags))
#define X25519_keypair_free(kp) eng25519_keypair_free((kp))

/**
 * 1) get _pkey and _peerkey using EVP_PKEY_CTX_get0 API.
 * 2) get keypair using EVP_PKEY_get0 API.
 * 3) do scalar multiplication.
 */
static int X25519_derive(EVP_PKEY_CTX *ctx, uint8_t *key, size_t *keylen)
{
    verbose("CALLED\n");
    EVP_PKEY *_pkey, *_peerkey;
    const X25519_KEYPAIR *pkey, *peerkey;

    _pkey = EVP_PKEY_CTX_get0_pkey(ctx);
    _peerkey = EVP_PKEY_CTX_get0_peerkey(ctx);

    if (_pkey == NULL || _peerkey == NULL) {
        ENG25519err(ENG25519_F_X25519_DERIVE, ENG25519_R_KEYS_NOT_SET);
        return 0;
    }
    pkey = EVP_PKEY_get0(_pkey);
    peerkey = EVP_PKEY_get0(_peerkey);

    /** pkey must contain a secret key */
    if (eng25519_keypair_is_invalid_private(pkey)) {
        ENG25519err(ENG25519_F_X25519_DERIVE, ENG25519_R_INVALID_PRIVATE_KEY);
        return 0;
    }
    /** peerkey must not contain a secret key */
    if (eng25519_keypair_is_invalid(peerkey)) {
        ENG25519err(ENG25519_F_X25519_DERIVE, ENG25519_R_INVALID_PEER_KEY);
        return 0;
    }

    *keylen = X25519_SHAREDKEYLEN;

#ifdef PRINT_CC
    uint64_t start = cycles_now();
#endif

    if (key != NULL &&
        eng25519_prov_x25519_sharedsecret(key, pkey->sk, peerkey->pk) != 1) {
        return 0;
    }

#ifdef PRINT_CC
    uint64_t end = cycles_now();
    fprintf(_dbgstream, "cc of x25519_derive = %lu\n", (uint64_t)(end - start));
    fflush(_dbgstream);
#endif

    return 1;
}

/**
 * Our x25519_keygen (fixed-point scalar multiplication) utilizes batch
 * strategy, so we use unfixed-point scalar multiplication here.
 * This function is used when implement ASN1-related functions.
 */
int X25519_sk_to_pk(uint8_t *pk, const uint8_t *sk)
{
    verbose("CALLED\n");
    uint32_t base_point[8] = {0x00000009, 0x00000000, 0x00000000, 0x00000000,
                              0x00000000, 0x00000000, 0x00000000, 0x00000000};
    if (eng25519_prov_x25519_sharedsecret(pk, sk, (uint8_t *)base_point) != 1) {
        ENG25519err(ENG25519_F_X25519_SK_TO_PK,
                    ENG25519_R_IMPLEMENTATION_BACKEND_UNEXPECTED_RETURN);
        return 0;
    }
    return 1;
}

/**
 * 1) new a keypair.
 * 2) call backend keygen function.
 * 3) bind kp to pkey using EVP_PKEY_assign API.
 */
static int X25519_keygen(EVP_PKEY_CTX *ctx, EVP_PKEY *pkey)
{
    verbose("CALLED\n");
    (void)ctx;
    X25519_KEYPAIR *kp = NULL;

#ifdef PRINT_CC
    uint64_t start = cycles_now();
#endif

    kp = X25519_keypair_new(NO_FLAG);
    if (eng25519_keypair_is_invalid_private(kp)) {
        ENG25519err(ENG25519_F_X25519_KEYGEN, ENG25519_R_INVALID_PRIVATE_KEY);
        goto err;
    }

    if (eng25519_prov_x25519_keygen(kp) != 1) {
        ENG25519err(ENG25519_F_X25519_KEYGEN,
                    ENG25519_R_IMPLEMENTATION_BACKEND_UNEXPECTED_RETURN);
        goto err;
    }

    EVP_PKEY_assign(pkey, NID_X25519, kp);

#ifdef PRINT_CC
    uint64_t end = cycles_now();
    fprintf(_dbgstream, "cc of x25519_keygen = %ld\n", end - start);
    fflush(_dbgstream);
#endif

    return 1;
err:
    if (kp)
        X25519_keypair_free(kp);
    return 0;
}

/**
 * Only need to handle peer key for derivation.
 * From pkey_ecx_ctrl@openssl/crypto/ec/ecx_meth.c.
 */
static int X25519_ctrl(EVP_PKEY_CTX *ctx, int type, int p1, void *p2)
{
    (void)ctx;
    (void)type;
    (void)p1;
    (void)p2;
    if (type == EVP_PKEY_CTRL_PEER_KEY)
        return 1;
    return -2;
}

void eng25519_register_x25519(EVP_PKEY_METHOD *pmeth)
{
    EVP_PKEY_meth_set_keygen(pmeth, NULL, X25519_keygen);
    EVP_PKEY_meth_set_derive(pmeth, NULL, X25519_derive);
    EVP_PKEY_meth_set_ctrl(pmeth, X25519_ctrl, NULL);
}