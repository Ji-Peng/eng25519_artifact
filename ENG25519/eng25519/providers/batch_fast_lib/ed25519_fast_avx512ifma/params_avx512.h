/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef INTRIN_H
#define INTRIN_H

#include <immintrin.h>

#define SCOPE static inline

#ifndef ALIGN
#    define ALIGN_BYTES 32
#    ifdef __INTEL_COMPILER
#        define ALIGN __declspec(align(ALIGN_BYTES))
#    else
#        define ALIGN __attribute__((aligned(ALIGN_BYTES)))
#    endif
#endif

#ifndef ALIGN64
#    ifdef __INTEL_COMPILER
#        define ALIGN64 __declspec(align(64))
#    else
#        define ALIGN64 __attribute__((aligned(64)))
#    endif
#endif

/** 2^51 - 1 */
#define MASK51b 0x7FFFFFFFFFFFFULL
#define LOW51b 0x7FFFFFFFFFFEDULL
#define CONSTC 19
#define CONSTA 486662

#define RADIX_8x1 51
#define NWORDS_8x1 5
typedef __m512i fe_8x1[NWORDS_8x1];

#define NWORDS_4x2 3
#define RADIX_4x2 51
typedef __m512i fe_4x2[NWORDS_4x2];

/** AVX-512F integer arithmetic */
#define VADD(X, Y) _mm512_add_epi64(X, Y)
#define VMADD(X, W, Y, Z) _mm512_mask_add_epi64(X, W, Y, Z)
#define VMZADD(W, X, Y) _mm512_maskz_add_epi64(W, X, Y)
#define VSUB(X, Y) _mm512_sub_epi64(X, Y)
#define VMSUB(X, W, Y, Z) _mm512_mask_sub_epi64(X, W, Y, Z)
#define VMZSUB(W, X, Y) _mm512_maskz_sub_epi64(W, X, Y)
/**
 * VMUL(X, Y): Multiply the low unsigned 32-bit integers from each packed 64-bit element
 * in X and Y, and store the unsigned 64-bit results in dst. = vpmuludq
 */
#define VMUL(X, Y) _mm512_mul_epu32(X, Y)

/** AVX-512IFMA instructions */
/**
 * VMACLO(X, Y, Z): Y * Z + X: Multiply packed unsigned 52-bit integers in each 64-bit
 * element of Y and Z to form a 104-bit intermediate result. Add the low 52-bit unsigned
 * integer from the intermediate result with the corresponding unsigned 64-bit integer in
 * X, and store the results in dst. = vpmadd52luq
 */
#define VMACLO(X, Y, Z) _mm512_madd52lo_epu64(X, Y, Z)
#define VMMACLO(X, W, Y, Z) _mm512_mask_madd52lo_epu64(X, W, Y, Z)
#define VMZMACLO(W, X, Y, Z) _mm512_maskz_madd52lo_epu64(W, X, Y, Z)
#define VMACHI(X, Y, Z) _mm512_madd52hi_epu64(X, Y, Z)
#define VMZMACHI(W, X, Y, Z) _mm512_maskz_madd52hi_epu64(W, X, Y, Z)

#define VABS8(X) _mm512_abs_epi8(X)
#define VSHUF32(X, W) _mm512_shuffle_epi32(X, W)

