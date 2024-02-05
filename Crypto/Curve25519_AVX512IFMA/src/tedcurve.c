/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "tedcurve.h"

#include "gfparith_1w.h"
#include "openssl_curve25519.h"
#include "tedtable.h"
#include "utils.h"

/**
 * @brief Point addition.
 *
 * @details
 * Unified mixed addition R = P + Q on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 * @param q Point in Duif representation [Y+X, Y-X, 2d*X*Y]
 *
 * The point addition in "Twisted Edwards Curves Revisited" Page 6.
 *
 * A=(Y1-X1)*(Y2-X2), B=(Y1+X1)(Y2+X2)
 * C=2*T1*T2, D=2Z1*Z2
 *
 * E=B-A, F=D-C, G=D+C, H=B+A
 *
 * X3=E*F, Y3=G*H, T3=E*H, Z3=F*G
 * 
 * Regarding the input and output range:
 *  The range of r/p->{X,Y,T,Z} is same with the output range of mul_x_fp255_8x1w.
 *  The range of q->{X,Y,Z} is [0, 2^51).
 */
void ted_point_add_avx512(ExtPoint *r, ExtPoint *p, ProPoint *q)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];

    /** t0 = Y1-X1 */
    sbc_fp255_8x1w(t0, p->Y, p->X);
    /** t1 = Y1+X1 */
    adc_fp255_8x1w(t1, p->Y, p->X);

    /** A = rX = (Y1-X1)(Y2-X2) */
    mul_fp255_8x1w(r->X, t0, q->Y);
    /** B = rY = (Y1+X1)(Y2+X2) */
    mul_fp255_8x1w(r->Y, t1, q->X);
    /** C = pT */
    mul_fp255_8x1w(p->T, p->T, q->Z);

    /** E = t0 = B - A */
    sbc_fp255_8x1w(t0, r->Y, r->X);
    /** H = rY = B + A */
    adc_fp255_8x1w(r->Y, r->Y, r->X);
    /** D = 2Z1 */
    add_fp255_8x1w(t1, p->Z, p->Z);
    /** G = rZ = D + C */
    adc_fp255_8x1w(r->Z, t1, p->T);
    /** F = t1 = D - C */
    sbc_fp255_8x1w(t1, t1, p->T);

    /** T3 = E * H */
    mul_fp255_8x1w(r->T, t0, r->Y);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, t0, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, r->Z, r->Y);
    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, r->Z);
}

/**
 * @brief Point doubling.
 *
 * @details
 * Doubling R = 2*P on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 *
 * See "Twisted Edwards Curves Revisited" Page 7.
 *
 * A=X^2, B=Y^2, C=2Z^2, D=-A
 *
 * E=(A+B)-(X+Y)^2=-2XY
 * G=(A-B)
 * F=(A-B)+2Z^2
 * H=(A+B)
 *
 * X3=E*F
 * Y3=G*H
 * T3=E*H
 * Z3=F*G
 */
void ted_point_dbl_avx512(ExtPoint *r, ExtPoint *p)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];
    /** A = t0 = X^2 */
    sqr_fp255_8x1w(t0, p->X);
    /** B = t1 = Y^2 */
    sqr_fp255_8x1w(t1, p->Y);
    /** C = rZ = 2Z^2 */
    sqr_2_fp255_8x1w(r->Z, p->Z);
    /** rX = (X+Y)^2 */
    adc_fp255_8x1w(r->X, p->X, p->Y);
    sqr_fp255_8x1w(r->X, r->X);

    /** H = rY = A + B */
    adc_fp255_8x1w(r->Y, t0, t1);
    /** G = t0 = A - B */
    sbc_fp255_8x1w(t0, t0, t1);
    /** E = rX = A + B - (X+Y)^2 */
    sbc_fp255_8x1w(r->X, r->Y, r->X);
    /** F = t1 = (A-B)+2Z^2 */
    adc_fp255_8x1w(t1, t0, r->Z);

    /** T3 = E * H */
    mul_fp255_8x1w(r->T, r->X, r->Y);
    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, t0);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, r->X, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, t0, r->Y);
}

/**
 * @brief Point doubling without computing T coordinate.
 *
 * @details
 * Doubling R = 2*P on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 *
 * See "Twisted Edwards Curves Revisited" Page 7.
 *
 * A=X^2, B=Y^2, C=2Z^2, D=-A
 *
 * E=(A+B)-(X+Y)^2=-2XY
 * G=(A-B)
 * F=(A-B)+2Z^2
 * H=(A+B)
 *
 * X3=E*F
 * Y3=G*H
 * T3=E*H (do not compute)
 * Z3=F*G
 */
void ted_point_dbl_no_T_avx512(ExtPoint *r, ExtPoint *p)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];
    /** A = t0 = X^2 */
    sqr_fp255_8x1w(t0, p->X);
    /** B = t1 = Y^2 */
    sqr_fp255_8x1w(t1, p->Y);
    /** C = rZ = 2Z^2 */
    sqr_2_fp255_8x1w(r->Z, p->Z);
    /** rX = (X+Y)^2 */
    adc_fp255_8x1w(r->X, p->X, p->Y);
    sqr_fp255_8x1w(r->X, r->X);

    /** H = rY = A + B */
    adc_fp255_8x1w(r->Y, t0, t1);
    /** G = t0 = A - B */
    sbc_fp255_8x1w(t0, t0, t1);
    /** E = rX = A + B - (X+Y)^2 */
    sbc_fp255_8x1w(r->X, r->Y, r->X);
    /** F = t1 = (A-B)+2Z^2 */
    adc_fp255_8x1w(t1, t0, r->Z);

    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, t0);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, r->X, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, t0, r->Y);
}

/**
 * @brief Convert a scalar to signed nibbles.
 *
 * @details
 * Convert the 256-bit scalar to 64 signed nibbles and store them in an array.
 *
 * @param e Nibbles
 * @param k Scalar
 */
void ted_conv_scalar2nibble_avx512(__m512i *e, const __m512i *k)
{
    int i;
    const __m512i eight = VSET1(8);
    const __m512i mask4 = VSET1(0x0F);
    const __m512i mask8 = VSET1(0xFF);
    __m512i carry = VZERO;

    /** convert scalar to nibbles */
    for (i = 0; i < 8; i++) {
        e[8 * i] = VAND(k[i], mask4);
        e[8 * i + 1] = VAND(VSHR(k[i], 4), mask4);
        e[8 * i + 2] = VAND(VSHR(k[i], 8), mask4);
        e[8 * i + 3] = VAND(VSHR(k[i], 12), mask4);
        e[8 * i + 4] = VAND(VSHR(k[i], 16), mask4);
        e[8 * i + 5] = VAND(VSHR(k[i], 20), mask4);
        e[8 * i + 6] = VAND(VSHR(k[i], 24), mask4);
        e[8 * i + 7] = VAND(VSHR(k[i], 28), mask4);
    }

    /** convert unsigned nibbles to signed */
    for (i = 0; i < 63; i++) {
        e[i] = VADD(e[i], carry);
        carry = VADD(e[i], eight);
        carry = VSHR(carry, 4);
        e[i] = VSUB(e[i], VSHL(carry, 4));
        e[i] = VAND(e[i], mask8);
    }
    e[63] = VADD(e[63], carry);
    e[63] = VAND(e[63], mask8);
}

/**
 * @brief Fixed-base scalar multiplication on twisted Edwards curve.
 *
 * @details
 * R = k * B.
 * Compute a scalar multiplication R = k * B with a fixed base B (x, 4/5) on
 * twisted Edwards curve.
 *
 * @param r Projective point
 * @param k Scalar
 */
void ted_mul_fixbase_avx512(ProPoint *r, const __m512i *k)
{
    ExtPoint h;
    __m512i e[64];
    int i;
    // "1/2" in the field
    __attribute__((aligned(64))) const __m512i one_half[NWORDS_8x1] = {
        VSET1(0x7fffffffffff7), VSET1(0x7ffffffffffff), VSET1(0x7ffffffffffff),
        VSET1(0x7ffffffffffff), VSET1(0x3ffffffffffff)};

    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8)], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 8], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 16], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 24], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 32], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 40], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 48], _MM_HINT_T0);
    _mm_prefetch(&multi_base_table[0 * (SUB_TABLE_BYTES / 8) + 56], _MM_HINT_T0);

    ted_conv_scalar2nibble_avx512(e, k);

    ted_point_query_table_avx512(r, 1 >> 1, e[1]);

    /** hX = addYX - subYX = 2X */
    sbc_fp255_8x1w(h.X, r->X, r->Y);
    /** hY = addYX + subYX = 2Y */
    adc_fp255_8x1w(h.Y, r->X, r->Y);
    /** hT = (2X*2Y)/Z = 2XY */
    mul_fp255_8x1w(h.T, h.X, h.Y);
    mul_fp255_8x1w(h.T, h.T, one_half);
    /** hZ = 2 */
    h.Z[1] = h.Z[2] = h.Z[3] = h.Z[4] = VZERO;
    h.Z[0] = VSET1(2);

    for (i = 1 + 2; i < 64; i += 2) {
        ted_point_query_table_avx512(r, i >> 1, e[i]);
        ted_point_add_avx512(&h, &h, r);
    }

    ted_point_dbl_no_T_avx512(&h, &h);
    ted_point_dbl_no_T_avx512(&h, &h);
    ted_point_dbl_no_T_avx512(&h, &h);
    ted_point_dbl_avx512(&h, &h);

    for (i = 0; i < 64; i += 2) {
        ted_point_query_table_avx512(r, i >> 1, e[i]);
        ted_point_add_avx512(&h, &h, r);
    }
    copy_fp255_8x1w(r->X, h.X);
    copy_fp255_8x1w(r->Y, h.Y);
    copy_fp255_8x1w(r->Z, h.Z);
}

const PointXYTZ_pc_2x4w multi_base_table_small[16];

/**
 * 2x4-way mixed point addition (Q and K come from pre-computed table)
 * P = P + Q, J = J + K.
 * PJ =
 * [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
 * [xp1 yp1 tp1 zp1 xj1 yj1 tj1 zj1]
 * [xp2 yp2 tp2 zp2 xj2 yj2 tj2 zj2]
 * [xp3 yp3 tp3 zp3 xj3 yj3 tj3 zj3]
 * [xp4 yp4 tp4 zp4 xj4 yj4 tj4 zj4]
 * QK =
 * [yq0-xq0 yq0+xq0 2dTq0 2Zq0 yk0-xk0 yk0+xk0 2dTk0 2Zk0]
 * [yq1-xq1 yq1+xq1 2dTq1 2Zq1 yk1-xk1 yk1+xk1 2dTk1 2Zk1]
 * [yq2-xq2 yq2+xq2 2dTq2 2Zq2 yk2-xk2 yk2+xk2 2dTk2 2Zk2]
 * [yq3-xq3 yq3+xq3 2dTq3 2Zq3 yk3-xk3 yk3+xk3 2dTk3 2Zk3]
 * [yq4-xq4 yq4+xq4 2dTq4 2Zq4 yk4-xk4 yk4+xk4 2dTk4 2Zk4]
 *
 * Algorithm design:
 * <A0,B0,C0,D0,A1,B1,C1,D1> = <Yp-Xp,Yp+Xp,Tp,Zp,Yj-Xj,Yj+Xj,Tj,Zj> *
 *                             <Yq-Xq,Yq+Xq,2dTq,2Zq,Yk-Xk,Yk+Xk,2dTk,2Zk>
 *
 * <E0,G0,H0,F0,E1,G1,H1,F1> =
 * <B0-A0,D0+C0,B0+A0,D0-C0,B1-A1,D1+C1,B1+A1,D1-C1> =
 * <B0,D0,B0,D0,B1,D1,B1,D1> -/+ <A0,C0,A0,C0,A1,C1,A1,C1>
 *
 * <F0,H0,E0,G0,F1,H1,E1,G1> = PERM(<E0,G0,H0,F0,E1,G1,H1,F1>)
 *
 * <Xp,Yp,Tp,Zp,Xj,Yj,Tj,Zj> = <E0,G0,H0,F0,E1,G1,H1,F1> *
 *                             <F0,H0,E0,G0,F1,H1,E1,G1>
 */
