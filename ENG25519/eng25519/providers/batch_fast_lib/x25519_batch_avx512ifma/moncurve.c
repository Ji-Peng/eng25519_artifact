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
    VSTORE(X_storage, p.X[0]);
    for (i = 0; i < NWORDS_8x1; i++) {
        VSTORE(Y_storage[i], p.Y[i]);
    }
    for (i = 0; i < 8; i++) {
        for (j = 0; j < NWORDS_8x1; j++) {
            temp[j] = Y_storage[j][i];
        }
        conv_51to64((_r + (32 / 8) * i), 4, temp, NWORDS_8x1);
        r[32 * i + 31] = (r[32 * i + 31] & 0x7F) | ((X_pointer[i * 8 + 0] & 0x1) << 7);
    }
}

/**
 * input = [x3 z3 x2 z2 ...]
 * If swap = 1
 *  mask = 0xFF
 *  output = [x2 z2 x3 z2 ...]
 * If swap = 0
 *  mask = 0x00
 *  output = [x3 z3 x2 z2 ...]
 * 0x4E = 0100 1110
 */
// static void mont_ladder_swap(__m512i *x3z3x2z2, int swap)
// {
//     int i;
//     uint8_t mask = 0 - (uint8_t)swap;
//     for (i = 0; i < NWORDS_8x1; i++) {
//         x3z3x2z2[i] = VMPERM(x3z3x2z2[i], mask, x3z3x2z2[i], 0x4E);
//     }
// }

/**
 * input = [x3 z3 x2 z2 ...]
 * output = [z2 x2 x2 z2 ...]
 * 0xEB = 1110 1011
 */
// static void mont_ladder_align(__m512i *z2x2x2z2, __m512i *x3z3x2z2)
// {
//     int i;
//     for (i = 0; i < NWORDS_8x1; i++) {
//         z2x2x2z2[i] = VPERM(x3z3x2z2[i], 0xEB);
//     }
// }

/**
 * input:
 * z1x1_A = [z1 x1 / A ...]
 * x5z5x4z4 = [x5 z5 x4 z4 ...]
 * output:
 * z1x1x2A = [z1 x1 x2 A ...]
 * x5z5z2z4 = [x5 z5 z2 z4 ...]
 */
// static void mont_ladder_premix(__m512i *z1x1x2A, __m512i *x5z5z2z4, __m512i *z1x1_A,
//                                __m512i *x5z5x4z4, __m512i *x3z3x2z2)
// {
//     int i;
//     /** 0x04 = 0000 0100 */
//     for (i = 0; i < NWORDS_8x1; i++) {
//         z1x1x2A[i] = VMBLEND(0x04, z1x1_A[i], x3z3x2z2[i]);
//         x5z5z2z4[i] = VMBLEND(0x04, x5z5x4z4[i], VSHUF(x3z3x2z2[i], 0x4E));
//     }
// }

/**
 * r = [r0 r1 r2 r3 ...]
 * r0 = x7
 * r1 = z7
 * r2 = x4 - z4
 * r3 = x6 + x6 + z6
 */
// static void mont_ladder_postmix(__m512i *r, __m512i *x7z7x6z6, __m512i *x5z5x4z4)
// {
//     int i;
//     const __m512i _2p_51b[2] = {VSET1(LOW51b * 2), VSET1(MASK51b * 2)};
//     __m512i t, t1;

//     for (i = 0; i < NWORDS_8x1; i++) {
//         /** [x7 z7 x6+x6 z6], 0x04 = 0000 0100 */
//         r[i] = VMADD(x7z7x6z6[i], 0x04, x7z7x6z6[i], x7z7x6z6[i]);
//         /** [? ? z6 x6+x6], 0xB4 = 1011 0100 */
//         t = VSHUF(r[i], 0x4E);
//         /** [x7 z7 ? x6+x6+z6], 0x08 = 0000 1000 */
//         r[i] = VMADD(r[i], 0x08, r[i], t);
//         /** [? ? z4 x4] */
//         t = VSHUF(x5z5x4z4[i], 0x4E);
//         /** [? ? x4+2p z4], 0x04 = 0000 0100 */
//         t1 = VMADD(x5z5x4z4[i], 0x04, x5z5x4z4[i], _2p_51b[i != 0]);
//         /** [? ? x4+2p-z4 z4] */
//         t1 = VMSUB(t1, 0x04, t1, t);
//         /** [x7 z7 x4+2p-z4 x6+x6+z6], 0x04 = 0000 0100 */
//         r[i] = VMBLEND(0x04, r[i], t1);
//     }
//     carry_fp255_8x1w(r);
// }