/** bitwise logical operations */
#define VAND(X, Y) _mm512_and_si512(X, Y)
#define VMAND(X, W, Y, Z) _mm512_mask_and_epi64(X, W, Y, Z)
#define VOR(X, Y) _mm512_or_si512(X, Y)
#define VMOR(W, X, Y, Z) _mm512_mask_or_epi64(W, X, Y, Z)
#define VXOR(X, Y) _mm512_xor_si512(X, Y)
#define VMXOR(X, Y, Z, W) _mm512_mask_xor_epi64(X, Y, Z, W)
#define VSHL(X, Y) _mm512_slli_epi64(X, Y)
#define VMSHL(X, W, Y, Z) _mm512_mask_slli_epi64(X, W, Y, Z)
#define VSHR(X, Y) _mm512_srli_epi64(X, Y)
#define VMSHR(X, W, Y, Z) _mm512_mask_srli_epi64(X, W, Y, Z)
#define VMZSHR(W, X, Y) _mm512_maskz_srli_epi64(W, X, Y)
#define VSRA(X, Y) _mm512_srai_epi64(X, Y)
#define VMZSRA(W, X, Y) _mm512_maskz_srai_epi64(W, X, Y)
#define VSHRV(X, Y) _mm512_srlv_epi64(X, Y)
#define VCMPNEQ(X, Y) _mm512_cmpneq_epi64_mask(X, Y)

/** broadcast operations */
#define VZERO _mm512_setzero_si512()
#define VSET1(X) _mm512_set1_epi64(X)
#define VSET(X7, X6, X5, X4, X3, X2, X1, X0) \
    _mm512_set_epi64(X7, X6, X5, X4, X3, X2, X1, X0)

/** permutation & shuffle operations */
/**
 * X = [X0 X1 X2 X3 ...X6 X7], W = 0xB1 = 1011 0001
 * result = [X1 X0 X3 X2 ...X7 X6]
 *
 * X = [X0 X1 X2 X3 ... X6 X7], W = 0xE1 = 1110 0001
 * result = [X1 X0 X2 X3 X5 X4 X6 X7]
 *
 * X = [X0 X1 X2 X3 ...X6 X7], W = 0xDD = 1101 1101
 * result = [X1 X3 X1 X3 X5 X7 X5 X7]
 *
 * X = [X0 X1 X2 X3 ...X6 X7], W = 0x88 = 1000 1000
 * result = [X0 X2 X0 X2 X4 X6 X4 X6]
 *
 * X = [X0 X1 X2 X3 ...X6 X7], W = 0x4B = 0100 1011
 * result = [X3 X2 X0 X1 X7 X6 X4 X5]
 *
 * X = [X0 X1 X2 X3 ...X6 X7], W = 0x4E = 0100 1110
 * result = [X2 X3 X0 X1 X6 X7 X4 X5]
 *
 * X = [X0 X1 X2 X3  X4 X5 X6 X7], W = 0xF4 = 1111 0100
 * result = [X0 X1 X3 X3 X4 X5 X7 X7]
 */
#define VPERM(X, W) _mm512_permutex_epi64(X, W)
#define VMPERM(SRC, M, X, W) _mm512_mask_permutex_epi64(SRC, M, X, W)
/**
 * X = [X0 X1 X2 X3 X4 X5 X6 X7]
 * W = [4 5 6 7 0 1 2 3]
 * result = [X4 X5 X6 X7 X0 X1 X2 X3]
 *
 * X = [X0 X1 X2 X3 X4 X5 X6 X7]
 * W = [2 3 6 7 2 3 6 7]
 * result = [X2 X3 X6 X7 X2 X3 X6 X7]
 *
 * X = [X0 X1 X2 X3 X4 X5 X6 X7]
 * W = [0 1 4 5 0 1 4 5]
 * result = [X0 X1 X4 X5 X0 X1 X4 X5]
 */
#define VPERMV(W, X) _mm512_permutexvar_epi64(W, X)
#define VMPERMV(SRC, W, IDX, X) _mm512_mask_permutexvar_epi64(SRC, W, IDX, X)
/**
 * W = [1 1 1 0 1 1 1 0]
 * IDX = [3 0 2 X 3 0 2 X]
 * X = [X0 X1 X2 X3 X4 X5 X6 X7]
 * result = [X3 X0 X2 0 X7 X4 X6 0]
 */
