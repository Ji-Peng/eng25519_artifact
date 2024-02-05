/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "curve25519.h"

#include <openssl/sha.h>

#include "gfparith_1w.h"
#include "moncurve.h"
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
void x25519_keygen_avx512_8x1w(__m512i *pk, const __m512i *sk)
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
void x25519_batch_keygen_8x1w(uint8_t *pks, uint8_t *sks)
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
        STORE(pks_storage[i], pks_vec[i]);
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
void ed25519_batch_keygen_8x1w(uint8_t *pks, uint8_t *sks)
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
void x25519_derive_avx512_8x1w(__m512i *ss, const __m512i *ska, const __m512i *pkb)
{
    mon_mul_var_base_avx512(ss, ska, pkb);
    final_modp_fp255_8x1w(ss);
}

int ed25519_sign_1x8w(uint8_t *signature, const uint8_t *message, uint64_t message_length,
                      const uint8_t *pk, const uint8_t *sk)
{
    SHA512_CTX ctx;
    uint8_t H_RAM[64], r[64], ah[64];

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, sk, 32);
    SHA512_Final(ah, &ctx);
    ah[0] &= -((uint8_t)1 << 3);
    ah[31] &= 127;
    ah[31] |= 64;

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, ah + 32, 32);
    SHA512_Update(&ctx, message, message_length);
    SHA512_Final(r, &ctx);
    modular_reduction_ed25519(r);

    PointXYTZ_2x4w t;
    point_multiplication_1x8w_ed25519(&t, r);
    point_encoding_1x8w_ed25519(signature, &t);

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, signature, 32);
    SHA512_Update(&ctx, pk, 32);
    SHA512_Update(&ctx, message, message_length);
    SHA512_Final(H_RAM, &ctx);
    modular_reduction_ed25519(H_RAM);

    calculate_s_ed25519(signature + 32, r, H_RAM, ah);
    return 1;
}

int ed25519_verify_1x2w(const uint8_t *message, uint64_t message_length,
                        const uint8_t *pk, const uint8_t *signature)
{
    SHA512_CTX ctx;
    uint8_t H_RAM[64];
    PointXYTZ_2x4w AA;
    uint8_t Q[64];
    const uint8_t *s;
    const uint8_t allzeroes[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    /* 27742317777372353535851937790883648493 in little endian format */
    const uint8_t l_low[16] = {0xED, 0xD3, 0xF5, 0x5C, 0x1A, 0x63, 0x12, 0x58,
                               0xD6, 0x9C, 0xF7, 0xA2, 0xDE, 0xF9, 0xDE, 0x14};
    int i;

    s = signature + 32;

    /**
     * Check 0 <= s < L where L = 2^252 + 27742317777372353535851937790883648493
     *
     * If not the signature is publicly invalid. Since it's public we can do the
     * check in variable time.
     *
     * First check the most significant byte
     */
    if (s[31] > 0x10)
        return 0;
    if (s[31] == 0x10) {
        /*
         * Most significant byte indicates a value close to 2^252 so check the
         * rest
         */
        if (memcmp(s + 16, allzeroes, sizeof(allzeroes)) != 0)
            return 0;
        for (i = 15; i >= 0; i--) {
            if (s[i] < l_low[i])
                break;
            if (s[i] > l_low[i])
                return 0;
        }
        if (i < 0)
            return 0;
    }

    point_decoding_2x4w_ed25519(&AA, (uint8_t *)pk);

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, signature, 32);
    SHA512_Update(&ctx, pk, 32);
    SHA512_Update(&ctx, message, message_length);
    SHA512_Final(H_RAM, &ctx);
    modular_reduction_ed25519(H_RAM);

    double_point_mult_2x4w_ed25519(Q, H_RAM, &AA, s);
    return (memcmp(signature, Q, 32) == 0) ? 1 : 0;
}