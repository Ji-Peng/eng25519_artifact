/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery
 * curves Version: 2019-02-13
 *
 */

#include "montgomery.h"

#include "datatype.h"
#include "thirdparty/faz_fp_avx2.h"
#include "thirdparty/p25519.h"
#include "thirdparty/simd_avx2.h"
/** the .c file must be in the last */
#include "thirdparty/eltfp25519_2w_redradix.c"

const ALIGN vec vecp25519[3] = {{p25519_03, p25519_58, p25519_03, p25519_58,
                                 p25519_03, p25519_58, p25519_03, p25519_58},
                                {p25519_1_, p25519_6_, p25519_1_, p25519_6_,
                                 p25519_1_, p25519_6_, p25519_1_, p25519_6_},
                                {p25519_24, p25519_79, p25519_24, p25519_79,
                                 p25519_24, p25519_79, p25519_24, p25519_79}};

const ALIGN vec vecshft2625 = {26UL, 25UL, 26UL, 25UL, 26UL, 25UL, 26UL, 25UL};
const ALIGN vec vecshft2526 = {25UL, 26UL, 25UL, 26UL, 25UL, 26UL, 25UL, 26UL};
const ALIGN vec vecshft6404 = {64UL, 4UL, 64UL, 4UL, 64UL, 4UL, 64UL, 4UL};
const ALIGN vec vecshft6401 = {64UL, 1UL, 64UL, 1UL, 64UL, 1UL, 64UL, 1UL};
const ALIGN vec vecmult1919 = {19UL, 19UL, 19UL, 19UL, 19UL, 19UL, 19UL, 19UL};
const ALIGN vec vecshft0100 = {1UL, 0UL, 1UL, 0UL, 1UL, 0UL, 1UL, 0UL};
const ALIGN vec vecshft0001 = {0UL, 1UL, 0UL, 1UL, 0UL, 1UL, 0UL, 1UL};
const ALIGN vec vecmask3232 = {mask32, mask32, mask32, mask32,
                               mask32, mask32, mask32, mask32};
const ALIGN vec vecmask2625 = {mask26, mask25, mask26, mask25,
                               mask26, mask25, mask26, mask25};
const ALIGN vec vecmask2526 = {mask25, mask26, mask25, mask26,
                               mask25, mask26, mask25, mask26};

const ALIGN vec vecmask26252526 = {mask2625, mask2526, mask2625, mask2526,
                                   mask2625, mask2526, mask2625, mask2526};
const ALIGN vec vecmask25002600 = {mask2500, mask2600, mask2500, mask2600,
                                   mask2500, mask2600, mask2500, mask2600};
const ALIGN vec vecmask26262525 = {mask2626, mask2525, mask2626, mask2525,
                                   mask2626, mask2525, mask2626, mask2525};
const ALIGN vec vecmask32003200 = {mask3200, mask3200, mask3200, mask3200,
                                   mask3200, mask3200, mask3200, mask3200};
vec vecshift26252526 = {shift2625, shift2526, shift2625, shift2526,
                        shift2625, shift2526, shift2625, shift2526};
vec vecshift25002600 = {shift2500, shift2600, shift2500, shift2600,
                        shift2500, shift2600, shift2500, shift2600};
vec vecshift26262525 = {shift2626, shift2525, shift2626, shift2525,
                        shift2626, shift2525, shift2626, shift2525};

// void mul19fast(vec *A);
// void gfe8x_reducefast(vec *c);
// void mul19(vec *A);
// void gfe8x_reduce(vec *c);
// INLINE void ladder_4x2(vec *x3z3x2z2, vec *z1x1_A, const unsigned char *n);

INLINE void mul19fast(vec *A)
{
    vec vecmultfast19 = {19UL | (1UL << 32), 1UL | (1UL << 32),
                         19UL | (1UL << 32), 1UL | (1UL << 32),
                         19UL | (1UL << 32), 1UL | (1UL << 32),
                         19UL | (1UL << 32), 1UL | (1UL << 32)};
    *A = MULW(VSHF(*A, _MM_SHUFFLE(2, 1, 0, 3)), vecmultfast19);
}