void _2x4w_mixadd(PointXYTZ_2x4w *R, const PointXYTZ_2x4w *PJ,
                  const PointXYTZ_pc_2x4w *QK)
{
    int i;
    __m512i subYX_addYX_T_Z[NWORDS_8x1];
    __m512i ABCD[NWORDS_8x1];
    __m512i *EGHF = subYX_addYX_T_Z;
    __m512i *FHEG = ABCD;
    /** lowest 51b of 2p and other 51b of 2p */
    const __m512i _2p_51b[2] = {VSET1(LOW51b * 2), VSET1(MASK51b * 2)};
    /**
     * Compute
     * [yp0-xp0 yp0+xp0 tp0 zp0 yj0-xj0 yj0+xj0 tj0 zj0]
     * ...
     * [yp4-xp4 yp4+xp4 tp4 zp4 yj4-xj4 yj4+xj4 tj4 zj4]
     * N = [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
     * M = [yp0 xp0 zp0 tp0 yj0 xj0 zj0 tj0] using VSHUF(N, 0x4E)
     * Method 1:
     * get [-xp0 yp0 tp0 zp0 -xj0 yj0 tj0 zj0] using SUB and XOR instructions
     * get [yp0-xp0+2p yp0+xp0 tp0 zp0 yj0-xj0+2p yj0+xj0 tj0 zj0]
     *      using two ADDs with MASK
     * Method 2:
     * get [yp0-xp0 yp0 tp0 zp0 yj0-xj0 yj0 tj0 zj0] using SUB with MASK
     * get [yp0-xp0 yp0+xp0 tp0 zp0 yj0-xj0 yj0+xj0 tj0 zj0] using ADD with MASK
     * get [yp0-xp0+2p yp0+xp0 tp0 zp0 yj0-xj0+2p yj0+xj0 tj0 zj0]
     *      using ADD with MASK
     * Method 2 is better.
     * Note that:
     * 1) propagating carry is needed after +2p
     */
    __m512i M;
    for (i = 0; i < NWORDS_8x1; i++) {
        /** VSHUF32(, 0x4E) is equal with PERM(, 0xB1) */
        M = VSHUF32(PJ->XYTZ[i], 0x4E);
        /** [yp0+2p yp0 tp0 zp0 yj0+2p yj0 tj0 zj0] */
        subYX_addYX_T_Z[i] = VMADD(PJ->XYTZ[i], 0x11, M, _2p_51b[i != 0]);
        /** [yp0+2p-xp0 yp0 tp0 zp0 yj0+2p-xj0 yj0 tj0 zj0] */
        subYX_addYX_T_Z[i] =
            VMSUB(subYX_addYX_T_Z[i], 0x11, subYX_addYX_T_Z[i], PJ->XYTZ[i]);
        /** [yp0+2p-xp0 yp0+xp0 tp0 zp0 yj0+2p-xj0 yj0+xj0 tj0 zj0] */
        subYX_addYX_T_Z[i] = VMADD(subYX_addYX_T_Z[i], 0x22, subYX_addYX_T_Z[i], M);
    }
    carry_fp255_8x1w(subYX_addYX_T_Z);

    /**
     * Compute <A0,B0,C0,D0,A1,B1,C1,D1> using 8x1-way multiplication.
     */
    mul_fp255_8x1w(ABCD, subYX_addYX_T_Z, QK->subYX_addYX_2dT_2Z);

    /**
     * get <B0 D0 B0 D0 B1 D1 B1 D1> using VPERM(, 0xDD)
     * get <A0 C0 A0 C0 A1 C1 A1 C1> using VPERM(, 0x88)
     * get <E0,G0,H0,F0,E1,G1,H1,F1> =
     *  <B0-A0,D0+C0,B0+A0,D0-C0,B1-A1,D1+C1,B1+A1,D1-C1>
     *  using ADD and SUB with MASK
     * Note that:
     * 1) propagating carry is needed
     */
    __m512i BDBD;
    __m512i ACAC;

    for (i = 0; i < NWORDS_8x1; i++) {
        //     BDBD = VPERM(ABCD[i], 0xDD);
        //     ACAC = VPERM(ABCD[i], 0x88);
        //     EGHF[i] = VMADD(BDBD, 0x99, BDBD, _2p_oth_51b);
        //     EGHF[i] = VMSUB(EGHF[i], 0x99, EGHF[i], ACAC);
        //     EGHF[i] = VMADD(EGHF[i], 0x66, EGHF[i], ACAC);
        BDBD = VPERM(ABCD[i], 0xDD);
        ACAC = VPERM(ABCD[i], 0x88);
        /** [B00+2p D00 B00 D00+2p B10+2p D10 B10 D10+2p] */
        EGHF[i] = VMADD(BDBD, 0x99, BDBD, _2p_51b[i != 0]);
        /** [B00+2p-A00 D00 B00 D00+2p-C00 B10+2p-A10 D10 B10 D10+2p-C10] */
        EGHF[i] = VMSUB(EGHF[i], 0x99, EGHF[i], ACAC);
        /** [B00+2p-A00 D00+C00 B00+A00 D00+2p-C00 B10+2p-A10 D10+C00 B10+A00
         * D10+2p-C10] */
        EGHF[i] = VMADD(EGHF[i], 0x66, EGHF[i], ACAC);
    }
    carry_fp255_8x1w(EGHF);

    /**
     * get <F0,H0,E0,G0,F1,H1,E1,G1> using VPERM(, 0x4B)
     * <Xp,Yp,Tp,Zp,Xj,Yj,Tj,Zj> = <E0,G0,H0,F0,E1,G1,H1,F1> *
     *                             <F0,H0,E0,G0,F1,H1,E1,G1>
     */
    for (i = 0; i < NWORDS_8x1; i++) {
        FHEG[i] = VPERM(EGHF[i], 0x4B);
    }
    mul_fp255_8x1w(R->XYTZ, EGHF, FHEG);
}

/**
 * 2x4-way full point addition
 * P = P + Q, J = J + K.
 * PJ =
 * [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
 * [xp1 yp1 tp1 zp1 xj1 yj1 tj1 zj1]
 * [xp2 yp2 tp2 zp2 xj2 yj2 tj2 zj2]
 * [xp3 yp3 tp3 zp3 xj3 yj3 tj3 zj3]
 * [xp4 yp4 tp4 zp4 xj4 yj4 tj4 zj4]
 *
 * Algorithm design:
 * <A0,B0,C0,D0,A1,B1,C1,D1> = <Yp-Xp,Yp+Xp,Tp,Zp,Yj-Xj,Yj+Xj,Tj,Zj> *
 *                             <Yq-Xq,Yq+Xq,2dTq,2Zq,Yk-Xk,Yk+Xk,2dTk,2Zk>
 *
 * <E0,G0,H0,F0,E1,G1,H1,F1> =
 * <B0-A0,D0+C0,B0+A0,D0-C0,B1-A1,D1+C1,B1+A1,D1-C1> =
 * <B0,D0,B0,D0,B1,D1,B1,D1> -/+ <A0,C0,A0,C0,A1,C1,A1,C1>
 *
 * <F0,H0,E0,G0,F1,H1,E1,G1> = PERM(<E0,G0,H0,F0,E1,G1,H1,F1>)
 *
 * <Xp,Yp,Tp,Zp,Xj,Yj,Tj,Zj> = <E0,G0,H0,F0,E1,G1,H1,F1> *
 *                             <F0,H0,E0,G0,F1,H1,E1,G1>
 */
void _2x4w_fulladd(PointXYTZ_2x4w *PJ, const PointXYTZ_2x4w *QK)
{
    int i;
    __m512i subYX_addYX_T_Z[NWORDS_8x1];
    __m512i ABCD[NWORDS_8x1];
    __m512i *EGHF = subYX_addYX_T_Z;
    __m512i *FHEG = ABCD;
    /** lowest 51b of 2p and other 51b of 2p */
    const __m512i _2p_51b[2] = {VSET1(LOW51b * 2), VSET1(MASK51b * 2)};
    const __m512i _2d_2x4w[NWORDS_8x1] = {
        VSET(2, 0x69b9426b2f159, 1, 1, 2, 0x69b9426b2f159, 1, 1),
        VSET(0, 0x35050762add7a, 0, 0, 0, 0x35050762add7a, 0, 0),
        VSET(0, 0x3cf44c0038052, 0, 0, 0, 0x3cf44c0038052, 0, 0),
        VSET(0, 0x6738cc7407977, 0, 0, 0, 0x6738cc7407977, 0, 0),
        VSET(0, 0x2406d9dc56dff, 0, 0, 0, 0x2406d9dc56dff, 0, 0)};
    /**
     * Compute
     * [yp0-xp0 yp0+xp0 tp0 zp0 yj0-xj0 yj0+xj0 tj0 zj0]
     * ...
     * [yp4-xp4 yp4+xp4 tp4 zp4 yj4-xj4 yj4+xj4 tj4 zj4]
     * N = [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
     * M = [yp0 xp0 zp0 tp0 yj0 xj0 zj0 tj0] using VSHUF(N, 0x4E)
     * get [yp0-xp0 yp0 tp0 zp0 yj0-xj0 yj0 tj0 zj0] using SUB with MASK
     * get [yp0-xp0 yp0+xp0 tp0 zp0 yj0-xj0 yj0+xj0 tj0 zj0] using ADD with MASK
     * get [yp0-xp0+2p yp0+xp0 tp0 zp0 yj0-xj0+2p yj0+xj0 tj0 zj0]
     *      using ADD with MASK
     * Note that:
     * 1) propagating carry is needed after +2p
     */
    __m512i M;
    for (i = 0; i < NWORDS_8x1; i++) {
        /** VSHUF32(, 0x4E) is equal with PERM(, 0xB1) */
        M = VSHUF32(PJ->XYTZ[i], 0x4E);
        /** [yp0+2p yp0 tp0 zp0 yj0+2p yj0 tj0 zj0] */
        subYX_addYX_T_Z[i] = VMADD(PJ->XYTZ[i], 0x11, M, _2p_51b[i != 0]);
        /** [yp0+2p-xp0 yp0 tp0 zp0 yj0+2p-xj0 yj0 tj0 zj0] */
        subYX_addYX_T_Z[i] =
            VMSUB(subYX_addYX_T_Z[i], 0x11, subYX_addYX_T_Z[i], PJ->XYTZ[i]);
        /** [yp0+2p-xp0 yp0+xp0 tp0 zp0 yj0+2p-xj0 yj0+xj0 tj0 zj0] */
        subYX_addYX_T_Z[i] = VMADD(subYX_addYX_T_Z[i], 0x22, subYX_addYX_T_Z[i], M);
    }
    carry_fp255_8x1w(subYX_addYX_T_Z);

    /** get <Yq-Xq,Yq+Xq,Tq,Zq,Yk-Xk,Yk+Xk,Tk,Zk> */
    for (i = 0; i < NWORDS_8x1; i++) {
        M = VSHUF32(QK->XYTZ[i], 0x4E);
        ABCD[i] = VMADD(QK->XYTZ[i], 0x11, M, _2p_51b[i != 0]);
        ABCD[i] = VMSUB(ABCD[i], 0x11, ABCD[i], QK->XYTZ[i]);
        ABCD[i] = VMADD(ABCD[i], 0x22, ABCD[i], M);
    }
    carry_fp255_8x1w(ABCD);
    /** get <Yq-Xq,Yq+Xq,2dTq,2Zq,Yk-Xk,Yk+Xk,2dTk,2Zk> */
    mul_fp255_8x1w(ABCD, ABCD, _2d_2x4w);

    /**
     * Compute <A0,B0,C0,D0,A1,B1,C1,D1> using 8x1-way multiplication.
     */
    mul_fp255_8x1w(ABCD, subYX_addYX_T_Z, ABCD);

    /**
     * get <B0 D0 B0 D0 B1 D1 B1 D1> using VPERM(, 0xDD)
     * get <A0 C0 A0 C0 A1 C1 A1 C1> using VPERM(, 0x88)
     * get <E0,G0,H0,F0,E1,G1,H1,F1> =
     *  <B0-A0,D0+C0,B0+A0,D0-C0,B1-A1,D1+C1,B1+A1,D1-C1>
     *  using ADD and SUB with MASK
     * Note that:
     * 1) propagating carry is needed
     */
    __m512i BDBD;
    __m512i ACAC;
    for (i = 0; i < NWORDS_8x1; i++) {
        BDBD = VPERM(ABCD[i], 0xDD);
        ACAC = VPERM(ABCD[i], 0x88);
        /** [B00+2p D00 B00 D00+2p B10+2p D10 B10 D10+2p] */
        EGHF[i] = VMADD(BDBD, 0x99, BDBD, _2p_51b[i != 0]);
        /** [B00+2p-A00 D00 B00 D00+2p-C00 B10+2p-A10 D10 B10 D10+2p-C10] */
        EGHF[i] = VMSUB(EGHF[i], 0x99, EGHF[i], ACAC);
        /** [B00+2p-A00 D00+C00 B00+A00 D00+2p-C00 B10+2p-A10 D10+C00 B10+A00
         * D10+2p-C10] */
        EGHF[i] = VMADD(EGHF[i], 0x66, EGHF[i], ACAC);
    }
    carry_fp255_8x1w(EGHF);

    /**
     * get <F0,H0,E0,G0,F1,H1,E1,G1> using VPERM(, 0x4B)
     * <Xp,Yp,Tp,Zp,Xj,Yj,Tj,Zj> = <E0,G0,H0,F0,E1,G1,H1,F1> *
     *                             <F0,H0,E0,G0,F1,H1,E1,G1>
     */
    for (i = 0; i < NWORDS_8x1; i++) {
        FHEG[i] = VPERM(EGHF[i], 0x4B);
    }
    mul_fp255_8x1w(PJ->XYTZ, EGHF, FHEG);
}

/**
 * 2x4-way point doubling operation.
 * PJ =
 * [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
 * [xp1 yp1 tp1 zp1 xj1 yj1 tj1 zj1]
 * [xp2 yp2 tp2 zp2 xj2 yj2 tj2 zj2]
 * [xp3 yp3 tp3 zp3 xj3 yj3 tj3 zj3]
 * [xp4 yp4 tp4 zp4 xj4 yj4 tj4 zj4]
 *
 * Algorithm design:
 * According to "Twisted Edwards Curves Revisited" Section 3.3.
 * A = X^2, B = Y^2, C = 2Z^2, D = -A, E = 2XY = 2TZ
 * G = B - A, F = G - C = B - A - C, H = D - B = -A - B
 * X = EF, Y = GH, T = EH, Z = FG
 *
 * [A B E/2 C/2] = [X^2 Y^2 TZ Z^2]
 * [-F -H E G] = [A-B+C A+B 2TZ==2XY -A+B]
 * ([X Y T Z] == [-X -Y -T -Z]) = [-F -H E G] * [E G -H -F]
 */
