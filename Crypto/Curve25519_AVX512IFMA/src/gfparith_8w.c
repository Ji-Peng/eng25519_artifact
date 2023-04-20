#include "gfparith_8w.h"

/**
 * @brief Conditional swap.
 *
 * @details
 * Replace (r,a) with (a,r) if b == 1;
 * replace (r,a) with (r,a) if b == 0.
 * Depending on a Boolean value that is passed as an argument to the function,
 * the two elements are either swapped or not swapped.
 *
 * @param r Field element
 * @param a Field element
 * @param b Swapping flag
 */
void cswap_fp255_8x1w(__m512i *r, __m512i *a, const __m512i b)
{
    int i;
    __m512i x[5];
    const __m512i mask = VSUB(VZERO, b);

    for (i = 0; i < 5; i++) {
        /**
         * r xor a
         * (r xor a) xor mask
         * r xor ((r xor a) xor mask)
         * a xor ((r xor a) xor mask)
         */
        x[i] = VXOR(r[i], a[i]);
        x[i] = VAND(x[i], mask);
        r[i] = VXOR(r[i], x[i]);
        a[i] = VXOR(a[i], x[i]);
    }
}

/**
 * @brief Field addition without carry propagation.
 *
 * @details
 * r = a + b without carry propagation.
 * This allows limbs expand one more bit.
 *
 * Regarding the input range:
 *  Note that, in our implementation, the input of this routine is always same with the
 *  output of mul_x_fp255_8x1w. a/b0 < 2^51+1634, a/b1 < 2^51, a/b2 < 2^51+51, a/b3 <
 *  2^51, a/b4 < 2^51+75.
 * Regarding the output range:
 *  r0 < 2^52+3268, r1 < 2^52, r2 < 2^52+102, r3 < 2^52, r4 < 2^52+150
 *
 * @param r Field element
 * @param a Field element
 * @param b Field element
 */
void add_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b)
{
    int i;
    for (i = 0; i < NWORDS_8x1; i++) {
        r[i] = VADD(a[i], b[i]);
    }
}

/**
 * @brief Field addition with carry propagation.
 *
 * @details
 * r = a + b with carry propagation.
 *
 * Regarding carry chain optimization:
 * The normal carry propagation logic looks like: r0->r1->r2->r3->r4->r0.
 * Its disadvantage is that carry r2 depends on the value of r1.
 * Our optimized carry propagation logic is: r0->r1, r2->r3, r4->r0, r1->r2,
 * r3->r4. This method breaks the above dependency chain. After using this
 * optimization: point addition cycles: 669 -> 661 point doubling cycles: 640 ->
 * 618 KeyGen throughput: 237356 -> 239496 SharedKey throughput: 101025 ->
 * 104012
 *
 * Regarding the input range:
 *  We consider all limbs of a and b are in the range of [0,2^52). In practice, the limbs
 *  are smaller in our implementation.
 * Regarding the output range:
 *  r0 < 2^51+2^7, r1 < 2^51, r2 < 2^51+5, r3 < 2^51, r4 < 2^51+5.
 *
 * @param r Field element
 * @param a Field element
 * @param b Field element
 */
void adc_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b)
{
    __m512i a0 = a[0], a1 = a[1], a2 = a[2], a3 = a[3], a4 = a[4];
    __m512i b0 = b[0], b1 = b[1], b2 = b[2], b3 = b[3], b4 = b[4];
    __m512i r0, r1, r2, r3, r4, temp;
    const __m512i vmask51 = VSET1(MASK51b);
    const __m512i vconstc = VSET1(CONSTC);

    // r = a + b
    r0 = VADD(a0, b0);  // r0 < 4*2^51
    r1 = VADD(a1, b1);  // r1 < 4*2^51
    r2 = VADD(a2, b2);  // r2 < 4*2^51
    r3 = VADD(a3, b3);  // r3 < 4*2^51
    r4 = VADD(a4, b4);  // r4 < 4*2^51

    /** carry r0->r1 */
    r1 = VADD(r1, VSHR(r0, RADIX_8x1));  // r1 < 4*2^51+2^2
    r0 = VAND(r0, vmask51);              // r0 < 2^51
    /** carry r2->r3 */
    r3 = VADD(r3, VSHR(r2, RADIX_8x1));  // r3 < 4*2^51+2^2
    r2 = VAND(r2, vmask51);              // r2 < 2^51
    /** carry r4->r0 */
    temp = VSHR(r4, RADIX_8x1);  // temp < 2^2
    temp = VMUL(temp, vconstc);  // temp < 2^7
    r0 = VADD(r0, temp);         // r0 < 2^51+2^7
    r4 = VAND(r4, vmask51);      // r4 < 2^51
    /** carry r1->r2 */
    r2 = VADD(r2, VSHR(r1, RADIX_8x1));  // r2 < 2^51+5
    r1 = VAND(r1, vmask51);              // r1 < 2^51
    /** carry r3->r4 */
    r4 = VADD(r4, VSHR(r3, RADIX_8x1));  // r4 < 2^51+5
    r3 = VAND(r3, vmask51);              // r3 < 2^51

    r[0] = r0;
    r[1] = r1;
    r[2] = r2;
    r[3] = r3;
    r[4] = r4;
}

/**
 * @brief Field subtraction with carry propagation.
 *
 * @details
 * r = 2p + a - b without carry propagation.
 * This function is not used at present, therefore we don't analyze its input and output
 * ranges.
 * @param r Field element
 * @param a Field element
 * @param b Field element
 */
void sub_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b)
{
    // r = a - b + 2p
    const __m512i vdlswp = VSET1(LOW51b * 2);
    const __m512i vdwrdp = VSET1(MASK51b * 2);

    int i;
    r[0] = VADD(vdlswp, VSUB(a[0], b[0]));
    for (i = 1; i < NWORDS_8x1; i++) {
        r[i] = VADD(vdwrdp, VSUB(a[i], b[i]));
    }
}

