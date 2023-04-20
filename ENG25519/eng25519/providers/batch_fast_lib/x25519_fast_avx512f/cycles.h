/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery
 * curves Version: 2019-02-13
 *
 */
#include <time.h>
unsigned long int get_cycles()
{
    unsigned int low, high;
    __asm__ __volatile__("rdtsc" : "=a"(low), "=d"(high));
    return ((unsigned long int)low) | ((unsigned long int)high << 32);
}

int compare(const void *a, const void *b)
{
    double *c = (double *)a;
    double *d = (double *)b;
    if (*c < *d) {
        return -1;
    }
    if (*c > *d) {
        return 1;
    }
    return 0;
}

#define CACHE 2000
#define TRIALS 200000

#define CYCLES(x, y, z)                                                \
    {                                                                  \
        do {                                                           \
            unsigned long int start, end;                              \
            clock_t start_time, end_time;                              \
            double tp, times = 0.0;                                    \
            double clocks[TRIALS];                                     \
            int count;                                                 \
            for (count = 0; count < CACHE; count++) {                  \
                {x};                                                   \
                {y};                                                   \
            };                                                         \
            for (count = 0; count < TRIALS; count++) {                 \
                {x};                                                   \
                start_time = clock();                                  \
                start = get_cycles();                                  \
                {y};                                                   \
                end = get_cycles();                                    \
                end_time = clock();                                    \
                {z};                                                   \
                times += (double)(end_time - start_time);              \
                clocks[count] = (double)(end - start);                 \
            };                                                         \
            qsort(clocks, TRIALS, sizeof(double), compare);            \
            tp = 1e6 * TRIALS / times;                                 \
            printf("  - Cycles: Median: %.2lf\n", clocks[TRIALS / 2]); \
            printf("  - Throughput: %8.1f op/sec\n", tp);              \
        } while (0);                                                   \
    }
