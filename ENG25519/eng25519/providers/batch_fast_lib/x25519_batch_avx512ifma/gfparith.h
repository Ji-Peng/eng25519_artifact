#ifndef _GFPARITH_H
#define _GFPARITH_H

#include <stdint.h>

#include "intrin.h"

/** radix-51 parameters and constants for High-Throughput (HT) implementations */

/** limb size */
#define RADIX_8x1 51
/** limb number */
#define NWORDS_8x1 5
/** least significant 51-bit word of p = 2^255 - 19 */
#define LOW51b 0x7FFFFFFFFFFEDULL
/** 2^51 - 1 */
#define MASK51b 0x7FFFFFFFFFFFFULL
/** p = 2^255 - 19 */
#define CONSTC 19
/** A */
#define CONSTA 486662
#define ALIGN64 __attribute__((aligned(64)))

typedef __m512i fe_8x1[NWORDS_8x1];

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
#define sqr_fp255_8x1w(r, a) sqr_x_fp255_8x1w(r, a, 1)
#define sqr_2_fp255_8x1w(r, a) sqr_x_fp255_8x1w(r, a, 2)
void inv_fp255_8x1w(__m512i *r, const __m512i *a);
void copy_fp255_8x1w(__m512i *r, const __m512i *a);
void carry_fp255_8x1w(__m512i *r);
void final_modp_fp255_8x1w(__m512i *r);

#endif