/**
 * @brief Field subtraction with carry propagation.
 *
 * @details
 * r = 2p + a - b with carry propagation.
 *
 * It adds 2p to avoid any negative intermediate values. We use same carry
 * propagation trick with the abc_fp255_8x1w.
 *
 * Regarding the input range:
 *  We only consider the maximum range appeared in our implementation. In
 *  ted_point_add_avx512/_8x1w_mixadd routine, the maximum range of a's limbs is a0 <
 *  2^52+3268, a1 < 2^52, a2 < 2^52+102, a3 < 2^52, a4 < 2^52+150, and the range of b's
 *  limbs is same with the output of mul_x_fp255_8x1w: b0 < 2^51+1634, b1 < 2^51, b2 <
 *  2^51+51, b3 < 2^51, b4 < 2^51+75.
 *
 * Regarding the output range:
 *  r0 < 2^51+114, r1 < 2^51, r2 < 2^51+6, r3 < 2^51, r4 < 2^51+6.
 *
 * @param r Field element
 * @param a Field element
 * @param b Field element
 */
void sbc_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b)
{
    __m512i a0 = a[0], a1 = a[1], a2 = a[2], a3 = a[3], a4 = a[4];
    __m512i b0 = b[0], b1 = b[1], b2 = b[2], b3 = b[3], b4 = b[4];
    __m512i r0, r1, r2, r3, r4, temp;

    // r = a - b + 2p
    const __m512i vdlswp = VSET1(LOW51b * 2);
    const __m512i vdwrdp = VSET1(MASK51b * 2);
    const __m512i vmask51 = VSET1(MASK51b);
    const __m512i vconstc = VSET1(CONSTC);

    // 0 < LOW51b*2-(2^51+3268) < r0 < 3*2^51+3*1634+LOW51b*2 < 5.1*2^51
    r0 = VADD(vdlswp, VSUB(a0, b0));
    r1 = VADD(vdwrdp, VSUB(a1, b1));  // r1 < 3*2^51+MASK51b*2 < 4.9*2^51
    r2 = VADD(vdwrdp, VSUB(a2, b2));  // r2 < 3*2^51+3*51+MASK51b*2 < 5.1*2^51
    r3 = VADD(vdwrdp, VSUB(a3, b3));  // r3 < 3*2^51+MASK51b*2 < 4.9*2^51
    r4 = VADD(vdwrdp, VSUB(a4, b4));  // r4 < 3*2^51+3*75+MASK51b*2 < 5.1*2^51

    /** carry r0->r1 */
    r1 = VADD(r1, VSHR(r0, RADIX_8x1));  // r1 < 5*2^51+3
    r0 = VAND(r0, vmask51);              // r0 < 2^51
    /** carry r2->r3 */
    r3 = VADD(r3, VSHR(r2, RADIX_8x1));  // r3 < 5*2^51+3
    r2 = VAND(r2, vmask51);              // r2 < 2^51
    /** carry r4->r0 */
    temp = VSHR(r4, RADIX_8x1);  // temp < 6
    temp = VMUL(temp, vconstc);  // temp < 114
    r0 = VADD(r0, temp);         // r0 < 2^51+114
    r4 = VAND(r4, vmask51);      // r4 < 2^51
    /** carry r1->r2 */
    r2 = VADD(r2, VSHR(r1, RADIX_8x1));  // r2 < 2^51+6
    r1 = VAND(r1, vmask51);              // r1 < 2^51
    /** carry r3->r4 */
    r4 = VADD(r4, VSHR(r3, RADIX_8x1));  // r4 < 2^51+6
    r3 = VAND(r3, vmask51);              // r3 < 2^51

    r[0] = r0;
    r[1] = r1;
    r[2] = r2;
    r[3] = r3;
    r[4] = r4;
}

/**
 * r = 0 - b + 2p
 */
void neg_fp255_8x1w(fe_8x1 r, const fe_8x1 b)
{
    __m512i zero = VZERO;

    const __m512i vdlswp = VSET1(LOW51b * 2);
    const __m512i vdwrdp = VSET1(MASK51b * 2);

    int i;
    r[0] = VADD(vdlswp, VSUB(zero, b[0]));
    for (i = 1; i < NWORDS_8x1; i++) {
        r[i] = VADD(vdwrdp, VSUB(zero, b[i]));
    }
    carry_fp255_8x1w(r);
}

/**
 * @brief Field multiplication.
 *
 * @details
 * r = x * a * b mod p, where x = 1 or 2 in our implementation.
 * Regarding the input range:
 *  The allowed range of a/b's limbs is [0, 2^52).
 *  In practice, the limbs may be smaller.
 * Regarding the output range:
 *  r0 < 2^51+1634, r1 < 2^51, r2 < 2^51+51, r3 < 2^51, r4 < 2^51+75
 * This is a modular multiplication. It performs a product-scanning and modulo-p
 * reduction separately. It uses local variables to store intermediate values.
 *
 * @param r Field element
 * @param a Field element
 * @param b Field element
 */
