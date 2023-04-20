/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery curves
 * Version: 2019-02-13
 *
 */

#define VADD _mm512_add_epi64
#define VSUB _mm512_sub_epi64
#define VMUL _mm512_mul_epu32
#define VSHF _mm512_shuffle_epi32
#define VBLD _mm512_mask_blend_epi64
#define VPER _mm512_permutexvar_epi64
#define VSHL _mm512_slli_epi64
#define VSHR _mm512_srli_epi64
#define SHRW _mm512_srlv_epi32
#define SHLW _mm512_sllv_epi32
#define ADDW _mm512_add_epi32
#define SUBW _mm512_sub_epi32
#define MULW _mm512_mullo_epi32
#define ADDM _mm512_maskz_add_epi64
#define ALIGNR(X, Y) _mm512_castpd_si512(_mm512_shuffle_pd(_mm512_castsi512_pd(Y),_mm512_castsi512_pd(X),0x55))

#define mask32 0xffffffffUL
#define mask26 0x03ffffffUL
#define mask25 0x01ffffffUL
#define mask3200 mask32
#define mask2600 mask26
#define mask2500 mask25
#define mask3232 mask32 | (mask32 << 32)
#define mask2626 mask26 | (mask26 << 32)
#define mask2625 mask26 | (mask25 << 32)
#define mask2526 mask25 | (mask26 << 32)
#define mask2525 mask25 | (mask25 << 32)

#define p25519_03 p25519_0(2) | (p25519_3(2) << 32)
#define p25519_1_ p25519_1(2)
#define p25519_24 p25519_2(2) | (p25519_4(2) << 32)
#define p25519_58 p25519_5(2) | (p25519_8(2) << 32)
#define p25519_6_ p25519_6(2)
#define p25519_79 p25519_7(2) | (p25519_9(2) << 32)

#define shift2626 26UL | (26UL << 32)
#define shift2625 26UL | (25UL << 32)
#define shift2526 25UL | (26UL << 32)
#define shift2525 25UL | (25UL << 32)
#define shift2600 26UL
#define shift2500 25UL

ALIGN void scalar_mult_var_base(unsigned char *q, const unsigned char *n, const unsigned char *p, const unsigned char *A);
