/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include <openssl/rand.h>
#include <stdint.h>
#include <stdio.h>   // puts, printf
#include <stdlib.h>  // srandom, rand
#include <string.h>
#include <time.h>

#include "clocks.h"
#include "ecdh.h"
#include "gfparith.h"
#include "moncurve.h"
#include "tedcurve.h"
#include "tedtable.h"
#include "utils.h"

void timing_fp_arith()
{
    fe_8x1 a, b, r;

    CLOCKS(8 - Way ADC, adc_fp255_8x1w(r, a, b), 1000);
    CLOCKS(8 - Way SBC, sbc_fp255_8x1w(r, a, b), 1000);
    CLOCKS(8 - Way MUL, mul_fp255_8x1w(r, a, b), 1000);
    CLOCKS(8 - Way SQR, sqr_fp255_8x1w(r, a), 1000);
}

/**
 * @brief Test the correctness of our software.
 *
 * @details
 * Test the correctness of key generation and shared secret according to the
 * test vectors of RFC 7748 and random private keys.
 */
void test_ecdh()
{
    int i, j, seed, wrong = 0;

    /** vector form of public keys */
    __m512i pks_vec[NWORDS_8x1];
    /** 8 64-bit form public keys */
    uint64_t pks1[(PUBLIC_KEY_BYTES / 8) * BATCH_SIZE];
    /** 8 64-bit form public keys */
    uint64_t pks2[(PUBLIC_KEY_BYTES / 8) * BATCH_SIZE];
    /** 8 51-bit form public keys */
    uint64_t pks_storage[NWORDS_8x1][BATCH_SIZE];
    /** temporary usage for storing a temp-form public key */
    uint64_t pk_temp[NWORDS_8x1];

    /** vector form of secret keys */
    __m512i sks_vec[BATCH_SIZE];
    /** 8 32-bit form secret keys */
    uint32_t sks[BATCH_SIZE][SECRET_KEY_BYTES / 4] = {
        /** Alice's private key (from RFC7748) */
        {0x0a6d0777, 0x7da51873, 0x72c1163c, 0x4566b251, 0x872f4cdf, 0x2a99c0eb,
         0xa5fb77b1, 0x2a2cb91d},
        /** Bob's private key (from RFC7748) */
        {0x7e08ab5d, 0x4b8a4a62, 0x8b7fe179, 0xe60e8083, 0x29b13b6f, 0xfdb61826,
         0x278b2f1c, 0xebe088ff},
        /** C's private key (from RFC7748) */
        {0x0a6d0777, 0x7da51873, 0x72c1163c, 0x4566b251, 0x872f4cdf, 0x2a99c0eb,
         0xa5fb77b1, 0x2a2cb91d},
        /** D's private key (from RFC7748) */
        {0x7e08ab5d, 0x4b8a4a62, 0x8b7fe179, 0xe60e8083, 0x29b13b6f, 0xfdb61826,
         0x278b2f1c, 0xebe088ff}};

    /** vector form of shared secrets */
    __m512i sss_vec[NWORDS_8x1];
    /** 8 64-bit form shared secrets */
    uint64_t sss[BATCH_SIZE][SHARED_KEY_BYTES / 8];
    /** 8 51-bit form shared secrets */
    uint64_t(*sss_storage)[BATCH_SIZE] = pks_storage;
    /** temporary usage for storing a temp-form shared secret */
    uint64_t *ss_temp = pk_temp;
    /** Alice & Bob's shared secret from RFC7748 */
    uint32_t ss_ab_rfc[SHARED_KEY_BYTES / 4] = {0x5B9D5D4A, 0xE12DCEA4, 0xF43B8E72,
                                                0x250F3580, 0xC9217EE0, 0x339ED147,
                                                0x3C9BF076, 0x4217161E};

    /** initialize random generator */
    seed = 1;
    srand(seed);

    for (i = 0; i < SECRET_KEY_BYTES / 4; i++) {
        sks[4][i] = rand32();
        sks[5][i] = rand32();
        sks[6][i] = rand32();
        sks[7][i] = rand32();
    }

    /** initialize AVX512 vector of private key */
    for (i = 0; i < BATCH_SIZE; i++)
        sks_vec[i] = VSET(sks[7][i], sks[6][i], sks[5][i], sks[4][i], sks[3][i],
                          sks[2][i], sks[1][i], sks[0][i]);
    keygen(pks_vec, sks_vec);

    crypto_x25519_batch_keygen((uint8_t *)pks2, (uint8_t *)sks);

    for (i = 0; i < NWORDS_8x1; i++) {
        VSTORE(pks_storage[i], pks_vec[i]);
    }
    for (i = 0; i < BATCH_SIZE; i++) {
        for (j = 0; j < NWORDS_8x1; j++) {
            pk_temp[j] = pks_storage[j][i];
        }
        conv_51to64((pks1 + (PUBLIC_KEY_BYTES / 8) * i), (PUBLIC_KEY_BYTES / 8), pk_temp,
                    NWORDS_8x1);
    }
    /** compare two different-output-form functions' outputs */
    if (memcmp(pks1, pks2, PUBLIC_KEY_BYTES * BATCH_SIZE) != 0) {
        printf("crypto_x25519_batch_keygen error\n");
        return;
    }

    /**
     * we simply swap the position of pk_a and pk_b in the AVX2 vectors
     * so now it is (pk_g, pk_h, pk_e, pk_f, pk_c, pk_d, pk_a, pk_b)
     */
    for (i = 0; i < NWORDS_8x1; i++)
        pks_vec[i] = VPERM(pks_vec[i], 0xB1);

    /**
     * Shared Secret
     * sks_vec = (sk_h, sk_g, sk_f, sk_e, sk_d, sk_c, sk_b, sk_a)
     * pks_vec = (pk_g, pk_h, pk_e, pk_f, pk_c, pk_d, pk_a, pk_b)
     * each pair should obtain the same shared secret
     */
    shared_secret(sss_vec, sks_vec, pks_vec);

    for (i = 0; i < NWORDS_8x1; i++) {
        VSTORE(sss_storage[i], sss_vec[i]);
    }
    for (i = 0; i < BATCH_SIZE; i++) {
        for (j = 0; j < NWORDS_8x1; j++) {
            ss_temp[j] = sss_storage[j][i];
        }
        conv_51to64(sss[i], (SHARED_KEY_BYTES) / 8, ss_temp, NWORDS_8x1);
        if (i < 4) {
            /** compare with the values provided by RFC 7748 */
            wrong = wrong | (memcmp(sss[i], ss_ab_rfc, 4 * sizeof(uint64_t)));
        }
    }
    /** compare two parties' shared secrets */
    wrong = wrong | (memcmp(sss[0], sss[1], (SHARED_KEY_BYTES / 8) * sizeof(uint64_t)));
    wrong = wrong | (memcmp(sss[2], sss[3], (SHARED_KEY_BYTES / 8) * sizeof(uint64_t)));
    wrong = wrong | (memcmp(sss[4], sss[5], (SHARED_KEY_BYTES / 8) * sizeof(uint64_t)));
    wrong = wrong | (memcmp(sss[6], sss[7], (SHARED_KEY_BYTES / 8) * sizeof(uint64_t)));

    /**
     * if wrong != 0 means there is at least one test that is wrong!
     * if wrong == 0 means that all the shared secrets are equal!
     */
    if (wrong)
        printf("X25519 TEST: NOT PASS!\n");
    else
        printf(
            "X25519 TEST : PASS including comparison with test vector in "
            "RFC7748!\n");
}

