/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef fp255_1w_fullradix_H
#define fp255_1w_fullradix_H

#include "params.h"

void add_fp255_1w_fullradix(uint64_t* c, uint64_t* a, uint64_t* b);
int cmp_fp255_1w_fullradix(uint64_t* a, uint64_t* b);
void cmv_fp255_1w_fullradix(int bit, uint64_t* c, uint64_t* a, uint64_t* b);
void inv_fp255_1w_fullradix(uint64_t* c, uint64_t* a);
void invsqrt_fp255_1w_fullradix(uint64_t* uv_p38, uint64_t* u, uint64_t* v);
void neg_fp255_1w_fullradix(uint64_t* c);
void reduce256bits(uint64_t* a);
void reduce64bits(uint64_t* a);
void calculate_s_ed25519(uint8_t* s_mod_l, uint8_t* r, uint8_t* k, const uint8_t* a);
void modular_reduction_ed25519(uint8_t* a);
void word64_multiplier(uint64_t* C, const uint64_t* A, const int numA, const uint64_t* B,
                       const int numB);

#endif