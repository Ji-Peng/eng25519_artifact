/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "eltfp255_1w_fullradix.h"

#include <string.h>

#include "providers/batch_fast_lib/x25519_batch_avx512ifma/openssl_curve25519.h"

void add_fp255_1w_fullradix(uint64_t* c, uint64_t* a, uint64_t* b)
{
    __asm__ __volatile__(
        "movl $38, %%eax;"
        "xorl  %%ecx, %%ecx;"
        "movq  0(%2),  %%r8;"
        "adcx  0(%1),  %%r8;"
        "movq  8(%2),  %%r9;"
        "adcx  8(%1),  %%r9;"
        "movq 16(%2), %%r10;"
        "adcx 16(%1), %%r10;"
        "movq 24(%2), %%r11;"
        "adcx 24(%1), %%r11;"
        "cmovc %%eax, %%ecx;"
        "xorl %%eax, %%eax;"
        "adcx %%rcx,  %%r8;"
        "adcx %%rax,  %%r9;"
        "movq  %%r9,  8(%0);"
        "adcx %%rax, %%r10;"
        "movq %%r10, 16(%0);"
        "adcx %%rax, %%r11;"
        "movq %%r11, 24(%0);"
        "movl $38, %%ecx;"
        "cmovc %%ecx, %%eax;"
        "addq %%rax,  %%r8;"
        "movq  %%r8,  0(%0);"
        :
        : "r"(c), "r"(a), "r"(b)
        : "memory", "cc", "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11");
}

int cmp_fp255_1w_fullradix(uint64_t* a, uint64_t* b)
{
    fe64_tobytes((uint8_t*)a, a);
    fe64_tobytes((uint8_t*)b, b);
    return memcmp((uint8_t*)a, (uint8_t*)b, 32);
}

void cmv_fp255_1w_fullradix(int bit, uint64_t* c, uint64_t* a, uint64_t* b)
{
    __asm__ __volatile__(
        "test       %3,     %3 ;"
        "movq    0(%1),  %%rax ;"
        "cmovnz  0(%2),  %%rax ;"
        "movq    %%rax,  0(%0) ;"

        "movq    8(%1),  %%rax ;"
        "cmovnz  8(%2),  %%rax ;"
        "movq    %%rax,  8(%0) ;"

        "movq   16(%1),  %%rax ;"
        "cmovnz 16(%2),  %%rax ;"
        "movq    %%rax, 16(%0) ;"

        "movq   24(%1),  %%rax ;"
        "cmovnz 24(%2),  %%rax ;"
        "movq    %%rax, 24(%0) ;"
        :
        : "r"(c), "r"(a), "r"(b), "r"(bit)
        : "memory", "cc", "%rax");
}

#define sqrn_fp255_1w_fullradix(A, times) \
    counter = times;                      \
    while (counter-- > 0) {               \
        fe64_sqr(A, A);                   \
    }

