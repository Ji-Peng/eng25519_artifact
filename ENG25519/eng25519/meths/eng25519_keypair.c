/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "eng25519_keypair.h"

#include <openssl/crypto.h>
#include <openssl/ec.h>
#include <openssl/err.h>

#include "ossl/eng25519_err.h"
#include "ossl/eng25519_objects.h"
#include "ossl/ossl_compat.h"

extern int X25519_sk_to_pk(uint8_t *pk, const uint8_t *sk);
extern int ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk);

ENG25519_ECDH_NID_DATA _eng25519_nid_data[] = {
    {NID_undef, "X25519", X25519_PRIVKEYLEN, X25519_PUBKEYLEN, X25519_sk_to_pk,
     NID_undef},
    {NID_undef, "ED25519", Ed25519_PRIVKEYLEN, Ed25519_PUBKEYLEN, ed25519_sk_to_pk,
     NID_undef}};

inline const ENG25519_ECDH_NID_DATA *eng25519_get_nid_data(int nid)
{
    if (nid == NID_X25519) {
        _eng25519_nid_data[0].nid = NID_X25519;
        return &_eng25519_nid_data[0];
    } else if (nid == NID_ED25519) {
        _eng25519_nid_data[1].nid = NID_ED25519;
        _eng25519_nid_data[1].default_md_nid = NID_identity_md;
        return &_eng25519_nid_data[1];
    }
    return NULL;
}

ENG25519_KEYPAIR *eng25519_keypair_new(int nid, eng25519_keypair_flags_t flags)
{
    ENG25519_KEYPAIR *kp = NULL;
    const ENG25519_ECDH_NID_DATA *nid_data = eng25519_get_nid_data(nid);
    if (nid_data == NULL)
        goto err;

    if ((kp = OPENSSL_secure_zalloc(sizeof(*kp))) == NULL ||
        (kp->pk = OPENSSL_secure_zalloc(nid_data->pk_bytes)) == NULL) {
        ENG25519err(ENG25519_F_ENG25519_KEYPAIR_NEW, ERR_R_MALLOC_FAILURE);
        goto err;
    }

    kp->nid = nid;
    kp->nid_data = nid_data;
    kp->has_private = 0;

    if ((flags & NO_PRIV_KEY) == 0) {
        kp->has_private = 1;
        if ((kp->sk = OPENSSL_secure_zalloc(nid_data->sk_bytes)) == NULL) {
            ENG25519err(ENG25519_F_ENG25519_KEYPAIR_NEW, ERR_R_MALLOC_FAILURE);
            goto err;
        }
    }
    return kp;
err:
    if (kp != NULL) {
        if (kp->pk != NULL)
            OPENSSL_secure_free(kp->pk);
        if (kp->sk != NULL)
            OPENSSL_secure_free(kp->sk);
        OPENSSL_secure_free(kp);
    }
    return NULL;
}

void eng25519_keypair_free(ENG25519_KEYPAIR *kp)
{
    const ENG25519_ECDH_NID_DATA *nid_data;
    if (kp == NULL)
        return;

    nid_data = kp->nid_data;
    if (nid_data == NULL)
        return;

    if (kp->pk != NULL)
        OPENSSL_secure_free(kp->pk);
    /** Note that we need to clear the secret key */
    if (kp->sk != NULL)
        OPENSSL_secure_clear_free(kp->sk, nid_data->sk_bytes);

    OPENSSL_secure_free(kp);
}