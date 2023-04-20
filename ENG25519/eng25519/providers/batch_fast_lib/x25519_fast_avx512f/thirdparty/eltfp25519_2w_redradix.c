/**
 * Copyright 2017 Armando Faz Hernández
 * This file is part of faz_ecc_avx2.
 *
 * faz_ecc_avx2 is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * faz_ecc_avx2 is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with faz_ecc_avx2.  If not, see <http://www.gnu.org/licenses/>.
 */

/**
 * Modified by HEY.
 * Date 07/02/2019.
 * Notes:
 * 1.Unused parts are eliminated.
 * 2.The body of functions are slightly modified in order to call from the 4x2 ladder.
 * 3.__m256i is renamed as __m512i everywhere.
 * 4. times_19, sh_0, sh_1 are expanded to 8 channels.
 **/

const ALIGN vec times_19 = { 19UL, 19UL, 19UL, 19UL, 19UL, 19UL, 19UL, 19UL };
const ALIGN vec sh_0 = {  1UL,  0UL,  1UL,  0UL,  1UL,  0UL,  1UL,  0UL };
const ALIGN vec sh_1 = {  0UL,  1UL,  0UL,  1UL,  0UL,  1UL,  0UL,  1UL };

INLINE void intmul(argElement_2w c, argElement_2w a, argElement_2w b) {
	__m512i ai,aj;
	__m512i b0,b1,b2,b3,b4;
	__m512i d0,d1,d2,d3,d4;
	__m512i e0,e1,e2,e3,e4;
	__m512i c0,c1,c2,c3,c4;
	__m512i k0,k1,k2,k3,k4;
	__m512i t0,t1,t2,t3,t4;

	b0 = b[0];
	b1 = b[1];
	b2 = b[2];
	b3 = b[3];
	b4 = b[4];

	e4 = MUL(b4,times_19); d4 = ALIGNR(b4,e4);
	e3 = MUL(b3,times_19); d3 = ALIGNR(b3,e3);
	e2 = MUL(b2,times_19); d2 = ALIGNR(b2,e2);
	e1 = MUL(b1,times_19); d1 = ALIGNR(b1,e1);
	e0 = MUL(b0,times_19); d0 = ALIGNR(b0,e0);

	ai = SHUF32(a[0],0x44);  		aj = SHUF32(a[1],0x44);
	c0 = MUL(b0,ai);       			k0 = MUL(d4,aj);
	c1 = MUL(b1,ai);       			k1 = MUL(b0,aj);
	c2 = MUL(b2,ai);       			k2 = MUL(b1,aj);
	c3 = MUL(b3,ai);       			k3 = MUL(b2,aj);
	c4 = MUL(b4,ai);       			k4 = MUL(b3,aj);

	ai = SHUF32(a[2], 0x44);    	aj = SHUF32(a[3], 0x44);
	c0 = ADD(c0,MUL(d3,ai));		k0 = ADD(k0,MUL(d2,aj));
	c1 = ADD(c1,MUL(d4,ai));		k1 = ADD(k1,MUL(d3,aj));
	c2 = ADD(c2,MUL(b0,ai));		k2 = ADD(k2,MUL(d4,aj));
	c3 = ADD(c3,MUL(b1,ai));		k3 = ADD(k3,MUL(b0,aj));
	c4 = ADD(c4,MUL(b2,ai));		k4 = ADD(k4,MUL(b1,aj));

	ai = SHUF32(a[4],0x44);         aj = SHUF32(a[0],0xEE);
	c0 = ADD(c0,MUL(d1,ai));        k0 = ADD(k0,MUL(d0,aj));
	c1 = ADD(c1,MUL(d2,ai));        k1 = ADD(k1,MUL(d1,aj));
	c2 = ADD(c2,MUL(d3,ai));        k2 = ADD(k2,MUL(d2,aj));
	c3 = ADD(c3,MUL(d4,ai));        k3 = ADD(k3,MUL(d3,aj));
	c4 = ADD(c4,MUL(b0,ai));        k4 = ADD(k4,MUL(d4,aj));

	ai = SHUF32(a[1],0xEE);         aj = SHUF32(a[2],0xEE);
	c0 = ADD(c0,MUL(e4,ai));        k0 = ADD(k0,MUL(e3,aj));
	c1 = ADD(c1,MUL(d0,ai));        k1 = ADD(k1,MUL(e4,aj));
	c2 = ADD(c2,MUL(d1,ai));        k2 = ADD(k2,MUL(d0,aj));
	c3 = ADD(c3,MUL(d2,ai));        k3 = ADD(k3,MUL(d1,aj));
	c4 = ADD(c4,MUL(d3,ai));        k4 = ADD(k4,MUL(d2,aj));

	ai = SHUF32(a[3],0xEE);         aj = SHUF32(a[4],0xEE);
	c0 = ADD(c0,MUL(e2,ai));        k0 = ADD(k0,MUL(e1,aj));
	c1 = ADD(c1,MUL(e3,ai));        k1 = ADD(k1,MUL(e2,aj));
	c2 = ADD(c2,MUL(e4,ai));        k2 = ADD(k2,MUL(e3,aj));
	c3 = ADD(c3,MUL(d0,ai));        k3 = ADD(k3,MUL(e4,aj));
	c4 = ADD(c4,MUL(d1,ai));        k4 = ADD(k4,MUL(d0,aj));

	t0 = SHLV(k0,sh_0);
	t1 = SHLV(k1,sh_1);
	t2 = SHLV(k2,sh_0);
	t3 = SHLV(k3,sh_1);
	t4 = SHLV(k4,sh_0);

	c[0] = ADD(c0,t0);
	c[1] = ADD(c1,t1);
	c[2] = ADD(c2,t2);
	c[3] = ADD(c3,t3);
	c[4] = ADD(c4,t4);
}