void _2x4w_doubling(PointXYTZ_2x4w *_2PJ, const PointXYTZ_2x4w *PJ)
{
    int i;
    __m512i ABEC[NWORDS_8x1];
    __m512i XYZZ[NWORDS_8x1];
    /** lowest 51b of 2p */
    const __m512i _2p_low_51b = VSET1(LOW51b * 2);
    /** other 51b of 2p */
    const __m512i _2p_oth_51b = VSET1(MASK51b * 2);
    __m512i *FHEG = ABEC;
    __m512i *EGHF = XYZZ;

    /** get XYZZ using VPERM(, 0xF4 = 1111 0100) */
    for (i = 0; i < NWORDS_8x1; i++) {
        XYZZ[i] = VPERM(PJ->XYTZ[i], 0xF4);
    }
    /** [A B E/2 C/2] = [X^2 Y^2 TZ Z^2] */
    mul_fp255_8x1w(ABEC, PJ->XYTZ, XYZZ);

    __m512i CBEB, CAE0, A000, B00A;
    /** get CBEB using VPERM(, 0x67 = 0110 0111) */
    CBEB = VPERM(ABEC[0], 0x67);
    /** get CAE0 using VMZPERM(0x77, ,0x23 = 0010 0011) */
    CAE0 = VMZPERM(0x77, ABEC[0], 0x23);
    /** get A000 using VMZPERM(0x11, ,0x00) */
    A000 = VMZPERM(0x11, ABEC[0], 0x00);
    /** get B00A using VMZPERM(0x99, ,0x01 = 0000 0001) */
    B00A = VMZPERM(0x99, ABEC[0], 0x01);
    FHEG[0] = VADD(CBEB, VADD(CAE0, VADD(A000, VSUB(_2p_low_51b, B00A))));
    for (i = 1; i < NWORDS_8x1; i++) {
        CBEB = VPERM(ABEC[i], 0x67);
        CAE0 = VMZPERM(0x77, ABEC[i], 0x23);
        A000 = VMZPERM(0x11, ABEC[i], 0x00);
        B00A = VMZPERM(0x99, ABEC[i], 0x01);
        FHEG[i] = VADD(CBEB, VADD(CAE0, VADD(A000, VSUB(_2p_oth_51b, B00A))));
    }
    carry_fp255_8x1w(FHEG);

    /** get EGHF using VPERM(, 0x1E = 0001 1110) */
    for (i = 0; i < NWORDS_8x1; i++) {
        EGHF[i] = VPERM(FHEG[i], 0x1E);
    }
    mul_fp255_8x1w(_2PJ->XYTZ, EGHF, FHEG);
}

/**
 * @brief Point addition.
 *
 * @details
 * Unified mixed addition R = P + Q on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 * @param q Point in Duif representation [Y+X, Y-X, 2d*X*Y = 2XY]. Note that Zq = 1 and Tq
 * = XY / Z = XY.
 *
 * The point addition in "Twisted Edwards Curves Revisited" Page 6.
 *
 * A=(Y1-X1)*(Y2-X2), B=(Y1+X1)(Y2+X2)
 * C=2*T1*T2, D=2Z1*Z2
 *
 * E=B-A, F=D-C, G=D+C, H=B+A
 *
 * X3=E*F, Y3=G*H, T3=E*H, Z3=F*G
 */
void _8x1w_mixadd(PointXYTZ_8x1w *r, PointXYTZ_8x1w *p, const PointXYTZ_pc_8x1w *q)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];

    /** t0 = Y1-X1 */
    sbc_fp255_8x1w(t0, p->Y, p->X);
    /** t1 = Y1+X1 */
    adc_fp255_8x1w(t1, p->Y, p->X);

    /** A = rX = (Y1-X1)(Y2-X2) */
    mul_fp255_8x1w(r->X, t0, q->subYX);
    /** B = rY = (Y1+X1)(Y2+X2) */
    mul_fp255_8x1w(r->Y, t1, q->addYX);
    /** C = pT = 2T1T2 */
    mul_fp255_8x1w(p->T, p->T, q->_2dYX);
    /** D = t1 = 2Z1 */
    add_fp255_8x1w(t1, p->Z, p->Z);

    /** E = t0 = B - A */
    sbc_fp255_8x1w(t0, r->Y, r->X);
    /** H = rY = B + A */
    adc_fp255_8x1w(r->Y, r->Y, r->X);
    /** G = rZ = D + C */
    adc_fp255_8x1w(r->Z, t1, p->T);
    /** F = t1 = D - C */
    sbc_fp255_8x1w(t1, t1, p->T);

    /** T3 = E * H */
    mul_fp255_8x1w(r->T, t0, r->Y);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, t0, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, r->Z, r->Y);
    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, r->Z);
}

/**
 * @brief Point addition.
 *
 * @details
 * Unified full addition R = P + Q on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 * @param q Point in extended projective coordinates [X, Y, T, Z]
 *
 * The point addition in "Twisted Edwards Curves Revisited" Page 6.
 *
 * A=(Y1-X1)*(Y2-X2), B=(Y1+X1)(Y2+X2)
 * C=2d*T1*T2, D=2Z1*Z2
 *
 * E=B-A, F=D-C, G=D+C, H=B+A
 *
 * X3=E*F, Y3=G*H, T3=E*H, Z3=F*G
 */
void _8x1w_fulladd(PointXYTZ_8x1w *r, PointXYTZ_8x1w *p, const PointXYTZ_8x1w *q)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];
    const __m512i _2d_8x1[NWORDS_8x1] = {VSET1(0x69b9426b2f159), VSET1(0x35050762add7a),
                                         VSET1(0x3cf44c0038052), VSET1(0x6738cc7407977),
                                         VSET1(0x2406d9dc56dff)};

    /** t0 = Y1-X1 */
    sbc_fp255_8x1w(t0, p->Y, p->X);
    /** t1 = Y1+X1 */
    adc_fp255_8x1w(t1, p->Y, p->X);
    /** rX = Y2-X2 */
    sbc_fp255_8x1w(r->X, q->Y, q->X);
    /** rY = Y2+X2 */
    adc_fp255_8x1w(r->Y, q->Y, q->X);

    /** A = rX = (Y1-X1)(Y2-X2) */
    mul_fp255_8x1w(r->X, t0, r->X);
    /** B = rY = (Y1+X1)(Y2+X2) */
    mul_fp255_8x1w(r->Y, t1, r->Y);
    /** C = pT = 2dT1T2 */
    mul_fp255_8x1w(p->T, p->T, q->T);
    mul_fp255_8x1w(p->T, p->T, _2d_8x1);
    /** D = t1 = 2Z1Z2 */
    mul_2_fp255_8x1w(t1, p->Z, q->Z);

    /** E = t0 = B - A */
    sbc_fp255_8x1w(t0, r->Y, r->X);
    /** H = rY = B + A */
    adc_fp255_8x1w(r->Y, r->Y, r->X);
    /** G = rZ = D + C */
    adc_fp255_8x1w(r->Z, t1, p->T);
    /** F = t1 = D - C */
    sbc_fp255_8x1w(t1, t1, p->T);

    /** T3 = E * H */
    mul_fp255_8x1w(r->T, t0, r->Y);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, t0, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, r->Z, r->Y);
    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, r->Z);
}

/**
 * @brief Point doubling.
 *
 * @details
 * Doubling R = 2*P on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 *
 * See "Twisted Edwards Curves Revisited" Page 7.
 *
 * A=X^2, B=Y^2, C=2Z^2, D=-A
 *
 * E=(A+B)-(X+Y)^2=-2XY
 * G=(A-B)
 * F=(A-B)+2Z^2
 * H=(A+B)
 *
 * X3=E*F
 * Y3=G*H
 * T3=E*H
 * Z3=F*G
 */
void _8x1w_dbl(PointXYTZ_8x1w *r, const PointXYTZ_8x1w *p)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];
    /** A = t0 = X^2 */
    sqr_fp255_8x1w(t0, p->X);
    /** B = t1 = Y^2 */
    sqr_fp255_8x1w(t1, p->Y);
    /** C = rZ = 2Z^2 */
    sqr_2_fp255_8x1w(r->Z, p->Z);
    /** rX = (X+Y)^2 */
    adc_fp255_8x1w(r->X, p->X, p->Y);
    sqr_fp255_8x1w(r->X, r->X);

    /** H = rY = A + B */
    adc_fp255_8x1w(r->Y, t0, t1);
    /** G = t0 = A - B */
    sbc_fp255_8x1w(t0, t0, t1);
    /** E = rX = A + B - (X+Y)^2 */
    sbc_fp255_8x1w(r->X, r->Y, r->X);
    /** F = t1 = (A-B)+2Z^2 */
    adc_fp255_8x1w(t1, t0, r->Z);

    /** T3 = E * H */
    mul_fp255_8x1w(r->T, r->X, r->Y);
    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, t0);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, r->X, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, t0, r->Y);
}

/**
 * @brief Point doubling without computing T coordinate.
 *
 * @details
 * Doubling R = 2*P on a twisted Edwards curve with a = -1.
 *
 * @param r Point in extended projective coordinates [X, Y, T, Z]
 * @param p Point in extended projective coordinates [X, Y, T, Z]
 *
 * See "Twisted Edwards Curves Revisited" Page 7.
 *
 * A=X^2, B=Y^2, C=2Z^2, D=-A
 *
 * E=(A+B)-(X+Y)^2=-2XY
 * G=(A-B)
 * F=(A-B)+2Z^2
 * H=(A+B)
 *
 * X3=E*F
 * Y3=G*H
 * T3=E*H (do not compute)
 * Z3=F*G
 */
void _8x1w_dbl_no_T(PointXYTZ_8x1w *r, const PointXYTZ_8x1w *p)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1];
    /** A = t0 = X^2 */
    sqr_fp255_8x1w(t0, p->X);
    /** B = t1 = Y^2 */
    sqr_fp255_8x1w(t1, p->Y);
    /** C = rZ = 2Z^2 */
    sqr_2_fp255_8x1w(r->Z, p->Z);
    /** rX = (X+Y)^2 */
    adc_fp255_8x1w(r->X, p->X, p->Y);
    sqr_fp255_8x1w(r->X, r->X);

    /** H = rY = A + B */
    adc_fp255_8x1w(r->Y, t0, t1);
    /** G = t0 = A - B */
    sbc_fp255_8x1w(t0, t0, t1);
    /** E = rX = A + B - (X+Y)^2 */
    sbc_fp255_8x1w(r->X, r->Y, r->X);
    /** F = t1 = (A-B)+2Z^2 */
    adc_fp255_8x1w(t1, t0, r->Z);

    /** Z3 = F * G */
    mul_fp255_8x1w(r->Z, t1, t0);
    /** X3 = E * F */
    mul_fp255_8x1w(r->X, r->X, t1);
    /** Y3 = G * H */
    mul_fp255_8x1w(r->Y, t0, r->Y);
}

/**
 * @brief Convert the coordinates of LUT point to 51b format.
 *
 * @details
 * Convert the coordinate of a LUT point (4*64-bit) to 5*51-bit.
 *
 * @param r Mpi51 integer
 * @param a LUT coordinate
 */
void conv_coor2mpi51_8x1w(__m512i *r, const __m512i *a)
{
    const __m512i mask = VSET1(MASK51b);
    r[0] = VAND(a[0], mask);
    r[1] = VSHR(a[0], 51);
    r[1] = VOR(r[1], VSHL(a[1], 13));
    r[1] = VAND(r[1], mask);
    r[2] = VSHR(a[1], 38);
    r[2] = VOR(r[2], VSHL(a[2], 26));
    r[2] = VAND(r[2], mask);
    r[3] = VSHR(a[2], 25);
    r[3] = VOR(r[3], VSHL(a[3], 39));
    r[3] = VAND(r[3], mask);
    r[4] = VAND(VSHR(a[3], 12), mask);
}

/**
 * Recoding to a signed radix 2^5 representation.
 * r is a 255-bit integer for x25519 and 0<=r<2^252+0x14def9dea2f79cd65812631a5cf5d3ed for
 * ed25519.
 *
 * Return (-1)^(signs[i]) * ki for i \in [0, 51] for x25519 (with final_carry) and i \in
 * [0, 50] for ed25519.
 *
 * Such that
 *  ki \in {0, 1, 2, ..., 2^{5-1}}.
 *  signs[i] = 00...00 if ki is positive
 *  signs[i] = 11...11 if ki is negative
 * digits[i] = ki.
 */
