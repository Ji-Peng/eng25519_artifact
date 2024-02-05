/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef fp255_8x1w_REDRADIX_H
#define fp255_8x1w_REDRADIX_H

#include <stdint.h>

#include "params_avx512.h"

void cswap_fp255_8x1w(__m512i *r, __m512i *a, const __m512i b);
void add_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b);
void adc_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b);
void sub_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b);
void sbc_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b);
void neg_fp255_8x1w(fe_8x1 r, const fe_8x1 b);
void mul_x_fp255_8x1w(fe_8x1 r, const fe_8x1 a, const fe_8x1 b, const uint8_t x);
#define mul_fp255_8x1w(r, a, b) mul_x_fp255_8x1w(r, a, b, 1)
#define mul_2_fp255_8x1w(r, a, b) mul_x_fp255_8x1w(r, a, b, 2)
void mul51_fp255_8x1w(__m512i *r, const __m512i *a, const uint64_t b);
void sqr_x_fp255_8x1w(__m512i *r, const __m512i *a, const uint8_t x);
// #define sqr_fp255_8x1w(r, a) sqr_x_fp255_8x1w(r, a, 1)
// #define sqr_2_fp255_8x1w(r, a) sqr_x_fp255_8x1w(r, a, 2)
#define sqr_fp255_8x1w(r, a) mul_x_fp255_8x1w(r, a, a, 1)
#define sqr_2_fp255_8x1w(r, a) mul_x_fp255_8x1w(r, a, a, 2)
void inv_fp255_8x1w(__m512i *r, const __m512i *a);
void copy_fp255_8x1w(__m512i *r, const __m512i *a);
void carry_fp255_8x1w(__m512i *r);
void final_modp_fp255_8x1w(__m512i *r);

#endif