void inv_fp255_1w_fullradix(uint64_t* c, uint64_t* a)
{
    uint64_t x0[4];
    uint64_t x1[4];
    uint64_t x2[4];
    uint64_t* T[5];
    int counter;

    T[0] = x0;
    T[1] = c; /* x^(-1) */
    T[2] = x1;
    T[3] = x2;
    T[4] = a; /* x */

    fe64_copy(T[1], T[4]);
    sqrn_fp255_1w_fullradix(T[1], 1);
    fe64_copy(T[2], T[1]);
    sqrn_fp255_1w_fullradix(T[2], 2);
    fe64_mul(T[0], T[4], T[2]);
    fe64_mul(T[1], T[1], T[0]);
    fe64_copy(T[2], T[1]);
    sqrn_fp255_1w_fullradix(T[2], 1);
    fe64_mul(T[0], T[0], T[2]);
    fe64_copy(T[2], T[0]);
    sqrn_fp255_1w_fullradix(T[2], 5);
    fe64_mul(T[0], T[0], T[2]);
    fe64_copy(T[2], T[0]);
    sqrn_fp255_1w_fullradix(T[2], 10);
    fe64_mul(T[2], T[2], T[0]);
    fe64_copy(T[3], T[2]);
    sqrn_fp255_1w_fullradix(T[3], 20);
    fe64_mul(T[3], T[3], T[2]);
    sqrn_fp255_1w_fullradix(T[3], 10);
    fe64_mul(T[3], T[3], T[0]);
    fe64_copy(T[0], T[3]);
    sqrn_fp255_1w_fullradix(T[0], 50);
    fe64_mul(T[0], T[0], T[3]);
    fe64_copy(T[2], T[0]);
    sqrn_fp255_1w_fullradix(T[2], 100);
    fe64_mul(T[2], T[2], T[0]);
    sqrn_fp255_1w_fullradix(T[2], 50);
    fe64_mul(T[2], T[2], T[3]);
    sqrn_fp255_1w_fullradix(T[2], 5);
    fe64_mul(T[1], T[1], T[2]);
}

/**
 * sqrt(u/v) = (u/v)^{(q+3)/8}=uv^3*(uv^7)^{(q-5)/8}
 * (q-5)/8=0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd
 */
void invsqrt_fp255_1w_fullradix(uint64_t* uv_p38, uint64_t* u, uint64_t* v)
{
    const uint64_t sqrt_minus_one[4] = {0xc4ee1b274a0ea0b0, 0x2f431806ad2fe478,
                                        0x2b4d00993dfbd7a7, 0x2b8324804fc1df0b};
    uint64_t v2[4];
    uint64_t uv[4];
    uint64_t uv3[4];
    uint64_t uv7[4];
    uint64_t x2[4];
    uint64_t x9[4];
    uint64_t uv7_p58[4];
    uint64_t* Tab[4];
    int counter;

    /*  uv = u*v     */
    fe64_mul(uv, u, v);
    fe64_copy(v2, v);
    /*  v2 = v^2     */
    fe64_sqr(v2, v2);
    /*  uv3 = uv^3 = uv*v^2 */
    fe64_mul(uv3, uv, v2);
    /*  v2 = (v^2)^2 */
    fe64_sqr(v2, v2);
    /*  uv7 = uv^7 = uv3*v2 */
    fe64_mul(uv7, uv3, v2);

    Tab[0] = x2;
    Tab[1] = x9;
    Tab[2] = uv7_p58;
    Tab[3] = uv7;

    fe64_copy(Tab[0], uv7);
    /* 10 */
    fe64_sqr(Tab[0], Tab[0]);
    fe64_copy(Tab[1], Tab[0]);
    /** 1000 */
    sqrn_fp255_1w_fullradix(Tab[1], 2);
    /** 1001 */
    fe64_mul(Tab[1], Tab[1], Tab[3]);
    /* 1011 */
    fe64_mul(Tab[0], Tab[0], Tab[1]);
    /* 10110 */
    sqrn_fp255_1w_fullradix(Tab[0], 1);
    /** 11111 */
    fe64_mul(Tab[0], Tab[0], Tab[1]);
    fe64_copy(Tab[1], Tab[0]);
    /** 1111100000 */
    sqrn_fp255_1w_fullradix(Tab[1], 5);
    /** 11111 11111 */
    fe64_mul(Tab[1], Tab[1], Tab[0]);
    fe64_copy(Tab[2], Tab[1]);
    /** 11111 11111 00000 */
    sqrn_fp255_1w_fullradix(Tab[2], 5);
    /** 0x7fff = 111 1111 1111 1111 */
    fe64_mul(Tab[2], Tab[2], Tab[0]);
    fe64_copy(Tab[1], Tab[2]);
    sqrn_fp255_1w_fullradix(Tab[1], 15);
    /** 0x3fffffff */
    fe64_mul(Tab[1], Tab[1], Tab[2]);
    fe64_copy(Tab[2], Tab[1]);
    sqrn_fp255_1w_fullradix(Tab[2], 30);
    /** 0xfffffffffffffff */
    fe64_mul(Tab[2], Tab[2], Tab[1]);
    fe64_copy(Tab[1], Tab[2]);
    sqrn_fp255_1w_fullradix(Tab[1], 60);
    /** 0xffffffffffffffffffffffffffffff */
    fe64_mul(Tab[1], Tab[1], Tab[2]);
    sqrn_fp255_1w_fullradix(Tab[1], 5);
    /** 0x1fffffffffffffffffffffffffffffff */
    fe64_mul(Tab[1], Tab[1], Tab[0]);
    fe64_copy(Tab[2], Tab[1]);
    sqrn_fp255_1w_fullradix(Tab[2], 125);
    /** 0x3ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff */
    fe64_mul(Tab[2], Tab[2], Tab[1]);
    /** 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffc */
    sqrn_fp255_1w_fullradix(Tab[2], 2);
    /** 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd */
    fe64_mul(Tab[2], Tab[2], Tab[3]);

    /* uv^(p+3)/8 = uv3*uv^(p-5)/8  */
    fe64_mul(uv_p38, uv7_p58, uv3);

    /**
     * Checking whether
     *      v*uv_p38^2 == -u
     **/
    fe64_copy(uv3, uv_p38);
    /* uv3 = uv_p38^2  */
    fe64_sqr(uv3, uv3);
    /* uv  = uv3*v     */
    fe64_mul(uv, uv3, v);
    /*  u  = -u        */
    neg_fp255_1w_fullradix(u);

    if (cmp_fp255_1w_fullradix(uv, u) == 0) {
        /*  uv_p38 = uv_p38*sqrt(-1) */
        fe64_mul(uv_p38, uv_p38, (uint64_t*)sqrt_minus_one);
    }
}

