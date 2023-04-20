/*
 * Copyright 2016-2022 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

/*
 * ECDSA low level APIs are deprecated for public use, but still ok for
 * internal use.
 */
#include "openssl_curve25519.h"

#include <openssl/evp.h>
#include <openssl/sha.h>
#include <string.h>

static uint64_t load_8(const uint8_t *in)
{
    uint64_t result;

    result = in[0];
    result |= ((uint64_t)in[1]) << 8;
    result |= ((uint64_t)in[2]) << 16;
    result |= ((uint64_t)in[3]) << 24;
    result |= ((uint64_t)in[4]) << 32;
    result |= ((uint64_t)in[5]) << 40;
    result |= ((uint64_t)in[6]) << 48;
    result |= ((uint64_t)in[7]) << 56;

    return result;
}

static void fe64_frombytes(fe64 h, const uint8_t *s)
{
    h[0] = load_8(s);
    h[1] = load_8(s + 8);
    h[2] = load_8(s + 16);
    h[3] = load_8(s + 24) & 0x7fffffffffffffff;
}

static void fe64_0(fe64 h)
{
    h[0] = 0;
    h[1] = 0;
    h[2] = 0;
    h[3] = 0;
}

static void fe64_1(fe64 h)
{
    h[0] = 1;
    h[1] = 0;
    h[2] = 0;
    h[3] = 0;
}

void fe64_copy(fe64 h, const fe64 f)
{
    h[0] = f[0];
    h[1] = f[1];
    h[2] = f[2];
    h[3] = f[3];
}

static void fe64_cswap(fe64 f, fe64 g, unsigned int b)
{
    int i;
    uint64_t mask = 0 - (uint64_t)b;

    for (i = 0; i < 4; i++) {
        uint64_t x = f[i] ^ g[i];
        x &= mask;
        f[i] ^= x;
        g[i] ^= x;
    }
}

void fe64_invert(fe64 out, const fe64 z)
{
    fe64 t0;
    fe64 t1;
    fe64 t2;
    fe64 t3;
    int i;

    /*
     * Compute z ** -1 = z ** (2 ** 255 - 19 - 2) with the exponent as
     * 2 ** 255 - 21 = (2 ** 5) * (2 ** 250 - 1) + 11.
     */

    /* t0 = z ** 2 */
    fe64_sqr(t0, z);

    /* t1 = t0 ** (2 ** 2) = z ** 8 */
    fe64_sqr(t1, t0);
    fe64_sqr(t1, t1);

    /* t1 = z * t1 = z ** 9 */
    fe64_mul(t1, z, t1);
    /* t0 = t0 * t1 = z ** 11 -- stash t0 away for the end. */
    fe64_mul(t0, t0, t1);

    /* t2 = t0 ** 2 = z ** 22 */
    fe64_sqr(t2, t0);

    /* t1 = t1 * t2 = z ** (2 ** 5 - 1) */
    fe64_mul(t1, t1, t2);

    /* t2 = t1 ** (2 ** 5) = z ** ((2 ** 5) * (2 ** 5 - 1)) */
    fe64_sqr(t2, t1);
    for (i = 1; i < 5; ++i)
        fe64_sqr(t2, t2);

    /* t1 = t1 * t2 = z ** ((2 ** 5 + 1) * (2 ** 5 - 1)) = z ** (2 ** 10 - 1) */
    fe64_mul(t1, t2, t1);

    /* Continuing similarly... */

    /* t2 = z ** (2 ** 20 - 1) */
    fe64_sqr(t2, t1);
    for (i = 1; i < 10; ++i)
        fe64_sqr(t2, t2);

    fe64_mul(t2, t2, t1);

    /* t2 = z ** (2 ** 40 - 1) */
    fe64_sqr(t3, t2);
    for (i = 1; i < 20; ++i)
        fe64_sqr(t3, t3);

    fe64_mul(t2, t3, t2);

    /* t2 = z ** (2 ** 10) * (2 ** 40 - 1) */
    for (i = 0; i < 10; ++i)
        fe64_sqr(t2, t2);

    /* t1 = z ** (2 ** 50 - 1) */
    fe64_mul(t1, t2, t1);

    /* t2 = z ** (2 ** 100 - 1) */
    fe64_sqr(t2, t1);
    for (i = 1; i < 50; ++i)
        fe64_sqr(t2, t2);

    fe64_mul(t2, t2, t1);

    /* t2 = z ** (2 ** 200 - 1) */
    fe64_sqr(t3, t2);
    for (i = 1; i < 100; ++i)
        fe64_sqr(t3, t3);

    fe64_mul(t2, t3, t2);

    /* t2 = z ** ((2 ** 50) * (2 ** 200 - 1) */
    for (i = 0; i < 50; ++i)
        fe64_sqr(t2, t2);

    /* t1 = z ** (2 ** 250 - 1) */
    fe64_mul(t1, t2, t1);

    /* t1 = z ** ((2 ** 5) * (2 ** 250 - 1)) */
    for (i = 0; i < 5; ++i)
        fe64_sqr(t1, t1);

    /* Recall t0 = z ** 11; out = z ** (2 ** 255 - 21) */
    fe64_mul(out, t1, t0);
}

/*
 * Duplicate of original x25519_scalar_mult_generic, but using
 * fe64_* subroutines.
 */
static void x25519_scalar_mulx(uint8_t out[32], const uint8_t scalar[32],
                               const uint8_t point[32])
{
    fe64 x1, x2, z2, x3, z3, tmp0, tmp1;
    uint8_t e[32];
    unsigned swap = 0;
    int pos;

    memcpy(e, scalar, 32);
    e[0] &= 0xf8;
    e[31] &= 0x7f;
    e[31] |= 0x40;
    fe64_frombytes(x1, point);
    fe64_1(x2);
    fe64_0(z2);
    fe64_copy(x3, x1);
    fe64_1(z3);

    for (pos = 254; pos >= 0; --pos) {
        unsigned int b = 1 & (e[pos / 8] >> (pos & 7));

        swap ^= b;
        fe64_cswap(x2, x3, swap);
        fe64_cswap(z2, z3, swap);
        swap = b;
        fe64_sub(tmp0, x3, z3);
        fe64_sub(tmp1, x2, z2);
        fe64_add(x2, x2, z2);
        fe64_add(z2, x3, z3);
        fe64_mul(z3, x2, tmp0);
        fe64_mul(z2, z2, tmp1);
        fe64_sqr(tmp0, tmp1);
        fe64_sqr(tmp1, x2);
        fe64_add(x3, z3, z2);
        fe64_sub(z2, z3, z2);
        fe64_mul(x2, tmp1, tmp0);
        fe64_sub(tmp1, tmp1, tmp0);
        fe64_sqr(z2, z2);
        fe64_mul121666(z3, tmp1);
        fe64_sqr(x3, x3);
        fe64_add(tmp0, tmp0, z3);
        fe64_mul(z3, x1, z2);
        fe64_mul(z2, tmp1, tmp0);
    }

    fe64_invert(z2, z2);
    fe64_mul(x2, x2, z2);
    fe64_tobytes(out, x2);

    OPENSSL_cleanse(e, sizeof(e));
}

int ossl_x25519(uint8_t out_shared_key[32], const uint8_t private_key[32],
                const uint8_t peer_public_value[32])
{
    static const uint8_t kZeros[32] = {0};
    x25519_scalar_mulx(out_shared_key, private_key, peer_public_value);
    /* The all-zero output results when the input is a point of small order. */
    return CRYPTO_memcmp(kZeros, out_shared_key, 32) != 0;
}