void mul_x_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b, const uint8_t x)
{
    __m512i z0, z1, z2, z3, z4;
    __m512i z5, z6, z7, z8, z9;
    __m512i t = VZERO;
    const __m512i vbmask = VSET1(MASK51b), vconstc = VSET1(CONSTC),
                  vconstc2 = VSET1(CONSTC * CONSTC);

    /** 1st loop of the product-scanning multiplication, {z1, z0} += a[0] * b[0] */
    z0 = VMACLO(VZERO, a[0], b[0]);  // z0 < 2*2^51
    z1 = VMACHI(VZERO, a[0], b[0]);  // z1 < 2*2^51
    z1 = VSHL(z1, 1);                // z1 < 4*2^51

    /** {z2, z1} += a[0] * b[1] + a[1] * b[0] */
    z1 = VMACLO(z1, a[0], b[1]);  // z1 < 6*2^51
    z1 = VMACLO(z1, a[1], b[0]);  // z1 < 8*2^51
    t = VMACHI(t, a[0], b[1]);    // t < 2*2^51
    t = VMACHI(t, a[1], b[0]);    // t < 4*2^51
    z2 = VSHL(t, 1);              // z2 < 8*2^51
    t = VZERO;

    /** {z3, z2} += a[0] * b[2] + a[1] * b[1] + a[2] * b[0] */
    z2 = VMACLO(z2, a[0], b[2]);  // z2 < 10*2^51
    z2 = VMACLO(z2, a[1], b[1]);  // z2 < 12*2^51
    z2 = VMACLO(z2, a[2], b[0]);  // z2 < 14*2^51
    t = VMACHI(t, a[0], b[2]);    // t < 2*2^51
    t = VMACHI(t, a[1], b[1]);    // t < 4*2^51
    t = VMACHI(t, a[2], b[0]);    // t < 6*2^51
    z3 = VSHL(t, 1);              // z3 < 12*2^51
    t = VZERO;

    /** {z4, z3} += a[0] * b[3] + a[1] * b[2] + a[2] * b[1] + a[3] * b[0] */
    z3 = VMACLO(z3, a[0], b[3]);  // z3 < 14*2^51
    z3 = VMACLO(z3, a[1], b[2]);  // z3 < 16*2^51
    z3 = VMACLO(z3, a[2], b[1]);  // z3 < 18*2^51
    z3 = VMACLO(z3, a[3], b[0]);  // z3 < 20*2^51
    t = VMACHI(t, a[0], b[3]);    // t < 2*2^51
    t = VMACHI(t, a[1], b[2]);    // t < 4*2^51
    t = VMACHI(t, a[2], b[1]);    // t < 6*2^51
    t = VMACHI(t, a[3], b[0]);    // t < 8*2^51
    z4 = VSHL(t, 1);              // z4 < 16*2^51
    t = VZERO;

    /** {z5, z4} += a[0] * b[4] + ... + a[4] * b[0] */
    z4 = VMACLO(z4, a[0], b[4]);  // z4 < 18*2^51
    z4 = VMACLO(z4, a[1], b[3]);  // z4 < 20*2^51
    z4 = VMACLO(z4, a[2], b[2]);  // z4 < 22*2^51
    z4 = VMACLO(z4, a[3], b[1]);  // z4 < 24*2^51
    z4 = VMACLO(z4, a[4], b[0]);  // z4 < 26*2^51
    t = VMACHI(t, a[0], b[4]);    // t < 2*2^51
    t = VMACHI(t, a[1], b[3]);    // t < 4*2^51
    t = VMACHI(t, a[2], b[2]);    // t < 6*2^51
    t = VMACHI(t, a[3], b[1]);    // t < 8*2^51
    t = VMACHI(t, a[4], b[0]);    // t < 10*2^51
    z5 = VSHL(t, 1);              // z5 < 20*2^51
    t = VZERO;

    /** 2nd loop of the product-scanning multiplication */

    /** {z6, z5} += a[1] * b[4] + a[2] * b[3] + a[3] * b[2] + a[4] * b[1] */
    z5 = VMACLO(z5, a[1], b[4]);  // z5 < 22*2^51
    z5 = VMACLO(z5, a[2], b[3]);  // z5 < 24*2^51
    z5 = VMACLO(z5, a[3], b[2]);  // z5 < 26*2^51
    z5 = VMACLO(z5, a[4], b[1]);  // z5 < 28*2^51
    t = VMACHI(t, a[1], b[4]);    // t < 2*2^51
    t = VMACHI(t, a[2], b[3]);    // t < 4*2^51
    t = VMACHI(t, a[3], b[2]);    // t < 6*2^51
    t = VMACHI(t, a[4], b[1]);    // t < 8*2^51
    z6 = VSHL(t, 1);              // z6 < 16*2^51
    t = VZERO;

    /** {z7, z6} += a[2] * b[4] + a[3] * b[3] + a[4] * b[2] */
    z6 = VMACLO(z6, a[2], b[4]);  // z6 < 18*2^51
    z6 = VMACLO(z6, a[3], b[3]);  // z6 < 20*2^51
    z6 = VMACLO(z6, a[4], b[2]);  // z6 < 22*2^51
    t = VMACHI(t, a[2], b[4]);    // t < 2*2^51
    t = VMACHI(t, a[3], b[3]);    // t < 4*2^51
    t = VMACHI(t, a[4], b[2]);    // t < 6*2^51
    z7 = VSHL(t, 1);              // z7 < 12*2^51
    t = VZERO;

    /** {z8, z7} += a[3] * b[4] + a[4] * b[3] */
    z7 = VMACLO(z7, a[3], b[4]);  // z7 < 14*2^51
    z7 = VMACLO(z7, a[4], b[3]);  // z7 < 16*2^51
    t = VMACHI(t, a[3], b[4]);    // t < 2*2^51
    t = VMACHI(t, a[4], b[3]);    // t < 4*2^51
    z8 = VSHL(t, 1);              // z8 < 8*2^51
    t = VZERO;

    /** {z9, z8} += a[4] * b[4] */
    z8 = VMACLO(z8, a[4], b[4]);     // z8 < 10*2^51
    z9 = VMACHI(VZERO, a[4], b[4]);  // z9 < 2*2^51
    z9 = VSHL(z9, 1);                // z9 < 4*2^51

    /** multiplication-result * x, where x = 1 or 2. */
    z0 = VSHL(z0, x - 1);  // z0 < 4*2^51
    z1 = VSHL(z1, x - 1);  // z1 < 16*2^51
    z2 = VSHL(z2, x - 1);  // z2 < 28*2^51
    z3 = VSHL(z3, x - 1);  // z3 < 40*2^51
    z4 = VSHL(z4, x - 1);  // z4 < 52*2^51
    z5 = VSHL(z5, x - 1);  // z5 < 56*2^51
    z6 = VSHL(z6, x - 1);  // z6 < 44*2^51
    z7 = VSHL(z7, x - 1);  // z7 < 32*2^51
    z8 = VSHL(z8, x - 1);  // z8 < 20*2^51
    z9 = VSHL(z9, x - 1);  // z9 < 8*2^51

    /**  1) carry z5->z6 */
    z6 = VADD(z6, VSHR(z5, RADIX_8x1));  // z6 < 44*2^51+56
    z5 = VAND(z5, vbmask);               // z5 < 2^51
    /** 3) carry z7->z8 */
    z8 = VADD(z8, VSHR(z7, RADIX_8x1));  // z8 < 20*2^51+32
    z7 = VAND(z7, vbmask);               // z7 < 2^51
    /** 5) carry z9->z0 */
    t = VADD(t, VSHR(z9, RADIX_8x1));  // t < 2^3
    z9 = VAND(z9, vbmask);             // z9 < 2^51
    z0 = VMACLO(z0, t, vconstc2);      // z0 < 4*2^51+2^12
    t = VZERO;
    /** 2) carry z6->z7 */
    z7 = VADD(z7, VSHR(z6, RADIX_8x1));  // z7 < 2^51+44
    z6 = VAND(z6, vbmask);               // z6 < 2^51
    /** 4) carry z8->z9 */
    z9 = VADD(z9, VSHR(z8, RADIX_8x1));  // z9 < 2^51+20
    z8 = VAND(z8, vbmask);               // z8 < 2^51

    /**
     * Now the range of zi is as follows.
     * z0 < 4*2^51+2^12, z1 < 16*2^51, z2 < 28*2^51, z3 < 40*2^51, z4 < 52*2^51
     * z5 < 2^51, z6 < 2^51, z7 < 2^51+44, z8 < 2^51, z9 < 2^51+20
     *
     * And then modulo-p reduction and conversion to 51-bit limbs.
     * base-of-z5 = 2^255
     */
    /** 6) carry z5*19->{z1,z0} */
    z0 = VMACLO(z0, z5, vconstc);  // z0 < 6*2^51+2^12
    t = VMACHI(t, z5, vconstc);    // t < 2^4
    z1 = VADD(z1, VSHL(t, 1));     // z1 < 16*2^51+2^5
    t = VZERO;
    z5 = VZERO;  // z5 = 0
    /** size-of-z0 > 51b, so carry z0->z1 */
    z1 = VADD(z1, VSHR(z0, RADIX_8x1));  // z1 < 16*2^51+39
    z0 = VAND(z0, vbmask);               // z0 < 2^51

    /** base-of-z7 = 255 + 51*2, base-of-z2 = 51*2 */
    /** 8) carry z7*19->{z3,z2} */
    z2 = VMACLO(z2, z7, vconstc);  // z2 < 30*2^51
    t = VMACHI(t, z7, vconstc);    // t < 2^4
    z3 = VADD(z3, VSHL(t, 1));     // z3 < 40*2^51+2^5
    t = VZERO;
    /** size-of-z2 > 51b, so carry z2->z3 */
    z3 = VADD(z3, VSHR(z2, RADIX_8x1));  // z3 < 40*2^51+62
    z2 = VAND(z2, vbmask);               // z2 < 2^51

    /** 10) carry z9*19->{z5,z4} */
    z4 = VMACLO(z4, z9, vconstc);  // z4 < 54*2^51
    t = VMACHI(t, z9, vconstc);    // t < 2^4
    z5 = VADD(z5, VSHL(t, 1));     // z5 < 2^5
    t = VZERO;
    /** size-of-z4 > 51b, so carry z4->z5 */
    z5 = VADD(z5, VSHR(z4, RADIX_8x1));  // z5 < 86
    z4 = VAND(z4, vbmask);               // z4 < 2^51

    /** base-of-z6 = 255 + 51, base-of-z1 = 51 */
    /** 7) carry z6*19->{z2,z1} */
    z1 = VMACLO(z1, z6, vconstc);  // z1 < 18*2^51+39
    t = VMACHI(t, z6, vconstc);    // t < 2^4
    z2 = VADD(z2, VSHL(t, 1));     // z2 < 2^51+32
    t = VZERO;
    /** size-of-z1 > 51b, so carry z1->z2 */
    z2 = VADD(z2, VSHR(z1, RADIX_8x1));  // z2 < 2^51+51
    z1 = VAND(z1, vbmask);               // z1 < 2^51

    /** base-of-z8 = 255 + 51*3, base-of-z3 = 51*3 */
    /** 9) carry z8*19->{z4,z3} */
    z3 = VMACLO(z3, z8, vconstc);  // z3 < 42*2^51+62
    t = VMACHI(t, z8, vconstc);    // t < 2^4
    z4 = VADD(z4, VSHL(t, 1));     // z4 < 2^51+2^5
    t = VZERO;
    /** size-of-z3 > 51b, so carry z3->z4 */
    z4 = VADD(z4, VSHR(z3, RADIX_8x1));  // z4 < 2^51+75
    z3 = VAND(z3, vbmask);               // z3 < 2^51

    /** 11) carry z5->z0, base-of-z5 = 2^255 */
    z0 = VMACLO(z0, z5, vconstc);  // z0 < 2^51+1634

    r[0] = z0;
    r[1] = z1;
    r[2] = z2;
    r[3] = z3;
    r[4] = z4;
}

