#include "utils.h"

#include <stdio.h>
#include <stdlib.h>  // srandom, rand
#include <string.h>

#include "gfparith.h"

/**
 * @brief Generation of a pseudo-random 32-bit integer.
 *
 * @details
 * Generates a pseudo-random 32-bit integer using the rand() function of the
 * standard C library (only used for the generation of test vectors).
 */
uint32_t rand32(void)
{
    uint32_t r;

    r = (rand() & 0x7FFF);
    r <<= 15;
    r |= (rand() & 0x7FFF);
    r <<= 15;
    r |= (rand() & 0x7FFF);

    return r;
}

void conv_51to64(uint64_t *r, int rlen, const uint64_t *a, int alen)
{
    uint64_t w0, w1, w2;
    int lbits = 51, rbits = 0, i, j = 0;

    for (i = 0; i < rlen; i++) {
        w0 = (j < alen) ? a[j] : 0;
        w1 = (j + 1 < alen) ? a[j + 1] : 0;
        w2 = (j + 2 < alen) ? a[j + 2] : 0;

        r[i] = (w1 << lbits) | (w0 >> rbits);
        if (lbits < 13) {
            r[i] |= (w2 << (64 + lbits));
        }

        rbits += 64;
        while (rbits >= 51) {
            rbits -= 51;
            j++;
        }
        lbits = 51 - rbits;
    }
}

void print(const char *c, const uint64_t *a, int len)
{
    int i;

    if ((c != NULL) && (strlen(c) > 0)) {
        printf("%s", c);
    }
    for (i = len - 1; i > 0; i--) {
        printf("%016lX", a[i]);
    }
    printf("%016lX\n", a[0]);
}