/**
 * input = [x3 z3 x2 z2 ...]
 * output = [x3+z3 2p+x3-z3 x2+z2 2p+x2-z2 ...]
 *
 * t = [z3 x3 z2 x2 ...] using VSHUF 0x4E
 * t += 2p using mask = 0x0A = 0000 1010:
 *   t = [z3 2p+x3 z2 2p+x2 ...]
 * t -= in0 using mask = 0x0A:
 *   t = [z3 2p+x3-z3 z2 2p+x2-z2 ...]
 * t += in0 using mask = 0x05 = 0000 0101:
 *   t = [x3+z3 2p+x3-z3 x2+z2 2p+x2-z2 ...]
 *
 */
// static void mont_ladder_hadamard(__m512i *x3z3x2z2)
// {
//     int i;
//     __m512i t;
//     const __m512i _2p_51b[2] = {VSET1(LOW51b * 2), VSET1(MASK51b * 2)};

//     for (i = 0; i < NWORDS_8x1; i++) {
//         /** t = [z3 x3 z2 x2 ...] */
//         t = VSHUF(x3z3x2z2[i], 0x4E);
//         /** t = [z3 2p+x3 z2 2p+x2 ...] */
//         t = VMADD(t, 0x0A, t, _2p_51b[i != 0]);
//         /** t = [z3 2p+x3-z3 z2 2p+x2-z2 ...] */
//         t = VMSUB(t, 0x0A, t, x3z3x2z2[i]);
//         /** [x3+z3 2p+x3-z3 x2+z2 2p+x2-z2 ...] */
//         x3z3x2z2[i] = VMADD(t, 0x05, t, x3z3x2z2[i]);
//     }
//     carry_fp255_8x1w(x3z3x2z2);
// }

// void mont_ladder_step_1x4w_avx512(__m512i *x3z3x2z2, __m512i *z1x1_A, const uint8_t *n)
// {
//     int i, j, bit, swap, prevbit = 0;
//     __m512i z2x2x2z2[NWORDS_8x1];
//     __m512i *x5z5x4z4 = z2x2x2z2;
//     __m512i z1x1x2A[NWORDS_8x1];
//     __m512i x5z5z2z4[NWORDS_8x1];
//     __m512i *x7z7x6z6 = z1x1x2A;

//     j = 6;
//     for (i = 31; i >= 0; i--) {
//         for (; j >= 0; j--) {
//             bit = (n[i] >> j) & 1;
//             swap = bit ^ prevbit;
//             prevbit = bit;
//             mont_ladder_swap(x3z3x2z2, swap);
//             mont_ladder_hadamard(x3z3x2z2);
//             mont_ladder_align(z2x2x2z2, x3z3x2z2);
//             mul_fp255_8x1w(x3z3x2z2, x3z3x2z2, z2x2x2z2);
//             mont_ladder_hadamard(x3z3x2z2);
//             sqr_fp255_8x1w(x5z5x4z4, x3z3x2z2);
//             /**
//              * [x5 z5 z2 z4 ...] * [z1 x1 x2 A ...]
//              */
//             mont_ladder_premix(z1x1x2A, x5z5z2z4, z1x1_A, x5z5x4z4, x3z3x2z2);
//             mul_fp255_8x1w(x7z7x6z6, x5z5z2z4, z1x1x2A);
//             mont_ladder_postmix(x3z3x2z2, x7z7x6z6, x5z5x4z4);
//         }
//         j = 7;
//     }
//     mont_ladder_swap(x3z3x2z2, bit);
//     final_modp_fp255_8x1w(x3z3x2z2);
// }