INLINE void gfe8x_reducefast(vec *c)
{
    vec h3085, h_1_6, h4297;
    c[1] &= vecmask32003200;
    h3085 = SHRW(c[0], vecshift26252526);
    c[0] &= vecmask26252526;
    c[1] = ADDW(c[1], h3085);
    h_1_6 = SHRW(c[1], vecshift25002600);
    c[1] &= vecmask25002600;
    c[2] = ADDW(c[2], h_1_6);
    h4297 = SHRW(c[2], vecshift26262525);
    c[2] &= vecmask26262525;
    mul19fast(&h4297);
    c[0] = ADDM(255, c[0], h4297); /*c[0]=ADDW(c[0],h4297);*/
}

INLINE void mul19(vec *A)
{
    vec t0, t1, t2, t3;
    t0 = SHLV(*A, vecshft6404);
    t1 = SHLV(*A, vecshft6401);
    t2 = VADD(t0, t1);
    t3 = VADD(t2, *A);
    *A = VSHF(t3, 0x4E);
}

INLINE void gfe8x_reduce(vec *c)
{
    vec h05, h16, h27, h38, h49;
    h27 = SHRV(c[2], vecshft2625);
    c[2] &= vecmask2625;
    c[3] = VADD(c[3], h27);
    h38 = SHRV(c[3], vecshft2526);
    c[3] &= vecmask2526;
    c[4] = VADD(c[4], h38);
    h49 = SHRV(c[4], vecshft2625);
    c[4] &= vecmask2625;
    mul19(&h49);
    c[0] = VADD(c[0], h49);
    h05 = SHRV(c[0], vecshft2625);
    c[0] &= vecmask2625;
    c[1] = VADD(c[1], h05);
    h16 = SHRV(c[1], vecshft2526);
    c[1] &= vecmask2526;
    c[2] = VADD(c[2], h16);
    h27 = SHRV(c[2], vecshft2625);
    c[2] &= vecmask2625;
    c[3] = VADD(c[3], h27);
}

INLINE void gfe8x_reduce_sequential(vec *c)
{
    vec h05, h16, h27, h38, h49;
    // This part is for h0->h1->h2->h3->h5.
    h05 = SHRV(c[0], vecshft2625);
    c[0] &= vecmask2625;
    c[1] = VADD(c[1], h05);
    h16 = SHRV(c[1], vecshft2526);
    c[1] &= vecmask2526;
    c[2] = VADD(c[2], h16);
    h27 = SHRV(c[2], vecshft2625);
    c[2] &= vecmask2625;
    c[3] = VADD(c[3], h27);
    h38 = SHRV(c[3], vecshft2526);
    c[3] &= vecmask2526;
    c[4] = VADD(c[4], h38);
    h49 = SHRV(c[4], vecshft2625);
    c[4] &= vecmask2625;
    mul19(&h49);
    c[0] = VADD(c[0], h49);
    // This part is for h5->h6->h7->h8->h9->h0.
    h05 = SHRV(c[0], vecshft2625);
    c[0] &= vecmask2625;
    c[1] = VADD(c[1], h05);
    h16 = SHRV(c[1], vecshft2526);
    c[1] &= vecmask2526;
    c[2] = VADD(c[2], h16);
    h27 = SHRV(c[2], vecshft2625);
    c[2] &= vecmask2625;
    c[3] = VADD(c[3], h27);
    h38 = SHRV(c[3], vecshft2526);
    c[3] &= vecmask2526;
    c[4] = VADD(c[4], h38);
    h49 = SHRV(c[4], vecshft2625);
    c[4] &= vecmask2625;
    mul19(&h49);
    c[0] = VADD(c[0], h49);
}

INLINE void gfe8x_mul(vec *c, vec *a, vec *b)
{
    intmul(c, a, b);
    gfe8x_reduce(c);
}

INLINE void gfe8x_squ(vec *c, vec *a)
{
    intsqr(c, a);
    gfe8x_reduce(c);
}

INLINE void gfe8x_squeeze(vec *ip)
{
    ip[0] ^= VSHL(ip[3], 32);
    ip[2] ^= VSHL(ip[4], 32);
}

