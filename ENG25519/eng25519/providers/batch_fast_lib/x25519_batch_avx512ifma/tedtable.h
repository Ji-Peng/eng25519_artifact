/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _TEDTABLE_H
#define _TEDTABLE_H

#include <stdint.h>

#include "gfparith.h"
#include "moncurve.h"

/**
 * 32: 256b = 32B
 * 3: three coordinates (addYX, subYX, 2dXY)
 * 8: 8 points in a sub-table
 * 32: 32 sub-tables
 */
#define SUB_TABLE_BYTES (32 * 3 * 8)
#define TABLE_BYTES (SUB_TABLE_BYTES * 32)

void lut_conv_coor2mpi51_avx512(__m512i *r, const __m512i *a);
void ted_point_query_table_avx512(ProPoint *r, const int pos, const __m512i b);

#endif
