
#ifndef ENG25519_CURVE25519_API_H
#define ENG25519_CURVE25519_API_H

#include <stdint.h>

#include "meths/eng25519_keypair.h"

extern int eng25519_prov_x25519_keygen(ENG25519_KEYPAIR *kp);
extern int eng25519_prov_x25519_sharedsecret(uint8_t *Q, const uint8_t *n,
                                             const uint8_t *P);

extern int eng25519_prov_ed25519_keygen(ENG25519_KEYPAIR *kp);
extern int eng25519_prov_ed25519_sk_to_pk(uint8_t *pk, const uint8_t *sk);
extern int eng25519_prov_ed25519_sign(uint8_t *signature, const uint8_t *message,
                                      uint64_t message_length, const uint8_t *public_key,
                                      const uint8_t *private_key);
extern int eng25519_prov_ed25519_verify(const uint8_t *message, uint64_t message_length,
                                        const uint8_t *public_key,
                                        const uint8_t *signature);
#endif