void recoding_signed_scalar_normal_ed25519(uint64_t *signs, uint64_t *digits,
                                           const uint8_t *r, int final_carry)
{
    const int OMEGA = 5;
    int i;
    int8_t carry = 0;
    int8_t value, digit;

    for (i = 0; i < 6; i++) {
        value = (r[i * 5 + 0] & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 0] = (int64_t)digit;
        signs[i * 8 + 0] = (int64_t)-carry;

        value = (((r[i * 5 + 1] << 3) | (r[i * 5 + 0] >> 5)) & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 1] = (int64_t)digit;
        signs[i * 8 + 1] = (int64_t)-carry;

        value = ((r[i * 5 + 1] >> 2) & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 2] = (int64_t)digit;
        signs[i * 8 + 2] = (int64_t)-carry;

        value = (((r[i * 5 + 2] << 1) | r[i * 5 + 1] >> 7) & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 3] = (int64_t)digit;
        signs[i * 8 + 3] = (int64_t)-carry;

        value = (((r[i * 5 + 3] << 4) | (r[i * 5 + 2] >> 4)) & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 4] = (int64_t)digit;
        signs[i * 8 + 4] = (int64_t)-carry;

        value = ((r[i * 5 + 3] >> 1) & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 5] = (int64_t)digit;
        signs[i * 8 + 5] = (int64_t)-carry;

        value = (((r[i * 5 + 4] << 2) | (r[i * 5 + 3] >> 6)) & 0x1F) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 6] = (int64_t)digit;
        signs[i * 8 + 6] = (int64_t)-carry;

        value = (r[i * 5 + 4] >> 3) + carry;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[i * 8 + 7] = (int64_t)digit;
        signs[i * 8 + 7] = (int64_t)-carry;
    }
    value = (r[6 * 5 + 0] & 0x1F) + carry;
    carry = value >= (1 << (OMEGA - 1));
    digit = ((value ^ (-carry)) + carry) & 0x1F;
    digits[6 * 8 + 0] = (int64_t)digit;
    signs[6 * 8 + 0] = (int64_t)-carry;

    value = (((r[6 * 5 + 1] << 3) | (r[6 * 5 + 0] >> 5)) & 0x1F) + carry;
    carry = value >= (1 << (OMEGA - 1));
    digit = ((value ^ (-carry)) + carry) & 0x1F;
    digits[6 * 8 + 1] = (int64_t)digit;
    signs[6 * 8 + 1] = (int64_t)-carry;

    /**
     * The effective-bit number of r[31] is 253-31*8=5.
     * Therefore it will not produce carry this time for ed25519.
     */
    value = ((r[6 * 5 + 1] >> 2) & 0x1F) + carry;
    carry = value >= (1 << (OMEGA - 1));
    digit = ((value ^ (-carry)) + carry) & 0x1F;
    digits[6 * 8 + 2] = (int64_t)digit;
    signs[6 * 8 + 2] = (int64_t)-carry;

    if (final_carry == 1) {
        value = (r[6 * 5 + 1] >> 7) & 0x1F;
        carry = value >= (1 << (OMEGA - 1));
        digit = ((value ^ (-carry)) + carry) & 0x1F;
        digits[6 * 8 + 3] = (int64_t)digit;
        signs[6 * 8 + 3] = (int64_t)-carry;
    }
}

/**
 * Recoding to a signed radix 2^4 representation.
 * r is a 256-bit integer.
 * Return (-1)^(signs[i]) * ki for i \in [0, 64].
 * Such that
 *  ki \in {0, 1, 2, ..., 2^{4-1}}.
 *  signs[i] = 00...00 if ki is positive
 *  signs[i] = 11...11 if ki is negative
 * digits[0, 1, 2, 3, 4, 5, 6, 7 ] = {k0, k1, k16, k17, k32, k33, k48, k49};
 * digits[8, 9, 10,11,12,13,14,15] = {k2, k3, k18, k19, k34, k35, k50, k51};
 * ...
 * digits[56,57,58,59,60,61,62,63] = {k14,k15,k30, k31, k46, k47, k62, k63};
 */
void recoding_signed_scalar_1x8w_ed25519(uint64_t *signs, uint64_t *digits,
                                         const uint8_t *r)
{
    const int OMEGA = 4;
    int i, j;
    int8_t carry = 0;
    uint8_t nibble_low, nibble_hig;
    int8_t value, digit;

    for (i = 0; i < 4; i++) {
        for (j = 0; j < 8; j++) {
            nibble_low = r[8 * i + j] & 0xF;
            value = nibble_low + carry;
            carry = value >= (1 << (OMEGA - 1));
            digit = ((value ^ (-carry)) + carry) & 0xF;

            digits[8 * j + 2 * i + 0] = (int64_t)digit;
            signs[8 * j + 2 * i + 0] = (int64_t)-carry;

            nibble_hig = (r[8 * i + j] >> 4) & 0xF;
            value = nibble_hig + carry;
            carry = value >= (1 << (OMEGA - 1));
            digit = ((value ^ (-carry)) + carry) & 0xF;

            digits[8 * j + 2 * i + 1] = (int64_t)digit;
            signs[8 * j + 2 * i + 1] = (int64_t)-carry;
        }
    }
    /*This is always equal to 0 iff r < 2**252 */
    digits[64] = carry;
}

/**
 * P is output; it contains 8 points from 4 sub-tables.
 * secret_signs: signs of 4 signed-4b-form scalars.
 * secret_digits: digits of 4 signed-4b-form scalars.
 * index: the index of sub-tables.
 */
void query_table_1x8w_ed25519(PointXYTZ_pc_8x1w *P, const uint64_t *secret_signs,
                              const uint64_t *secret_digits, const uint64_t index)
{
    (void)P;
    const __m512i zero = VZERO;
    __m512i temp;
    __m512i v_scalar = VLOAD512(secret_digits);
    __m512i v_sign = VLOAD512(secret_signs);
    (void)v_sign;
    __m512i addYX[4], subYX[4], _2dYX[4];
    const uint64_t one[4] = {1, 0, 0, 0};
    /**
     * assume that v_scalar = [0 1 2 3 4 5 6 7]
     * v_index = [-1 0 1 2 3 4 5 6]
     * v_mask_zero = [0 1 1 1 1 1 1 1] for processing the case that scalar = 0
     */
    const __m512i v_index = VSUB(v_scalar, VSET1(1));
    const __mmask8 v_mask_zero = VCMPNEQ(v_scalar, zero);
    /**
     * [0 1 0 0 0 0 0 0] for getting the values in Ti sub-table
     * [0 0 1 1 0 0 0 0] for getting the values in Ti+8 sub-table
     * [0 0 0 0 1 1 0 0] for getting the values in Ti+16 sub-table
     * [0 0 0 0 0 0 1 1] for getting the values in Ti+24 sub-table
     */
    __mmask8 v_mask_tis[4] = {v_mask_zero & 0x03, v_mask_zero & 0x0C, v_mask_zero & 0x30,
                              v_mask_zero & 0xC0};
    /**
     * (| 0xFC): 0xFC = 1111 1100b for processing "scalar = 0" in Ti sub-table
     * (| 0xF3): 0xF3 = 1111 0011b for processing "scalar = 0" in Ti+8 sub-table
     * (| 0xCF): 0xCF = 1100 1111b for processing "scalar = 0" in Ti+16 sub-table
     * (| 0x3F): 0x3F = 0011 1111b for processing "scalar = 0" in Ti+25 sub-table
     */
    __mmask8 v_mask_scalar_zero[4] = {0xFC, 0xF3, 0xCF, 0x3F};
    int i, j;

    for (i = 0; i < 4; i++) {
        addYX[i] = subYX[i] = _2dYX[i] = zero;
        /**
         * 32 * 3 * 8: the size of sub-table
         * (/ 8): the type of multi_base_table is uint64_t
         * (* 8): 512b == 8 * 64b
         * (* 3): three coordinates
         */
        for (j = 0; j < 4; j++) {
            /**
             * [Ti-1B-addYXi Ti-2B-addYXi ... Ti-8B-addYXi]
             * [Ti8-1B-addYXi Ti8-2B-addYXi ... Ti8-8B-addYXi]
             * [Ti16-1B-addYXi Ti16-2B-addYXi ... Ti16-8B-addYXi]
             * [Ti24-1B-addYXi Ti24-2B-addYXi ... Ti24-8B-addYXi]
             */
            temp = VLOAD512(
                &multi_base_table[(index + j * 8) * ((32 * 3 * 8) / 8) + i * 8 * 3 + 0]);
            /**
             * [0 Ti-1B-addYXi 0 0 0 0 0 0]
             * [0 0 Ti8-2B-addYXi Ti8-3B-addYXi 0 0 0 0]
             * [0 0 0 0 Ti16-4B-addYXi Ti16-5B-addYXi 0 0]
             * [0 0 0 0 0 0 Ti24-6B-addYXi Ti24-7B-addYXi]
             */
            temp = VMZPERMV(v_mask_tis[j], v_index, temp);
            temp = VMXOR(temp, ~(v_mask_tis[j] | v_mask_scalar_zero[j]), temp,
                         VSET1(one[i]));
            addYX[i] = VXOR(addYX[i], temp);

            temp = VLOAD512(
                &multi_base_table[(index + j * 8) * ((32 * 3 * 8) / 8) + i * 8 * 3 + 8]);
            temp = VMZPERMV(v_mask_tis[j], v_index, temp);
            temp = VMXOR(temp, ~(v_mask_tis[j] | v_mask_scalar_zero[j]), temp,
                         VSET1(one[i]));
            subYX[i] = VXOR(subYX[i], temp);

            temp = VLOAD512(
                &multi_base_table[(index + j * 8) * ((32 * 3 * 8) / 8) + i * 8 * 3 + 16]);
            temp = VMZPERMV(v_mask_tis[j], v_index, temp);
            temp = VMXOR(temp, ~(v_mask_tis[j] | v_mask_scalar_zero[j]), temp, zero);
            _2dYX[i] = VXOR(_2dYX[i], temp);
        }
    }
    /**
     * Point Sign Verification
     * if secret_sign == -1
     *    addYX <- subYX
     *    subYX <- addYX
     *    2dYX  <- -2dYX
     * otherwise
     *    they remain unchanged
     */
    for (i = 0; i < 4; i++) {
        temp = VAND(VXOR(addYX[i], subYX[i]), v_sign);
        addYX[i] = VXOR(addYX[i], temp);
        subYX[i] = VXOR(subYX[i], temp);
    }
    conv_coor2mpi51_8x1w(P->_2dYX, _2dYX);
    neg_fp255_8x1w(P->subYX, P->_2dYX);
    cswap_fp255_8x1w(P->_2dYX, P->subYX, VSHR(v_sign, 63));

    conv_coor2mpi51_8x1w(P->addYX, addYX);
    conv_coor2mpi51_8x1w(P->subYX, subYX);
}

/**
 * Q = [Q0 Q1 Q2 Q3 Q4 Q5 Q6 Q7]
 * R = [Q1 Q0 Q3 Q2 Q5 Q4 Q7 Q6]
 * 0xB1 = 1011 0001
 */
void perm_point_01234567_to_10325476(PointXYTZ_8x1w *R, const PointXYTZ_8x1w *Q)
{
    int i;
    for (i = 0; i < NWORDS_8x1; i++) {
        R->X[i] = VPERM(Q->X[i], 0xB1);
        R->Y[i] = VPERM(Q->Y[i], 0xB1);
        R->T[i] = VPERM(Q->T[i], 0xB1);
        R->Z[i] = VPERM(Q->Z[i], 0xB1);
    }
}

/**
 * Q = [Q0 Q1 Q2 Q3 Q4 Q5 Q6 Q7]
 * R = [Q4 Q5 Q6 Q7 Q0 Q1 Q2 Q3]
 */
void perm_point_01234567_to_45670123(PointXYTZ_8x1w *R, const PointXYTZ_8x1w *Q)
{
    int i;
    ALIGN64 const __m512i idx_45670123 = {4ULL, 5ULL, 6ULL, 7ULL, 0ULL, 1ULL, 2ULL, 3ULL};
    for (i = 0; i < NWORDS_8x1; i++) {
        R->X[i] = VPERMV(idx_45670123, Q->X[i]);
        R->Y[i] = VPERMV(idx_45670123, Q->Y[i]);
        R->T[i] = VPERMV(idx_45670123, Q->T[i]);
        R->Z[i] = VPERMV(idx_45670123, Q->Z[i]);
    }
}

/**
 * Q = [Q0 Q1 Q2 Q3 Q4 Q5 Q6 Q7]
 * Q->X =
 * [Q0X0 Q1X0 Q2X0 Q3X0 Q4X0 Q5X0 Q6X0 Q7X0]
 * ...
 * [Q0X4 Q1X4 Q2X4 Q3X4 Q4X4 Q5X4 Q6X4 Q7X4]
 *
 * R = [Q1 Q3] =
 * [Q1X0 Q1Y0 Q1T0 Q1Z0 Q3X0 Q3Y0 Q3T0 Q3Z0]
 * [Q1X1 Q1Y1 Q1T1 Q1Z1 Q3X1 Q3Y1 Q3T1 Q3Z1]
 * ...
 * [Q1X4 Q1Y4 Q1T4 Q1Z4 Q3X4 Q3Y4 Q3T4 Q3Z4]
 */
void convert_8x1w_to_2x4w(PointXYTZ_2x4w *R, const PointXYTZ_8x1w *Q)
{
    int i;
    /** get Q1Xi and Q3Xi from Q->X */
    ALIGN64 const __m512i idx_10003000 = {1ULL, 0ULL, 0ULL, 0ULL, 3ULL, 0ULL, 0ULL, 0ULL};
    /** get Q1Yi and Q3Yi from Q->Y */
    ALIGN64 const __m512i idx_01000300 = {0ULL, 1ULL, 0ULL, 0ULL, 0ULL, 3ULL, 0ULL, 0ULL};
    /** get Q1Ti and Q3Ti from Q->T */
    ALIGN64 const __m512i idx_00100030 = {0ULL, 0ULL, 1ULL, 0ULL, 0ULL, 0ULL, 3ULL, 0ULL};
    /** get Q1Zi and Q3Zi from Q->Z */
    ALIGN64 const __m512i idx_00010003 = {0ULL, 0ULL, 0ULL, 1ULL, 0ULL, 0ULL, 0ULL, 3ULL};

    for (i = 0; i < NWORDS_8x1; i++) {
        /**
         * 0x11 = 0001 0001
         * XYTZ[i] = [Q1Xi 0 0 0 Q3Xi 0 0 0]
         */
        R->XYTZ[i] = VMZPERMV(0x11, idx_10003000, Q->X[i]);
        /**
         * 0x22 = 0010 0010
         * XYTZ[i] = [Q1Xi Q1Yi 0 0 Q3Xi Q1Yi 0 0]
         */
        R->XYTZ[i] = VMPERMV(R->XYTZ[i], 0x22, idx_01000300, Q->Y[i]);
        /**
         * 0x44 = 0100 0100
         * XYTZ[i] = [Q1Xi Q1Yi Q1Ti 0 Q3Xi Q1Yi Q1Ti 0]
         */
        R->XYTZ[i] = VMPERMV(R->XYTZ[i], 0x44, idx_00100030, Q->T[i]);
        /**
         * 0x88 = 1000 1000
         * XYTZ[i] = [Q1Xi Q1Yi Q1Ti Q1Zi Q3Xi Q1Yi Q1Ti Q1Zi]
         */
        R->XYTZ[i] = VMPERMV(R->XYTZ[i], 0x88, idx_00010003, Q->Z[i]);
    }
}