INLINE void gfe8x_unsqueeze(vec *ip)
{
    ip[3] = VSHR(ip[0], 32);
    ip[4] = VSHR(ip[2], 32);
}

INLINE void gfe8x_mask32(vec *ip)
{
    ip[0] &= vecmask3232;
    ip[2] &= vecmask3232;
}

INLINE void gfe8x_swap(vec *ip, int swap)
{
    const vec vec_mask_perm0 = {0, 1, 2, 3, 4, 5, 6, 7};
    const vec vec_mask_perm1 = {4, 5, 6, 7, 0, 1, 2, 3};
    vec perm_mask = VBLD(-swap, vec_mask_perm0, vec_mask_perm1);
    ip[0] = VPER(perm_mask, ip[0]);
    ip[1] = VPER(perm_mask, ip[1]);
    ip[2] = VPER(perm_mask, ip[2]);
}

INLINE void gfe8x_align(vec *op, vec *ip)
{
    const vec align_mask = {6, 7, 4, 5, 4, 5, 6, 7};
    op[0] = VPER(align_mask, ip[0]);
    op[1] = VPER(align_mask, ip[1]);
    op[2] = VPER(align_mask, ip[2]);
}

INLINE void gfe8x_hadamard(vec *ip)
{
    const vec perm_mask = {2, 3, 0, 1, 6, 7, 4, 5};
    vec temp1[3], temp2[3], temp3[3];
    temp1[0] = VPER(perm_mask, ip[0]);
    temp3[0] = SUBW(vecp25519[0], ip[0]);
    temp1[1] = VPER(perm_mask, ip[1]);
    temp3[1] = SUBW(vecp25519[1], ip[1]);
    temp1[2] = VPER(perm_mask, ip[2]);
    temp3[2] = SUBW(vecp25519[2], ip[2]);
    temp2[0] = VBLD(204, ip[0], temp3[0]);
    ip[0] = ADDW(temp1[0], temp2[0]);
    temp2[1] = VBLD(204, ip[1], temp3[1]);
    ip[1] = ADDW(temp1[1], temp2[1]);
    temp2[2] = VBLD(204, ip[2], temp3[2]);
    ip[2] = ADDW(temp1[2], temp2[2]);
}

///*More readable but slightly slower version.*/
// INLINE void gfe8x_hadamard(vec *ip) {
//	const vec perm_mask = { 2, 3, 0, 1, 6, 7, 4, 5 };
//	vec temp1[3], temp2[3], temp3[3];
//	int i;
//	for(i = 0; i < 3; i++){
//		temp1[i] = VPER(perm_mask, ip[i]);
//		temp3[i] = SUBW(vecp25519[i], ip[i]);
//		temp2[i] = VBLD(204, ip[i], temp3[i]);
//		ip[i] = ADDW(temp1[i], temp2[i]);
//	}
// }

INLINE void gfe8x_premix(vec *z1x1x2A, vec *x5z5z2z4, vec *z1x1_A,
                         vec *x3z3x2z2, vec *x5z5x4z4)
{
    const vec perm_mask = {2, 3, 0, 1, 6, 7, 4, 5};
    vec x3z3z2x2[3];
    int i;
    for (i = 0; i < 3; i++) {
        z1x1x2A[i] = VBLD(48, z1x1_A[i], x3z3x2z2[i]);
        x3z3z2x2[i] = VPER(perm_mask, x3z3x2z2[i]);
        x5z5z2z4[i] = VBLD(48, x5z5x4z4[i], x3z3z2x2[i]);
    }
}

INLINE void gfe8x_postmix(vec *x3z3x2z2, vec *x7z7x6z6, vec *x5z5x4z4)
{
    const vec perm_mask = {2, 3, 0, 1, 6, 7, 4, 5};
    vec x9z9x8z8[3], x1z1x0z0[3];
    int i;
    for (i = 0; i < 3; i++) {
        x9z9x8z8[i] = VADD(x7z7x6z6[i], x7z7x6z6[i]);
        x9z9x8z8[i] = VPER(perm_mask, x9z9x8z8[i]);
        x1z1x0z0[i] = VPER(perm_mask, x5z5x4z4[i]);
        x9z9x8z8[i] = VADD(x9z9x8z8[i], x7z7x6z6[i]);
        x1z1x0z0[i] = VSUB(VADD(x5z5x4z4[i], vecp25519[i]), x1z1x0z0[i]);
        x3z3x2z2[i] = VBLD(48, x7z7x6z6[i], x1z1x0z0[i]);
        x3z3x2z2[i] = VBLD(192, x3z3x2z2[i], x9z9x8z8[i]);
    }
}

