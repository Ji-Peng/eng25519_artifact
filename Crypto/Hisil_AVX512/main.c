/*
 * This file is in public domain.
 *
 * Authors: Huseyin Hisil, Berkan Egrice, Mert Yassi
 * Title:   Fast 4 way vectorized ladder for the complete set of Montgomery curves
 * Version: 2019-02-13
 *
 */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#include "cycles.h"
#include "datatype.h"
#include "montgomery.h"
#include "clocks.h"

#define SPEED
//#define CHECK
//#define MAGMA

#ifdef SPEED
int main()
{
	const unsigned char A[32] = {
		0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	unsigned char k[32], q[32], p[32], r = 0;
	int i, seed;

	seed = (int)time(NULL);
	srandom(seed);

	printf("\n//avx512-5limb-4x2 scalar_mult_var_base() speed test...\n\n");
	fflush(stdout);
	// Change scalar. Do clamping as in curve25519.
	for (i = 0; i < 32; i++)
	{
		k[i] = (unsigned char)random();
	}
	k[0] &= 248;
	k[31] &= 127;
	k[31] |= 64;
	// Change base point.
	for (i = 0; i < 32; i++)
	{
		p[i] = (unsigned char)random();
	}
	p[31] &= 127;

	// Just measure variable-point variable-scalar multiplication.
	// scalar_mult_var_base(q, k, p, A);

	oper_second_n(while (0), scalar_mult_var_base, scalar_mult_var_base(q, k, p, A), 20000, 1);

	return 0;
}
#endif

#ifdef CHECK
void print_scalar(char *str, const unsigned char *n)
{
	int i;
	printf("%s:=", str);
	for (i = 0; i < 32; i++)
	{
		printf("+(2^8)^%d*(%u)", i, n[i]);
	}
	printf("; printf \"\\n%s : \%\%o\",%s;\n\n", str, str);
}

void print_point(char *str, const unsigned char *n)
{
	int i;
	printf("F:=GF(2^255-19); B:=2^29; ");
	printf("%s:=", str);
	for (i = 0; i < 32; i++)
	{
		printf("+(2^8)^%d*(%u)", i, n[i]);
	}
	printf("; printf \"\\n%s : \%\%o\",F!%s;\n\n", str, str);
}

int main()
{
	const unsigned char A[32] = {
		0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	unsigned char bp[32], k1[32], k2[32], op1[32], op2[32], op3[32], op4[32];
	int seed, i, j;

	seed = (int)time(NULL);
	srandom(seed);

	printf("\n//Running DH Verifications with session seed %d:\n\n", seed);
	for (j = 0; j < 100000; j++)
	{

		// Do clamping as in curve25519.
		for (i = 0; i < 32; i++)
		{
			k1[i] = (unsigned char)random();
		}
		k1[0] &= 248;
		k1[31] &= 127;
		k1[31] |= 64;
		for (i = 0; i < 32; i++)
		{
			k2[i] = (unsigned char)random();
		}
		k2[0] &= 248;
		k2[31] &= 127;
		k2[31] |= 64;
		for (i = 0; i < 32; i++)
		{
			bp[i] = (unsigned char)random();
		}
		bp[31] &= 127;

		scalar_mult_var_base(op1, k1, bp, A);
		scalar_mult_var_base(op2, k2, bp, A);
		scalar_mult_var_base(op3, k1, op2, A);
		scalar_mult_var_base(op4, k2, op1, A);

		for (i = 0; i < 32; i++)
		{
			if (op3[i] != op4[i])
			{
				printf("//DH check failed (seed %d, iteration %d):\n", seed, j);
				printf("\n\nclear; Fp:=GF(2^255-19);\n");
				printf("E:=EllipticCurve([0,Fp!486662,0,1,0]);\n\n");
				print_point("bp", bp);
				print_scalar("k1", k1);
				print_scalar("k2", k2);
				print_point("op1", op1);
				print_point("op2", op2);
				print_point("op3", op3);
				print_point("op4", op4);
				return 1;
			}
		}
		if ((j % 10000) == 0)
		{
			printf("Test passed : [k1]*([k2]*P) = [k2]*([k1]*P). Iterations: %d\n", j);
			fflush(stdout);
		}
	}
	printf("\n\nAll tests passed.\n\n");

	return 0;
}
#endif

#ifdef MAGMA
int main()
{
	const unsigned char A[32] = {
		0x06, 0x6D, 0x07, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
		0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
	unsigned char bp[32] = {
		0x86, 0x4F, 0xCA, 0x0A, 0x0B, 0x0B, 0x65, 0x3B,
		0xA7, 0x57, 0xCA, 0xC0, 0xBF, 0x08, 0x3E, 0x00,
		0xDA, 0xD1, 0x22, 0xF6, 0xDD, 0x5E, 0x5B, 0xE5,
		0x6C, 0x29, 0xB6, 0x78, 0x70, 0x6F, 0x41, 0x70};
	unsigned char op1[32], k1[32];
	int i, j, seed;

	seed = (int)time(NULL);
	srandom(seed);

	fprintf(stdout, "\n\nclear; Fp:=GF(2^255-19);\n");
	fprintf(stdout, "E:=EllipticCurve([0,Fp!486662,0,1,0]);\n");
	fprintf(stdout, "res:=true;\n");
	for (j = 0; j < 100; j++)
	{

		// Do clamping as in curve25519.
		for (i = 0; i < 32; i++)
		{
			k1[i] = (unsigned char)random();
		}
		k1[0] &= 248;
		k1[31] &= 127;
		k1[31] |= 64;

		scalar_mult_var_base(op1, k1, bp, A);

		fprintf(stdout, "k:=");
		for (i = 0; i < 32; i++)
		{
			fprintf(stdout, "+%hhu*256^%d", k1[i], i);
		}
		fprintf(stdout, ";\nx0:=Fp!(");
		for (i = 0; i < 32; i++)
		{
			fprintf(stdout, "+%hhu*256^%d", bp[i], i);
		}
		fprintf(stdout, ");\nx1:=Fp!(");
		for (i = 0; i < 32; i++)
		{
			fprintf(stdout, "+%hhu*256^%d", op1[i], i);
		}
		fprintf(stdout, ");");
		fprintf(stdout, "P:=Points(E,x0)[1]; ");
		fprintf(stdout, "res:=res and (x1 eq (k*P)[1]);\n");
	}
	fprintf(stdout, "res;\n");
	fflush(stdout);
	return 0;
}
#endif