#undef sqrn_fp255_1w_fullradix

void neg_fp255_1w_fullradix(uint64_t* c)
{
    uint64_t zero[4] = {0};
    fe64_sub(c, zero, c);
}

void sub_fp255_1w_fullradix(uint64_t* c, uint64_t* a, uint64_t* b)
{
    __asm__ __volatile__(
        "mov     $38, %%eax ;"
        "movq   (%1),  %%r8 ;"
        "subq   (%2),  %%r8 ;"
        "movq  8(%1),  %%r9 ;"
        "sbbq  8(%2),  %%r9 ;"
        "movq 16(%1), %%r10 ;"
        "sbbq 16(%2), %%r10 ;"
        "movq 24(%1), %%r11 ;"
        "sbbq 24(%2), %%r11 ;"
        "mov      $0, %%ecx ;"
        "cmovc %%eax, %%ecx ;"
        "subq %%rcx,  %%r8  ;"
        "sbbq    $0,  %%r9  ;"
        "movq  %%r9,  8(%0) ;"
        "sbbq    $0, %%r10  ;"
        "movq %%r10, 16(%0) ;"
        "sbbq    $0, %%r11  ;"
        "movq %%r11, 24(%0) ;"
        "mov     $0, %%ecx  ;"
        "cmovc %%eax, %%ecx ;"
        "subq %%rcx,  %%r8  ;"
        "movq  %%r8,   (%0) ;"
        :
        : "r"(c), "r"(a), "r"(b)
        : "memory", "cc", "%rax", "%rcx", "%r8", "%r9", "%r10", "%r11");
}

/**
 * Given:
 * 		'a' = a_1(2^256) + a_0
 * with |a_0| = |a_1| = 256 bits
 * calculate:
 * 		'a' = a_0 - 16*\ell*a_1
 * 	'a' could be as large as 385 bits.
 */
