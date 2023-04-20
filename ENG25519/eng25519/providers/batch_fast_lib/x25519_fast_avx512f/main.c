/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery
 * curves Version: 2019-02-13
 *
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "cycles.h"
#include "datatype.h"
#include "montgomery.h"

#define SPEED
// #define CHECK
// #define MAGMA

#ifdef SPEED
int main()
{
    const unsigned char A[32] = {
        0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    unsigned char k[32], q[32], p[32], r = 0;
    int i, seed;

    seed = (int)time(NULL);
    srandom(seed);

    printf("\n//avx512-5limb-4x2 scalar_mult_var_base() speed test...\n\n");
    fflush(stdout);
    // benchmark part
    uint64_t start_cycles, end_cycles, diff_cycles;
    clock_t start_time, end_time;
    double tp;
    int iterations = 20000;
    // Change scalar. Do clamping as in curve25519.
    for (i = 0; i < 32; i++) {
        k[i] = (unsigned char)random();
    }
    k[0] &= 248;
    k[31] &= 127;
    k[31] |= 64;
    // Change base point.
    for (i = 0; i < 32; i++) {
        p[i] = (unsigned char)random();
    }
    p[31] &= 127;
    // Just measure variable-point variable-scalar multiplication.
    for (i = 0; i < iterations; i++)
        scalar_mult_var_base(q, k, p, A);

    // measure timing
    start_time = clock();
    start_cycles = get_cycles();
    for (i = 0; i < iterations; i++) {
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
        scalar_mult_var_base(q, k, p, A);
    }
    end_cycles = get_cycles();
    end_time = clock();
    diff_cycles = (end_cycles - start_cycles) / (10 * iterations);
    printf("  - Latency (single): %ld\n", diff_cycles);
    tp = 1e6 * 10 * iterations / (double)(end_time - start_time);
    printf("  - Throughput: %8.1f op/sec\n", tp);
    // Chain the output to prevent the compiler from removing code.
    for (i = 0; i < 32; i++) {
        r ^= q[i];
    }
    // printf("\n//Chained output (to be omitted): %d.\n", r);

    return 0;
}
#endif

#ifdef CHECK
void print_scalar(char *str, const unsigned char *n)
{
    int i;
    printf("%s:=", str);
    for (i = 0; i < 32; i++) {
        printf("+(2^8)^%d*(%u)", i, n[i]);
    }
    printf("; printf \"\\n%s : \%\%o\",%s;\n\n", str, str);
}

void print_point(char *str, const unsigned char *n)
{
    int i;
    printf("F:=GF(2^255-19); B:=2^29; ");
    printf("%s:=", str);
    for (i = 0; i < 32; i++) {
        printf("+(2^8)^%d*(%u)", i, n[i]);
    }
    printf("; printf \"\\n%s : \%\%o\",F!%s;\n\n", str, str);
}

int main()
{
    const unsigned char A[32] = {
        0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    uint32_t base_point[8] = {0x00000009, 0x00000000, 0x00000000, 0x00000000,
                              0x00000000, 0x00000000, 0x00000000, 0x00000000};
    // Alice's public key from RFC 7748
    // 8520f009 8930a754 748b7ddc b43ef75a 0dbf3a0d 26381af4 eba4a98e aa9b4e6a
    uint32_t pk_a[8] = {0x09f02085, 0x54a73089, 0xdc7d8b74, 0x5af73eb4,
                        0x0d3abf0d, 0xf41a3826, 0x8ea9a4eb, 0x6a4e9baa};
    // Alice's private key from RFC 7748
    // 77076d0a 7318a57d 3c16c172 51b26645 df4c2f87 ebc0992a b177fba5 1db92c2a
    uint32_t sk_a[8] = {0x0a6d0777, 0x7da51873, 0x72c1163c, 0x4566b251,
                        0x872f4cdf, 0x2a99c0eb, 0xa5fb77b1, 0x2a2cb91d};
    // Bob's secret key from RFC 7748
    // 5dab087e 624a8a4b 79e17f8b 83800ee6 6f3bb129 2618b6fd 1c2f8b27 ff88e0eb
    uint32_t sk_b[8] = {0x7e08ab5d, 0x4b8a4a62, 0x8b7fe179, 0xe60e8083,
                        0x29b13b6f, 0xfdb61826, 0x278b2f1c, 0xebe088ff};
    // ALice and Bob's shared secret
    // 4a5d9d5b a4ce2de1 728e3bf4 80350f25 e07e21c9 47d19e33 76f09b3c 1e161742
    uint32_t ss_ab_rfc[8] = {0x5B9D5D4A, 0xE12DCEA4, 0xF43B8E72, 0x250F3580,
                             0xC9217EE0, 0x339ED147, 0x3C9BF076, 0x4217161E};
    unsigned char bp[32], k1[32], k2[32], op1[32], op2[32], op3[32], op4[32];
    int seed, i, j;

    // test with vector from RFC 7748
    scalar_mult_var_base(op1, (uint8_t *)sk_b, (uint8_t *)pk_a, A);
    if (memcmp(op1, ss_ab_rfc, 32) == 0) {
        printf("Test passed with vector from RFC 7748\n");
    } else {
        printf("Test failed with vector from RFC 7748\n");
    }

    scalar_mult_var_base(op1, (uint8_t *)sk_a, (uint8_t *)base_point, A);
    if (memcmp(op1, pk_a, 32) == 0) {
        printf("Test passed with vector from RFC 7748\n");
    } else {
        printf("Test failed with vector from RFC 7748\n");
    }

    seed = (int)time(NULL);
    srandom(seed);

    printf("\n//Running DH Verifications with session seed %d:\n\n", seed);
    for (j = 0; j < 100000; j++) {
        // Do clamping as in curve25519.
        for (i = 0; i < 32; i++) {
            k1[i] = (unsigned char)random();
        }
        k1[0] &= 248;
        k1[31] &= 127;
        k1[31] |= 64;
        for (i = 0; i < 32; i++) {
            k2[i] = (unsigned char)random();
        }
        k2[0] &= 248;
        k2[31] &= 127;
        k2[31] |= 64;
        for (i = 0; i < 32; i++) {
            bp[i] = (unsigned char)random();
        }
        bp[31] &= 127;

        scalar_mult_var_base(op1, k1, bp, A);
        scalar_mult_var_base(op2, k2, bp, A);
        scalar_mult_var_base(op3, k1, op2, A);
        scalar_mult_var_base(op4, k2, op1, A);

        for (i = 0; i < 32; i++) {
            if (op3[i] != op4[i]) {
                printf("//DH check failed (seed %d, iteration %d):\n", seed, j);
                printf("\n\nclear; Fp:=GF(2^255-19);\n");
                printf("E:=EllipticCurve([0,Fp!486662,0,1,0]);\n\n");
                print_point("bp", bp);
                print_scalar("k1", k1);
                print_scalar("k2", k2);
                print_point("op1", op1);
                print_point("op2", op2);
                print_point("op3", op3);
                print_point("op4", op4);
                return 1;
            }
        }
        if ((j % 10000) == 0) {
            printf(
                "Test passed : [k1]*([k2]*P) = [k2]*([k1]*P). Iterations: %d\n",
                j);
            fflush(stdout);
        }
    }
    printf("\n\nAll tests passed.\n\n");

    return 0;
}
#endif

#ifdef MAGMA
int main()
{
    const unsigned char A[32] = {
        0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
    unsigned char bp[32] = {0x86, 0x4F, 0xCA, 0x0A, 0x0B, 0x0B, 0x65, 0x3B,
                            0xA7, 0x57, 0xCA, 0xC0, 0xBF, 0x08, 0x3E, 0x00,
                            0xDA, 0xD1, 0x22, 0xF6, 0xDD, 0x5E, 0x5B, 0xE5,
                            0x6C, 0x29, 0xB6, 0x78, 0x70, 0x6F, 0x41, 0x70};
    unsigned char op1[32], k1[32];
    int i, j, seed;

    seed = (int)time(NULL);
    srandom(seed);

    fprintf(stdout, "\n\nclear; Fp:=GF(2^255-19);\n");
    fprintf(stdout, "E:=EllipticCurve([0,Fp!486662,0,1,0]);\n");
    fprintf(stdout, "res:=true;\n");
    for (j = 0; j < 100; j++) {
        // Do clamping as in curve25519.
        for (i = 0; i < 32; i++) {
            k1[i] = (unsigned char)random();
        }
        k1[0] &= 248;
        k1[31] &= 127;
        k1[31] |= 64;

        scalar_mult_var_base(op1, k1, bp, A);

        fprintf(stdout, "k:=");
        for (i = 0; i < 32; i++) {
            fprintf(stdout, "+%hhu*256^%d", k1[i], i);
        }
        fprintf(stdout, ";\nx0:=Fp!(");
        for (i = 0; i < 32; i++) {
            fprintf(stdout, "+%hhu*256^%d", bp[i], i);
        }
        fprintf(stdout, ");\nx1:=Fp!(");
        for (i = 0; i < 32; i++) {
            fprintf(stdout, "+%hhu*256^%d", op1[i], i);
        }
        fprintf(stdout, ");");
        fprintf(stdout, "P:=Points(E,x0)[1]; ");
        fprintf(stdout, "res:=res and (x1 eq (k*P)[1]);\n");
    }
    fprintf(stdout, "res;\n");
    fflush(stdout);
    return 0;
}
#endif