INLINE void intsqr(argElement_2w c, argElement_2w a) {
	__m512i ai,aj,a2i,a2j;
	__m512i b0,b1,b2,b3,b4;
	__m512i d0,d1,d2,d3,d4;
	__m512i e0,e1,e2,e3,e4;
	__m512i c0,c1,c2,c3,c4;
	__m512i k0,k1,k2,k3,k4;
	__m512i t0,t1,t2,t3,t4;

	b0 = a[0];
	b1 = a[1];
	b2 = a[2];
	b3 = a[3];
	b4 = a[4];

	e4 = MUL(b4,times_19); d4 = ALIGNR(b4,e4);
	e3 = MUL(b3,times_19); d3 = ALIGNR(b3,e3);
	e2 = MUL(b2,times_19); d2 = ALIGNR(b2,e2);
	e1 = MUL(b1,times_19); d1 = ALIGNR(b1,e1);
	e0 = MUL(b0,times_19); d0 = ALIGNR(b0,e0);

	ai = SHUF32(a[0],0x44);  	    aj = SHUF32(a[1],0x44);
	a2i = ADD(ai,ai);				a2j = ADD(aj,aj);
	c0 = MUL(b0,ai);       			k0 = MUL(d4,a2j);
	c1 = MUL(b1,a2i);      			/*k1 = MUL(b0,aj);*/
	c2 = MUL(b2,a2i);      			k2 = MUL(b1,aj);
	c3 = MUL(b3,a2i);      			k3 = MUL(b2,a2j);
	c4 = MUL(b4,a2i);      			k4 = MUL(b3,a2j);

	ai = SHUF32(a[2], 0x44);    	aj = SHUF32(a[3], 0x44);
	a2i = ADD(ai,ai);				a2j = ADD(aj,aj);
	c0 = ADD(c0,MUL(d3,a2i));		/*k0 = ADD(k0, MUL(d2,aj));*/
	c1 = ADD(c1,MUL(d4,a2i));		k1 = MUL(d3,aj);
	/*c2 = ADD(c2,MUL(b0,ai));*/	k2 = ADD(k2,MUL(d4,a2j));
	/*c3 = ADD(c3,MUL(b1,ai));*/	/*k3 = ADD(k3,MUL(b0,aj));*/
	c4 = ADD(c4,MUL(b2,ai));		/*k4 = ADD(k4,MUL(b1,aj));*/

	ai = SHUF32(a[4],0x44);         aj = SHUF32(a[0],0xEE);
	a2i = ADD(ai,ai);				a2j = ADD(aj,aj);
	/*c0 = ADD(c0,MUL(d1,ai));*/    k0 = ADD(k0,MUL(d0,aj));
	/*c1 = ADD(c1,MUL(d2,ai));*/    k1 = ADD(k1,MUL(d1,a2j));
	/*c2 = ADD(c2,MUL(d3,ai));*/    k2 = ADD(k2,MUL(d2,a2j));
	c3 = ADD(c3,MUL(d4,ai));        k3 = ADD(k3,MUL(d3,a2j));
	/*c4 = ADD(c4,MUL(b0,ai));*/    k4 = ADD(k4,MUL(d4,a2j));

	ai = SHUF32(a[1],0xEE);         aj = SHUF32(a[2],0xEE);
	a2i = ADD(ai,ai);				a2j = ADD(aj,aj);
	c0 = ADD(c0,MUL(e4,a2i));       k0 = ADD(k0,MUL(e3,a2j));
	/*c1 = ADD(c1,MUL(d0,ai));*/    k1 = ADD(k1,MUL(e4,a2j));
	c2 = ADD(c2,MUL(d1,ai));        /*k2 = ADD(k2,MUL(d0,aj));*/
	c3 = ADD(c3,MUL(d2,a2i));       /*k3 = ADD(k3,MUL(d1,aj));*/
	c4 = ADD(c4,MUL(d3,a2i));       k4 = ADD(k4,MUL(d2,aj));

	ai = SHUF32(a[3],0xEE);         aj = SHUF32(a[4],0xEE);
	a2i = ADD(ai,ai);
	/*c0 = ADD(c0,MUL(e2,ai));*/    /*k0 = ADD(k0,MUL(e1,aj));*/
	c1 = ADD(c1,MUL(e3,ai));        /*k1 = ADD(k1,MUL(e2,aj));*/
	c2 = ADD(c2,MUL(e4,a2i));       /*k2 = ADD(k2,MUL(e3,aj));*/
	/*c3 = ADD(c3,MUL(d0,ai));*/    k3 = ADD(k3,MUL(e4,aj));
	/*c4 = ADD(c4,MUL(d1,ai));*/    /*k4 = ADD(k4,MUL(d0,aj));*/

	t0 = SHLV(k0,sh_0);
	t1 = SHLV(k1,sh_1);
	t2 = SHLV(k2,sh_0);
	t3 = SHLV(k3,sh_1);
	t4 = SHLV(k4,sh_0);

	c[0] = ADD(c0,t0);
	c[1] = ADD(c1,t1);
	c[2] = ADD(c2,t2);
	c[3] = ADD(c3,t3);
	c[4] = ADD(c4,t4);
}

