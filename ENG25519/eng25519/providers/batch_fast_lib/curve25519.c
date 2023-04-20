
#include "providers/api/curve25519.h"

#include "batch.h"
#include "ed25519_fast_avx512ifma/ed255.h"
#include "x25519_batch_avx512ifma/ecdh.h"

void scalar_mult_var_base(unsigned char *q, const unsigned char *n,
                          const unsigned char *p, const unsigned char *A);

/**
 * Generate a new keypair for ECDH.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_x25519_keygen(ENG25519_KEYPAIR *kp)
{
    /** kp's validation will be checked in this function */
    if (!eng25519_prov_batch_get_keypair(kp))
        return 0;
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
    const unsigned char A[32] = {0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00,
                                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                                 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    scalar_mult_var_base(Q, n, P, A);
    return 1;
}

/**
 * Derive public key from secret key.
 *
 * Returns 1 on success, 0 otherwise.
 */
int eng25519_prov_ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk)
{
    return ed25519_sk_to_pk_internal(pk, sk);
}

int eng25519_prov_ed25519_keygen(ENG25519_KEYPAIR *kp)
{
    if (!eng25519_prov_batch_get_keypair(kp))
        return 0;
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
    if (ed25519_sign(signature, message, message_length, public_key, private_key) == 1) {
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
    return ed25519_verify(message, message_length, public_key, signature);
}