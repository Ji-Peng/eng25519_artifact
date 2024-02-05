/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "ed255.h"

#include <openssl/sha.h>

#include "edwards255_avx512.h"
#include "eltfp255_1w_fullradix.h"

int ed25519_sign(uint8_t *signature, const uint8_t *message, uint64_t message_length,
                 const uint8_t *pk, const uint8_t *sk)
{
    SHA512_CTX ctx;
    ALIGN uint8_t H_RAM[ED25519_HASH_BYTES], r[ED25519_HASH_BYTES],
        ah[ED25519_HASH_BYTES];

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, sk, ED25519_KEY_SIZE);
    SHA512_Final(ah, &ctx);
    ah[0] &= -((uint8_t)1 << ED25519_C_PARAM);
    ah[31] &= 127;
    ah[31] |= 64;

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, ah + ED25519_KEY_SIZE, ED25519_KEY_SIZE);
    SHA512_Update(&ctx, message, message_length);
    SHA512_Final(r, &ctx);
    modular_reduction_ed25519(r);

    PointXYTZ_2x4w t;
    point_multiplication_1x8w_ed25519(&t, r);
    point_encoding_1x8w_ed25519(signature, &t);

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, signature, ED25519_KEY_SIZE);
    SHA512_Update(&ctx, pk, ED25519_KEY_SIZE);
    SHA512_Update(&ctx, message, message_length);
    SHA512_Final(H_RAM, &ctx);
    modular_reduction_ed25519(H_RAM);

    calculate_s_ed25519(signature + ED25519_KEY_SIZE, r, H_RAM, ah);
    return 1;
}

int ed25519_verify(const uint8_t *message, uint64_t message_length, const uint8_t *pk,
                   const uint8_t *signature)
{
    SHA512_CTX ctx;
    ALIGN uint8_t H_RAM[ED25519_HASH_BYTES];
    PointXYTZ_2x4w AA;
    ALIGN uint8_t Q[ED25519_SIG_SIZE];
    const uint8_t *s;
    const uint8_t allzeroes[15] = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
    /* 27742317777372353535851937790883648493 in little endian format */
    const uint8_t l_low[16] = {0xED, 0xD3, 0xF5, 0x5C, 0x1A, 0x63, 0x12, 0x58,
                               0xD6, 0x9C, 0xF7, 0xA2, 0xDE, 0xF9, 0xDE, 0x14};
    int i;

    s = signature + ED25519_KEY_SIZE;

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
    SHA512_Update(&ctx, signature, ED25519_KEY_SIZE);
    SHA512_Update(&ctx, pk, ED25519_KEY_SIZE);
    SHA512_Update(&ctx, message, message_length);
    SHA512_Final(H_RAM, &ctx);
    modular_reduction_ed25519(H_RAM);

    double_point_mult_2x4w_ed25519(Q, H_RAM, &AA, s);
    return (memcmp(signature, Q, ED25519_KEY_SIZE) == 0) ? 1 : 0;
}

int ed25519_sk_to_pk_internal(uint8_t *pk, const uint8_t *sk)
{
    SHA512_CTX ctx;
    uint8_t az[ED25519_HASH_BYTES];
    PointXYTZ_2x4w azB;

    SHA512_Init(&ctx);
    SHA512_Update(&ctx, sk, ED25519_KEY_SIZE);
    SHA512_Final(az, &ctx);

    az[0] &= -((uint8_t)1 << ED25519_C_PARAM);
    az[31] &= 127;
    az[31] |= 64;

    /* Reduce mod order of the curve */
    ((uint64_t *)az)[4] = (uint64_t)(az[31] >> 4);
    az[31] &= ((uint8_t)1 << 4) - 1;
    reduce64bits((uint64_t *)az);

    point_multiplication_1x8w_ed25519(&azB, az);
    point_encoding_1x8w_ed25519(pk, &azB);
    return 1;
}