/**
 * PQ = [P Q]
 *    = [xp0 yp0 tp0 zp0 xq0 yq0 tq0 zq0]
 *      ...
 *      [xp4 yp4 tp4 zp4 xq4 yq4 tq4 zq4]
 * QP = [Q P]
 *    = [xq0 yq0 tq0 zq0 xp0 yp0 tp0 zp0]
 *      ...
 *    = [xq4 yq4 tq4 zq4 xp4 yp4 tp4 zp4]
 */
void perm_PQ_to_QP(PointXYTZ_2x4w *QP, const PointXYTZ_2x4w *PQ)
{
    int i;
    ALIGN64 const __m512i idx_45670123 = {4ULL, 5ULL, 6ULL, 7ULL, 0ULL, 1ULL, 2ULL, 3ULL};
    for (i = 0; i < NWORDS_8x1; i++) {
        QP->XYTZ[i] = VPERMV(idx_45670123, PQ->XYTZ[i]);
    }
}

/**
 * Q = [Q0 Q1 Q2 Q3 Q4 Q5 Q6 Q7]
 * The result should be (Q0 + Q2 + Q4 + Q6) + (Q1 + Q3 + Q5 + Q7) * (2^4).
 * t0 = Q * (2^4) = [16Q0 16Q1 16Q2 16Q3 16Q4 16Q5 16Q6 16Q7] (8x1-way point doubling)
 * t1 = PERM(Q) = [Q1 Q0 Q3 Q2 Q5 Q4 Q7 Q6]
 * t0 = t0 + t1 = [? Q0+16Q1 ? Q2+16Q3 ? Q4+16Q5 ? Q6+16Q7] (8x1-way point addition)
 * t1 = PERM(t0) = [? Q4+16Q5 ? Q6+16Q7 ? ? ? ?]
 * Convert t0 and t1 into another format for using 2x4-way point addition.
 * t2 = [Q0+16Q1 Q2+16Q3]
 * t3 = [Q4+16Q5 Q6+16Q7]
 * t2 = t2 + t3 = [Q0+16Q1+Q4+16Q5 Q2+16Q3+Q6+16Q7] (2x4-way point addition)
 * t3 = PERM(t2) = [Q2+16Q3+Q6+16Q7 ?]
 * t2 = t2 + t3 = [Q0+16Q1+Q4+16Q5+Q2+16Q3+Q6+16Q7 ?] (2x4-way point addition)
 * Finally, R = [Q0+16Q1+Q4+16Q5+Q2+16Q3+Q6+16Q7 ?]
 */
void merge_points(PointXYTZ_2x4w *R, const PointXYTZ_8x1w *Q)
{
    PointXYTZ_8x1w t0, t1;
    PointXYTZ_2x4w *t2 = R, t3;

    /**
     * t0 = 16Q
     *    = [16Q0 16Q1 16Q2 16Q3 16Q4 16Q5 16Q6 16Q7]
     */
    _8x1w_dbl_no_T(&t0, Q);
    _8x1w_dbl_no_T(&t0, &t0);
    _8x1w_dbl_no_T(&t0, &t0);
    _8x1w_dbl(&t0, &t0);
    /** t1 = [Q1 Q0 Q3 Q2 Q5 Q4 Q7 Q6] */
    perm_point_01234567_to_10325476(&t1, Q);
    /** t0 = t0 + t1 = [? Q0+16Q1 ? Q2+16Q3 ? Q4+16Q5 ? Q6+16Q7] */
    _8x1w_fulladd(&t0, &t0, &t1);
    /** [Q0+16Q1 Q2+16Q3] */
    convert_8x1w_to_2x4w(t2, &t0);
    /** t1 = [? Q4+16Q5 ? Q6+16Q7 ? ? ? ?] */
    perm_point_01234567_to_45670123(&t1, &t0);
    /** [Q4+16Q5 Q6+16Q7] */
    convert_8x1w_to_2x4w(&t3, &t1);
    /** t2 = t2 + t3 = [Q0+16Q1+Q4+16Q5 Q2+16Q3+Q6+16Q7] */
    _2x4w_fulladd(t2, &t3);
    /** t3 = [Q2+16Q3+Q6+16Q7 ?] */
    perm_PQ_to_QP(&t3, t2);
    /** t2 = t2 + t3 = [Q0+16Q1+Q4+16Q5+Q2+16Q3+Q6+16Q7 ?] */
    _2x4w_fulladd(t2, &t3);
}

/**
 * The scalar r is encoded as 64 4-bit signed integer values, i.e., r0, r1, ..., r63.
 * Q0 = (16^0  r0  + 16^2 r2   + ... + 16^14 r14) * B
 * Q1 = (16^0  r1  + 16^2 r3   + ... + 16^14 r15) * B
 * Q2 = (16^16 r16 + 16^18 r18 + ... + 16^30 r30) * B
 * Q3 = (16^16 r17 + 16^18 r19 + ... + 16^30 r31) * B
 * Q4 = (16^32 r32 + 16^34 r34 + ... + 16^46 r46) * B
 * Q5 = (16^32 r33 + 16^34 r35 + ... + 16^46 r47) * B
 * Q6 = (16^48 r48 + 16^50 r50 + ... + 16^62 r62) * B
 * Q7 = (16^48 r49 + 16^50 r51 + ... + 16^62 r63) * B
 * The calculation of Q0 to Q7 can be done using a (8x1)-way point addition.
 * The quantity ri * B is fetched from a pre-computed table.
 * Finally, we have to merge them to get the final result of scalar multiplication.
 * The result is (Q0 + Q2 + Q4 + Q6) + (Q1 + Q3 + Q5 + Q7) * (2^4)
 *
 * r is the input scalar.
 * R is the result. The type of R is PointXYTZ_2x4w; therefore, it contain two points,
 * i.e., [R1 R2]. The point R1 is the real result of scalar multiplication; R2 can be
 * ignored.
 */
void point_multiplication_1x8w_ed25519(PointXYTZ_2x4w *R, const uint8_t *r)
{
    ALIGN64 uint64_t K[64 + 3];
    ALIGN64 uint64_t S[64 + 3];
    ALIGN64 const __m512i one_half[NWORDS_8x1] = {
        VSET1(0x7fffffffffff7), VSET1(0x7ffffffffffff), VSET1(0x7ffffffffffff),
        VSET1(0x7ffffffffffff), VSET1(0x3ffffffffffff)};
    PointXYTZ_8x1w Q;
    PointXYTZ_pc_8x1w P;
    int i;

    recoding_signed_scalar_1x8w_ed25519(S, K, r);

    query_table_1x8w_ed25519(&P, S, K, 0);
    /** QX = 2X */
    sbc_fp255_8x1w(Q.X, P.addYX, P.subYX);
    /** QY = 2Y */
    adc_fp255_8x1w(Q.Y, P.addYX, P.subYX);
    /** QT = (QX * QY) / Z = 2XY */
    mul_fp255_8x1w(Q.T, Q.X, Q.Y);
    mul_fp255_8x1w(Q.T, Q.T, one_half);
    /** QZ = 2 */
    Q.Z[1] = Q.Z[2] = Q.Z[3] = Q.Z[4] = VZERO;
    Q.Z[0] = VSET1(2);

    for (i = 1; i < 8; i++) {
        query_table_1x8w_ed25519(&P, S + 8 * i, K + 8 * i, i);
        _8x1w_mixadd(&Q, &Q, &P);
    }
    merge_points(R, &Q);
    final_modp_fp255_8x1w(R->XYTZ);
}

/**
 * The point encoding function for the point resulted by
 * point_multiplication_1x8w_ed25519.
 *
 * The input point P is generated by point_multiplication_1x8w_ed25519.
 * P = [R ?] =
 * [Rx0 Ry0 Rt0 Rz0 ? ? ? ?]
 * [Rx1 Ry1 Rt1 Rz1 ? ? ? ?]
 * [Rx2 Ry2 Rt2 Rz2 ? ? ? ?]
 * [Rx3 Ry3 Rt3 Rz3 ? ? ? ?]
 * [Rx4 Ry4 Rt4 Rz4 ? ? ? ?]
 * We only care about the point R.
 */
void point_encoding_1x8w_ed25519(uint8_t *encP, const PointXYTZ_2x4w *P)
{
    int i;
    ALIGN64 uint64_t buff[8];
    uint64_t X_51b[NWORDS_8x1], Y_51b[NWORDS_8x1], Z_51b[NWORDS_8x1];
    uint64_t X_64b[4], Y_64b[4], Z_64b[4], inv_Z_64b[4];
    uint8_t encX[32];

    for (i = 0; i < NWORDS_8x1; i++) {
        VSTORE(buff, P->XYTZ[i]);
        X_51b[i] = buff[0];
        Y_51b[i] = buff[1];
        Z_51b[i] = buff[3];
    }

    conv_51to64(X_64b, 4, X_51b, NWORDS_8x1);
    conv_51to64(Y_64b, 4, Y_51b, NWORDS_8x1);
    conv_51to64(Z_64b, 4, Z_51b, NWORDS_8x1);

    fe64_invert(inv_Z_64b, Z_64b);
    fe64_mul(X_64b, X_64b, inv_Z_64b);
    fe64_mul(Y_64b, Y_64b, inv_Z_64b);

    fe64_tobytes(encX, X_64b);
    fe64_tobytes(encP, Y_64b);

    encP[32 - 1] = (encP[32 - 1] & 0x7F) | ((encX[0] & 0x1) << 7);
}

const uint64_t param_curve_d[4] = {0x75eb4dca135978a3, 0x00700a4d4141d8ab,
                                   0x8cc740797779e898, 0x52036cee2b6ffe73};
const uint64_t one[4] = {1, 0, 0, 0};

__attribute__((noinline)) static void convert_64_to_51(
    uint64_t XYTZXYTZ_51b[NWORDS_8x1][8], int i, uint64_t *SRC)
{
    XYTZXYTZ_51b[0][i] = XYTZXYTZ_51b[0][i + 4] = (SRC[0] & MASK51b);
    XYTZXYTZ_51b[1][i] = XYTZXYTZ_51b[1][i + 4] =
        ((SRC[1] << 13) | (SRC[0] >> 51)) & MASK51b;
    XYTZXYTZ_51b[2][i] = XYTZXYTZ_51b[2][i + 4] =
        ((SRC[2] << 26) | (SRC[1] >> 38)) & MASK51b;
    XYTZXYTZ_51b[3][i] = XYTZXYTZ_51b[3][i + 4] =
        ((SRC[3] << 39) | (SRC[2] >> 25)) & MASK51b;
    XYTZXYTZ_51b[4][i] = XYTZXYTZ_51b[4][i + 4] = (SRC[3] >> 12);
}

void point_decoding_2x4w_ed25519(PointXYTZ_2x4w *AA, const uint8_t *A)
{
    uint64_t X[4];
    uint64_t Y[4];
    uint64_t T[4];
    uint64_t u[4];
    uint64_t v[4];
    ALIGN64 uint64_t XYTZXYTZ_51b[NWORDS_8x1][8] = {0};
    uint8_t bit_X;

    bit_X = A[31] >> 7;

    fe64_copy(u, (uint64_t *)A);
    u[3] &= ((uint64_t)1 << 63) - 1;
    fe64_copy(Y, u);
    /*  u = y^2    */
    fe64_sqr(u, u);
    /*  v = dy^2   */
    fe64_mul(v, u, (uint64_t *)param_curve_d);
    /*  u =  y^2-1 */
    fe64_sub(u, u, (uint64_t *)one);
    /*  v = dy^2+1 */
    fe64_add(v, v, (uint64_t *)one);
    /*  X = sqrt(u/v) */
    invsqrt_fp255_1w_fullradix(X, u, v);
    /*  Checking whether
     *  X is positive or negative
     */
    fe64_tobytes((uint8_t *)X, X);
    if (bit_X == (X[0] & 0x1)) {
        neg_fp255_1w_fullradix(X);
    }
    /* Point represented in extended coordinates */
    fe64_mul(T, X, Y);

    /**
     * Convert 2^{64}-radix to 2^{51}-radix.
     * Then construct AVX512 vectors representation.
     */
    convert_64_to_51(XYTZXYTZ_51b, 0, X);
    convert_64_to_51(XYTZXYTZ_51b, 1, Y);
    convert_64_to_51(XYTZXYTZ_51b, 2, T);

    XYTZXYTZ_51b[0][3] = XYTZXYTZ_51b[0][7] = 1;

    AA->XYTZ[0] = VLOAD512(XYTZXYTZ_51b[0]);
    AA->XYTZ[1] = VLOAD512(XYTZXYTZ_51b[1]);
    AA->XYTZ[2] = VLOAD512(XYTZXYTZ_51b[2]);
    AA->XYTZ[3] = VLOAD512(XYTZXYTZ_51b[3]);
    AA->XYTZ[4] = VLOAD512(XYTZXYTZ_51b[4]);
}

/**
 * get PJ_pc according to PJ.
 * N = [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
 * M = [yp0 xp0 zp0 tp0 yj0 xj0 zj0 tj0]
 * M += 2p using mask = [yp0+2p0 xp0 tp0 zp0 yj0+2p0 xj0 tj0 zj0]
 * M -= N using mask = [yp0+2p0-xp0 xp0 tp0 zp0 yj0+2p0-xj0 xj0 tj0 zj0]
 * M += N using mask = [yp0+2p0-xp0 yp0+xp0 tp0 zp0 yj0+2p0-xj0 yj0+xj0 tj0 zj0]
 * propagate carry
 * get [yp0-xp0 yp0+xp0 2dtp0 2zp0 yj0-xj0 yj0+xj0 2dtj0 2zj0]
 */