/**
 * @brief Field multiplication.
 *
 * @details
 * r = b * a mod p.
 * The modular multiplication between a field element "a" and a 51-bit integer "b".
 *
 * Regarding the input range:
 *  The allowed range of a's limbs or b is [0, 2^52).
 *  In practice, the limbs may be smaller.
 * Regarding the output range:
 *  r0 < 2^51, r1 < 2^51+2^7+2^6+3, r2 < 2^51+6, r3 < 2^51, r4 < 2^51+6
 *
 * @param r Field element
 * @param a Field element
 * @param b 51-bit integer
 */
void mul51_fp255_8x1w(__m512i *r, const __m512i *a, const uint64_t b)
{
    __m512i a0 = a[0], a1 = a[1], a2 = a[2];
    __m512i a3 = a[3], a4 = a[4];
    __m512i z0 = VZERO, z1 = VZERO, z2 = VZERO, z3 = VZERO, z4 = VZERO;
    __m512i z5 = VZERO, z6 = VZERO;
    __m512i t = VZERO;
    const __m512i vb = VSET1(b);
    const __m512i vbmask = VSET1(MASK51b), vconstc = VSET1(CONSTC);

    /** the product-scanning multiplication */
    z0 = VMACLO(z0, a0, vb);  // z0 < 2*2^51
    z1 = VMACHI(z1, a0, vb);  // z1 < 2*2^51
    z1 = VSHL(z1, 1);         // z1 < 4*2^51

    z1 = VMACLO(z1, a1, vb);  // z1 < 6*2^51
    z2 = VMACHI(z2, a1, vb);  // z2 < 2*2^51
    z2 = VSHL(z2, 1);         // z2 < 4*2^51

    z2 = VMACLO(z2, a2, vb);  // z2 < 6*2^51
    z3 = VMACHI(z3, a2, vb);  // z3 < 2*2^51
    z3 = VSHL(z3, 1);         // z3 < 4*2^51

    z3 = VMACLO(z3, a3, vb);  // z3 < 6*2^51
    z4 = VMACHI(z4, a3, vb);  // z4 < 2*2^51
    z4 = VSHL(z4, 1);         // z4 < 4*2^51

    z4 = VMACLO(z4, a4, vb);  // z4 < 6*2^51
    z5 = VMACHI(z5, a4, vb);  // z5 < 2*2^51
    z5 = VSHL(z5, 1);         // z5 < 4*2^51

    /** modulo-p reduction and conversion to 51-bit limbs */
    /** base-of-z5 = 2^255 */
    /** carry z0->z1 */
    z1 = VADD(z1, VSHR(z0, RADIX_8x1));  // z1 < 6*2^51+2
    z0 = VAND(z0, vbmask);               // z0 < 2^51
    /** carry z2->z3 */
    z3 = VADD(z3, VSHR(z2, RADIX_8x1));  // z3 < 6*2^51+6
    z2 = VAND(z2, vbmask);               // z2 < 2^51
    /** carry z4->z5 */
    z5 = VADD(z5, VSHR(z4, RADIX_8x1));  // z5 < 4*2^51+6
    z4 = VAND(z4, vbmask);               // z4 < 2^51
    /** carry z1->z2 */
    z2 = VADD(z2, VSHR(z1, RADIX_8x1));  // z2 < 2^51+6
    z1 = VAND(z1, vbmask);               // z1 < 2^51
    /** carry z3->z4 */
    z4 = VADD(z4, VSHR(z3, RADIX_8x1));  // z4 < 2^51+6
    z3 = VAND(z3, vbmask);               // z3 < 2^51
    /** carry z5->z6 */
    z6 = VADD(z6, VSHR(z5, RADIX_8x1));  // z6 < 5
    z5 = VAND(z5, vbmask);               // z5 < 2^51
    /** carry z5->z0->z1 */
    z0 = VMACLO(z0, z5, vconstc);  // z0 < 3*2^51
    t = VMACHI(t, z5, vconstc);    // t < 2^5
    z1 = VADD(z1, VSHL(t, 1));     // z1 < 2^51+2^6
    t = VZERO;
    /** carry the part that overflows 52b in z0 to z1 */
    z1 = VADD(z1, VSHR(z0, RADIX_8x1));  // z1 < 2^51+2^6+3
    z0 = VAND(z0, vbmask);               // z0 < 2^51
    /** carry z6->z1 */
    t = VMACLO(t, z6, vconstc);  // t < 2^7
    z1 = VADD(z1, t);            // z1 < 2^51+2^7+2^6+3

    r[0] = z0;
    r[1] = z1;
    r[2] = z2;
    r[3] = z3;
    r[4] = z4;
}