#define VMZPERMV(W, IDX, X) _mm512_maskz_permutexvar_epi64(W, IDX, X)
#define VMZPERM(W, X, IMM) _mm512_maskz_permutex_epi64(W, X, IMM)
/**
 * X = [X0 X1 X2 X3 X4 X5 X6 X7], Y = [Y0 Y1 Y2 Y3 Y4 Y5 Y6 Y7]
 * IDX = [0000, 0001, 0010, 0011, 1000, 1001, 1010, 1011]
 *     = [0, 1, 2, 3, 8, 9, 10, 11]
 * const ALIGN64 __m512i idx_a0123_b0123 = {0UL, 1UL, 2UL,  3UL,
                                            8UL, 9UL, 10UL, 11UL};
 * result = [X0 X1 X2 X3 Y0 Y1 Y2 Y3]
 *
 * X = [X0 X1 X2 X3 X4 X5 X6 X7], Y = [Y0 Y1 Y2 Y3 Y4 Y5 Y6 Y7]
 * IDX = [0100 0101 0110 0111 1100 1101 1110 1111]
 *     = [4 5 6 7 12 13 14 15]
 * const ALIGN64 __m512i idx_a4567_b4567 = {4UL,  5UL,  6UL,  7UL,
                                            12UL, 13UL, 14UL, 15UL};
 * result = [X4 X5 X6 X7 Y4 Y5 Y6 Y7]
 */
#define VPERMV2(X, IDX, Y) _mm512_permutex2var_epi64(X, IDX, Y)
/**
 * X = [X0 X1 X2 X3 ...X6 X7], W = 0x4E = 0100 1110
 * result = [X1 X0 X3 X2 ...X7 X6]
 */
#define VSHUF(X, W) _mm512_shuffle_epi32(X, W)
#define VALIGNR(X, Y, Z) _mm512_alignr_epi64(X, Y, Z)
#define VZALIGNR(W, X, Y, Z) _mm512_maskz_alignr_epi64(W, X, Y, Z)
/**
 * W = 0xAA = 1010 1010, X = [X0 X1 X2 X3 ...], Y = [Y0 Y1 Y2 Y3 ...]
 * result = [X0 Y1 X2 Y3 ...]
 *
 * W = 0xF0 = 1111 0000, X = [X0 X1 X2 X3 ...], Y = [Y0 Y1 Y2 Y3 ...]
 * result = [X0 X1 X2 X3 Y4 Y5 Y6 Y7]
 */
#define VMBLEND(W, X, Y) _mm512_mask_blend_epi64(W, X, Y)

#define VBROAD64(X) _mm512_broadcastq_epi64(X)
#define VLOAD128(X) _mm_load_si128((__m128i *)X)
#define VLOAD512(X) _mm512_load_epi64(X)
/** CASE Y[0] OF 0: dst[255:0] := X[255:0]; 1: dst[255:0] := X[511:256] */
#define VEXTR256(X, Y) _mm512_extracti64x4_epi64(X, Y)
/** dst[63:0] := (X[255:0] >> (Y[1:0] * 64))[63:0] */
#define VEXTR64(X, Y) _mm256_extract_epi64(X, Y)
#define VSTORE(X, Y) _mm512_store_epi64(X, Y)
#define VMMOV(SRC, W, X) _mm512_mask_mov_epi64(SRC, W, X)

#define VADDRDC(X)                                                        \
    ((uint64_t *)&X)[0] + ((uint64_t *)&X)[1] + ((uint64_t *)&X)[2] +     \
        ((uint64_t *)&X)[3] + ((uint64_t *)&X)[4] + ((uint64_t *)&X)[5] + \
        ((uint64_t *)&X)[6] + ((uint64_t *)&X)[7]

#define VORRDC(X)                                                         \
    ((uint64_t *)&X)[0] | ((uint64_t *)&X)[1] | ((uint64_t *)&X)[2] |     \
        ((uint64_t *)&X)[3] | ((uint64_t *)&X)[4] | ((uint64_t *)&X)[5] | \
        ((uint64_t *)&X)[6] | ((uint64_t *)&X)[7]

#endif
