#ifndef _UTILS_H
#define _UTILS_H

#include <stdint.h>

uint32_t rand32(void);
void conv_51to64(uint64_t *r, int rlen, const uint64_t *a, int alen);
void print(const char *c, const uint64_t *a, int len);

#endif