/**
 * @brief Field squaring and multiply 2; r = 2 * a^2.
 *
 * @details
 * r = x * a^2 mod p.
 * x = 1 or 2 in our implementation.
 *
 * Regarding the input range:
 *  The allowed range of a's limbs or b is [0, 2^52).
 *  In practice, the limbs may be smaller.
 * Regarding the output range:
 *  r0 < 2^51+1634, r1 < 2^51, r2 < 2^51+2^5+19, r3 < 2^51, r4 < 2^51+75
 *
 * This is a modular squaring. It performs a product-scanning and modulo-p
 * reduction separately. It uses local variables to store intermediate values.
 *
 * @param r Field element
 * @param a Field element
 */
void sqr_x_fp255_8x1w(__m512i *r, const __m512i *a, const uint8_t x)
{
    __m512i a0 = a[0], a1 = a[1], a2 = a[2], a3 = a[3], a4 = a[4];
    __m512i z0 = VZERO, z1 = VZERO, z2 = VZERO, z3 = VZERO, z4 = VZERO;
    __m512i z5 = VZERO, z6 = VZERO, z7 = VZERO, z8 = VZERO, z9 = VZERO;
    __m512i t = VZERO;
    const __m512i vbmask = VSET1(MASK51b), vconstc = VSET1(CONSTC),
                  vconstc2 = VSET1(CONSTC * CONSTC);

    /** 1st loop of the product-scanning squaring */
    /** {z1, z0} += a0 * a0 */
    z0 = VMACLO(z0, a0, a0);  // z0 < 2*2^51
    z1 = VMACHI(z1, a0, a0);  // z1 < 2*2^51
    z1 = VSHL(z1, 1);         // z1 < 4*2^51

    /** {z2, z1} += 2 * a0 * a1, base-of-z1 = 2^51 */
    t = VMACLO(t, a0, a1);      // t < 2*2^51
    z1 = VADD(z1, VSHL(t, 1));  // z1 < 8*2^51
    t = VZERO;
    t = VMACHI(t, a0, a1);  // t < 2*2^51
    z2 = VSHL(t, 2);        // z2 < 8*2^51
    t = VZERO;

    /** {z3, z2} += 2 * a0 * a2 + a1 * b1, base-of-z2 = 2^(51*2) */
    t = VMACLO(t, a0, a2);      // t < 2*2^51
    z2 = VADD(z2, VSHL(t, 1));  // z2 < 12*2^51
    t = VZERO;
    z2 = VMACLO(z2, a1, a1);  // z2 < 14*2^51
    t = VMACHI(t, a0, a2);    // t < 2*2^51
    t = VSHL(t, 1);           // t < 4*2^51
    t = VMACHI(t, a1, a1);    // t < 6*2^51
    z3 = VSHL(t, 1);          // z3 < 12*2^51
    t = VZERO;

    /** {z4, z3} += 2 * a0 * a3 + 2 * a1 * a2, base-of-z3 = 2^(51*3) */
    t = VMACLO(t, a0, a3);      // t < 2*2^51
    t = VMACLO(t, a1, a2);      // t < 4*2^51
    z3 = VADD(z3, VSHL(t, 1));  // z3 < 20*2^51
    t = VZERO;
    t = VMACHI(t, a0, a3);  // t < 2*2^51
    t = VMACHI(t, a1, a2);  // t < 4*2^51
    z4 = VSHL(t, 2);        // t < 16*2^51
    t = VZERO;

    /** {z5, z4} += 2 * a0 * a4 + 2 * a1 * a3 + a2 * a2, base-of-z4 = 2^(51*4) */
    t = VMACLO(t, a0, a4);      // t < 2*2^51
    t = VMACLO(t, a1, a3);      // t < 4*2^51
    z4 = VADD(z4, VSHL(t, 1));  // z4 < 24*2^51
    t = VZERO;
    z4 = VMACLO(z4, a2, a2);  // z4 < 26*2^51
    t = VMACHI(t, a0, a4);    // t < 2*2^51
    t = VMACHI(t, a1, a3);    // t < 4*2^51
    t = VSHL(t, 1);           // t < 8*2^51
    t = VMACHI(t, a2, a2);    // t < 10*2^51
    z5 = VSHL(t, 1);          // z5 < 20*2^51
    t = VZERO;

    /** 2nd loop of the product-scanning squaring */
    /** {z6, z5} += 2 * a1 * a4 + 2 * a2 * a3, base-of-z5 = 2^(51*5) */
    t = VMACLO(t, a1, a4);      // t < 2*2^51
    t = VMACLO(t, a2, a3);      // t < 4*2^51
    z5 = VADD(z5, VSHL(t, 1));  // z5 < 28*2^51
    t = VZERO;
    t = VMACHI(t, a1, a4);  // t < 2*2^51
    t = VMACHI(t, a2, a3);  // t < 4*2^51
    z6 = VSHL(t, 2);        // z6 < 16*2^51
    t = VZERO;

    /** {z7, z6} += 2 * a2 * a4 + a3 * a3, base-of-z6 = 2^(51*5) * 2^51 */
    t = VMACLO(t, a2, a4);      // t < 2*2^51
    z6 = VADD(z6, VSHL(t, 1));  // z6 < 20*2^51
    t = VZERO;
    z6 = VMACLO(z6, a3, a3);  // z6 < 22*2^51
    t = VMACHI(t, a2, a4);    // t < 2*2^51
    t = VSHL(t, 1);           // t < 4*2^51
    t = VMACHI(t, a3, a3);    // t < 6*2^51
    z7 = VSHL(t, 1);          // z7 < 12*2^51
    t = VZERO;

    /** {z8, z7} += 2 * a3 * a4, base-of-z7 = 2^(51*5) * 2^(51*2) */
    t = VMACLO(t, a3, a4);      // t < 2*2^51
    z7 = VADD(z7, VSHL(t, 1));  // z7 < 16*2^51
    t = VZERO;
    t = VMACHI(t, a3, a4);  // t < 2*2^51
    z8 = VSHL(t, 2);        // z8 < 8*2^51
    t = VZERO;

    /** {z9, z8} += a4 * a4, base-of-z8 = 2^(51*5) * 2^(51*3), base-of-z9 = */
    /** 2^(51*5) * 2^(51*4) */
    z8 = VMACLO(z8, a4, a4);  // z8 < 10*2^51
    z9 = VMACHI(z9, a4, a4);  // z9 < 2*2^51
    z9 = VSHL(z9, 1);         // z9 < 4*2^51

    z0 = VSHL(z0, x - 1);  // z0 < 4*2^51
    z1 = VSHL(z1, x - 1);  // z1 < 16*2^51
    z2 = VSHL(z2, x - 1);  // z2 < 28*2^51
    z3 = VSHL(z3, x - 1);  // z3 < 40*2^51
    z4 = VSHL(z4, x - 1);  // z4 < 52*2^51
    z5 = VSHL(z5, x - 1);  // z5 < 56*2^51
    z6 = VSHL(z6, x - 1);  // z6 < 44*2^51
    z7 = VSHL(z7, x - 1);  // z7 < 32*2^51
    z8 = VSHL(z8, x - 1);  // z8 < 20*2^51
    z9 = VSHL(z9, x - 1);  // z9 < 8*2^51

    /** carry propagation */
    /** 1) carry z5->z6 */
    z6 = VADD(z6, VSHR(z5, RADIX_8x1));  // z6 < 44*2^51+56
    z5 = VAND(z5, vbmask);               // z5 < 2^51

    /** 3) carry z7->z8 */
    z8 = VADD(z8, VSHR(z7, RADIX_8x1));  // z8 < 20*2^51+32
    z7 = VAND(z7, vbmask);               // z7 < 2^51

    /** 5) carry z9->z0 */
    t = VADD(t, VSHR(z9, RADIX_8x1));  // t < 2^3
    z9 = VAND(z9, vbmask);             // z9 < 2^51
    z0 = VMACLO(z0, t, vconstc2);      // z0 < 4*2^51+2888
    t = VZERO;

    /** 2) carry z6->z7 */
    z7 = VADD(z7, VSHR(z6, RADIX_8x1));  // z7 < 2^51+45
    z6 = VAND(z6, vbmask);               // z6 < 2^51

    /** 4) carry z8->z9 */
    z9 = VADD(z9, VSHR(z8, RADIX_8x1));  // z9 < 2^51+21
    z8 = VAND(z8, vbmask);               // z8 < 2^51

    /** modulo-p reduction and conversion to 51-bit limbs */
    /** 6) carry z5*19->{z1,z0} */
    z0 = VMACLO(z0, z5, vconstc);  // z0 < 6*2^51+2888
    t = VMACHI(t, z5, vconstc);    // t < 2^4
    z1 = VADD(z1, VSHL(t, 1));     // z1 < 16*2^51+2^5
    t = VZERO;
    z5 = VZERO;
    /** carry the part that overflows 52b in z0 to z1 */
    z1 = VADD(z1, VSHR(z0, RADIX_8x1));  // z1 < 16*2^51+2^5+7
    z0 = VAND(z0, vbmask);               // z0 < 2^51

    /** 8) carry z7*19->{z3,z2} */
    z2 = VMACLO(z2, z7, vconstc);  // z2 < 30*2^51
    t = VMACHI(t, z7, vconstc);    // t < 2^4
    z3 = VADD(z3, VSHL(t, 1));     // z3 < 40*2^51+2^5
    t = VZERO;
    /** carry overflowing part */
    z3 = VADD(z3, VSHR(z2, RADIX_8x1));  // z3 < 40*2^51+2^5+30
    z2 = VAND(z2, vbmask);               // z2 < 2^51

    /** 10) carry z9*19->{z5,z4} */
    z4 = VMACLO(z4, z9, vconstc);  // z4 < 54*2^51
    t = VMACHI(t, z9, vconstc);    // t < 2^4
    z5 = VADD(z5, VSHL(t, 1));     // z5 < 2^5
    t = VZERO;
    z5 = VADD(z5, VSHR(z4, RADIX_8x1));  // z5 < 2^5+54
    z4 = VAND(z4, vbmask);               // z4 < 2^51

    /** 7) carry z6*19->{z2,z1} */
    z1 = VMACLO(z1, z6, vconstc);  // z1 < 18*2^51+2^5+7
    t = VMACHI(t, z6, vconstc);    // t < 2^4
    z2 = VADD(z2, VSHL(t, 1));     // z2 < 2^51+2^5
    t = VZERO;
    z2 = VADD(z2, VSHR(z1, RADIX_8x1));  // z2 < 2^51+2^5+19
    z1 = VAND(z1, vbmask);               // z1 < 2^51

    /** 9) carry z8*19->{z4,z3} */
    z3 = VMACLO(z3, z8, vconstc);  // z3 < 42*2^51+2^5+30
    t = VMACHI(t, z8, vconstc);    // t < 2^4
    z4 = VADD(z4, VSHL(t, 1));     // z4 < 2^51+2^5
    t = VZERO;
    z4 = VADD(z4, VSHR(z3, RADIX_8x1));  // z4 < 2^51+2^5+43
    z3 = VAND(z3, vbmask);               // z3 < 2^51

    /** 11) carry z5*19->z0 */
    z0 = VMACLO(z0, z5, vconstc);  // z0 < 2^51+1634

    r[0] = z0;
    r[1] = z1;
    r[2] = z2;
    r[3] = z3;
    r[4] = z4;
}

