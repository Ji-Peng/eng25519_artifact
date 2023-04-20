#ifndef _KEM_H
#define _KEM_H

#include "gfparith_8w.h"

#define BATCH_SIZE 8
#define SECRET_KEY_BYTES 32
#define PUBLIC_KEY_BYTES 32
#define SHARED_KEY_BYTES 32

void x25519_keygen_avx512_8x1w(__m512i *pk, const __m512i *sk);
void x25519_batch_keygen_8x1w(uint8_t *pks, uint8_t *sks);
void x25519_derive_avx512_8x1w(__m512i *ss, const __m512i *ska, const __m512i *pkb);

void ed25519_batch_keygen_8x1w(uint8_t *pks, uint8_t *sks);
int ed25519_sign_1x8w(uint8_t *signature, const uint8_t *message, uint64_t message_length,
                      const uint8_t *pk, const uint8_t *sk);
int ed25519_verify_1x2w(const uint8_t *message, uint64_t message_length,
                        const uint8_t *pk, const uint8_t *signature);

#endif
