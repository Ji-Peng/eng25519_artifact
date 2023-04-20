#ifndef PARAMS_H
#define PARAMS_H

#include <immintrin.h>
#include <stdint.h>
#include <stdio.h>

#define SCOPE static inline

#ifndef ALIGN
#    define ALIGN_BYTES 32
#    ifdef __INTEL_COMPILER
#        define ALIGN __declspec(align(ALIGN_BYTES))
#    else
#        define ALIGN __attribute__((aligned(ALIGN_BYTES)))
#    endif
#endif

/**
 * Swap method
 * ===========
 *
 * The flag SWAP_METHOD defines the method used for
 * performing constant time conditional move.
 *  1) PERMUTATION. Uses AVX2 permutation instructions
 *  2) LOGIC. Uses the AVX2 LOGIC instructions.
 *  3) CMOV. Uses the 64-bit CMOV instruction.
 */
#define PERMUTATION 0x1
#define LOGIC 0x2
#define CMOV 0x4
#define SWAP_METHOD PERMUTATION

/** X25519 */
#define DH255_KEY_SIZE 32
/** X448 */
#define DH448_KEY_SIZE 56

/**
 * Flag for sign/verify indicating
 * an empty context.
 */
#define EDDSA_NOCONTEXT 0

/**
 * Types and sizes of Ed25519
 **/
#define ED25519_B_PARAM 256
#define ED25519_C_PARAM 3
#define ED25519_N_PARAM 254
#define ED25519_HASH_BYTES 64
#define ED25519_KEY_SIZE ((ED25519_B_PARAM) / 8)
#define ED25519_SIG_SIZE (2 * (ED25519_B_PARAM) / 8)

/**
 * Types and sizes of Ed448
 **/
#define ED448_B_PARAM 456
#define ED448_C_PARAM 2
#define ED448_N_PARAM 447
#define ED448_HASH_BYTES 114
#define ED448_KEY_SIZE ((ED448_B_PARAM) / 8)
#define ED448_SIG_SIZE (2 * (ED448_B_PARAM) / 8)

#define LUT_24KB 24
#define LUT_12KB 12
#define LOOKUP_TABLE_SIZE LUT_24KB

/** Definitions for fp, p = 2^255-19 */
#define SIZE_fp255 32
#define BASE0_fp255 26
#define BASE1_fp255 25
#define NUM_DIGITS_fp255 10
#define NUM_DIGITS_fp255_X64 4
// 4 * ((NUM_DIGITS_fp255 + 3) / 4)
#define NUM_DIGITS_fp255_X64_RED 12
#define NUM_DIGITS_fp255_2w (NUM_DIGITS_fp255 / 2)

/** Definitions for fp, p = 2^448-2^224-1 */
#define SIZE_FP448 56
#define BASE_FP448 28
#define NUM_DIGITS_FP448 16
#define NUM_DIGITS_FP448_X64 7
#define NUM_DIGITS_FP448_2w (NUM_DIGITS_FP448 / 2)

/** AVX2 Definitions */
#define HASWELL 0x80
#define SKYLAKE 0x40

#define PROCESSOR SKYLAKE

#define ZEROUPPER _mm256_zeroupper()
#define ZERO128 _mm_setzero_si128()
#define LOAD128(X) _mm_load_si128((__m128i*)X)
#define STORE128(X, Y) _mm_store_si128((__m128i*)X, Y)
#define ADD128(X, Y) _mm_add_epi64(X, Y)
#define AND128(X, Y) _mm_and_si128(X, Y)
#define MUL128(X, Y) _mm_mul_epu32(X, Y)
#define SHL128(X, Y) _mm_slli_epi64(X, Y)
#define SHR128(X, Y) _mm_srli_epi64(X, Y)
#define SHR8N128(X, Y) _mm_srli_si128(X, Y)
#define SET32(W, X, Y, Z) _mm_set_epi32(W, X, Y, Z)
#define SHUF32128(X, Y) _mm_shuffle_epi32(X, Y)
#define BLEND32128(X, Y, Z) _mm_blend_epi32(X, Y, Z)
#define SHLV128(X, Y) _mm_sllv_epi64(X, Y)
#define SHRV128(X, Y) _mm_srlv_epi64(X, Y)

