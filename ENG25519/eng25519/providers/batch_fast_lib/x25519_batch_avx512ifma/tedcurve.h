/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _TEDCURVE_H
#define _TEDCURVE_H

#include "gfparith.h"
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

void ted_point_add_avx512(ExtPoint *r, ExtPoint *p, ProPoint *q);
void ted_point_dbl_avx512(ExtPoint *r, ExtPoint *p);
void ted_point_dbl_no_T_avx512(ExtPoint *r, ExtPoint *p);
void ted_mul_fixbase_avx512(ProPoint *r, const __m512i *k);

#endif