void XYTZ_to_XYTZ_pc_2x4w(PointXYTZ_pc_2x4w *PJ_pc, const PointXYTZ_2x4w *PJ)
{
    int i;
    __m512i M;
    /** lowest 51b of 2p */
    const __m512i _2p_low_51b = VSET1(LOW51b * 2);
    /** other 51b of 2p */
    const __m512i _2p_oth_51b = VSET1(MASK51b * 2);
    /** [1 1 2d 2 1 1 2d 2] */
    const __m512i _2d_2x4w[NWORDS_8x1] = {
        VSET(2, 0x69b9426b2f159, 1, 1, 2, 0x69b9426b2f159, 1, 1),
        VSET(0, 0x35050762add7a, 0, 0, 0, 0x35050762add7a, 0, 0),
        VSET(0, 0x3cf44c0038052, 0, 0, 0, 0x3cf44c0038052, 0, 0),
        VSET(0, 0x6738cc7407977, 0, 0, 0, 0x6738cc7407977, 0, 0),
        VSET(0, 0x2406d9dc56dff, 0, 0, 0, 0x2406d9dc56dff, 0, 0)};
    /** M = [yp0 xp0 zp0 tp0 yj0 xj0 zj0 tj0] */
    M = VSHUF32(PJ->XYTZ[0], 0x4E);
    /** [yp0+2p yp0 tp0 zp0 yj0+2p yj0 tj0 zj0] */
    PJ_pc->subYX_addYX_2dT_2Z[0] = VMADD(PJ->XYTZ[0], 0x11, M, _2p_low_51b);
    /** [yp0+2p-xp0 yp0 tp0 zp0 yj0+2p-xp0 yj0 tj0 zj0] */
    PJ_pc->subYX_addYX_2dT_2Z[0] = VMSUB(PJ_pc->subYX_addYX_2dT_2Z[0], 0x11,
                                         PJ_pc->subYX_addYX_2dT_2Z[0], PJ->XYTZ[0]);
    /** [yp0+2p-xp0 xp0+yp0 tp0 zp0 yj0+2p-xp0 xj0+yj0 tj0 zj0] */
    PJ_pc->subYX_addYX_2dT_2Z[0] =
        VMADD(PJ_pc->subYX_addYX_2dT_2Z[0], 0x22, PJ_pc->subYX_addYX_2dT_2Z[0], M);
    for (i = 1; i < NWORDS_8x1; i++) {
        M = VSHUF32(PJ->XYTZ[i], 0x4E);
        PJ_pc->subYX_addYX_2dT_2Z[i] = VMADD(PJ->XYTZ[i], 0x11, M, _2p_oth_51b);
        PJ_pc->subYX_addYX_2dT_2Z[i] = VMSUB(PJ_pc->subYX_addYX_2dT_2Z[i], 0x11,
                                             PJ_pc->subYX_addYX_2dT_2Z[i], PJ->XYTZ[i]);
        PJ_pc->subYX_addYX_2dT_2Z[i] =
            VMADD(PJ_pc->subYX_addYX_2dT_2Z[i], 0x22, PJ_pc->subYX_addYX_2dT_2Z[i], M);
    }
    carry_fp255_8x1w(PJ_pc->subYX_addYX_2dT_2Z);
    /** get [yp0-xp0 yp0+xp0 2dtp0 2zp0 yj0-xj0 yj0+xj0 2dtj0 2zj0] */
    mul_fp255_8x1w(PJ_pc->subYX_addYX_2dT_2Z, PJ_pc->subYX_addYX_2dT_2Z, _2d_2x4w);
}

__attribute__((noinline)) static void copy_Point_pc_2x4w(PointXYTZ_pc_2x4w *dst,
                                                         PointXYTZ_pc_2x4w *src)
{
    dst->subYX_addYX_2dT_2Z[0] = src->subYX_addYX_2dT_2Z[0];
    dst->subYX_addYX_2dT_2Z[1] = src->subYX_addYX_2dT_2Z[1];
    dst->subYX_addYX_2dT_2Z[2] = src->subYX_addYX_2dT_2Z[2];
    dst->subYX_addYX_2dT_2Z[3] = src->subYX_addYX_2dT_2Z[3];
    dst->subYX_addYX_2dT_2Z[4] = src->subYX_addYX_2dT_2Z[4];
}

__attribute__((noinline)) static void perm_45670123_pc_2x4w(PointXYTZ_pc_2x4w *dst,
                                                            PointXYTZ_pc_2x4w *src)
{
    ALIGN64 const __m512i idx_45670123 = {4ULL, 5ULL, 6ULL, 7ULL, 0ULL, 1ULL, 2ULL, 3ULL};
    dst->subYX_addYX_2dT_2Z[0] = VPERMV(idx_45670123, src->subYX_addYX_2dT_2Z[0]);
    dst->subYX_addYX_2dT_2Z[1] = VPERMV(idx_45670123, src->subYX_addYX_2dT_2Z[1]);
    dst->subYX_addYX_2dT_2Z[2] = VPERMV(idx_45670123, src->subYX_addYX_2dT_2Z[2]);
    dst->subYX_addYX_2dT_2Z[3] = VPERMV(idx_45670123, src->subYX_addYX_2dT_2Z[3]);
    dst->subYX_addYX_2dT_2Z[4] = VPERMV(idx_45670123, src->subYX_addYX_2dT_2Z[4]);
}

/**
 * table[0] = (1A,?)
 * table[1] = (2A,?)
 * ...
 * table[15] = (16A,?)
 */
void precompute_points_2x4w_ed25519(PointXYTZ_pc_2x4w *table, const PointXYTZ_2x4w *AA)
{
    int i;
    PointXYTZ_2x4w t0, t1, t2;
    PointXYTZ_pc_2x4w AA_pc, t0_pc, t1_pc, t2_pc;

    XYTZ_to_XYTZ_pc_2x4w(&AA_pc, AA);

    /** table[0] = (1A,1A) */
    copy_Point_pc_2x4w(&table[0], &AA_pc);
    /** (2A,2A) = (1A,1A) * 2 */
    _2x4w_doubling(&t0, AA);
    XYTZ_to_XYTZ_pc_2x4w(&t0_pc, &t0);
    /** table[1] = (2A,2A) */
    copy_Point_pc_2x4w(&table[1], &t0_pc);

    /** (3A,3A) = (2A,2A) + (1A,1A) */
    _2x4w_mixadd(&t1, &t0, &AA_pc);
    XYTZ_to_XYTZ_pc_2x4w(&t1_pc, &t1);
    /** table[2] = (3A,3A) */
    copy_Point_pc_2x4w(&table[2], &t1_pc);

    /**
     * get (2A,3A)
     * t0.XYTZ[0] = [2A.x0 2A.y0 2A.t0 2A.z0 2A.x0 2A.y0 2A.t0 2A.z0]
     * t1.XYTZ[0] = [3A.x0 3A.y0 3A.t0 3A.z0 3A.x0 3A.y0 3A.t0 3A.z0]
     * VMBLEND(0xF0, t0.XYTZ[0], t1.XYTZ[0]) =
     * [2A.x0 2A.y0 2A.t0 2A.z0 3A.x0 3A.y0 3A.t0 3A.z0]
     */
    for (i = 0; i < NWORDS_8x1; i++) {
        t0.XYTZ[i] = VMBLEND(0xF0, t0.XYTZ[i], t1.XYTZ[i]);
    }

    /** (4A,6A) = (2A,3A) * 2 */
    _2x4w_doubling(&t1, &t0);
    XYTZ_to_XYTZ_pc_2x4w(&t1_pc, &t1);
    /** table[3] = (4A,?) */
    copy_Point_pc_2x4w(&table[3], &t1_pc);
    perm_45670123_pc_2x4w(&table[5], &t1_pc);

    /** (5A,7A) = (4A,6A) + (1A,1A) */
    _2x4w_mixadd(&t0, &t1, &AA_pc);
    XYTZ_to_XYTZ_pc_2x4w(&t0_pc, &t0);
    copy_Point_pc_2x4w(&table[4], &t0_pc);
    perm_45670123_pc_2x4w(&table[6], &t0_pc);

    /** (8A,12A) = (4A,6A) * 2 */
    _2x4w_doubling(&t1, &t1);
    XYTZ_to_XYTZ_pc_2x4w(&t1_pc, &t1);
    copy_Point_pc_2x4w(&table[7], &t1_pc);
    perm_45670123_pc_2x4w(&table[11], &t1_pc);

    /** (16A,?) = (8A,?) * 2 */
    _2x4w_doubling(&t2, &t1);
    XYTZ_to_XYTZ_pc_2x4w(&t2_pc, &t2);
    copy_Point_pc_2x4w(&table[15], &t2_pc);

    /** (9A,13A) = (8A,12A) + (1A,1A) */
    _2x4w_mixadd(&t1, &t1, &AA_pc);
    XYTZ_to_XYTZ_pc_2x4w(&t1_pc, &t1);
    copy_Point_pc_2x4w(&table[8], &t1_pc);
    perm_45670123_pc_2x4w(&table[12], &t1_pc);

    /** (10A,14A) = (5A,7A) * 2 */
    _2x4w_doubling(&t0, &t0);
    XYTZ_to_XYTZ_pc_2x4w(&t0_pc, &t0);
    copy_Point_pc_2x4w(&table[9], &t0_pc);
    perm_45670123_pc_2x4w(&table[13], &t0_pc);

    /** (11A,15A) = (10A,14A) + (1A,1A) */
    _2x4w_mixadd(&t0, &t0, &AA_pc);
    XYTZ_to_XYTZ_pc_2x4w(&t0_pc, &t0);
    copy_Point_pc_2x4w(&table[10], &t0_pc);
    perm_45670123_pc_2x4w(&table[14], &t0_pc);
}

/**
 * P1_P2 = ((-1)^s_S*s_K*A (-1)^r_S*r_K*B)
 * This routine appeared in Ed25519-verify; no need constant-time implementation.
 */
void read_point_A_B(PointXYTZ_pc_2x4w *P1_P2, PointXYTZ_pc_2x4w *tableA, uint64_t s_S,
                    uint64_t s_K, uint64_t r_S, uint64_t r_K)
{
    int i;
    PointXYTZ_pc_2x4w t0, t1;
    /**
     * tableA[i] = ((i+1)A, ?)
     * multi_base_table_small[i] = ((i+1)B, (i+1)B)
     */
    if (s_K == 0) {
        P1_P2->subYX_addYX_2dT_2Z[0] = VSET(2, 0, 1, 1, 2, 0, 1, 1);
        P1_P2->subYX_addYX_2dT_2Z[1] = P1_P2->subYX_addYX_2dT_2Z[2] =
            P1_P2->subYX_addYX_2dT_2Z[3] = P1_P2->subYX_addYX_2dT_2Z[4] = VZERO;
    } else {
        copy_Point_pc_2x4w(P1_P2, &tableA[s_K - 1]);
        /**
         * Point sign verification for tableA[s_K-1]
         * if sign == -1
         *   mask_perm = 0x33 = 0011 0011
         *   0xE1 = 1110 0001
         *   swap subYX and addYX
         *   mask_blend = 0x44 = 0100 0100
         *   2dT <- -2dT
         * otherwise
         *   they remain unchanged
         */
        neg_fp255_8x1w(t0.subYX_addYX_2dT_2Z, P1_P2->subYX_addYX_2dT_2Z);
        __mmask8 mask_perm = s_S & 0x33;
        __mmask8 mask_blend = s_S & 0x44;
        for (i = 0; i < NWORDS_8x1; i++) {
            P1_P2->subYX_addYX_2dT_2Z[i] = VMPERM(P1_P2->subYX_addYX_2dT_2Z[i], mask_perm,
                                                  P1_P2->subYX_addYX_2dT_2Z[i], 0xE1);
            P1_P2->subYX_addYX_2dT_2Z[i] = VMBLEND(
                mask_blend, P1_P2->subYX_addYX_2dT_2Z[i], t0.subYX_addYX_2dT_2Z[i]);
        }
    }

    if (r_K == 0) {
        t0.subYX_addYX_2dT_2Z[0] = VSET(2, 0, 1, 1, 2, 0, 1, 1);
        t0.subYX_addYX_2dT_2Z[1] = t0.subYX_addYX_2dT_2Z[2] = t0.subYX_addYX_2dT_2Z[3] =
            t0.subYX_addYX_2dT_2Z[4] = VZERO;
    } else {
        /** Point sign verification for multi_base_table_small[r_K-1] */
        t0 = multi_base_table_small[r_K - 1];
        neg_fp255_8x1w(t1.subYX_addYX_2dT_2Z, t0.subYX_addYX_2dT_2Z);
        __mmask8 mask_perm = r_S & 0x33;
        __mmask8 mask_blend = r_S & 0x44;
        for (i = 0; i < NWORDS_8x1; i++) {
            t0.subYX_addYX_2dT_2Z[i] = VMPERM(t0.subYX_addYX_2dT_2Z[i], mask_perm,
                                              t0.subYX_addYX_2dT_2Z[i], 0xE1);
            t0.subYX_addYX_2dT_2Z[i] =
                VMBLEND(mask_blend, t0.subYX_addYX_2dT_2Z[i], t1.subYX_addYX_2dT_2Z[i]);
        }
    }
    /**
     * Now, P1_P2 = ((-1)^s_S*s_K*A ?) and t0 = ((-1)^r_S*r_K*B (-1)^r_S*r_K*B).
     * We want P1_P2 = ((-1)^s_S*s_K*A (-1)^r_S*r_K*B).
     * 0xF0 = 1111 0000
     */
    for (i = 0; i < NWORDS_8x1; i++) {
        P1_P2->subYX_addYX_2dT_2Z[i] =
            VMBLEND(0xF0, P1_P2->subYX_addYX_2dT_2Z[i], t0.subYX_addYX_2dT_2Z[i]);
    }
}