/**
 * @brief Field multiplicative inversion.
 *
 * @details
 * r = a^-1 mod p. (Fermat's little theorem: a^-1 = a^p-2 mod p, p-2 = 2 ** 255
 * - 19 - 2 = 2 ** 255 - 21 = (2 ** 5) * (2 ** 250 - 1) + 11.) This function
 * computes the multiplicative inverse of an element.
 *
 * Regarding the input range:
 *  This routine only uses sqr and mul routines. Therefore, the range of a's limbs is [0,
 * 2^52). In practice, these values are smaller.
 * Regarding the output range:
 *  The range of r's limbs are same with the output of mul_x_fp255_8x1w.
 *
 * @param r Field element
 * @param a Field element
 */
void inv_fp255_8x1w(__m512i *r, const __m512i *a)
{
    __m512i t0[NWORDS_8x1], t1[NWORDS_8x1], t2[NWORDS_8x1], t3[NWORDS_8x1];
    int i;
    sqr_fp255_8x1w(t0, a);
    sqr_fp255_8x1w(t1, t0);
    sqr_fp255_8x1w(t1, t1);
    mul_fp255_8x1w(t1, a, t1);
    mul_fp255_8x1w(t0, t0, t1);
    sqr_fp255_8x1w(t2, t0);
    mul_fp255_8x1w(t1, t1, t2);
    sqr_fp255_8x1w(t2, t1);
    for (i = 0; i < 4; i++)
        sqr_fp255_8x1w(t2, t2);
    mul_fp255_8x1w(t1, t2, t1);
    sqr_fp255_8x1w(t2, t1);
    for (i = 0; i < 9; i++)
        sqr_fp255_8x1w(t2, t2);
    mul_fp255_8x1w(t2, t2, t1);
    sqr_fp255_8x1w(t3, t2);
    for (i = 0; i < 19; i++)
        sqr_fp255_8x1w(t3, t3);
    mul_fp255_8x1w(t2, t3, t2);
    sqr_fp255_8x1w(t2, t2);
    for (i = 0; i < 9; i++)
        sqr_fp255_8x1w(t2, t2);
    mul_fp255_8x1w(t1, t2, t1);
    sqr_fp255_8x1w(t2, t1);
    for (i = 0; i < 49; i++)
        sqr_fp255_8x1w(t2, t2);
    mul_fp255_8x1w(t2, t2, t1);
    sqr_fp255_8x1w(t3, t2);
    for (i = 0; i < 99; i++)
        sqr_fp255_8x1w(t3, t3);
    mul_fp255_8x1w(t2, t3, t2);
    sqr_fp255_8x1w(t2, t2);
    for (i = 0; i < 49; i++)
        sqr_fp255_8x1w(t2, t2);
    mul_fp255_8x1w(t1, t2, t1);
    sqr_fp255_8x1w(t1, t1);
    for (i = 0; i < 4; i++)
        sqr_fp255_8x1w(t1, t1);
    mul_fp255_8x1w(r, t1, t0);
}

