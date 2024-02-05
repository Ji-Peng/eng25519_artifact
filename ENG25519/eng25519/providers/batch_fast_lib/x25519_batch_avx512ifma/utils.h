/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _UTILS_H
#define _UTILS_H

#include <stdint.h>

uint32_t rand32(void);
void conv_51to64(uint64_t *r, int rlen, const uint64_t *a, int alen);
void print(const char *c, const uint64_t *a, int len);

#endif