void reduce256bits(uint64_t* a)
{
    const uint64_t ellx16[] = {0x812631a5cf5d3ed0, 0x4def9dea2f79cd65, 0x1};
    __asm__ __volatile__(
        "movq    (%0), %%rbx      ;"
        "movq   8(%0), %%rcx      ;"
        "movq  16(%0), %%r8       ;"
        "movq  24(%0), %%r9       ;"

        "xorl %%r10d, %%r10d      ;"
        "xorl %%r11d, %%r11d      ;"
        "xorl %%r12d, %%r12d      ;"
        "xorl %%r13d, %%r13d      ;"
        "movq  0(%1), %%rax       ;"
        "mulq 32(%0)              ;"
        "subq %%rax,  %%rbx       ;"
        "sbbq %%rdx,  %%rcx       ;"
        "sbbq $0x0,   %%r8        ;"
        "sbbq $0x0,   %%r9        ;"
        "sbbq $0x0,   %%r10       ;"
        "sbbq $0x0,   %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq  0(%1), %%rax       ;"
        "mulq 40(%0)              ;"
        "subq %%rax,  %%rcx       ;"
        "sbbq %%rdx,  %%r8        ;"
        "sbbq $0x0,   %%r9        ;"
        "sbbq $0x0,   %%r10       ;"
        "sbbq $0x0,   %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq  0(%1), %%rax       ;"
        "mulq 48(%0)              ;"
        "subq %%rax,  %%r8        ;"
        "sbbq %%rdx,  %%r9        ;"
        "sbbq $0x0,   %%r10       ;"
        "sbbq $0x0,   %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq  0(%1), %%rax       ;"
        "mulq 56(%0)              ;"
        "subq %%rax,  %%r9        ;"
        "sbbq %%rdx,  %%r10       ;"
        "sbbq $0x0,   %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq  8(%1), %%rax       ;"
        "mulq 32(%0)              ;"
        "subq %%rax,  %%rcx       ;"
        "sbbq %%rdx,  %%r8        ;"
        "sbbq $0x0,   %%r9        ;"
        "sbbq $0x0,   %%r10       ;"
        "sbbq $0x0,   %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq  8(%1), %%rax       ;"
        "mulq 40(%0)              ;"
        "subq %%rax, %%r8         ;"
        "sbbq %%rdx, %%r9         ;"
        "sbbq $0x0,  %%r10        ;"
        "sbbq $0x0,  %%r11        ;"
        "sbbq $0x0,  %%r12        ;"
        "sbbq $0x0,  %%r13        ;"

        "movq  8(%1), %%rax       ;"
        "mulq 48(%0)              ;"
        "subq %%rax,  %%r9        ;"
        "sbbq %%rdx,  %%r10       ;"
        "sbbq $0x0,   %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq  8(%1), %%rax       ;"
        "mulq 56(%0)              ;"
        "subq %%rax, %%r10        ;"
        "sbbq %%rdx, %%r11        ;"
        "sbbq $0x0,  %%r12        ;"
        "sbbq $0x0,  %%r13        ;"

        "subq 32(%0), %%r8        ;"
        "sbbq 40(%0), %%r9        ;"
        "sbbq 48(%0), %%r10       ;"
        "sbbq 56(%0), %%r11       ;"
        "sbbq $0x0,   %%r12       ;"
        "sbbq $0x0,   %%r13       ;"

        "movq %%rbx,  0(%0)       ;"
        "movq %%rcx,  8(%0)       ;"
        "movq %%r8,  16(%0)       ;"
        "movq %%r9,  24(%0)       ;"
        "movq %%r10, 32(%0)       ;"
        "movq %%r11, 40(%0)       ;"
        "movq %%r12, 48(%0)       ;"
        "movq %%r13, 56(%0)       ;"
        : /* out  */
        : /* in   */ "r"(a), "r"(ellx16)
        : /* regs */
        "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9", "%r10", "%r11",
        "%r12", "%r13");
}

