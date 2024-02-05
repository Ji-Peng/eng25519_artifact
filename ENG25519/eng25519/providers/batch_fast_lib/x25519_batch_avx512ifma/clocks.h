/**
 * Copyright (c) 2024 Jipeng Zhang (jp-zhang@outlook.com)
 *
 * This source code is licensed under the GNU Lesser General Public License
 * found in the license file in the root directory of this source tree.
 */

#ifndef _CLOCKS_H_
#define _CLOCKS_H_

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef __INTEL_COMPILER
#    define BARRIER __memory_barrier()
#else
#    define BARRIER __asm__ __volatile__("" ::: "memory")
#endif

#define CLOCKS_RANDOM(RANDOM, LABEL, FUNCTION, NUMBER)                                \
    do {                                                                              \
        uint64_t start, end;                                                          \
        int64_t i_bench, j_bench;                                                     \
        unsigned cycles_high0, cycles_low0;                                           \
        unsigned cycles_high1, cycles_low1;                                           \
        /** Load the caches */                                                        \
        for (i_bench = 0; i_bench < NUMBER * 10; i_bench++)                           \
            FUNCTION;                                                                 \
        __asm__ __volatile__(                                                         \
            "mfence\n\t"                                                              \
            "RDTSC\n\t"                                                               \
            "mov %%edx, %0\n\t"                                                       \
            "mov %%eax, %1\n\t"                                                       \
            : "=r"(cycles_high0), "=r"(cycles_low0)::"%rax", "%rbx", "%rcx", "%rdx"); \
        BARRIER;                                                                      \
        i_bench = NUMBER;                                                             \
        do {                                                                          \
            j_bench = NUMBER;                                                         \
            RANDOM;                                                                   \
            do {                                                                      \
                FUNCTION;                                                             \
                j_bench--;                                                            \
            } while (j_bench != 0);                                                   \
            i_bench--;                                                                \
        } while (i_bench != 0);                                                       \
        BARRIER;                                                                      \
        __asm__ __volatile__(                                                         \
            "RDTSCP\n\t"                                                              \
            "mov %%edx, %0\n\t"                                                       \
            "mov %%eax, %1\n\t"                                                       \
            "mfence\n\t"                                                              \
            : "=r"(cycles_high1), "=r"(cycles_low1)::"%rax", "%rbx", "%rcx", "%rdx"); \
        start = (((uint64_t)cycles_high0) << 32) | cycles_low0;                       \
        end = (((uint64_t)cycles_high1) << 32) | cycles_low1;                         \
        printf("%-25s= %6lu cc\n", #LABEL, (end - start) / (NUMBER * NUMBER));        \
    } while (0)

#define CLOCKS(LABEL, FUNCTION, NUMBER) CLOCKS_RANDOM(while (0), LABEL, FUNCTION, NUMBER)

#define oper_second(RANDOM, LABEL, FUNCTION, NUMBER)             \
    do {                                                         \
        printf("%-25s : ", #LABEL);                              \
        RANDOM;                                                  \
                                                                 \
        unsigned i;                                              \
        uint64_t start, end;                                     \
        const unsigned iterations = NUMBER;                      \
        uint64_t start_c, end_c;                                 \
                                                                 \
        /* Load the caches*/                                     \
        for (i = 0; i < NUMBER / 10; ++i) {                      \
            FUNCTION;                                            \
        }                                                        \
                                                                 \
        start = time_now();                                      \
        start_c = cycles_now();                                  \
        for (i = 0; i < iterations; ++i) {                       \
            FUNCTION;                                            \
        }                                                        \
        end = time_now();                                        \
        end_c = cycles_now();                                    \
                                                                 \
        printf("%3lu µs, %8.1f oper/s, %6lu cycles/op\n",        \
               (unsigned long)((end - start) / iterations),      \
               iterations*(double)1e6 / (end - start),           \
               (unsigned long)((end_c - start_c) / iterations)); \
    } while (0)

#define oper_second_n(RANDOM, LABEL, FUNCTION, NUMBER, PARALLEL) \
    do {                                                         \
        printf("%-25s : ", #LABEL);                              \
        RANDOM;                                                  \
                                                                 \
        unsigned i;                                              \
        uint64_t start, end;                                     \
        const unsigned iterations = NUMBER;                      \
        uint64_t start_c, end_c;                                 \
                                                                 \
        /* Load the caches*/                                     \
        for (i = 0; i < NUMBER / 10; ++i) {                      \
            FUNCTION;                                            \
        }                                                        \
                                                                 \
        start = time_now();                                      \
        start_c = cycles_now();                                  \
        for (i = 0; i < iterations; ++i) {                       \
            FUNCTION;                                            \
        }                                                        \
        end = time_now();                                        \
        end_c = cycles_now();                                    \
                                                                 \
        printf("%3lu µs, %8.1f oper/s, %6lu cycles/op\n",        \
               (unsigned long)((end - start) / iterations),      \
               PARALLEL* iterations*(double)1e6 / (end - start), \
               (unsigned long)((end_c - start_c) / iterations)); \
    } while (0)

uint64_t time_now();
uint64_t cycles_now(void);

/* _CLOCKS_H_ */
#endif
