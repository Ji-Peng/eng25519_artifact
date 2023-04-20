#include "ecdh.h"

#include <openssl/sha.h>
#include <string.h>

#include "moncurve.h"
// #include "providers/batch_fast_lib/ed25519_fast_avx512ifma/eltfp255_1w_fullradix.h"
#include "../ed25519_fast_avx512ifma/eltfp255_1w_fullradix.h"
#include "tedcurve.h"
#include "utils.h"

/**
 * @brief Key generation.
 *
 * @details
 * Generate public key based on the given private key.
 *
 * @param pk Public key
 * @param sk Private key
 */
void keygen(__m512i *pk, const __m512i *sk)
{
    int i;
    __m512i _sk[8];
    const __m512i t0 = VSET1(0xFFFFFFF8U);
    const __m512i t1 = VSET1(0x7FFFFFFFU);
    const __m512i t2 = VSET1(0x40000000U);
    for (i = 0; i < 8; i++)
        _sk[i] = sk[i];
    _sk[0] = VAND(_sk[0], t0);
    _sk[7] = VAND(_sk[7], t1);
    _sk[7] = VOR(_sk[7], t2);
    /**
     * Fixed-base scalar multiplication on twisted Edwards curve, followed by a conversion
     * of the obtained point to the corresponding Montgomery curve
     */
    mon_mul_fixed_base_x25519_avx512(pk, _sk);
    final_modp_fp255_8x1w(pk);
}

/**
 * Batch keygen function for X25519.
 * You should alloc enough memory for accommodating 8 pks and 8 sks.
 * @param pks: used for accommodating 8 public keys; size should be greater than
 * or equal to 8 * 32 bytes.
 * @param sks: used for accommodating 8 secret keys; size should be
 * greater than or equal to 8 * 32 bytes.
 */
void crypto_x25519_batch_keygen(uint8_t *pks, uint8_t *sks)
{
    int i, j;
    const __m512i t0 = VSET1(0xFFFFFFF8U);
    const __m512i t1 = VSET1(0x7FFFFFFFU);
    const __m512i t2 = VSET1(0x40000000U);
    /** vector form of secret keys, each 64-bit lane contain a 32-bit value */
    __m512i sks_vec[BATCH_SIZE];
    /** vector form of public keys */
    __m512i pks_vec[NWORDS_8x1];
    /**
     * 1th sk: _sks[0] - _sks[BATCH_SIZE-1]
     * 2th sk: _sks[1 * BATCH_SIZE] - _sks[2 * BATCH_SIZE - 1]
     * ...
     * 8th sk: _sks[7 * BATCH_SIZE] - _sks[8 * BATCH_SIZE - 1]
     */
    uint32_t *_sks = (uint32_t *)sks;
    /** 51-bit form of all public keys */
    ALIGN64 uint64_t pks_storage[NWORDS_8x1][BATCH_SIZE];
    /** temporary storage for a 51-bit form public key */
    uint64_t pk_temp[NWORDS_8x1];
    /**
     * 1th pk: _pks[0] - _pks[4 - 1]
     * 2th pk: _pks[4] - _pks[4 * 2 - 1]
     * ...
     * 8th pk: _pks[7 * 4] - _pks[8 * 4 - 1]
     */
    uint64_t *_pks = (uint64_t *)pks;

    /** construct vector form of sks */
    for (i = 0; i < BATCH_SIZE; i++) {
        sks_vec[i] = VSET(_sks[7 * BATCH_SIZE + i], _sks[6 * BATCH_SIZE + i],
                          _sks[5 * BATCH_SIZE + i], _sks[4 * BATCH_SIZE + i],
                          _sks[3 * BATCH_SIZE + i], _sks[2 * BATCH_SIZE + i],
                          _sks[1 * BATCH_SIZE + i], _sks[0 * BATCH_SIZE + i]);
    }
    sks_vec[0] = VAND(sks_vec[0], t0);
    sks_vec[7] = VAND(sks_vec[7], t1);
    sks_vec[7] = VOR(sks_vec[7], t2);
    mon_mul_fixed_base_x25519_avx512(pks_vec, sks_vec);
    final_modp_fp255_8x1w(pks_vec);
    for (i = 0; i < NWORDS_8x1; i++) {
        VSTORE(pks_storage[i], pks_vec[i]);
    }
    for (i = 0; i < BATCH_SIZE; i++) {
        /** get the ith public key */
        for (j = 0; j < NWORDS_8x1; j++) {
            pk_temp[j] = pks_storage[j][i];
        }
        conv_51to64((_pks + (PUBLIC_KEY_BYTES / 8) * i), 4, pk_temp, NWORDS_8x1);
    }
}

/**
 * Batch keygen function for Ed25519.
 * You should alloc enough memory for accommodating 8 pks and 8 sks.
 * @param pks: used for accommodating 8 public keys; size should be greater than
 * or equal to 8 * 32 bytes.
 * @param sks: used for accommodating 8 secret keys; size should be
 * greater than or equal to 8 * 32 bytes.
 */