#define UPKL64128(X, Y) _mm_unpacklo_epi64(X, Y)
#define ZERO _mm256_setzero_si256()
#define LOAD(X) _mm256_load_si256((__m256i*)X)
#define STORE(X, Y) _mm256_store_si256((__m256i*)X, Y)
//#define ALIGNR(X,Y)      _mm256_alignr_epi8(X,Y,8)
/**
 * Y = {Y3,Y2,Y1,Y0}, X = {X3,X2,X1,X0}
 * result = {X2,Y3,X0,Y1}
 */
#define ALIGNR(X, Y)     \
    _mm256_castpd_si256( \
        _mm256_shuffle_pd(_mm256_castsi256_pd(Y), _mm256_castsi256_pd(X), 0x5))
#define ADD(X, Y) _mm256_add_epi64(X, Y)
#define SUB(X, Y) _mm256_sub_epi64(X, Y)
#define AND(X, Y) _mm256_and_si256(X, Y)
#define ANDNOT(X, Y) _mm256_andnot_si256(X, Y)
#define XOR(X, Y) _mm256_xor_si256(X, Y)
#define OR(X, Y) _mm256_or_si256(X, Y)
#define MUL(X, Y) _mm256_mul_epu32(X, Y)
#define SHR(X, Y) _mm256_srli_epi64(X, Y)
#define SHL(X, Y) _mm256_slli_epi64(X, Y)
#define SHLV(X, Y) _mm256_sllv_epi64(X, Y)
#define SHRV(X, Y) _mm256_srlv_epi64(X, Y)
#define SHL8(X) _mm256_slli_si256(X, 8)
#define SHR8(X) _mm256_srli_si256(X, 8)
#define SHR8N(X, Y) _mm256_srli_si256(X, Y)
#define CLEAN_LOW64(X) _mm256_blend_epi32(X, ZERO, 0x33)
#define CLEAN_HIGH64(X) _mm256_blend_epi32(X, ZERO, 0xCC)
#define UPKL64(X, Y) _mm256_unpacklo_epi64(X, Y)
#define UPKH64(X, Y) _mm256_unpackhi_epi64(X, Y)
/**
 * X = [X3 X2 X1 X0] & Y = 0x44 = 0100 0100
 * result = [X2 X2 X0 X0]
 * X = [X3 X2 X1 X0] & Y = 0xEE = 1110 1110
 * result = [X3 X3 X1 X1]
 * X = [X3 X2 X1 X0] & Y = 0x4E = 0100 1110
 * result = [X2 X3 X0 X1]
 */
#define SHUF32(X, Y) _mm256_shuffle_epi32(X, Y)
#define SHUFPD(X, Y, Z)  \
    _mm256_castpd_si256( \
        _mm256_shuffle_pd(_mm256_castsi256_pd(X), _mm256_castsi256_pd(Y), Z))
#define PERM64(X, Y) _mm256_permute4x64_epi64(X, Y)
#define PERM128(X, Y, Z) _mm256_permute2x128_si256(X, Y, Z)
//#define PERM128(X, Y, Z) _mm256_permute2f128_si256(X,Y,Z)
#define PERMV128(X, Y) _mm256_permutevar8x32_epi32(X, Y)
/**
 * X = [X3 X2 X1 X0], Y = [Y3 Y2 Y1 Y0], Z = 0xF0 = 1111 0000
 * result = [Y3 Y2 X1 X0]
 */
#define BLEND32(X, Y, Z) _mm256_blend_epi32(X, Y, Z)
#define SET164(X) _mm256_set1_epi64x(X)
#define SET64(W, X, Y, Z) _mm256_set_epi64x(W, X, Y, Z)
#define EXTR(X, Y) _mm256_extracti128_si256(X, Y)
#define INSR(X, Y, Z) _mm256_inserti128_si256(X, Y, Z)
//#define INSR(X,Y,Z)        _mm256_insertf128_si256(X,Y,Z)
#define CAST256TO128(X) _mm256_castsi256_si128(X)
#define CAST128TO256(X) _mm256_castsi128_si256(X)
/**
 * This construction calls broadcast instruction
 * explicitly specifying a memory location Y, which
 * could or could not be aligned.
 */
#define BROADCASTQ(X, Y)                        \
    __asm__ __volatile("vpbroadcastq (%1), %0;" \
                       : /* out  */ "=x"(X)     \
                       : /* in   */ "r"(Y)      \
                       : /* regs */);

#endif