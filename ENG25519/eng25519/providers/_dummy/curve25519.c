
#include "providers/api/curve25519.h"

#include "debug/debug.h"

int eng25519_prov_x25519_keygen(ENG25519_KEYPAIR *kp)
{
    errorf("SHOULD NOT BE CALLED\n");
    (void)kp;
    return 0;
}

int eng25519_prov_x25519_sharedsecret(uint8_t *Q, const uint8_t *n, const uint8_t *P)
{
    errorf("SHOULD NOT BE CALLED\n");
    (void)Q;
    (void)n;
    (void)P;
    return 0;
}

int eng25519_prov_ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk)
{
    errorf("SOULD NOT BE CALLED\n");
    (void)pk;
    (void)sk;
}

int eng25519_prov_ed25519_keygen(ENG25519_KEYPAIR *kp)
{
    errorf("SOULD NOT BE CALLED\n");
    (void)kp;
}

int eng25519_prov_ed25519_sign(uint8_t *signature, const uint8_t *message,
                               uint64_t message_length, const uint8_t *public_key,
                               const uint8_t *private_key)
{
    errorf("SHOULD NOT BE CALLED\n");
    (void)signature;
    (void)message;
    (void)message_length;
    (void)public_key;
    (void)private_key;
}

int eng25519_prov_ed25519_verify(const uint8_t *message, uint64_t message_length,
                                 const uint8_t *public_key, const uint8_t *signature)
{
    errorf("SHOULD NOT BE CALLED\n");
    (void)message;
    (void)message_length;
    (void)public_key;
    (void)signature;
}