/**
 * Double point multiplication using 2x4-way point addition/doubling.
 * sA_rB = s*A + r*B, where r and s are scalars; B is the fixed point and A is an unfixed
 * point.
 *
 * Algorithm design:
 * 1) Pre-computing.
 * Get (1,2,3,...,2^{w-1})A.
 * For w = 5, the computing sequence is as follows:
 * (2A,2A) = (1A,1A) * 2        // using 2x4-way point doubling
 * (3A,3A) = (2A,2A) + (1A,1A)  // using 2x4-way point addition
 * (4A,6A) = (2A,3A) * 2
 * (5A,7A) = (4A,6A) + (1A,1A)
 * (8A,12A) = (4A,6A) * 2
 * (9A,13A) = (8A,12A) + (1A,1A)
 * (10A,14A) = (5A,7A) * 2
 * (11A,15A) = (10A,14A) + (1A,1A)
 * (16A,?) = (8A,?) * 2
 * The cost is 5 2x4-way point doubling (PD) and 4 2x4-way point addition (PA).
 * Using parameter w, the cost is (2^{w-3} + 1) PD and 2^{w-3} PA.
 * The pre-computing of (1,2,3,...,2^{w-1})B can be done offline.
 *
 * 2) Main loop.
 * d = ceil(l/w), where l is the bit length of scalars and w is the bit length of
 * scalar-nibble. Two scalars r and s are recoded as (r_0,r_1,...,r_{d-1}) and
 * (s_0,s_1,...,s_{d-1}) respectively; ri and si \in [-2^{w-1}, 2^{w-1}).
 *
 * (R1,R2) = (0,0)
 * P1 = read_point_A(s_{d-1})
 * P2 = read_point_B(r_{d-1})
 * (R1,R2) += (P1,P2)
 * for i=d-2 downto 0
 *   (R1,R2) = (2^w*R1,2^w*R2)  // using 2x4-way PD
 *   P1 = read_point_A(si)
 *   P2 = read_point_B(ri)
 *   (R1,R2) += (P1,P2)         // using 2x4-way PA
 * R = R1+R2                    // for merging
 * return R
 * The cost of the main loop is w(d-1)PD + dPA + 1PA(for merging)
 *
 * 3) Overall cost for l = 253.
 * (2^{w-3} + 1 + w(d-1))PD + (2^{w-3} + d + 1)PA
 * w/Cost   PD      PA      PA (PD = 0.97PA)
 * w = 3    254     87      334
 * w = 4    255     67      315
 * w = 5    255     56      304
 * w = 6    261     52      306
 * w = 7    269     54      315
 * For our implementation, PA (_2x4w_mixadd) = 181cc, PD (_2x4w_doubling) = 176cc =
 * 0.97PA. Finally, we choose w = 5 for the best performance.
 */
void double_point_mult_2x4w_ed25519(uint8_t *sA_rB, const uint8_t *s,
                                    const PointXYTZ_2x4w *AA, const uint8_t *r)
{
    int i;
    PointXYTZ_2x4w R1_R2, t0;
    PointXYTZ_pc_2x4w P1_P2;
    PointXYTZ_pc_2x4w tableA[1 << (5 - 1)];
    uint64_t r_K[51], r_S[51], s_K[51], s_S[51];
    ALIGN64 const __m512i idx_45670123 = {4ULL, 5ULL, 6ULL, 7ULL, 0ULL, 1ULL, 2ULL, 3ULL};

    /** 1) Pre-computing */
    precompute_points_2x4w_ed25519(tableA, AA);

    /** recoding two scalars */
    recoding_signed_scalar_normal_ed25519(r_S, r_K, r, 0);
    recoding_signed_scalar_normal_ed25519(s_S, s_K, s, 0);

    /** (R1,R2) = (0,0) */
    R1_R2.XYTZ[0] = VSET(1, 0, 1, 0, 1, 0, 1, 0);
    R1_R2.XYTZ[1] = R1_R2.XYTZ[2] = R1_R2.XYTZ[3] = R1_R2.XYTZ[4] = VZERO;
    /** P1_P2 = ((-1)^s_S[50]*s_K[50]*A (-1)^r_S[50]*r_K[50]*B) */
    read_point_A_B(&P1_P2, tableA, s_S[50], s_K[50], r_S[50], r_K[50]);
    /** R1_R2 += P1_P2 */
    _2x4w_mixadd(&R1_R2, &R1_R2, &P1_P2);
    for (i = 49; i >= 0; i--) {
        _2x4w_doubling(&R1_R2, &R1_R2);
        _2x4w_doubling(&R1_R2, &R1_R2);
        _2x4w_doubling(&R1_R2, &R1_R2);
        _2x4w_doubling(&R1_R2, &R1_R2);
        _2x4w_doubling(&R1_R2, &R1_R2);
        read_point_A_B(&P1_P2, tableA, s_S[i], s_K[i], r_S[i], r_K[i]);
        _2x4w_mixadd(&R1_R2, &R1_R2, &P1_P2);
    }
    /** t0 = R2_R1 */
    for (i = 0; i < NWORDS_8x1; i++) {
        t0.XYTZ[i] = VPERMV(idx_45670123, R1_R2.XYTZ[i]);
    }
    /** R1_R2 += R2_R1 */
    _2x4w_fulladd(&R1_R2, &t0);
    final_modp_fp255_8x1w(R1_R2.XYTZ);
    point_encoding_1x8w_ed25519(sA_rB, &R1_R2);
}

/**
 * A small pre-computing table for double point scalar multiplication; it contains 16
 * point, i.e., 1B, 2B, ..., 16B.
 * 0th PointXYTZ_pc_2x4w: [1B-subYX 1B-addYX 1B-2dT 1B-2Z 1B-subYX 1B-addYX 1B-2dT 1B-2Z].
 * ...
 * 15th PointXYTZ_pc_2x4w: [16B-subYX 16B-addYX 16B-2dT 16B-2Z 16B-subYX 16B-addYX 16B-2dT
 * 16B-2Z].
 *
 * Why does a PointXYTZ_pc_2x4w contain two identical points? Won't this waste memory?
 * Yes, it does waste (512*5*16)/2/8/1024=2.5KB memory.
 * However, it will be easier to read this table when executing double point mult.
 */
