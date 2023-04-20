#include <stdint.h>

typedef uint64_t fe64[4];
typedef int32_t fe[10];
typedef struct {
    fe X;
    fe Y;
    fe Z;
    fe T;
} ge_p3;

/*
 * Following subroutines perform corresponding operations modulo
 * 2^256-38, i.e. double the curve modulus. However, inputs and
 * outputs are permitted to be partially reduced, i.e. to remain
 * in [0..2^256) range. It's all tied up in final fe64_tobytes
 * that performs full reduction modulo 2^255-19.
 *
 * There are no reference C implementations for these.
 */
void x25519_fe64_mul(fe64 h, const fe64 f, const fe64 g);
void x25519_fe64_sqr(fe64 h, const fe64 f);
void x25519_fe64_mul121666(fe64 h, fe64 f);
void x25519_fe64_add(fe64 h, const fe64 f, const fe64 g);
void x25519_fe64_sub(fe64 h, const fe64 f, const fe64 g);
void x25519_fe64_tobytes(uint8_t *s, const fe64 f);
#define fe64_mul x25519_fe64_mul
#define fe64_sqr x25519_fe64_sqr
#define fe64_mul121666 x25519_fe64_mul121666
#define fe64_add x25519_fe64_add
#define fe64_sub x25519_fe64_sub
#define fe64_tobytes x25519_fe64_tobytes
void fe64_copy(fe64 h, const fe64 f);
void fe64_invert(fe64 out, const fe64 z);

void ge_scalarmult_base(ge_p3 *h, const uint8_t *a);
void ED25519_public_from_private(uint8_t out_public_key[32],
                                 const uint8_t private_key[32]);

int ED25519_sign(uint8_t *out_sig, const uint8_t *message, size_t message_len,
                 const uint8_t public_key[32], const uint8_t private_key[32]);

int ED25519_verify(const uint8_t *message, size_t message_len,
                   const uint8_t signature[64], const uint8_t public_key[32]);

void X25519_public_from_private(uint8_t out_public_value[32],
                                const uint8_t private_key[32]);

int X25519(uint8_t out_shared_key[32], const uint8_t private_key[32],
           const uint8_t peer_public_value[32]);