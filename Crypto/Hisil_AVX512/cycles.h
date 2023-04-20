/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery curves
 * Version: 2019-02-13
 *
 */

unsigned long int get_cycles() {
	unsigned int low, high;
	__asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high));
	return ((unsigned long int) low) | ((unsigned long int) high << 32);
}

int compare(const void *a, const void *b) {
	double *c = (double *) a;
	double *d = (double *) b;
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

#define CYCLES(x,y,z){                                             \
	do{                                                            \
		unsigned long int start, end;                              \
		double clocks[TRIALS];                                     \
		int count;                                                 \
		for(count = 0; count < CACHE; count++){                    \
			{x};                                                   \
			{y};                                                   \
		};                                                         \
		for(count = 0; count < TRIALS; count++){                   \
			{x};                                                   \
			start = get_cycles();                                  \
			{y};                                                   \
			end = get_cycles();                                    \
			{z};                                                   \
			clocks[count] = (double)(end-start);                   \
		};                                                         \
		qsort(clocks, TRIALS, sizeof(double), compare);            \
		printf("//Cycles: Median: %.2lf\n", clocks[TRIALS/2]);     \
	}while(0);                                                     \
}