ALIGN64 const PointXYTZ_pc_2x4w multi_base_table_small[16] = {
    {{{0x00003905d740913e, 0x000493c6f58c3b85, 0x00011205877aaa68, 0x0000000000000002,
       0x00003905d740913e, 0x000493c6f58c3b85, 0x00011205877aaa68, 0x0000000000000002},
      {0x0000ba2817d673a2, 0x0000df7181c325f7, 0x000479955893d579, 0x0000000000000000,
       0x0000ba2817d673a2, 0x0000df7181c325f7, 0x000479955893d579, 0x0000000000000000},
      {0x00023e2827f4e67c, 0x0000f50b0b3e4cb7, 0x00050d66309b67a0, 0x0000000000000000,
       0x00023e2827f4e67c, 0x0000f50b0b3e4cb7, 0x00050d66309b67a0, 0x0000000000000000},
      {0x000133d2e0c21a34, 0x0005329385a44c32, 0x0002d42d0dbee5ee, 0x0000000000000000,
       0x000133d2e0c21a34, 0x0005329385a44c32, 0x0002d42d0dbee5ee, 0x0000000000000000},
      {0x00044fd2f9298f81, 0x00007cf9d3a33d4b, 0x0006f117b689f0c6, 0x0000000000000000,
       0x00044fd2f9298f81, 0x00007cf9d3a33d4b, 0x0006f117b689f0c6, 0x0000000000000000}}},
    {{{0x0001a56042b4d5a8, 0x0004e7fc933c71d7, 0x0002a8b3a59b7a5f, 0x0000000000000002,
       0x0001a56042b4d5a8, 0x0004e7fc933c71d7, 0x0002a8b3a59b7a5f, 0x0000000000000002},
      {0x000189cc159ed153, 0x0002cf41feb6b244, 0x0003abb359ef087f, 0x0000000000000000,
       0x000189cc159ed153, 0x0002cf41feb6b244, 0x0003abb359ef087f, 0x0000000000000000},
      {0x0005b8deaa3cae04, 0x0007581c0a7d1a76, 0x0004f5a8c4db05af, 0x0000000000000000,
       0x0005b8deaa3cae04, 0x0007581c0a7d1a76, 0x0004f5a8c4db05af, 0x0000000000000000},
      {0x0002aaf04f11b5d8, 0x0007172d534d32f0, 0x0005b9a807d04205, 0x0000000000000000,
       0x0002aaf04f11b5d8, 0x0007172d534d32f0, 0x0005b9a807d04205, 0x0000000000000000},
      {0x0006bb595a669c92, 0x000590c063fa87d2, 0x000701af5b13ea50, 0x0000000000000000,
       0x0006bb595a669c92, 0x000590c063fa87d2, 0x000701af5b13ea50, 0x0000000000000000}}},
    {{{0x00011fe8a4fcd265, 0x0005b0a84cee9730, 0x0006933f0dd0d889, 0x0000000000000002,
       0x00011fe8a4fcd265, 0x0005b0a84cee9730, 0x0006933f0dd0d889, 0x0000000000000002},
      {0x0007bcb8374faacc, 0x00061d10c97155e4, 0x00044386bb4c4295, 0x0000000000000000,
       0x0007bcb8374faacc, 0x00061d10c97155e4, 0x00044386bb4c4295, 0x0000000000000000},
      {0x00052f5af4ef4d4f, 0x0004059cc8096a10, 0x0003cb6d3162508c, 0x0000000000000000,
       0x00052f5af4ef4d4f, 0x0004059cc8096a10, 0x0003cb6d3162508c, 0x0000000000000000},
      {0x0005314098f98d10, 0x00047a608da8014f, 0x00026368b872a2c6, 0x0000000000000000,
       0x0005314098f98d10, 0x00047a608da8014f, 0x00026368b872a2c6, 0x0000000000000000},
      {0x0002ab91587555bd, 0x0007a164e1b9a80f, 0x0005a2826af12b9b, 0x0000000000000000,
       0x0002ab91587555bd, 0x0007a164e1b9a80f, 0x0005a2826af12b9b, 0x0000000000000000}}},
    {{{0x0006050a056818bf, 0x000351b98efc099f, 0x0003fbe9c476ff09, 0x0000000000000002,
       0x0006050a056818bf, 0x000351b98efc099f, 0x0003fbe9c476ff09, 0x0000000000000002},
      {0x00062acc1f5532bf, 0x00068fbfa4a7050e, 0x0000af6b982e4b42, 0x0000000000000000,
       0x00062acc1f5532bf, 0x00068fbfa4a7050e, 0x0000af6b982e4b42, 0x0000000000000000},
      {0x00028141ccc9fa25, 0x00042a49959d971b, 0x0000ad1251ba78e5, 0x0000000000000000,
       0x00028141ccc9fa25, 0x00042a49959d971b, 0x0000ad1251ba78e5, 0x0000000000000000},
      {0x00024d61f471e683, 0x000393e51a469efd, 0x000715aeedee7c88, 0x0000000000000000,
       0x00024d61f471e683, 0x000393e51a469efd, 0x000715aeedee7c88, 0x0000000000000000},
      {0x00027933f4c7445a, 0x000680e910321e58, 0x0007f9d0cbf63553, 0x0000000000000000,
       0x00027933f4c7445a, 0x000680e910321e58, 0x0007f9d0cbf63553, 0x0000000000000000}}},
    {{{0x000182c3a447d6ba, 0x0002bc4408a5bb33, 0x0003dbf1812a8285, 0x0000000000000002,
       0x000182c3a447d6ba, 0x0002bc4408a5bb33, 0x0003dbf1812a8285, 0x0000000000000002},
      {0x00022964e536eff2, 0x000078ebdda05442, 0x0000fa17ba3f9797, 0x0000000000000000,
       0x00022964e536eff2, 0x000078ebdda05442, 0x0000fa17ba3f9797, 0x0000000000000000},
      {0x000192821f540053, 0x0002ffb112354123, 0x0006f69cb49c3820, 0x0000000000000000,
       0x000192821f540053, 0x0002ffb112354123, 0x0006f69cb49c3820, 0x0000000000000000},
      {0x0002f9f19e788e5c, 0x000375ee8df5862d, 0x00034d5a0db3858d, 0x0000000000000000,
       0x0002f9f19e788e5c, 0x000375ee8df5862d, 0x00034d5a0db3858d, 0x0000000000000000},
      {0x000154a7e73eb1b5, 0x0002945ccf146e20, 0x00043aabe696b3bb, 0x0000000000000000,
       0x000154a7e73eb1b5, 0x0002945ccf146e20, 0x00043aabe696b3bb, 0x0000000000000000}}},
    {{{0x000006b67b7d8ca4, 0x0004eeeb77157131, 0x0004326702ea4b71, 0x0000000000000002,
       0x000006b67b7d8ca4, 0x0004eeeb77157131, 0x0004326702ea4b71, 0x0000000000000002},
      {0x000084fa44e72933, 0x0001201915f10741, 0x00006834376030b5, 0x0000000000000000,
       0x000084fa44e72933, 0x0001201915f10741, 0x00006834376030b5, 0x0000000000000000},
      {0x0001154ee55d6f8a, 0x0001669cda6c9c56, 0x0000ef0512f9c380, 0x0000000000000000,
       0x0001154ee55d6f8a, 0x0001669cda6c9c56, 0x0000ef0512f9c380, 0x0000000000000000},
      {0x0004425d842e7390, 0x00045ec032db346d, 0x0000f1a9f2512584, 0x0000000000000000,
       0x0004425d842e7390, 0x00045ec032db346d, 0x0000f1a9f2512584, 0x0000000000000000},
      {0x00038b64c41ae417, 0x00051e57bb6a2cc3, 0x00010b8e91a9f0d6, 0x0000000000000000,
       0x00038b64c41ae417, 0x00051e57bb6a2cc3, 0x00010b8e91a9f0d6, 0x0000000000000000}}},
    {{{0x00072c9aaa3221b1, 0x00025cd0944ea3bf, 0x00036dc801b8b3a2, 0x0000000000000002,
       0x00072c9aaa3221b1, 0x00025cd0944ea3bf, 0x00036dc801b8b3a2, 0x0000000000000002},
      {0x000267774474f74d, 0x00075673b81a4d63, 0x0000e0a7d4935e30, 0x0000000000000000,
       0x000267774474f74d, 0x00075673b81a4d63, 0x0000e0a7d4935e30, 0x0000000000000000},
      {0x000064b0e9b28085, 0x000150b925d1c0d4, 0x0001deb7cecc0d7d, 0x0000000000000000,
       0x000064b0e9b28085, 0x000150b925d1c0d4, 0x0001deb7cecc0d7d, 0x0000000000000000},
      {0x0003f04ef53b27c9, 0x00013f38d9294114, 0x000053a94e20dd2c, 0x0000000000000000,
       0x0003f04ef53b27c9, 0x00013f38d9294114, 0x000053a94e20dd2c, 0x0000000000000000},
      {0x0001d6edd5d2e531, 0x000461bea69283c9, 0x0007a9fbb1c6a0f9, 0x0000000000000000,
       0x0001d6edd5d2e531, 0x000461bea69283c9, 0x0007a9fbb1c6a0f9, 0x0000000000000000}}},
    {{{0x00075dedf39234d9, 0x0007596604dd3e8f, 0x0001f5d9c9a2911a, 0x0000000000000002,
       0x00075dedf39234d9, 0x0007596604dd3e8f, 0x0001f5d9c9a2911a, 0x0000000000000002},
      {0x00001c36ab1f3c54, 0x0006fc510e058b36, 0x0007117994fafcf8, 0x0000000000000000,
       0x00001c36ab1f3c54, 0x0006fc510e058b36, 0x0007117994fafcf8, 0x0000000000000000},
      {0x0000f08fee58f5da, 0x0003670c8db2cc0d, 0x0002d8a8cae28dc5, 0x0000000000000000,
       0x0000f08fee58f5da, 0x0003670c8db2cc0d, 0x0002d8a8cae28dc5, 0x0000000000000000},
      {0x0000e19613a0d637, 0x000297d899ce332f, 0x00074ab1b2090c87, 0x0000000000000000,
       0x0000e19613a0d637, 0x000297d899ce332f, 0x00074ab1b2090c87, 0x0000000000000000},
      {0x0003a9024a1320e0, 0x0000915e76061bce, 0x00026907c5c2ecc4, 0x0000000000000000,
       0x0003a9024a1320e0, 0x0000915e76061bce, 0x00026907c5c2ecc4, 0x0000000000000000}}},
    {{{0x0006217e039d8064, 0x0006678aa6a8632f, 0x0004e8bf9045af1b, 0x0000000000000002,
       0x0006217e039d8064, 0x0006678aa6a8632f, 0x0004e8bf9045af1b, 0x0000000000000002},
      {0x0006dea408337e6d, 0x0005ea3788d8b365, 0x000514e33a45e0d6, 0x0000000000000000,
       0x0006dea408337e6d, 0x0005ea3788d8b365, 0x000514e33a45e0d6, 0x0000000000000000},
      {0x00057ac112628206, 0x00021bd6d6994279, 0x0007533c5b8bfe0f, 0x0000000000000000,
       0x00057ac112628206, 0x00021bd6d6994279, 0x0007533c5b8bfe0f, 0x0000000000000000},
      {0x000647cb65e30473, 0x0007ace75919e4e3, 0x000583557b7e14c9, 0x0000000000000000,
       0x000647cb65e30473, 0x0007ace75919e4e3, 0x000583557b7e14c9, 0x0000000000000000},
      {0x00049c05a51fadc9, 0x00034b9ed338add7, 0x00073c172021b008, 0x0000000000000000,
       0x00049c05a51fadc9, 0x00034b9ed338add7, 0x00073c172021b008, 0x0000000000000000}}},
    {{{0x0003558e227081dd, 0x000593d2b360748e, 0x00052ae403d0f8d8, 0x0000000000000002,
       0x0003558e227081dd, 0x000593d2b360748e, 0x00052ae403d0f8d8, 0x0000000000000002},
      {0x0006ccb53e05eebe, 0x000282c2fc0affe3, 0x00017a7e0c681a07, 0x0000000000000000,
       0x0006ccb53e05eebe, 0x000282c2fc0affe3, 0x00017a7e0c681a07, 0x0000000000000000},
      {0x000770e56013e060, 0x000555191917d4d3, 0x0004c6d424743073, 0x0000000000000000,
       0x000770e56013e060, 0x000555191917d4d3, 0x0004c6d424743073, 0x0000000000000000},
      {0x0003814239cba2fa, 0x0000f686aa81b1cd, 0x000673ff8b4f87b3, 0x0000000000000000,
       0x0003814239cba2fa, 0x0000f686aa81b1cd, 0x000673ff8b4f87b3, 0x0000000000000000},
      {0x0000353832c4950b, 0x00043ac7628aae59, 0x0000ec62af470bf4, 0x0000000000000000,
       0x0000353832c4950b, 0x00043ac7628aae59, 0x0000ec62af470bf4, 0x0000000000000000}}},
    {{{0x00075b0249864348, 0x000700848a802ade, 0x00032cc5fd6089e9, 0x0000000000000002,
       0x00075b0249864348, 0x000700848a802ade, 0x00032cc5fd6089e9, 0x0000000000000002},
      {0x00052ee11070262b, 0x0001e04605c4e5f7, 0x000426505c949b05, 0x0000000000000000,
       0x00052ee11070262b, 0x0001e04605c4e5f7, 0x000426505c949b05, 0x0000000000000000},
      {0x000237ae54fb5acd, 0x0005c0d01b9767fb, 0x00046a18880c7ad2, 0x0000000000000000,
       0x000237ae54fb5acd, 0x0005c0d01b9767fb, 0x00046a18880c7ad2, 0x0000000000000000},
      {0x0003bfd1d03aaab5, 0x0007d7889f42388b, 0x0004a4221888ccda, 0x0000000000000000,
       0x0003bfd1d03aaab5, 0x0007d7889f42388b, 0x0004a4221888ccda, 0x0000000000000000},
      {0x00018ab598029d5c, 0x0004275aae2546d8, 0x0003dc65522b53df, 0x0000000000000000,
       0x00018ab598029d5c, 0x0004275aae2546d8, 0x0003dc65522b53df, 0x0000000000000000}}},
    {{{0x00078375b53d54b9, 0x00058042a71e7539, 0x000594d87f944553, 0x0000000000000002,
       0x00078375b53d54b9, 0x00058042a71e7539, 0x000594d87f944553, 0x0000000000000002},
      {0x000219964b6490ad, 0x0002fb069a353c46, 0x00047449c3017dd4, 0x0000000000000000,
       0x000219964b6490ad, 0x0002fb069a353c46, 0x00047449c3017dd4, 0x0000000000000000},
      {0x0003576f748ecafe, 0x000069be4e2378f7, 0x00025d9187d9b368, 0x0000000000000000,
       0x0003576f748ecafe, 0x000069be4e2378f7, 0x00025d9187d9b368, 0x0000000000000000},
      {0x000176c426fdb72b, 0x0006ac22f66e9738, 0x0000637fe5ac4d7a, 0x0000000000000000,
       0x000176c426fdb72b, 0x0006ac22f66e9738, 0x0000637fe5ac4d7a, 0x0000000000000000},
      {0x0007956ece28a602, 0x000078aafde8d3cd, 0x00037c6a5151c83d, 0x0000000000000000,
       0x0007956ece28a602, 0x000078aafde8d3cd, 0x00037c6a5151c83d, 0x0000000000000000}}},
    {{{0x0007013b327fbf93, 0x0000c222a2007f6d, 0x0000a119732ea378, 0x0000000000000002,
       0x0007013b327fbf93, 0x0000c222a2007f6d, 0x0000a119732ea378, 0x0000000000000002},
      {0x0001336eeded6a0d, 0x000356b79bdb77ee, 0x00063bf1ba8e2a6c, 0x0000000000000000,
       0x0001336eeded6a0d, 0x000356b79bdb77ee, 0x00063bf1ba8e2a6c, 0x0000000000000000},
      {0x0002b565a2bbf3af, 0x00041ee81efe12ce, 0x00069f94cc90df9a, 0x0000000000000000,
       0x0002b565a2bbf3af, 0x00041ee81efe12ce, 0x00069f94cc90df9a, 0x0000000000000000},
      {0x000253ce89591955, 0x000120a9bd07097d, 0x000431d1779bfc48, 0x0000000000000000,
       0x000253ce89591955, 0x000120a9bd07097d, 0x000431d1779bfc48, 0x0000000000000000},
      {0x0000267882d17602, 0x000234fd7eec346f, 0x000497ba6fdaa097, 0x0000000000000000,
       0x0000267882d17602, 0x000234fd7eec346f, 0x000497ba6fdaa097, 0x0000000000000000}}},
    {{{0x00038a44d4171280, 0x000070ec3f213df2, 0x0001c5877a1e1b82, 0x0000000000000002,
       0x00038a44d4171280, 0x000070ec3f213df2, 0x0001c5877a1e1b82, 0x0000000000000002},
      {0x0001fb6f94663bfb, 0x00000afdf530e4df, 0x0005b45537ea92d4, 0x0000000000000000,
       0x0001fb6f94663bfb, 0x00000afdf530e4df, 0x0005b45537ea92d4, 0x0000000000000000},
      {0x0003b11ea739a6c8, 0x000206f756009dff, 0x00032c6eabc08e5f, 0x0000000000000000,
       0x0003b11ea739a6c8, 0x000206f756009dff, 0x00032c6eabc08e5f, 0x0000000000000000},
      {0x00006908972b78b7, 0x0003180d23a60214, 0x000649ce0fefb81f, 0x0000000000000000,
       0x00006908972b78b7, 0x0003180d23a60214, 0x000649ce0fefb81f, 0x0000000000000000},
      {0x0002df0ea2c5b3c8, 0x0006eaf60b2464d1, 0x00024bf7e3cd8ba9, 0x0000000000000000,
       0x0002df0ea2c5b3c8, 0x0006eaf60b2464d1, 0x00024bf7e3cd8ba9, 0x0000000000000000}}},
    {{{0x0003cd86468ccf0b, 0x0006cc0313cfeaa0, 0x0002762f9bd0b516, 0x0000000000000002,
       0x0003cd86468ccf0b, 0x0006cc0313cfeaa0, 0x0002762f9bd0b516, 0x0000000000000002},
      {0x00048553221ac081, 0x0001a313848da499, 0x0001c6e7fbddcbb3, 0x0000000000000000,
       0x00048553221ac081, 0x0001a313848da499, 0x0001c6e7fbddcbb3, 0x0000000000000000},
      {0x0006c9464b4e0a6e, 0x0007cb534219230a, 0x00075909c3ace2bd, 0x0000000000000000,
       0x0006c9464b4e0a6e, 0x0007cb534219230a, 0x00075909c3ace2bd, 0x0000000000000000},
      {0x00075fba84180403, 0x00039596dedefd60, 0x00042101972d3ec9, 0x0000000000000000,
       0x00075fba84180403, 0x00039596dedefd60, 0x00042101972d3ec9, 0x0000000000000000},
      {0x00043b5cd4218d05, 0x00061e22917f12de, 0x000511d61210ae4d, 0x0000000000000000,
       0x00043b5cd4218d05, 0x00061e22917f12de, 0x000511d61210ae4d, 0x0000000000000000}}},
    {{{0x000051ca553e2df3, 0x000504a52d9021f6, 0x00067c7d968acaab, 0x0000000000000002,
       0x000051ca553e2df3, 0x000504a52d9021f6, 0x00067c7d968acaab, 0x0000000000000002},
      {0x000174c90f166fd9, 0x00066eb8d7f38645, 0x0001c4e124e533f0, 0x0000000000000000,
       0x000174c90f166fd9, 0x00066eb8d7f38645, 0x0001c4e124e533f0, 0x0000000000000000},
      {0x000223479e9c4a13, 0x0003482c26e7067c, 0x00006025d57d5096, 0x0000000000000000,
       0x000223479e9c4a13, 0x0003482c26e7067c, 0x00006025d57d5096, 0x0000000000000000},
      {0x000441f35af20c99, 0x000730ac3d1d21a1, 0x000370e853e9a5f5, 0x0000000000000000,
       0x000441f35af20c99, 0x000730ac3d1d21a1, 0x000370e853e9a5f5, 0x0000000000000000},
      {0x0004cf210ec5a9a8, 0x000143b1cf8aa64f, 0x00021b546a337412, 0x0000000000000000,
       0x0004cf210ec5a9a8, 0x000143b1cf8aa64f, 0x00021b546a337412, 0x0000000000000000}}}};
