/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "providers/api/curve25519.h"

#include <openssl/rand.h>

#include "openssl_curve25519.h"

/**
 * Generate a new keypair for ECDH.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_x25519_keygen(ENG25519_KEYPAIR *kp)
{
    /** kp's validation will be checked in this function */
    RAND_bytes(kp->sk, kp->nid_data->sk_bytes);
    X25519_public_from_private(kp->pk, kp->sk);
    return 1;
}

/**
 * Compute shared secret, Q = n * P.
 * Q: the shared secret.
 * n: my secret key.
 * P: peer's public key.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_x25519_sharedsecret(uint8_t *Q, const uint8_t *n, const uint8_t *P)
{
    // crypto_x25519_sharedsecret(Q, n, P);
    X25519(Q, n, P);
    return 1;
}

/**
 * Derive public key from secret key.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk)
{
    ED25519_public_from_private(pk, sk);
    return 1;
}

int eng25519_prov_ed25519_keygen(ENG25519_KEYPAIR *kp)
{
    RAND_bytes(kp->sk, kp->nid_data->sk_bytes);
    ED25519_public_from_private(kp->pk, kp->sk);
    return 1;
}

/**
 * Generate signature according to message and private key.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_ed25519_sign(uint8_t *signature, const uint8_t *message,
                               uint64_t message_length, const uint8_t *public_key,
                               const uint8_t *private_key)
{
    if (ED25519_sign(signature, message, message_length, public_key, private_key) == 1) {
        return 1;
    } else {
        return 0;
    }
}

/**
 * Verify the signature according to message and public key.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_ed25519_verify(const uint8_t *message, uint64_t message_length,
                                 const uint8_t *public_key, const uint8_t *signature)
{
    return ED25519_verify(message, message_length, signature, public_key);
}