/**
 * Given:
 * 		'a' = a_257,a_256,a_255,a_254, ... , a_0
 * calculate:
 * 		'a' = a[252:0] - \ell*a_[257:252]
 * 	'a' could be as large as 252 bits.
 */
void reduce64bits(uint64_t* a)
{
    const uint64_t ell[2] = {0x5812631a5cf5d3ed, 0x14def9dea2f79cd6};
    __asm__ __volatile__(
        "movq     (%0), %%rbx  \n\t"
        "movq    8(%0), %%rcx  \n\t"
        "movq   16(%0), %%r8   \n\t"
        "movq   24(%0), %%r9   \n\t"

        "movq    0(%1), %%rax  \n\t"
        "mulq   32(%0)         \n\t"
        "subq    %%rax, %%rbx  \n\t"
        "sbbq    %%rdx, %%rcx  \n\t"
        "sbbq     $0x0,  %%r8  \n\t"
        "sbbq     $0x0,  %%r9  \n\t"

        "movq    8(%1), %%rax  \n\t"
        "mulq   32(%0)         \n\t"
        "subq    %%rax, %%rcx  \n\t"
        "sbbq    %%rdx,  %%r8  \n\t"
        "sbbq     $0x0,  %%r9  \n\t"

        "movq    %%rbx,  0(%0) \n\t"
        "movq    %%rcx,  8(%0) \n\t"
        "movq     %%r8, 16(%0) \n\t"
        "movq     %%r9, 24(%0) \n\t"
        : /* out  */
        : /* in   */ "r"(a), "r"(ell)
        : /* regs */ "memory", "cc", "%rax", "%rbx", "%rcx", "%rdx", "%r8", "%r9");
}

/**
 *
 * Calculates:
 *     s = r+k*a  (mod \ell)
 * such that size of r,k and a is 32-bytes.
 */
void calculate_s_ed25519(uint8_t* s_mod_l, uint8_t* r, uint8_t* k, const uint8_t* a)
{
    int i;
    uint64_t product[12] = {0};
    for (i = 0; i < 4; i++) {
        product[i] = ((uint64_t*)r)[i];
    }

    word64_multiplier(product, (uint64_t*)k, 4, (uint64_t*)a, 4);
    modular_reduction_ed25519((uint8_t*)product);
    for (i = 0; i < 4; i++) {
        ((uint64_t*)s_mod_l)[i] = product[i];
    }
}

/**
 * This function performs a modular reduction
 * (mod \ell) where:
 * 		\ell = 2^252+0x14def9dea2f79cd65812631a5cf5d3ed
 * this is a prime number which denotes the
 * size of the main subgroup of the elliptic curve.
 */
void modular_reduction_ed25519(uint8_t* a)
{
    uint64_t* pA = (uint64_t*)a;
    reduce256bits(pA);
    reduce256bits(pA);
    pA[4] = ((pA[4] & 0x3) << 4) | pA[3] >> 60;
    pA[3] &= ((uint64_t)1 << 60) - 1;
    reduce64bits(pA);
}

void word64_multiplier(uint64_t* C, const uint64_t* A, const int numA, const uint64_t* B,
                       const int numB)
{
    int i, j;
#define mul64x64(Z, X, Y)                                     \
    __asm__ __volatile__(                                     \
        "movq 0(%3), %%rax     ;"                             \
        "mulq 0(%4)            ;"                             \
        "addq %%rax, %0        ;"                             \
        "adcq %%rdx, %1        ;"                             \
        "adcq $0x0,  %2        ;"                             \
        : /* out  */ "+r"((Z)[0]), "+r"((Z)[1]), "+r"((Z)[2]) \
        : /* in   */ "r"(X), "r"(Y)                           \
        : /* regs */ "memory", "cc", "%rax", "%rdx");

    for (i = 0; i < numA; i++) {
        for (j = 0; j < numB; j++) {
            mul64x64(C + i + j, A + i, B + j);
        }
    }
#undef mul64x64
}
