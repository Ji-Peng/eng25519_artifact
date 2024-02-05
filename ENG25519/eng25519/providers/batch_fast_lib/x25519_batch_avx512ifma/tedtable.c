/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#include "tedtable.h"

#include <stdint.h>
#include <stdio.h>

#include "gfparith.h"

extern const uint64_t multi_base_table[(32 * 3 * 8 * 32) / 8];

/**
 * @brief Convert the coordinates of LUT point to 51b format.
 *
 * @details
 * Convert the coordinate of a LUT point (4*64-bit) to 5*51-bit.
 *
 * @param r Mpi51 integer
 * @param a LUT coordinate
 */
void lut_conv_coor2mpi51_avx512(__m512i *r, const __m512i *a)
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
 * @brief Point multiplication based on the look-up table.
 *
 * @details
 * Look up the table with specifying the position to obtain the multiple of base
 * point (in Duif representation).
 *
 * @param r Point of the table in Duif representation [Y+X, Y-X, 2d*X*Y]
 * @param pos Position of the table
 * @param b Scalar (a nibble)
 */
void ted_point_query_table_avx512(ProPoint *r, const int pos, const __m512i b)
{
    const __m512i b_abs = VABS8(b);
    const __m512i zero = VZERO;
    __m512i addYX[4], subYX[4], _2dYX[4];
    const uint64_t one[4] = {1, 0, 0, 0};
    /**
     * assume that b_abs = [0 1 2 3 4 5 6 7]
     * v_index = [-1 0 1 2 3 4 5 6]
     * v_mask = [0 1 1 1 1 1 1 1]
     */
    const __m512i v_index = VSUB(b_abs, VSET1(1));
    const __mmask8 v_mask = VCMPNEQ(b_abs, zero);
    __m512i bsign, bmask, temp;
    int i;

    /**
     * if scalar == 0, the point we obtained should be [addYX=1,subYX=1,2dYX=0]
     * we will use VMZPERMV and VMXOR to process this case.
     */
    for (i = 0; i < 4; i++) {
        /**
         * (SUB_TABLE_BYTES / 8): the size of sub-table in 64b
         * 8: 8 * 64b == 512b
         * 3: three coordinates (addYX, subYX and 2dYX)
         */

        /** [1B_addYX_i 2B_addYX_i ... 8B_addYX_i] */
        addYX[i] =
            VLOAD512(&multi_base_table[pos * (SUB_TABLE_BYTES / 8) + i * 8 * 3 + 0]);
        /** [1B_subYX_i 2B_subYX_i ... 8B_subYX_i] */
        subYX[i] =
            VLOAD512(&multi_base_table[pos * (SUB_TABLE_BYTES / 8) + i * 8 * 3 + 8]);
        /** [1B_2dYX_i 2B_2dYX_i ... 8B_2dYX_i] */
        _2dYX[i] =
            VLOAD512(&multi_base_table[pos * (SUB_TABLE_BYTES / 8) + i * 8 * 3 + 16]);
        /** [0 1B_addYX_i 2B_addYX_i ... 7B_addYX_i] */
        addYX[i] = VMZPERMV(v_mask, v_index, addYX[i]);
        /** [one[i] 1B_addYX_i 2B_addYX_i ... 7B_addYX_i] */
        addYX[i] = VMXOR(addYX[i], ~v_mask, addYX[i], VSET1(one[i]));

        subYX[i] = VMZPERMV(v_mask, v_index, subYX[i]);
        subYX[i] = VMXOR(subYX[i], ~v_mask, subYX[i], VSET1(one[i]));
        _2dYX[i] = VMZPERMV(v_mask, v_index, _2dYX[i]);
        _2dYX[i] = VMXOR(_2dYX[i], ~v_mask, _2dYX[i], zero);
    }

    /**
     * if b < 0, bsign = 1
     * if b >= 0, bsign = 0
     */
    bsign = VSHR(b, 7);
    bmask = VSUB(zero, bsign);
    for (i = 0; i < 4; i++) {
        temp = VAND(VXOR(addYX[i], subYX[i]), bmask);
        addYX[i] = VXOR(addYX[i], temp);
        subYX[i] = VXOR(subYX[i], temp);
    }

    lut_conv_coor2mpi51_avx512(r->Z, _2dYX);
    copy_fp255_8x1w(r->Y, r->Z);
    neg_fp255_8x1w(r->Y, r->Y);
    cswap_fp255_8x1w(r->Z, r->Y, bsign);

    lut_conv_coor2mpi51_avx512(r->X, addYX);
    lut_conv_coor2mpi51_avx512(r->Y, subYX);
}