void crypto_ed25519_batch_keygen(uint8_t *pks, uint8_t *sks)
{
    int i;
    SHA512_CTX ctx;
    const __m512i t0 = VSET1(0xFFFFFFF8U);
    const __m512i t1 = VSET1(0x3FFFFFFFU);
    const __m512i t2 = VSET1(0x40000000U);
    /** vector form of secret keys, each 64-bit lane contain a 32-bit value */
    __m512i sks_vec[BATCH_SIZE];
    uint8_t az[BATCH_SIZE][32];
    /**
     * 1th sk: _az[0] - _az[8-1]
     * 2th sk: _az[1*8] - _az[2*8-1]
     * ...
     * 8th sk: _az[7*8] - _az[8*8-1]
     */
    uint32_t *_az = (uint32_t *)az;
    // TODO: use 8-way sha512 implementation with AVX512 instructions.
    for (i = 0; i < BATCH_SIZE; i++) {
        SHA512_Init(&ctx);
        SHA512_Update(&ctx, sks + i * SECRET_KEY_BYTES, SECRET_KEY_BYTES);
        SHA512_Final(az[i], &ctx);
    }

    /** construct vector form of sks */
    for (i = 0; i < BATCH_SIZE; i++) {
        sks_vec[i] = VSET(_az[7 * 8 + i], _az[6 * 8 + i], _az[5 * 8 + i], _az[4 * 8 + i],
                          _az[3 * 8 + i], _az[2 * 8 + i], _az[1 * 8 + i], _az[0 * 8 + i]);
    }
    sks_vec[0] = VAND(sks_vec[0], t0);
    sks_vec[7] = VAND(sks_vec[7], t1);
    sks_vec[7] = VOR(sks_vec[7], t2);
    mon_mul_fixed_base_ed25519_avx512(pks, sks_vec);
}

/**
 * @brief Shared secret computation.
 *
 * @details
 * Generate a shared secret (session key) based on own private key and the
 * public key of the other side.
 *
 * @param ss  Shared secret
 * @param ska Own private key
 * @param pkb Public key of the other side
 */
void shared_secret(__m512i *ss, const __m512i *ska, const __m512i *pkb)
{
    mon_mul_var_base_avx512(ss, ska, pkb);
    final_modp_fp255_8x1w(ss);
}

// void crypto_x25519_sharedsecret(uint8_t *ss, const uint8_t *ska, const uint8_t *pkb)
// {
//     int i;
//     __m512i z1x1_A[NWORDS_8x1], x3z3x2z2[NWORDS_8x1];
//     uint8_t _ska[32];
//     uint64_t *pkb_p = (uint64_t *)pkb;
//     /** parameter A in X25519 = 0x076D06 */
//     ALIGN64 uint64_t _z1x1_A[NWORDS_8x1][8] = {{1, 0, 0, 0x076D06, 0, 0, 0, 0},
//                                                {0, 0, 0, 0, 0, 0, 0, 0},
//                                                {0, 0, 0, 0, 0, 0, 0, 0},
//                                                {0, 0, 0, 0, 0, 0, 0, 0},
//                                                {0, 0, 0, 0, 0, 0, 0, 0}};
//     ALIGN64 uint64_t _x3z3x2z2[NWORDS_8x1][8] = {{0, 1, 1, 0, 0, 0, 0, 0},
//                                                  {0, 0, 0, 0, 0, 0, 0, 0},
//                                                  {0, 0, 0, 0, 0, 0, 0, 0},
//                                                  {0, 0, 0, 0, 0, 0, 0, 0},
//                                                  {0, 0, 0, 0, 0, 0, 0, 0}};
//     uint64_t x2_51b[NWORDS_8x1], z2_51b[NWORDS_8x1];
//     uint64_t x2_64b[4], z2_64b[4], inv_z[4];

//     memcpy(_ska, ska, 32);
//     _ska[0] &= 0xF8;
//     _ska[31] &= 0x7F;
//     _ska[31] |= 0x40;

//     /**
//      * construct z1x1_A = [z1 x1 ? A ...]
//      * where z1 = 1, x1 = pkb
//      * construct x3z3x2z2 = [x3 z3 x2 z2 ...]
//      * where x3 = pkb, z3 = 1, x2 = 1, z2 = 0
//      *
//      * 1) convert from 64b representation to 51b.
//      * 2) obtain z1x1_a and x3z3x2z2 via load instructions.
//      */
//     _x3z3x2z2[0][0] = _z1x1_A[0][1] = (pkb_p[0] & MASK51b);
//     _x3z3x2z2[1][0] = _z1x1_A[1][1] = ((pkb_p[1] << 13) | (pkb_p[0] >> 51)) & MASK51b;
//     _x3z3x2z2[2][0] = _z1x1_A[2][1] = ((pkb_p[2] << 26) | (pkb_p[1] >> 38)) & MASK51b;
//     _x3z3x2z2[3][0] = _z1x1_A[3][1] = ((pkb_p[3] << 39) | (pkb_p[2] >> 25)) & MASK51b;
//     _x3z3x2z2[4][0] = _z1x1_A[4][1] = (pkb_p[3] >> 12) & MASK51b;

//     for (i = 0; i < NWORDS_8x1; i++) {
//         z1x1_A[i] = VLOAD512(_z1x1_A[i]);
//         x3z3x2z2[i] = VLOAD512(_x3z3x2z2[i]);
//     }
//     mont_ladder_step_1x4w_avx512(x3z3x2z2, z1x1_A, _ska);
//     /**
//      * 1) get x2 and z2 from x3z3x2z2
//      * 2) convert them to 64b
//      *
//      */
//     for (i = 0; i < NWORDS_8x1; i++) {
//         VSTORE(_x3z3x2z2[i], x3z3x2z2[i]);
//         x2_51b[i] = _x3z3x2z2[i][2];
//         z2_51b[i] = _x3z3x2z2[i][3];
//     }
//     conv_51to64(x2_64b, 4, x2_51b, NWORDS_8x1);
//     conv_51to64(z2_64b, 4, z2_51b, NWORDS_8x1);
//     inv_fp255_1w_fullradix(inv_z, z2_64b);
//     mul_fp255_1w_fullradix(z2_64b, inv_z, x2_64b);
//     ser_fp255_1w_fullradix(ss, z2_64b);
// }