INLINE void ladder_4x2(vec *x3z3x2z2, vec *z1x1_A, const unsigned char *n)
{
    vec x5z5x4z4[5], z2x2x2z2[5], z1x1x2A[5], x5z5z2z4[5], x7z7z6z6[5];
    int i, j, bit, swap, prevbit = 0;
    gfe8x_squeeze(x3z3x2z2);
    gfe8x_squeeze(z1x1_A);
    j = 6;
    for (i = 31; i >= 0; i--) {
        for (; j >= 0; j--) {
            bit = (n[i] >> j) & 1;
            swap = bit ^ prevbit;
            prevbit = bit;
            gfe8x_swap(x3z3x2z2, swap);
            gfe8x_hadamard(x3z3x2z2);
            gfe8x_align(z2x2x2z2, x3z3x2z2);
            gfe8x_unsqueeze(x3z3x2z2);
            gfe8x_unsqueeze(z2x2x2z2);
            gfe8x_mul(x3z3x2z2, x3z3x2z2, z2x2x2z2);
            gfe8x_squeeze(x3z3x2z2);
            gfe8x_hadamard(x3z3x2z2);
            gfe8x_unsqueeze(x3z3x2z2);
            gfe8x_squ(x5z5x4z4, x3z3x2z2);
            gfe8x_squeeze(x5z5x4z4);
            gfe8x_premix(z1x1x2A, x5z5z2z4, z1x1_A, x3z3x2z2, x5z5x4z4);
            gfe8x_unsqueeze(x5z5z2z4);
            gfe8x_unsqueeze(z1x1x2A);
            gfe8x_mul(x7z7z6z6, z1x1x2A, x5z5z2z4);
            gfe8x_squeeze(x7z7z6z6);
            gfe8x_postmix(x3z3x2z2, x7z7z6z6, x5z5x4z4);
            gfe8x_reducefast(x3z3x2z2);
        }
        j = 7;
    }
    gfe8x_swap(x3z3x2z2, bit);
    gfe8x_unsqueeze(x3z3x2z2);
    gfe8x_mask32(x3z3x2z2);
    gfe8x_reduce_sequential(x3z3x2z2);
    gfe8x_reduce_sequential(x3z3x2z2);  // Do not remove this 2nd reduction.
}

void scalar_mult_var_base(unsigned char *q, const unsigned char *n,
                          const unsigned char *p, const unsigned char *A)
{
    vec z1x1_A[NLIMB], x3z3x2z2[NLIMB];
    gfe25519 x64[1], z64[1], res[1], inv[1];
    gfe t0[1], t1[1];
    unsigned char k[32], x1[32];
    int i;

    // Change scalar. Do clamping as in curve25519.
    for (i = 0; i < 32; i++) {
        k[i] = n[i];
    }
    k[0] &= 248;
    k[31] &= 127;
    k[31] |= 64;
    for (i = 0; i < 32; i++) {
        x1[i] = p[i];
    }
    x1[31] &= 127;

    char_to_gfe(t0, x1);
    char_to_gfe(t1, A);
    set_base(z1x1_A, t0, t1);
    set_vector(x3z3x2z2, t0);

    ladder_4x2(x3z3x2z2, z1x1_A, k);

    get_channel(t0, x3z3x2z2, 2);
    get_channel(t1, x3z3x2z2, 3);
    reduce_unique(t0);
    reduce_unique(t1);
    gfe64_pack((gfe64 *)x64, t0);
    gfe64_pack((gfe64 *)z64, t1);

    gfp25519inv(inv, z64);
    gfp25519mul(res, inv, x64);
    gfp25519reduce(res);
    gfp25519makeunique(res);

    for (i = 0; i < 4; i++) {
        ((u64 *)q)[i] = res->l[i];
    }
}
