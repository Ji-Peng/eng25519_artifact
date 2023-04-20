#include "tedcurve.h"

#include "tedtable.h"

extern const uint64_t multi_base_table[(32 * 3 * 8 * 32) / 8];

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