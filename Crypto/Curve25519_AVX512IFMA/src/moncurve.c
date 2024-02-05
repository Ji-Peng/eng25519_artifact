/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "moncurve.h"

#include "tedcurve.h"
#include "utils.h"

/**
 * @brief Montgomery ladder step.
 *
 * @details
 * (P,Q) <- LadderStep(P,Q,pk)
 * The Ladder-step contains a differential point addition and point doubling,
 * and it only operates on x- and z-coordinates of projective points.
 *
 * @param p Projective point
 * @param q Projective point
 * @param xd Field element
 */
void mon_ladder_step_avx512(ProPoint *p, ProPoint *q, const __m512i *xd)
{
    __m512i *tmp1 = p->Y, *tmp2 = q->Y;

    adc_fp255_8x1w(tmp1, p->X, p->Z);
    sbc_fp255_8x1w(p->X, p->X, p->Z);
    adc_fp255_8x1w(tmp2, q->X, q->Z);
    sbc_fp255_8x1w(q->X, q->X, q->Z);
    sqr_fp255_8x1w(p->Z, tmp1);
    mul_fp255_8x1w(q->Z, tmp2, p->X);
    mul_fp255_8x1w(tmp2, q->X, tmp1);
    sqr_fp255_8x1w(tmp1, p->X);
    mul_fp255_8x1w(p->X, p->Z, tmp1);
    sbc_fp255_8x1w(tmp1, p->Z, tmp1);
    mul51_fp255_8x1w(q->X, tmp1, (CONSTA - 2) / 4);
    adc_fp255_8x1w(q->X, q->X, p->Z);
    mul_fp255_8x1w(p->Z, q->X, tmp1);
    adc_fp255_8x1w(tmp1, tmp2, q->Z);
    sqr_fp255_8x1w(q->X, tmp1);
    sbc_fp255_8x1w(tmp1, tmp2, q->Z);
    sqr_fp255_8x1w(tmp2, tmp1);
    mul_fp255_8x1w(q->Z, tmp2, xd);
}

/**
 * @brief Conditional swap (cswap) of two points.
 *
 * @details
 * Replace (P,Q) with (Q,P) if b == 1;
 * replace (P,Q) with (P,Q) if b == 0.
 * Depending on a boolean value that is passed as argument to the function,
 * the two points are either swapped or not swapped.
 *
 * @param p Projective point
 * @param q Projective point
 * @param b Swapping flag
 */
static void mon_cswap_point_avx512(ProPoint *p, ProPoint *q, const __m512i b)
{
    const __m512i one = VSET1(1);
    const __m512i cbit = VAND(b, one);

    cswap_fp255_8x1w(p->X, q->X, cbit);
    cswap_fp255_8x1w(p->Z, q->Z, cbit);
}

/**
 * @brief Variable-base scalar multiplication.
 *
 * @details
 * xR = k * xP.
 * This function computes only the x-coordinate of R = k * P, where R and P are
 * points with affine coordinates. This is the core operation of ECDH shared
 * secret phase.
 *
 * @param r x-coordinate of point with affine coordinates
 * @param k scalar
 * @param x x-coordinate of point with affine coordinates
 */
void mon_mul_var_base_avx512(__m512i *r, const __m512i *k, const __m512i *x)
{
    ProPoint p1, p2;
    __m512i b, s = VZERO, kp[8];

    const __m512i t0 = VSET1(0xFFFFFFF8UL);
    const __m512i t1 = VSET1(0x7FFFFFFFUL);
    const __m512i t2 = VSET1(0x40000000UL);
    int i;

    /** prune scalar k */
    for (i = 0; i < 8; i++)
        kp[i] = k[i];
    kp[0] = VAND(kp[0], t0);
    kp[7] = VAND(kp[7], t1);
    kp[7] = VOR(kp[7], t2);

    /** initialize ladder */
    for (i = 0; i < NWORDS_8x1; i++) {
        p1.X[i] = p1.Z[i] = p2.Z[i] = VZERO;
        p2.X[i] = x[i];
    }
    p1.X[0] = p2.Z[0] = VSET1(1);

    /** main ladder loop */
    for (i = 254; i >= 0; i--) {
        b = kp[i >> 5];
        b = VSHR(b, i & 31);
        s = VXOR(s, b);
        mon_cswap_point_avx512(&p1, &p2, s);
        mon_ladder_step_avx512(&p1, &p2, x);
        s = b;
    }
    mon_cswap_point_avx512(&p1, &p2, s);

    /** projective -> affine */
    inv_fp255_8x1w(p2.Y, p1.Z);
    mul_fp255_8x1w(r, p2.Y, p1.X);
}

/**
 * @brief Fixed-base scalar multiplication for X25519.
 *
 * @details
 * R = k * B.
 * Take advantage of fixed-base scalar multiplication on twisted Edwards curve
 * and then map the projective points to Montgomery curve. Finally output the
 * x-coordinate of R on Montgomery curve.
 *
 * @param r Projective point
 * @param k Scalar
 */
void mon_mul_fixed_base_x25519_avx512(__m512i *r, const __m512i *k)
{
    ProPoint p;
    __m512i t[NWORDS_8x1];

    ted_mul_fixbase_avx512(&p, k);

    /**
     * from twisted Edwards curve to Montgomery curve u = (Z+Y)/(Z-Y)
     * t1 = Z-Y
     * t1 = 1/(Z-Y)
     * t2 = Z+Y
     * r = (Z+Y)/(Z-Y)
     */
    sbc_fp255_8x1w(p.X, p.Z, p.Y);
    inv_fp255_8x1w(p.X, p.X);
    adc_fp255_8x1w(t, p.Z, p.Y);
    mul_fp255_8x1w(r, t, p.X);
}

/**
 * @brief Fixed-base scalar multiplication for Ed25519.
 *
 * @param r Projective point
 * @param k Scalar
 */
void mon_mul_fixed_base_ed25519_avx512(uint8_t *r, const __m512i *k)
{
    int i, j;
    ProPoint p;
    ALIGN64 uint64_t X_storage[8];
    ALIGN64 uint64_t Y_storage[NWORDS_8x1][8];
    uint64_t temp[NWORDS_8x1];
    uint64_t *_r = (uint64_t *)r;
    uint8_t *X_pointer = (uint8_t *)X_storage;

    ted_mul_fixbase_avx512(&p, k);

    /**
     * from projective form (X:Y:Z) to affine form (x,y).
     * x = X/Z
     * y = Y/Z
     */
    inv_fp255_8x1w(p.Z, p.Z);
    mul_fp255_8x1w(p.X, p.X, p.Z);
    mul_fp255_8x1w(p.Y, p.Y, p.Z);
    final_modp_fp255_8x1w(p.X);
    final_modp_fp255_8x1w(p.Y);
    /**
     * from 51-bit form to 64-bit form.
     */
    STORE(X_storage, p.X[0]);
    for (i = 0; i < NWORDS_8x1; i++) {
        STORE(Y_storage[i], p.Y[i]);
    }
    for (i = 0; i < 8; i++) {
        for (j = 0; j < NWORDS_8x1; j++) {
            temp[j] = Y_storage[j][i];
        }
        conv_51to64((_r + (32 / 8) * i), 4, temp, NWORDS_8x1);
        r[32 * i + 31] = (r[32 * i + 31] & 0x7F) | ((X_pointer[i * 8 + 0] & 0x1) << 7);
    }
}