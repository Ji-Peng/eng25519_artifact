/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _MONCURVE_H
#define _MONCURVE_H

#include "gfparith_8w.h"

/** projective points with coordinates [X, Y, Z] */
typedef struct projective_point {
    __m512i X[NWORDS_8x1];
    __m512i Y[NWORDS_8x1];
    __m512i Z[NWORDS_8x1];
} ProPoint;

void mon_ladder_step_avx512(ProPoint *p, ProPoint *q, const __m512i *xd);
void mon_mul_var_base_avx512(__m512i *r, const __m512i *k, const __m512i *x);
void mon_mul_fixed_base_x25519_avx512(__m512i *r, const __m512i *k);
void mon_mul_fixed_base_ed25519_avx512(uint8_t *r, const __m512i *k);

#endif