/**
 * @brief Copy.
 *
 * @details
 * Copy a to r.
 *
 * @param r Field element
 * @param a Field element
 */
void copy_fp255_8x1w(__m512i *r, const __m512i *a)
{
    int i;
    for (i = 0; i < NWORDS_8x1; i++) {
        r[i] = a[i];
    }
}

/**
 * Carry propagation.
 *
 * Regarding the input range:
 *  The ranges of r's limbs are [0, 2^52). In practice, these values are smaller.
 * Regarding the output range:
 *  r0 < 2^51+38, r1 < 2^51, r2 < 2^51+2, r3 < 2^51, r4 < 2^51+2.
 */
void carry_fp255_8x1w(__m512i *r)
{
    const __m512i vmask51 = VSET1(MASK51b);
    const __m512i vconstc = VSET1(CONSTC);
    __m512i temp;

    /** carry r0->r1 */
    r[1] = VADD(r[1], VSHR(r[0], RADIX_8x1));  // r1 < 2*2^51+2
    r[0] = VAND(r[0], vmask51);                // r0 < 2^51
    /** carry r2->r3 */
    r[3] = VADD(r[3], VSHR(r[2], RADIX_8x1));  // r3 < 2*2^51+2
    r[2] = VAND(r[2], vmask51);                // r2 < 2^51
    /** carry r4->r0 */
    temp = VSHR(r[4], RADIX_8x1);  // temp < 2
    temp = VMUL(temp, vconstc);    // temp < 38
    r[0] = VADD(r[0], temp);       // r0 < 2^51+38
    r[4] = VAND(r[4], vmask51);    // r4 < 2^51
    /** carry r1->r2 */
    r[2] = VADD(r[2], VSHR(r[1], RADIX_8x1));  // r2 < 2^51+2
    r[1] = VAND(r[1], vmask51);                // r1 < 2^51
    /** carry r3->r4 */
    r[4] = VADD(r[4], VSHR(r[3], RADIX_8x1));  // r4 < 2^51+2
    r[3] = VAND(r[3], vmask51);                // r3 < 2^51
}