void test_ed25519_keygen()
{
    uint8_t sks[BATCH_SIZE][SECRET_KEY_BYTES] = {
        /** sk0 from RFC8032 */
        {0x9d, 0x61, 0xb1, 0x9d, 0xef, 0xfd, 0x5a, 0x60, 0xba, 0x84, 0x4a,
         0xf4, 0x92, 0xec, 0x2c, 0xc4, 0x44, 0x49, 0xc5, 0x69, 0x7b, 0x32,
         0x69, 0x19, 0x70, 0x3b, 0xac, 0x03, 0x1c, 0xae, 0x7f, 0x60},
        /** sk1 from RFC8032 */
        {0x4c, 0xcd, 0x08, 0x9b, 0x28, 0xff, 0x96, 0xda, 0x9d, 0xb6, 0xc3,
         0x46, 0xec, 0x11, 0x4e, 0x0f, 0x5b, 0x8a, 0x31, 0x9f, 0x35, 0xab,
         0xa6, 0x24, 0xda, 0x8c, 0xf6, 0xed, 0x4f, 0xb8, 0xa6, 0xfb},
        /** sk2 from RFC8032 */
        {0xc5, 0xaa, 0x8d, 0xf4, 0x3f, 0x9f, 0x83, 0x7b, 0xed, 0xb7, 0x44,
         0x2f, 0x31, 0xdc, 0xb7, 0xb1, 0x66, 0xd3, 0x85, 0x35, 0x07, 0x6f,
         0x09, 0x4b, 0x85, 0xce, 0x3a, 0x2e, 0x0b, 0x44, 0x58, 0xf7},
        /** sk0 from RFC8032 */
        {0x9d, 0x61, 0xb1, 0x9d, 0xef, 0xfd, 0x5a, 0x60, 0xba, 0x84, 0x4a,
         0xf4, 0x92, 0xec, 0x2c, 0xc4, 0x44, 0x49, 0xc5, 0x69, 0x7b, 0x32,
         0x69, 0x19, 0x70, 0x3b, 0xac, 0x03, 0x1c, 0xae, 0x7f, 0x60},
        /** sk1 from RFC8032 */
        {0x4c, 0xcd, 0x08, 0x9b, 0x28, 0xff, 0x96, 0xda, 0x9d, 0xb6, 0xc3,
         0x46, 0xec, 0x11, 0x4e, 0x0f, 0x5b, 0x8a, 0x31, 0x9f, 0x35, 0xab,
         0xa6, 0x24, 0xda, 0x8c, 0xf6, 0xed, 0x4f, 0xb8, 0xa6, 0xfb},
        /** sk2 from RFC8032 */
        {0xc5, 0xaa, 0x8d, 0xf4, 0x3f, 0x9f, 0x83, 0x7b, 0xed, 0xb7, 0x44,
         0x2f, 0x31, 0xdc, 0xb7, 0xb1, 0x66, 0xd3, 0x85, 0x35, 0x07, 0x6f,
         0x09, 0x4b, 0x85, 0xce, 0x3a, 0x2e, 0x0b, 0x44, 0x58, 0xf7},
        /** sk0 from RFC8032 */
        {0x9d, 0x61, 0xb1, 0x9d, 0xef, 0xfd, 0x5a, 0x60, 0xba, 0x84, 0x4a,
         0xf4, 0x92, 0xec, 0x2c, 0xc4, 0x44, 0x49, 0xc5, 0x69, 0x7b, 0x32,
         0x69, 0x19, 0x70, 0x3b, 0xac, 0x03, 0x1c, 0xae, 0x7f, 0x60},
        /** sk1 from RFC8032 */
        {0x4c, 0xcd, 0x08, 0x9b, 0x28, 0xff, 0x96, 0xda, 0x9d, 0xb6, 0xc3,
         0x46, 0xec, 0x11, 0x4e, 0x0f, 0x5b, 0x8a, 0x31, 0x9f, 0x35, 0xab,
         0xa6, 0x24, 0xda, 0x8c, 0xf6, 0xed, 0x4f, 0xb8, 0xa6, 0xfb},
    };
    uint8_t pks[BATCH_SIZE][PUBLIC_KEY_BYTES] = {
        /** pk0 from RFC8032 */
        {0xd7, 0x5a, 0x98, 0x01, 0x82, 0xb1, 0x0a, 0xb7, 0xd5, 0x4b, 0xfe,
         0xd3, 0xc9, 0x64, 0x07, 0x3a, 0x0e, 0xe1, 0x72, 0xf3, 0xda, 0xa6,
         0x23, 0x25, 0xaf, 0x02, 0x1a, 0x68, 0xf7, 0x07, 0x51, 0x1a},
        /** pk1 from RFC8032 */
        {0x3d, 0x40, 0x17, 0xc3, 0xe8, 0x43, 0x89, 0x5a, 0x92, 0xb7, 0x0a,
         0xa7, 0x4d, 0x1b, 0x7e, 0xbc, 0x9c, 0x98, 0x2c, 0xcf, 0x2e, 0xc4,
         0x96, 0x8c, 0xc0, 0xcd, 0x55, 0xf1, 0x2a, 0xf4, 0x66, 0x0c},
        /** pk2 from RFC8032 */
        {0xfc, 0x51, 0xcd, 0x8e, 0x62, 0x18, 0xa1, 0xa3, 0x8d, 0xa4, 0x7e,
         0xd0, 0x02, 0x30, 0xf0, 0x58, 0x08, 0x16, 0xed, 0x13, 0xba, 0x33,
         0x03, 0xac, 0x5d, 0xeb, 0x91, 0x15, 0x48, 0x90, 0x80, 0x25},
        /** pk0 from RFC8032 */
        {0xd7, 0x5a, 0x98, 0x01, 0x82, 0xb1, 0x0a, 0xb7, 0xd5, 0x4b, 0xfe,
         0xd3, 0xc9, 0x64, 0x07, 0x3a, 0x0e, 0xe1, 0x72, 0xf3, 0xda, 0xa6,
         0x23, 0x25, 0xaf, 0x02, 0x1a, 0x68, 0xf7, 0x07, 0x51, 0x1a},
        /** pk1 from RFC8032 */
        {0x3d, 0x40, 0x17, 0xc3, 0xe8, 0x43, 0x89, 0x5a, 0x92, 0xb7, 0x0a,
         0xa7, 0x4d, 0x1b, 0x7e, 0xbc, 0x9c, 0x98, 0x2c, 0xcf, 0x2e, 0xc4,
         0x96, 0x8c, 0xc0, 0xcd, 0x55, 0xf1, 0x2a, 0xf4, 0x66, 0x0c},
        /** pk2 from RFC8032 */
        {0xfc, 0x51, 0xcd, 0x8e, 0x62, 0x18, 0xa1, 0xa3, 0x8d, 0xa4, 0x7e,
         0xd0, 0x02, 0x30, 0xf0, 0x58, 0x08, 0x16, 0xed, 0x13, 0xba, 0x33,
         0x03, 0xac, 0x5d, 0xeb, 0x91, 0x15, 0x48, 0x90, 0x80, 0x25},
        /** pk0 from RFC8032 */
        {0xd7, 0x5a, 0x98, 0x01, 0x82, 0xb1, 0x0a, 0xb7, 0xd5, 0x4b, 0xfe,
         0xd3, 0xc9, 0x64, 0x07, 0x3a, 0x0e, 0xe1, 0x72, 0xf3, 0xda, 0xa6,
         0x23, 0x25, 0xaf, 0x02, 0x1a, 0x68, 0xf7, 0x07, 0x51, 0x1a},
        /** pk1 from RFC8032 */
        {0x3d, 0x40, 0x17, 0xc3, 0xe8, 0x43, 0x89, 0x5a, 0x92, 0xb7, 0x0a,
         0xa7, 0x4d, 0x1b, 0x7e, 0xbc, 0x9c, 0x98, 0x2c, 0xcf, 0x2e, 0xc4,
         0x96, 0x8c, 0xc0, 0xcd, 0x55, 0xf1, 0x2a, 0xf4, 0x66, 0x0c},
    };
    uint8_t pks_0[BATCH_SIZE][PUBLIC_KEY_BYTES];
    crypto_ed25519_batch_keygen((uint8_t *)pks_0, (uint8_t *)sks);
    if (memcmp(pks, pks_0, sizeof(pks_0)) == 0) {
        printf("Ed25519-KeyGen TEST: PASS including vectors from RFC8032!\n");
    } else {
        printf("Ed25519-KeyGen TEST: NOT PASS!\n");
    }
}

