/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _TEDCURVE_H
#define _TEDCURVE_H

#include "gfparith_8w.h"
#include "moncurve.h"
#include "tedtable.h"

/**
 * Point in Extended Twisted Edwards Coordinates [X, Y, T, Z].
 * See "Twisted Edwards Curves Revisited" Section 3.
 * (X:Y:T:Z) corresponds to the extended affine point (X/Z,Y/Z,T/Z).
 * The auxiliary coordinates T has the property T=XY/Z.
 */
typedef struct extended_point {
    __m512i X[NWORDS_8x1];
    __m512i Y[NWORDS_8x1];
    __m512i T[NWORDS_8x1];
    __m512i Z[NWORDS_8x1];
} ExtPoint;

/**
 * [xp0 yp0 tp0 zp0 xj0 yj0 tj0 zj0]
 * [xp1 yp1 tp1 zp1 xj1 yj1 tj1 zj1]
 * [xp2 yp2 tp2 zp2 xj2 yj2 tj2 zj2]
 * [xp3 yp3 tp3 zp3 xj3 yj3 tj3 zj3]
 * [xp4 yp4 tp4 zp4 xj4 yj4 tj4 zj4]
 */
typedef ALIGN64 struct pointxytz_2x4w {
    ALIGN64 __m512i XYTZ[NWORDS_8x1];
} PointXYTZ_2x4w;

/**
 * pc: precompute
 * This structure contains two precomputed points.
 * [yq0-xq0 yq0+xq0 2dtq0 2zq0 yk0-xk0 yk0+xk0 2dtk0 2zk0]
 * [yq1-xq1 yq1+xq1 2dtq1 2zq1 yk1-xk1 yk1+xk1 2dtk1 2zk1]
 * [yq2-xq2 yq2+xq2 2dtq2 2zq2 yk2-xk2 yk2+xk2 2dtk2 2zk2]
 * [yq3-xq3 yq3+xq3 2dtq3 2zq3 yk3-xk3 yk3+xk3 2dtk3 2zk3]
 * [yq4-xq4 yq4+xq4 2dtq4 2zq4 yk4-xk4 yk4+xk4 2dtk4 2zk4]
 */
typedef ALIGN64 struct pointxytz_pc_2x4w {
    ALIGN64 __m512i subYX_addYX_2dT_2Z[NWORDS_8x1];
} PointXYTZ_pc_2x4w;

/**
 * [xp0 xp3 yp0 yp3 tp0 tp3 zp0 zp3]
 * [xp1 xp4 yp1 yp4 tp1 tp4 zp1 zp4]
 * [xp2 ??? yp3 ??? tp2 ??? zp2 ???]
 */
typedef ALIGN64 struct pointxytz_1x4w {
    ALIGN64 __m512i XYTZ[NWORDS_4x2];
} PointXYTZ_1x4w;

/**
 * pc: precompute
 * [yq0-xq0 yq3-xq3 yq0+xq0 yq3+xq3 2dtq0 2dtq3 2zq0 2zq3]
 * [yq1-xq1 yq4-xq4 yq1+xq1 yq4+xq4 2dtq1 2dtq4 2zq1 2zq4]
 * [yq2-xq2 ?       yq2+xq2 ?       2dtq2 ?     2zq2 ?   ]
 */
typedef ALIGN64 struct pointxytz_pc_1x4w {
    ALIGN64 __m512i subYX_addYX_2dT_2Z[NWORDS_4x2];
} PointXYTZ_pc_1x4w;

/**
 * X[NWORDS_8x1] =
 * [P0-x0 P1-x0 P2-x0 P3-x0 P4-x0 P5-x0 P6-x0 P7-x0]
 * [P0-x1 P1-x1 P2-x1 P3-x1 P4-x1 P5-x1 P6-x1 P7-x1]
 * ...
 * [P0-x4 P1-x4 P2-x4 P3-x4 P4-x4 P5-x4 P6-x4 P7-x4]
 */
typedef ALIGN64 struct pointxytz_8x1w {
    ALIGN64 __m512i X[NWORDS_8x1];
    ALIGN64 __m512i Y[NWORDS_8x1];
    ALIGN64 __m512i T[NWORDS_8x1];
    ALIGN64 __m512i Z[NWORDS_8x1];
} PointXYTZ_8x1w;

typedef ALIGN64 struct pointxytz_pc_8x1w {
    ALIGN64 __m512i addYX[NWORDS_8x1];
    ALIGN64 __m512i subYX[NWORDS_8x1];
    ALIGN64 __m512i _2dYX[NWORDS_8x1];
} PointXYTZ_pc_8x1w;

void ted_point_add_avx512(ExtPoint *r, ExtPoint *p, ProPoint *q);
void ted_point_dbl_avx512(ExtPoint *r, ExtPoint *p);
void ted_point_dbl_no_T_avx512(ExtPoint *r, ExtPoint *p);
void ted_mul_fixbase_avx512(ProPoint *r, const __m512i *k);

void _2x4w_mixadd(PointXYTZ_2x4w *R, const PointXYTZ_2x4w *PJ,
                  const PointXYTZ_pc_2x4w *QK);
void _2x4w_fulladd(PointXYTZ_2x4w *PJ, const PointXYTZ_2x4w *QK);
void _2x4w_doubling(PointXYTZ_2x4w *_2PJ, const PointXYTZ_2x4w *PJ);

void query_table_1x8w_ed25519(PointXYTZ_pc_8x1w *P, const uint64_t *secret_signs,
                              const uint64_t *secret_digits, const uint64_t index);
void point_multiplication_1x8w_ed25519(PointXYTZ_2x4w *R, const uint8_t *r);
void point_encoding_1x8w_ed25519(uint8_t *encP, const PointXYTZ_2x4w *P);
void double_point_mult_2x4w_ed25519(uint8_t *sA_rB, const uint8_t *s,
                                    const PointXYTZ_2x4w *AA, const uint8_t *r);
void point_decoding_2x4w_ed25519(PointXYTZ_2x4w *AA, const uint8_t *A);

void _8x1w_fulladd(PointXYTZ_8x1w *r, PointXYTZ_8x1w *p, const PointXYTZ_8x1w *q);

#endif