/**
 * Perform modulo-p reduction of the operand so that it falls into the range
 * [0, 2^255-19).
 *
 * Regarding the input range:
 *  Note that, in our implementation, the input of this routine is always the output of
 *  mul_x_fp255_8x1w. r0 < 2^51+1634, r1 < 2^51, r2 < 2^51+51, r3 < 2^51, r4 < 2^51+75.
 * Regarding the output range:
 *  0 <= r < p
 */
void final_modp_fp255_8x1w(__m512i *r)
{
    int i;
    __m512i smask;
    const __m512i vpl = VSET1(LOW51b);
    const __m512i vph = VSET1(MASK51b);
    const __m512i vbmask = VSET1(MASK51b);

    /** r = r - p */
    r[0] = VSUB(r[0], vpl);
    for (i = 1; i < NWORDS_8x1; i++) {
        r[i] = VSUB(r[i], vph);
    }

    /** carry propagation */
    for (i = 0; i < NWORDS_8x1 - 1; i++) {
        r[i + 1] = VADD(r[i + 1], VSRA(r[i], RADIX_8x1));
        r[i] = VAND(r[i], vbmask);
    }

    /**
     * if r is positive, then the corresponding element in smask = 0;
     * if r is negative, then the corresponding element in smask = 0xFF...FF.
     * r = r + (p & smask), add either p or 0 to the current r
     */
    smask = VSRA(r[4], 63);
    r[0] = VADD(r[0], VAND(vpl, smask));
    for (i = 1; i < NWORDS_8x1; i++) {
        r[i] = VADD(r[i], VAND(vph, smask));
    }

    /** carry propagation */
    for (i = 0; i < NWORDS_8x1 - 1; i++) {
        r[i + 1] = VADD(r[i + 1], VSHR(r[i], RADIX_8x1));
        r[i] = VAND(r[i], vbmask);
    }

    r[4] = VAND(r[4], vbmask);
}