/**
 * @brief Measure latency of point operations.
 *
 * @details
 * Measure latency of ladder-step on Montgomery curve and point addition,
 * doubling, table-based multiplication on twisted Edward curve.
 */
void timing_point_arith()
{
    ProPoint p, q;
    ExtPoint r;
    __m512i t[NWORDS_8x1];

    puts("\nMontgomery curve:");
    CLOCKS(8 - Way Ladder - Step, mon_ladder_step_avx512(&p, &q, t), 1000);

    puts("\ntwisted Edwards curve:");
    CLOCKS(8 - Way Point Addition, ted_point_add_avx512(&r, &r, &p), 1000);
    CLOCKS(8 - Way Point Doubling, ted_point_dbl_avx512(&r, &r), 1000);
    CLOCKS(8 - Way Point Doubling, ted_point_dbl_no_T_avx512(&r, &r), 1000);
    CLOCKS(8 - Way Table Query, ted_point_query_table_avx512(&p, 0, t[0]), 1000);
}

void timing_ecdh()
{
    __m512i a[NWORDS_8x1], r[NWORDS_8x1];
    uint8_t pks[8 * 32], sks[8 * 32];

    oper_second_n(while (0), keygen, keygen(r, r), 20000, 8);
    oper_second_n(while (0), crypto_x25519_batch_keygen,
                  crypto_x25519_batch_keygen(pks, sks), 20000, 8);
    oper_second_n(
        while (0), crypto_x25519_batch_keygen with random,
        {
            RAND_bytes(sks, 8 * 32);
            crypto_x25519_batch_keygen(pks, sks);
        },
        20000, 8);
    oper_second_n(while (0), Shared Secret, shared_secret(r, a, r), 20000, 8);
    // oper_second_n(while (0), Shared Secret 1x4w,
    //               crypto_x25519_sharedsecret(sks + 32, sks, pks), 20000, 1);
}

void timing_all()
{
    puts(
        "\n\n******************************************************************"
        "*");
    puts("TIMING OF SOFTWARE (clock cycles):");
    puts("-------------------------------------------------------------------");
    puts("Field operations:");
    timing_fp_arith();
    puts("-------------------------------------------------------------------");
    puts("Point operations:");
    timing_point_arith();
    puts("-------------------------------------------------------------------");
    puts("Diffie-Hellman functions:");
    timing_ecdh();
    puts("*******************************************************************");
}

int main(int argc, char *argv[])
{
    (void)argv;
    if (argc == 2) {
        test_ecdh();
        test_ed25519_keygen();
    } else {
        test_ecdh();
        test_ed25519_keygen();
        timing_all();
    }
    return 0;
}