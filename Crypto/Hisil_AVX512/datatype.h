/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery curves
 * Version: 2019-02-13
 *
 */

#include <immintrin.h>

#ifndef ALIGN
#define ALIGN __attribute__ ((aligned (32)))
//#define ALIGN
#endif

#ifndef INLINE
#define INLINE static inline
//#define INLINE
#endif

#define NLIMB 5

typedef unsigned long int u64;

typedef __m512i vec;

typedef struct {
	u64 v[4];
} gfe64;

typedef struct {
	u64 v[NLIMB*2];
} gfe;


#define p25519_0(c) (0x3FFFFEDUL * c)
#define p25519_1(c) (0x1FFFFFFUL * c)
#define p25519_2(c) (0x3FFFFFFUL * c)
#define p25519_3(c) (0x1FFFFFFUL * c)
#define p25519_4(c) (0x3FFFFFFUL * c)
#define p25519_5(c) (0x1FFFFFFUL * c)
#define p25519_6(c) (0x3FFFFFFUL * c)
#define p25519_7(c) (0x1FFFFFFUL * c)
#define p25519_8(c) (0x3FFFFFFUL * c)
#define p25519_9(c) (0x1FFFFFFUL * c)

void set_base(vec *z, const gfe *a, const gfe *b);
void set_vector(vec *z, const gfe *a);
void reduce_unique(gfe *z);
void get_channel(gfe *z, const vec *a, const int ch);
void gfe64_pack(gfe64 *z, const gfe *a);
void char_to_gfe(gfe *z, const unsigned char a[32]);
