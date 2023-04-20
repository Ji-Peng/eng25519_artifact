(*
cv -v -disable_safety mul_x_fp255_8x1w.cl
Parsing CryptoLine file:		        [OK]		0.006309 seconds
Checking well-formedness:		        [OK]		0.002912 seconds
Transforming to SSA form:		        [OK]		0.001602 seconds
Normalizing specification:		      [OK]		0.001632 seconds
Rewriting assignments:			        [OK]		0.001086 seconds
Verifying range assertions:		      [OK]		717.492779 seconds
Verifying range specification:		  [OK]		0.000286 seconds
Rewriting value-preserved casting:	[OK]		0.001376 seconds
Verifying algebraic assertions:		  [OK]		0.153428 seconds
Verifying algebraic specification:	[OK]		0.000063 seconds
Verification result:			          [OK]		717.663531 seconds
*)

proc main (uint64 a00, uint64 a10, uint64 a20, uint64 a30, uint64 a40, uint64 a50, uint64 a60, uint64 a70,
           uint64 a01, uint64 a11, uint64 a21, uint64 a31, uint64 a41, uint64 a51, uint64 a61, uint64 a71,
           uint64 a02, uint64 a12, uint64 a22, uint64 a32, uint64 a42, uint64 a52, uint64 a62, uint64 a72,
           uint64 a03, uint64 a13, uint64 a23, uint64 a33, uint64 a43, uint64 a53, uint64 a63, uint64 a73,
           uint64 a04, uint64 a14, uint64 a24, uint64 a34, uint64 a44, uint64 a54, uint64 a64, uint64 a74,
           uint64 b00, uint64 b10, uint64 b20, uint64 b30, uint64 b40, uint64 b50, uint64 b60, uint64 b70,
           uint64 b01, uint64 b11, uint64 b21, uint64 b31, uint64 b41, uint64 b51, uint64 b61, uint64 b71,
           uint64 b02, uint64 b12, uint64 b22, uint64 b32, uint64 b42, uint64 b52, uint64 b62, uint64 b72,
           uint64 b03, uint64 b13, uint64 b23, uint64 b33, uint64 b43, uint64 b53, uint64 b63, uint64 b73,
           uint64 b04, uint64 b14, uint64 b24, uint64 b34, uint64 b44, uint64 b54, uint64 b64, uint64 b74,
           uint64 c00, uint64 c10, uint64 c20, uint64 c30, uint64 c40, uint64 c50, uint64 c60, uint64 c70,
           uint64 c01, uint64 c11, uint64 c21, uint64 c31, uint64 c41, uint64 c51, uint64 c61, uint64 c71,
           uint64 c02, uint64 c12, uint64 c22, uint64 c32, uint64 c42, uint64 c52, uint64 c62, uint64 c72,
           uint64 c03, uint64 c13, uint64 c23, uint64 c33, uint64 c43, uint64 c53, uint64 c63, uint64 c73,
           uint64 c04, uint64 c14, uint64 c24, uint64 c34, uint64 c44, uint64 c54, uint64 c64, uint64 c74,
           uint268 p) =
{
  and [
    p = 0x007fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed
  ]
  &&
  and [
        p = 0x07fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed@268,
        a00 <=u 0xfffffffffffff@64, a01 <=u 0xfffffffffffff@64, a02 <=u 0xfffffffffffff@64, a03 <=u 0xfffffffffffff@64, a04 <=u 0xfffffffffffff@64, 
        a10 <=u 0xfffffffffffff@64, a11 <=u 0xfffffffffffff@64, a12 <=u 0xfffffffffffff@64, a13 <=u 0xfffffffffffff@64, a14 <=u 0xfffffffffffff@64, 
        a20 <=u 0xfffffffffffff@64, a21 <=u 0xfffffffffffff@64, a22 <=u 0xfffffffffffff@64, a23 <=u 0xfffffffffffff@64, a24 <=u 0xfffffffffffff@64, 
        a30 <=u 0xfffffffffffff@64, a31 <=u 0xfffffffffffff@64, a32 <=u 0xfffffffffffff@64, a33 <=u 0xfffffffffffff@64, a34 <=u 0xfffffffffffff@64, 
        a40 <=u 0xfffffffffffff@64, a41 <=u 0xfffffffffffff@64, a42 <=u 0xfffffffffffff@64, a43 <=u 0xfffffffffffff@64, a44 <=u 0xfffffffffffff@64, 
        a50 <=u 0xfffffffffffff@64, a51 <=u 0xfffffffffffff@64, a52 <=u 0xfffffffffffff@64, a53 <=u 0xfffffffffffff@64, a54 <=u 0xfffffffffffff@64,
        a60 <=u 0xfffffffffffff@64, a61 <=u 0xfffffffffffff@64, a62 <=u 0xfffffffffffff@64, a63 <=u 0xfffffffffffff@64, a64 <=u 0xfffffffffffff@64,
        a70 <=u 0xfffffffffffff@64, a71 <=u 0xfffffffffffff@64, a72 <=u 0xfffffffffffff@64, a73 <=u 0xfffffffffffff@64, a74 <=u 0xfffffffffffff@64, 
        b00 <=u 0xfffffffffffff@64, b01 <=u 0xfffffffffffff@64, b02 <=u 0xfffffffffffff@64, b03 <=u 0xfffffffffffff@64, b04 <=u 0xfffffffffffff@64, 
        b10 <=u 0xfffffffffffff@64, b11 <=u 0xfffffffffffff@64, b12 <=u 0xfffffffffffff@64, b13 <=u 0xfffffffffffff@64, b14 <=u 0xfffffffffffff@64, 
        b20 <=u 0xfffffffffffff@64, b21 <=u 0xfffffffffffff@64, b22 <=u 0xfffffffffffff@64, b23 <=u 0xfffffffffffff@64, b24 <=u 0xfffffffffffff@64, 
        b30 <=u 0xfffffffffffff@64, b31 <=u 0xfffffffffffff@64, b32 <=u 0xfffffffffffff@64, b33 <=u 0xfffffffffffff@64, b34 <=u 0xfffffffffffff@64, 
        b40 <=u 0xfffffffffffff@64, b41 <=u 0xfffffffffffff@64, b42 <=u 0xfffffffffffff@64, b43 <=u 0xfffffffffffff@64, b44 <=u 0xfffffffffffff@64, 
        b50 <=u 0xfffffffffffff@64, b51 <=u 0xfffffffffffff@64, b52 <=u 0xfffffffffffff@64, b53 <=u 0xfffffffffffff@64, b54 <=u 0xfffffffffffff@64,
        b60 <=u 0xfffffffffffff@64, b61 <=u 0xfffffffffffff@64, b62 <=u 0xfffffffffffff@64, b63 <=u 0xfffffffffffff@64, b64 <=u 0xfffffffffffff@64,
        b70 <=u 0xfffffffffffff@64, b71 <=u 0xfffffffffffff@64, b72 <=u 0xfffffffffffff@64, b73 <=u 0xfffffffffffff@64, b74 <=u 0xfffffffffffff@64
      ]
}

mov L0x55555556a100 0x13@uint64;
mov L0x55555556a140 0x7ffffffffffff@uint64;
mov L0x55555556a148 0x7ffffffffffff@uint64;
mov L0x55555556a150 0x7ffffffffffff@uint64;
mov L0x55555556a158 0x7ffffffffffff@uint64;
mov L0x55555556a160 0x7ffffffffffff@uint64;
mov L0x55555556a168 0x7ffffffffffff@uint64;
mov L0x55555556a170 0x7ffffffffffff@uint64;
mov L0x55555556a178 0x7ffffffffffff@uint64;
mov L0x55555556a180 0x169@uint64;
mov L0x55555556a188 0x169@uint64;
mov L0x55555556a190 0x169@uint64;
mov L0x55555556a198 0x169@uint64;
mov L0x55555556a1a0 0x169@uint64;
mov L0x55555556a1a8 0x169@uint64;
mov L0x55555556a1b0 0x169@uint64;
mov L0x55555556a1b8 0x169@uint64;
mov L0x7fffffffd500 a00;
mov L0x7fffffffd508 a10;
mov L0x7fffffffd510 a20;
mov L0x7fffffffd518 a30;
mov L0x7fffffffd520 a40;
mov L0x7fffffffd528 a50;
mov L0x7fffffffd530 a60;
mov L0x7fffffffd538 a70;
mov L0x7fffffffd540 a01;
mov L0x7fffffffd548 a11;
mov L0x7fffffffd550 a21;
mov L0x7fffffffd558 a31;
mov L0x7fffffffd560 a41;
mov L0x7fffffffd568 a51;
mov L0x7fffffffd570 a61;
mov L0x7fffffffd578 a71;
mov L0x7fffffffd580 a02;
mov L0x7fffffffd588 a12;
mov L0x7fffffffd590 a22;
mov L0x7fffffffd598 a32;
mov L0x7fffffffd5a0 a42;
mov L0x7fffffffd5a8 a52;
mov L0x7fffffffd5b0 a62;
mov L0x7fffffffd5b8 a72;
mov L0x7fffffffd5c0 a03;
mov L0x7fffffffd5c8 a13;
mov L0x7fffffffd5d0 a23;
mov L0x7fffffffd5d8 a33;
mov L0x7fffffffd5e0 a43;
mov L0x7fffffffd5e8 a53;
mov L0x7fffffffd5f0 a63;
mov L0x7fffffffd5f8 a73;
mov L0x7fffffffd600 a04;
mov L0x7fffffffd608 a14;
mov L0x7fffffffd610 a24;
mov L0x7fffffffd618 a34;
mov L0x7fffffffd620 a44;
mov L0x7fffffffd628 a54;
mov L0x7fffffffd630 a64;
mov L0x7fffffffd638 a74;
mov L0x7fffffffd640 b00;
mov L0x7fffffffd648 b10;
mov L0x7fffffffd650 b20;
mov L0x7fffffffd658 b30;
mov L0x7fffffffd660 b40;
mov L0x7fffffffd668 b50;
mov L0x7fffffffd670 b60;
mov L0x7fffffffd678 b70;
mov L0x7fffffffd680 b01;
mov L0x7fffffffd688 b11;
mov L0x7fffffffd690 b21;
mov L0x7fffffffd698 b31;
mov L0x7fffffffd6a0 b41;
mov L0x7fffffffd6a8 b51;
mov L0x7fffffffd6b0 b61;
mov L0x7fffffffd6b8 b71;
mov L0x7fffffffd6c0 b02;
mov L0x7fffffffd6c8 b12;
mov L0x7fffffffd6d0 b22;
mov L0x7fffffffd6d8 b32;
mov L0x7fffffffd6e0 b42;
mov L0x7fffffffd6e8 b52;
mov L0x7fffffffd6f0 b62;
mov L0x7fffffffd6f8 b72;
mov L0x7fffffffd700 b03;
mov L0x7fffffffd708 b13;
mov L0x7fffffffd710 b23;
mov L0x7fffffffd718 b33;
mov L0x7fffffffd720 b43;
mov L0x7fffffffd728 b53;
mov L0x7fffffffd730 b63;
mov L0x7fffffffd738 b73;
mov L0x7fffffffd740 b04;
mov L0x7fffffffd748 b14;
mov L0x7fffffffd750 b24;
mov L0x7fffffffd758 b34;
mov L0x7fffffffd760 b44;
mov L0x7fffffffd768 b54;
mov L0x7fffffffd770 b64;
mov L0x7fffffffd778 b74;

(* #! -> SP = 0x7fffffffd4b8 *)
#! 0x7fffffffd4b8 = 0x7fffffffd4b8;
(* vmovdqa64 0xc0(%rdx),%zmm7                      #! EA = L0x7fffffffd700; Value = 0x0000004000000000; PC = 0x555555556444 *)
mov zmm7_000 L0x7fffffffd700;
mov zmm7_001 L0x7fffffffd708;
mov zmm7_010 L0x7fffffffd710;
mov zmm7_011 L0x7fffffffd718;
mov zmm7_100 L0x7fffffffd720;
mov zmm7_101 L0x7fffffffd728;
mov zmm7_110 L0x7fffffffd730;
mov zmm7_111 L0x7fffffffd738;
(* vmovdqa64 (%rsi),%zmm16                         #! EA = L0x7fffffffd500; Value = 0x00007fffffffd610; PC = 0x55555555644b *)
mov zmm16_000 L0x7fffffffd500;
mov zmm16_001 L0x7fffffffd508;
mov zmm16_010 L0x7fffffffd510;
mov zmm16_011 L0x7fffffffd518;
mov zmm16_100 L0x7fffffffd520;
mov zmm16_101 L0x7fffffffd528;
mov zmm16_110 L0x7fffffffd530;
mov zmm16_111 L0x7fffffffd538;
(* vpxor  %zmm2,%zmm2,%zmm2                        #! PC = 0x555555556451 *)
mov zmm2_000 0@uint64;
mov zmm2_001 0@uint64;
mov zmm2_010 0@uint64;
mov zmm2_011 0@uint64;
mov zmm2_100 0@uint64;
mov zmm2_101 0@uint64;
mov zmm2_110 0@uint64;
mov zmm2_111 0@uint64;
(* vmovdqa64 %zmm2,%zmm1                           #! PC = 0x555555556455 *)
mov zmm1_000 zmm2_000;
mov zmm1_001 zmm2_001;
mov zmm1_010 zmm2_010;
mov zmm1_011 zmm2_011;
mov zmm1_100 zmm2_100;
mov zmm1_101 zmm2_101;
mov zmm1_110 zmm2_110;
mov zmm1_111 zmm2_111;
(* vpmadd52huq %zmm7,%zmm16,%zmm1                  #! PC = 0x55555555645b *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm16_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm16_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm16_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm16_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm16_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm16_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm16_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm16_111 <u 0x10000000000000@64
];
umulj zmm7_zmm16_000F zmm7_000 zmm16_000; spl zmm7_zmm16_000h_t zmm7_zmm16_000l_t zmm7_zmm16_000F 52;
umulj zmm7_zmm16_001F zmm7_001 zmm16_001; spl zmm7_zmm16_001h_t zmm7_zmm16_001l_t zmm7_zmm16_001F 52;
umulj zmm7_zmm16_010F zmm7_010 zmm16_010; spl zmm7_zmm16_010h_t zmm7_zmm16_010l_t zmm7_zmm16_010F 52;
umulj zmm7_zmm16_011F zmm7_011 zmm16_011; spl zmm7_zmm16_011h_t zmm7_zmm16_011l_t zmm7_zmm16_011F 52;
umulj zmm7_zmm16_100F zmm7_100 zmm16_100; spl zmm7_zmm16_100h_t zmm7_zmm16_100l_t zmm7_zmm16_100F 52;
umulj zmm7_zmm16_101F zmm7_101 zmm16_101; spl zmm7_zmm16_101h_t zmm7_zmm16_101l_t zmm7_zmm16_101F 52;
umulj zmm7_zmm16_110F zmm7_110 zmm16_110; spl zmm7_zmm16_110h_t zmm7_zmm16_110l_t zmm7_zmm16_110F 52;
umulj zmm7_zmm16_111F zmm7_111 zmm16_111; spl zmm7_zmm16_111h_t zmm7_zmm16_111l_t zmm7_zmm16_111F 52;
vpc zmm7_zmm16_000h_t@uint64 zmm7_zmm16_000h_t; vpc zmm7_zmm16_000l_t@uint64 zmm7_zmm16_000l_t;
vpc zmm7_zmm16_001h_t@uint64 zmm7_zmm16_001h_t; vpc zmm7_zmm16_001l_t@uint64 zmm7_zmm16_001l_t;
vpc zmm7_zmm16_010h_t@uint64 zmm7_zmm16_010h_t; vpc zmm7_zmm16_010l_t@uint64 zmm7_zmm16_010l_t;
vpc zmm7_zmm16_011h_t@uint64 zmm7_zmm16_011h_t; vpc zmm7_zmm16_011l_t@uint64 zmm7_zmm16_011l_t;
vpc zmm7_zmm16_100h_t@uint64 zmm7_zmm16_100h_t; vpc zmm7_zmm16_100l_t@uint64 zmm7_zmm16_100l_t;
vpc zmm7_zmm16_101h_t@uint64 zmm7_zmm16_101h_t; vpc zmm7_zmm16_101l_t@uint64 zmm7_zmm16_101l_t;
vpc zmm7_zmm16_110h_t@uint64 zmm7_zmm16_110h_t; vpc zmm7_zmm16_110l_t@uint64 zmm7_zmm16_110l_t;
vpc zmm7_zmm16_111h_t@uint64 zmm7_zmm16_111h_t; vpc zmm7_zmm16_111l_t@uint64 zmm7_zmm16_111l_t;
add zmm1_000 zmm1_000 zmm7_zmm16_000h_t;
add zmm1_001 zmm1_001 zmm7_zmm16_001h_t;
add zmm1_010 zmm1_010 zmm7_zmm16_010h_t;
add zmm1_011 zmm1_011 zmm7_zmm16_011h_t;
add zmm1_100 zmm1_100 zmm7_zmm16_100h_t;
add zmm1_101 zmm1_101 zmm7_zmm16_101h_t;
add zmm1_110 zmm1_110 zmm7_zmm16_110h_t;
add zmm1_111 zmm1_111 zmm7_zmm16_111h_t;
(* vmovdqa64 0x40(%rsi),%zmm14                     #! EA = L0x7fffffffd540; Value = 0x0000000000000009; PC = 0x555555556461 *)
mov zmm14_000 L0x7fffffffd540;
mov zmm14_001 L0x7fffffffd548;
mov zmm14_010 L0x7fffffffd550;
mov zmm14_011 L0x7fffffffd558;
mov zmm14_100 L0x7fffffffd560;
mov zmm14_101 L0x7fffffffd568;
mov zmm14_110 L0x7fffffffd570;
mov zmm14_111 L0x7fffffffd578;
(* vmovdqa64 0x80(%rdx),%zmm10                     #! EA = L0x7fffffffd6c0; Value = 0x0000000000000000; PC = 0x555555556468 *)
mov zmm10_000 L0x7fffffffd6c0;
mov zmm10_001 L0x7fffffffd6c8;
mov zmm10_010 L0x7fffffffd6d0;
mov zmm10_011 L0x7fffffffd6d8;
mov zmm10_100 L0x7fffffffd6e0;
mov zmm10_101 L0x7fffffffd6e8;
mov zmm10_110 L0x7fffffffd6f0;
mov zmm10_111 L0x7fffffffd6f8;
(* vmovdqa64 0x40(%rdx),%zmm13                     #! EA = L0x7fffffffd680; Value = 0x3d52455355007473; PC = 0x55555555646f *)
mov zmm13_000 L0x7fffffffd680;
mov zmm13_001 L0x7fffffffd688;
mov zmm13_010 L0x7fffffffd690;
mov zmm13_011 L0x7fffffffd698;
mov zmm13_100 L0x7fffffffd6a0;
mov zmm13_101 L0x7fffffffd6a8;
mov zmm13_110 L0x7fffffffd6b0;
mov zmm13_111 L0x7fffffffd6b8;
(* vmovdqa64 0x80(%rsi),%zmm12                     #! EA = L0x7fffffffd580; Value = 0x0000000000000000; PC = 0x555555556476 *)
mov zmm12_000 L0x7fffffffd580;
mov zmm12_001 L0x7fffffffd588;
mov zmm12_010 L0x7fffffffd590;
mov zmm12_011 L0x7fffffffd598;
mov zmm12_100 L0x7fffffffd5a0;
mov zmm12_101 L0x7fffffffd5a8;
mov zmm12_110 L0x7fffffffd5b0;
mov zmm12_111 L0x7fffffffd5b8;
(* vpmadd52huq %zmm10,%zmm14,%zmm1                 #! PC = 0x55555555647d *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm14_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm14_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm14_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm14_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm14_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm14_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm14_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm14_111 <u 0x10000000000000@64
];
umulj zmm10_zmm14_000F zmm10_000 zmm14_000; spl zmm10_zmm14_000h_t zmm10_zmm14_000l_t zmm10_zmm14_000F 52;
umulj zmm10_zmm14_001F zmm10_001 zmm14_001; spl zmm10_zmm14_001h_t zmm10_zmm14_001l_t zmm10_zmm14_001F 52;
umulj zmm10_zmm14_010F zmm10_010 zmm14_010; spl zmm10_zmm14_010h_t zmm10_zmm14_010l_t zmm10_zmm14_010F 52;
umulj zmm10_zmm14_011F zmm10_011 zmm14_011; spl zmm10_zmm14_011h_t zmm10_zmm14_011l_t zmm10_zmm14_011F 52;
umulj zmm10_zmm14_100F zmm10_100 zmm14_100; spl zmm10_zmm14_100h_t zmm10_zmm14_100l_t zmm10_zmm14_100F 52;
umulj zmm10_zmm14_101F zmm10_101 zmm14_101; spl zmm10_zmm14_101h_t zmm10_zmm14_101l_t zmm10_zmm14_101F 52;
umulj zmm10_zmm14_110F zmm10_110 zmm14_110; spl zmm10_zmm14_110h_t zmm10_zmm14_110l_t zmm10_zmm14_110F 52;
umulj zmm10_zmm14_111F zmm10_111 zmm14_111; spl zmm10_zmm14_111h_t zmm10_zmm14_111l_t zmm10_zmm14_111F 52;
vpc zmm10_zmm14_000h_t@uint64 zmm10_zmm14_000h_t; vpc zmm10_zmm14_000l_t@uint64 zmm10_zmm14_000l_t;
vpc zmm10_zmm14_001h_t@uint64 zmm10_zmm14_001h_t; vpc zmm10_zmm14_001l_t@uint64 zmm10_zmm14_001l_t;
vpc zmm10_zmm14_010h_t@uint64 zmm10_zmm14_010h_t; vpc zmm10_zmm14_010l_t@uint64 zmm10_zmm14_010l_t;
vpc zmm10_zmm14_011h_t@uint64 zmm10_zmm14_011h_t; vpc zmm10_zmm14_011l_t@uint64 zmm10_zmm14_011l_t;
vpc zmm10_zmm14_100h_t@uint64 zmm10_zmm14_100h_t; vpc zmm10_zmm14_100l_t@uint64 zmm10_zmm14_100l_t;
vpc zmm10_zmm14_101h_t@uint64 zmm10_zmm14_101h_t; vpc zmm10_zmm14_101l_t@uint64 zmm10_zmm14_101l_t;
vpc zmm10_zmm14_110h_t@uint64 zmm10_zmm14_110h_t; vpc zmm10_zmm14_110l_t@uint64 zmm10_zmm14_110l_t;
vpc zmm10_zmm14_111h_t@uint64 zmm10_zmm14_111h_t; vpc zmm10_zmm14_111l_t@uint64 zmm10_zmm14_111l_t;
add zmm1_000 zmm1_000 zmm10_zmm14_000h_t;
add zmm1_001 zmm1_001 zmm10_zmm14_001h_t;
add zmm1_010 zmm1_010 zmm10_zmm14_010h_t;
add zmm1_011 zmm1_011 zmm10_zmm14_011h_t;
add zmm1_100 zmm1_100 zmm10_zmm14_100h_t;
add zmm1_101 zmm1_101 zmm10_zmm14_101h_t;
add zmm1_110 zmm1_110 zmm10_zmm14_110h_t;
add zmm1_111 zmm1_111 zmm10_zmm14_111h_t;
(* vmovdqa64 %zmm2,%zmm4                           #! PC = 0x555555556483 *)
mov zmm4_000 zmm2_000;
mov zmm4_001 zmm2_001;
mov zmm4_010 zmm2_010;
mov zmm4_011 zmm2_011;
mov zmm4_100 zmm2_100;
mov zmm4_101 zmm2_101;
mov zmm4_110 zmm2_110;
mov zmm4_111 zmm2_111;
(* vpmadd52huq %zmm10,%zmm16,%zmm4                 #! PC = 0x555555556489 *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm16_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm16_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm16_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm16_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm16_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm16_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm16_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm16_111 <u 0x10000000000000@64
];
umulj zmm10_zmm16_000F zmm10_000 zmm16_000; spl zmm10_zmm16_000h_t zmm10_zmm16_000l_t zmm10_zmm16_000F 52;
umulj zmm10_zmm16_001F zmm10_001 zmm16_001; spl zmm10_zmm16_001h_t zmm10_zmm16_001l_t zmm10_zmm16_001F 52;
umulj zmm10_zmm16_010F zmm10_010 zmm16_010; spl zmm10_zmm16_010h_t zmm10_zmm16_010l_t zmm10_zmm16_010F 52;
umulj zmm10_zmm16_011F zmm10_011 zmm16_011; spl zmm10_zmm16_011h_t zmm10_zmm16_011l_t zmm10_zmm16_011F 52;
umulj zmm10_zmm16_100F zmm10_100 zmm16_100; spl zmm10_zmm16_100h_t zmm10_zmm16_100l_t zmm10_zmm16_100F 52;
umulj zmm10_zmm16_101F zmm10_101 zmm16_101; spl zmm10_zmm16_101h_t zmm10_zmm16_101l_t zmm10_zmm16_101F 52;
umulj zmm10_zmm16_110F zmm10_110 zmm16_110; spl zmm10_zmm16_110h_t zmm10_zmm16_110l_t zmm10_zmm16_110F 52;
umulj zmm10_zmm16_111F zmm10_111 zmm16_111; spl zmm10_zmm16_111h_t zmm10_zmm16_111l_t zmm10_zmm16_111F 52;
vpc zmm10_zmm16_000h_t@uint64 zmm10_zmm16_000h_t; vpc zmm10_zmm16_000l_t@uint64 zmm10_zmm16_000l_t;
vpc zmm10_zmm16_001h_t@uint64 zmm10_zmm16_001h_t; vpc zmm10_zmm16_001l_t@uint64 zmm10_zmm16_001l_t;
vpc zmm10_zmm16_010h_t@uint64 zmm10_zmm16_010h_t; vpc zmm10_zmm16_010l_t@uint64 zmm10_zmm16_010l_t;
vpc zmm10_zmm16_011h_t@uint64 zmm10_zmm16_011h_t; vpc zmm10_zmm16_011l_t@uint64 zmm10_zmm16_011l_t;
vpc zmm10_zmm16_100h_t@uint64 zmm10_zmm16_100h_t; vpc zmm10_zmm16_100l_t@uint64 zmm10_zmm16_100l_t;
vpc zmm10_zmm16_101h_t@uint64 zmm10_zmm16_101h_t; vpc zmm10_zmm16_101l_t@uint64 zmm10_zmm16_101l_t;
vpc zmm10_zmm16_110h_t@uint64 zmm10_zmm16_110h_t; vpc zmm10_zmm16_110l_t@uint64 zmm10_zmm16_110l_t;
vpc zmm10_zmm16_111h_t@uint64 zmm10_zmm16_111h_t; vpc zmm10_zmm16_111l_t@uint64 zmm10_zmm16_111l_t;
add zmm4_000 zmm4_000 zmm10_zmm16_000h_t;
add zmm4_001 zmm4_001 zmm10_zmm16_001h_t;
add zmm4_010 zmm4_010 zmm10_zmm16_010h_t;
add zmm4_011 zmm4_011 zmm10_zmm16_011h_t;
add zmm4_100 zmm4_100 zmm10_zmm16_100h_t;
add zmm4_101 zmm4_101 zmm10_zmm16_101h_t;
add zmm4_110 zmm4_110 zmm10_zmm16_110h_t;
add zmm4_111 zmm4_111 zmm10_zmm16_111h_t;
(* vmovdqa64 (%rdx),%zmm5                          #! EA = L0x7fffffffd640; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x55555555648f *)
mov zmm5_000 L0x7fffffffd640;
mov zmm5_001 L0x7fffffffd648;
mov zmm5_010 L0x7fffffffd650;
mov zmm5_011 L0x7fffffffd658;
mov zmm5_100 L0x7fffffffd660;
mov zmm5_101 L0x7fffffffd668;
mov zmm5_110 L0x7fffffffd670;
mov zmm5_111 L0x7fffffffd678;
(* vmovdqa64 0xc0(%rsi),%zmm8                      #! EA = L0x7fffffffd5c0; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x555555556495 *)
mov zmm8_000 L0x7fffffffd5c0;
mov zmm8_001 L0x7fffffffd5c8;
mov zmm8_010 L0x7fffffffd5d0;
mov zmm8_011 L0x7fffffffd5d8;
mov zmm8_100 L0x7fffffffd5e0;
mov zmm8_101 L0x7fffffffd5e8;
mov zmm8_110 L0x7fffffffd5f0;
mov zmm8_111 L0x7fffffffd5f8;
(* vpmadd52huq %zmm13,%zmm12,%zmm1                 #! PC = 0x55555555649c *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm13_zmm12_000F zmm13_000 zmm12_000; spl zmm13_zmm12_000h_t zmm13_zmm12_000l_t zmm13_zmm12_000F 52;
umulj zmm13_zmm12_001F zmm13_001 zmm12_001; spl zmm13_zmm12_001h_t zmm13_zmm12_001l_t zmm13_zmm12_001F 52;
umulj zmm13_zmm12_010F zmm13_010 zmm12_010; spl zmm13_zmm12_010h_t zmm13_zmm12_010l_t zmm13_zmm12_010F 52;
umulj zmm13_zmm12_011F zmm13_011 zmm12_011; spl zmm13_zmm12_011h_t zmm13_zmm12_011l_t zmm13_zmm12_011F 52;
umulj zmm13_zmm12_100F zmm13_100 zmm12_100; spl zmm13_zmm12_100h_t zmm13_zmm12_100l_t zmm13_zmm12_100F 52;
umulj zmm13_zmm12_101F zmm13_101 zmm12_101; spl zmm13_zmm12_101h_t zmm13_zmm12_101l_t zmm13_zmm12_101F 52;
umulj zmm13_zmm12_110F zmm13_110 zmm12_110; spl zmm13_zmm12_110h_t zmm13_zmm12_110l_t zmm13_zmm12_110F 52;
umulj zmm13_zmm12_111F zmm13_111 zmm12_111; spl zmm13_zmm12_111h_t zmm13_zmm12_111l_t zmm13_zmm12_111F 52;
vpc zmm13_zmm12_000h_t@uint64 zmm13_zmm12_000h_t; vpc zmm13_zmm12_000l_t@uint64 zmm13_zmm12_000l_t;
vpc zmm13_zmm12_001h_t@uint64 zmm13_zmm12_001h_t; vpc zmm13_zmm12_001l_t@uint64 zmm13_zmm12_001l_t;
vpc zmm13_zmm12_010h_t@uint64 zmm13_zmm12_010h_t; vpc zmm13_zmm12_010l_t@uint64 zmm13_zmm12_010l_t;
vpc zmm13_zmm12_011h_t@uint64 zmm13_zmm12_011h_t; vpc zmm13_zmm12_011l_t@uint64 zmm13_zmm12_011l_t;
vpc zmm13_zmm12_100h_t@uint64 zmm13_zmm12_100h_t; vpc zmm13_zmm12_100l_t@uint64 zmm13_zmm12_100l_t;
vpc zmm13_zmm12_101h_t@uint64 zmm13_zmm12_101h_t; vpc zmm13_zmm12_101l_t@uint64 zmm13_zmm12_101l_t;
vpc zmm13_zmm12_110h_t@uint64 zmm13_zmm12_110h_t; vpc zmm13_zmm12_110l_t@uint64 zmm13_zmm12_110l_t;
vpc zmm13_zmm12_111h_t@uint64 zmm13_zmm12_111h_t; vpc zmm13_zmm12_111l_t@uint64 zmm13_zmm12_111l_t;
add zmm1_000 zmm1_000 zmm13_zmm12_000h_t;
add zmm1_001 zmm1_001 zmm13_zmm12_001h_t;
add zmm1_010 zmm1_010 zmm13_zmm12_010h_t;
add zmm1_011 zmm1_011 zmm13_zmm12_011h_t;
add zmm1_100 zmm1_100 zmm13_zmm12_100h_t;
add zmm1_101 zmm1_101 zmm13_zmm12_101h_t;
add zmm1_110 zmm1_110 zmm13_zmm12_110h_t;
add zmm1_111 zmm1_111 zmm13_zmm12_111h_t;
(* vmovdqa64 0x100(%rdx),%zmm11                    #! EA = L0x7fffffffd740; Value = 0x0000000000000002; PC = 0x5555555564a2 *)
mov zmm11_000 L0x7fffffffd740;
mov zmm11_001 L0x7fffffffd748;
mov zmm11_010 L0x7fffffffd750;
mov zmm11_011 L0x7fffffffd758;
mov zmm11_100 L0x7fffffffd760;
mov zmm11_101 L0x7fffffffd768;
mov zmm11_110 L0x7fffffffd770;
mov zmm11_111 L0x7fffffffd778;
(* vpmadd52huq %zmm13,%zmm14,%zmm4                 #! PC = 0x5555555564a9 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm14_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm14_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm14_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm14_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm14_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm14_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm14_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm14_111 <u 0x10000000000000@64
];
umulj zmm13_zmm14_000F zmm13_000 zmm14_000; spl zmm13_zmm14_000h_t zmm13_zmm14_000l_t zmm13_zmm14_000F 52;
umulj zmm13_zmm14_001F zmm13_001 zmm14_001; spl zmm13_zmm14_001h_t zmm13_zmm14_001l_t zmm13_zmm14_001F 52;
umulj zmm13_zmm14_010F zmm13_010 zmm14_010; spl zmm13_zmm14_010h_t zmm13_zmm14_010l_t zmm13_zmm14_010F 52;
umulj zmm13_zmm14_011F zmm13_011 zmm14_011; spl zmm13_zmm14_011h_t zmm13_zmm14_011l_t zmm13_zmm14_011F 52;
umulj zmm13_zmm14_100F zmm13_100 zmm14_100; spl zmm13_zmm14_100h_t zmm13_zmm14_100l_t zmm13_zmm14_100F 52;
umulj zmm13_zmm14_101F zmm13_101 zmm14_101; spl zmm13_zmm14_101h_t zmm13_zmm14_101l_t zmm13_zmm14_101F 52;
umulj zmm13_zmm14_110F zmm13_110 zmm14_110; spl zmm13_zmm14_110h_t zmm13_zmm14_110l_t zmm13_zmm14_110F 52;
umulj zmm13_zmm14_111F zmm13_111 zmm14_111; spl zmm13_zmm14_111h_t zmm13_zmm14_111l_t zmm13_zmm14_111F 52;
vpc zmm13_zmm14_000h_t@uint64 zmm13_zmm14_000h_t; vpc zmm13_zmm14_000l_t@uint64 zmm13_zmm14_000l_t;
vpc zmm13_zmm14_001h_t@uint64 zmm13_zmm14_001h_t; vpc zmm13_zmm14_001l_t@uint64 zmm13_zmm14_001l_t;
vpc zmm13_zmm14_010h_t@uint64 zmm13_zmm14_010h_t; vpc zmm13_zmm14_010l_t@uint64 zmm13_zmm14_010l_t;
vpc zmm13_zmm14_011h_t@uint64 zmm13_zmm14_011h_t; vpc zmm13_zmm14_011l_t@uint64 zmm13_zmm14_011l_t;
vpc zmm13_zmm14_100h_t@uint64 zmm13_zmm14_100h_t; vpc zmm13_zmm14_100l_t@uint64 zmm13_zmm14_100l_t;
vpc zmm13_zmm14_101h_t@uint64 zmm13_zmm14_101h_t; vpc zmm13_zmm14_101l_t@uint64 zmm13_zmm14_101l_t;
vpc zmm13_zmm14_110h_t@uint64 zmm13_zmm14_110h_t; vpc zmm13_zmm14_110l_t@uint64 zmm13_zmm14_110l_t;
vpc zmm13_zmm14_111h_t@uint64 zmm13_zmm14_111h_t; vpc zmm13_zmm14_111l_t@uint64 zmm13_zmm14_111l_t;
add zmm4_000 zmm4_000 zmm13_zmm14_000h_t;
add zmm4_001 zmm4_001 zmm13_zmm14_001h_t;
add zmm4_010 zmm4_010 zmm13_zmm14_010h_t;
add zmm4_011 zmm4_011 zmm13_zmm14_011h_t;
add zmm4_100 zmm4_100 zmm13_zmm14_100h_t;
add zmm4_101 zmm4_101 zmm13_zmm14_101h_t;
add zmm4_110 zmm4_110 zmm13_zmm14_110h_t;
add zmm4_111 zmm4_111 zmm13_zmm14_111h_t;
(* vmovdqa64 %zmm2,%zmm3                           #! PC = 0x5555555564af *)
mov zmm3_000 zmm2_000;
mov zmm3_001 zmm2_001;
mov zmm3_010 zmm2_010;
mov zmm3_011 zmm2_011;
mov zmm3_100 zmm2_100;
mov zmm3_101 zmm2_101;
mov zmm3_110 zmm2_110;
mov zmm3_111 zmm2_111;
(* vpmadd52huq %zmm13,%zmm16,%zmm3                 #! PC = 0x5555555564b5 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm16_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm16_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm16_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm16_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm16_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm16_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm16_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm16_111 <u 0x10000000000000@64
];
umulj zmm13_zmm16_000F zmm13_000 zmm16_000; spl zmm13_zmm16_000h_t zmm13_zmm16_000l_t zmm13_zmm16_000F 52;
umulj zmm13_zmm16_001F zmm13_001 zmm16_001; spl zmm13_zmm16_001h_t zmm13_zmm16_001l_t zmm13_zmm16_001F 52;
umulj zmm13_zmm16_010F zmm13_010 zmm16_010; spl zmm13_zmm16_010h_t zmm13_zmm16_010l_t zmm13_zmm16_010F 52;
umulj zmm13_zmm16_011F zmm13_011 zmm16_011; spl zmm13_zmm16_011h_t zmm13_zmm16_011l_t zmm13_zmm16_011F 52;
umulj zmm13_zmm16_100F zmm13_100 zmm16_100; spl zmm13_zmm16_100h_t zmm13_zmm16_100l_t zmm13_zmm16_100F 52;
umulj zmm13_zmm16_101F zmm13_101 zmm16_101; spl zmm13_zmm16_101h_t zmm13_zmm16_101l_t zmm13_zmm16_101F 52;
umulj zmm13_zmm16_110F zmm13_110 zmm16_110; spl zmm13_zmm16_110h_t zmm13_zmm16_110l_t zmm13_zmm16_110F 52;
umulj zmm13_zmm16_111F zmm13_111 zmm16_111; spl zmm13_zmm16_111h_t zmm13_zmm16_111l_t zmm13_zmm16_111F 52;
vpc zmm13_zmm16_000h_t@uint64 zmm13_zmm16_000h_t; vpc zmm13_zmm16_000l_t@uint64 zmm13_zmm16_000l_t;
vpc zmm13_zmm16_001h_t@uint64 zmm13_zmm16_001h_t; vpc zmm13_zmm16_001l_t@uint64 zmm13_zmm16_001l_t;
vpc zmm13_zmm16_010h_t@uint64 zmm13_zmm16_010h_t; vpc zmm13_zmm16_010l_t@uint64 zmm13_zmm16_010l_t;
vpc zmm13_zmm16_011h_t@uint64 zmm13_zmm16_011h_t; vpc zmm13_zmm16_011l_t@uint64 zmm13_zmm16_011l_t;
vpc zmm13_zmm16_100h_t@uint64 zmm13_zmm16_100h_t; vpc zmm13_zmm16_100l_t@uint64 zmm13_zmm16_100l_t;
vpc zmm13_zmm16_101h_t@uint64 zmm13_zmm16_101h_t; vpc zmm13_zmm16_101l_t@uint64 zmm13_zmm16_101l_t;
vpc zmm13_zmm16_110h_t@uint64 zmm13_zmm16_110h_t; vpc zmm13_zmm16_110l_t@uint64 zmm13_zmm16_110l_t;
vpc zmm13_zmm16_111h_t@uint64 zmm13_zmm16_111h_t; vpc zmm13_zmm16_111l_t@uint64 zmm13_zmm16_111l_t;
add zmm3_000 zmm3_000 zmm13_zmm16_000h_t;
add zmm3_001 zmm3_001 zmm13_zmm16_001h_t;
add zmm3_010 zmm3_010 zmm13_zmm16_010h_t;
add zmm3_011 zmm3_011 zmm13_zmm16_011h_t;
add zmm3_100 zmm3_100 zmm13_zmm16_100h_t;
add zmm3_101 zmm3_101 zmm13_zmm16_101h_t;
add zmm3_110 zmm3_110 zmm13_zmm16_110h_t;
add zmm3_111 zmm3_111 zmm13_zmm16_111h_t;
(* vpmadd52huq %zmm5,%zmm8,%zmm1                   #! PC = 0x5555555564bb *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm5_zmm8_000F zmm5_000 zmm8_000; spl zmm5_zmm8_000h_t zmm5_zmm8_000l_t zmm5_zmm8_000F 52;
umulj zmm5_zmm8_001F zmm5_001 zmm8_001; spl zmm5_zmm8_001h_t zmm5_zmm8_001l_t zmm5_zmm8_001F 52;
umulj zmm5_zmm8_010F zmm5_010 zmm8_010; spl zmm5_zmm8_010h_t zmm5_zmm8_010l_t zmm5_zmm8_010F 52;
umulj zmm5_zmm8_011F zmm5_011 zmm8_011; spl zmm5_zmm8_011h_t zmm5_zmm8_011l_t zmm5_zmm8_011F 52;
umulj zmm5_zmm8_100F zmm5_100 zmm8_100; spl zmm5_zmm8_100h_t zmm5_zmm8_100l_t zmm5_zmm8_100F 52;
umulj zmm5_zmm8_101F zmm5_101 zmm8_101; spl zmm5_zmm8_101h_t zmm5_zmm8_101l_t zmm5_zmm8_101F 52;
umulj zmm5_zmm8_110F zmm5_110 zmm8_110; spl zmm5_zmm8_110h_t zmm5_zmm8_110l_t zmm5_zmm8_110F 52;
umulj zmm5_zmm8_111F zmm5_111 zmm8_111; spl zmm5_zmm8_111h_t zmm5_zmm8_111l_t zmm5_zmm8_111F 52;
vpc zmm5_zmm8_000h_t@uint64 zmm5_zmm8_000h_t; vpc zmm5_zmm8_000l_t@uint64 zmm5_zmm8_000l_t;
vpc zmm5_zmm8_001h_t@uint64 zmm5_zmm8_001h_t; vpc zmm5_zmm8_001l_t@uint64 zmm5_zmm8_001l_t;
vpc zmm5_zmm8_010h_t@uint64 zmm5_zmm8_010h_t; vpc zmm5_zmm8_010l_t@uint64 zmm5_zmm8_010l_t;
vpc zmm5_zmm8_011h_t@uint64 zmm5_zmm8_011h_t; vpc zmm5_zmm8_011l_t@uint64 zmm5_zmm8_011l_t;
vpc zmm5_zmm8_100h_t@uint64 zmm5_zmm8_100h_t; vpc zmm5_zmm8_100l_t@uint64 zmm5_zmm8_100l_t;
vpc zmm5_zmm8_101h_t@uint64 zmm5_zmm8_101h_t; vpc zmm5_zmm8_101l_t@uint64 zmm5_zmm8_101l_t;
vpc zmm5_zmm8_110h_t@uint64 zmm5_zmm8_110h_t; vpc zmm5_zmm8_110l_t@uint64 zmm5_zmm8_110l_t;
vpc zmm5_zmm8_111h_t@uint64 zmm5_zmm8_111h_t; vpc zmm5_zmm8_111l_t@uint64 zmm5_zmm8_111l_t;
add zmm1_000 zmm1_000 zmm5_zmm8_000h_t;
add zmm1_001 zmm1_001 zmm5_zmm8_001h_t;
add zmm1_010 zmm1_010 zmm5_zmm8_010h_t;
add zmm1_011 zmm1_011 zmm5_zmm8_011h_t;
add zmm1_100 zmm1_100 zmm5_zmm8_100h_t;
add zmm1_101 zmm1_101 zmm5_zmm8_101h_t;
add zmm1_110 zmm1_110 zmm5_zmm8_110h_t;
add zmm1_111 zmm1_111 zmm5_zmm8_111h_t;
(* vmovdqa64 %zmm2,%zmm9                           #! PC = 0x5555555564c1 *)
mov zmm9_000 zmm2_000;
mov zmm9_001 zmm2_001;
mov zmm9_010 zmm2_010;
mov zmm9_011 zmm2_011;
mov zmm9_100 zmm2_100;
mov zmm9_101 zmm2_101;
mov zmm9_110 zmm2_110;
mov zmm9_111 zmm2_111;
(* vpmadd52huq %zmm5,%zmm12,%zmm4                  #! PC = 0x5555555564c7 *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm5_zmm12_000F zmm5_000 zmm12_000; spl zmm5_zmm12_000h_t zmm5_zmm12_000l_t zmm5_zmm12_000F 52;
umulj zmm5_zmm12_001F zmm5_001 zmm12_001; spl zmm5_zmm12_001h_t zmm5_zmm12_001l_t zmm5_zmm12_001F 52;
umulj zmm5_zmm12_010F zmm5_010 zmm12_010; spl zmm5_zmm12_010h_t zmm5_zmm12_010l_t zmm5_zmm12_010F 52;
umulj zmm5_zmm12_011F zmm5_011 zmm12_011; spl zmm5_zmm12_011h_t zmm5_zmm12_011l_t zmm5_zmm12_011F 52;
umulj zmm5_zmm12_100F zmm5_100 zmm12_100; spl zmm5_zmm12_100h_t zmm5_zmm12_100l_t zmm5_zmm12_100F 52;
umulj zmm5_zmm12_101F zmm5_101 zmm12_101; spl zmm5_zmm12_101h_t zmm5_zmm12_101l_t zmm5_zmm12_101F 52;
umulj zmm5_zmm12_110F zmm5_110 zmm12_110; spl zmm5_zmm12_110h_t zmm5_zmm12_110l_t zmm5_zmm12_110F 52;
umulj zmm5_zmm12_111F zmm5_111 zmm12_111; spl zmm5_zmm12_111h_t zmm5_zmm12_111l_t zmm5_zmm12_111F 52;
vpc zmm5_zmm12_000h_t@uint64 zmm5_zmm12_000h_t; vpc zmm5_zmm12_000l_t@uint64 zmm5_zmm12_000l_t;
vpc zmm5_zmm12_001h_t@uint64 zmm5_zmm12_001h_t; vpc zmm5_zmm12_001l_t@uint64 zmm5_zmm12_001l_t;
vpc zmm5_zmm12_010h_t@uint64 zmm5_zmm12_010h_t; vpc zmm5_zmm12_010l_t@uint64 zmm5_zmm12_010l_t;
vpc zmm5_zmm12_011h_t@uint64 zmm5_zmm12_011h_t; vpc zmm5_zmm12_011l_t@uint64 zmm5_zmm12_011l_t;
vpc zmm5_zmm12_100h_t@uint64 zmm5_zmm12_100h_t; vpc zmm5_zmm12_100l_t@uint64 zmm5_zmm12_100l_t;
vpc zmm5_zmm12_101h_t@uint64 zmm5_zmm12_101h_t; vpc zmm5_zmm12_101l_t@uint64 zmm5_zmm12_101l_t;
vpc zmm5_zmm12_110h_t@uint64 zmm5_zmm12_110h_t; vpc zmm5_zmm12_110l_t@uint64 zmm5_zmm12_110l_t;
vpc zmm5_zmm12_111h_t@uint64 zmm5_zmm12_111h_t; vpc zmm5_zmm12_111l_t@uint64 zmm5_zmm12_111l_t;
add zmm4_000 zmm4_000 zmm5_zmm12_000h_t;
add zmm4_001 zmm4_001 zmm5_zmm12_001h_t;
add zmm4_010 zmm4_010 zmm5_zmm12_010h_t;
add zmm4_011 zmm4_011 zmm5_zmm12_011h_t;
add zmm4_100 zmm4_100 zmm5_zmm12_100h_t;
add zmm4_101 zmm4_101 zmm5_zmm12_101h_t;
add zmm4_110 zmm4_110 zmm5_zmm12_110h_t;
add zmm4_111 zmm4_111 zmm5_zmm12_111h_t;
(* vpmadd52huq %zmm5,%zmm16,%zmm9                  #! PC = 0x5555555564cd *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm16_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm16_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm16_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm16_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm16_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm16_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm16_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm16_111 <u 0x10000000000000@64
];
umulj zmm5_zmm16_000F zmm5_000 zmm16_000; spl zmm5_zmm16_000h_t zmm5_zmm16_000l_t zmm5_zmm16_000F 52;
umulj zmm5_zmm16_001F zmm5_001 zmm16_001; spl zmm5_zmm16_001h_t zmm5_zmm16_001l_t zmm5_zmm16_001F 52;
umulj zmm5_zmm16_010F zmm5_010 zmm16_010; spl zmm5_zmm16_010h_t zmm5_zmm16_010l_t zmm5_zmm16_010F 52;
umulj zmm5_zmm16_011F zmm5_011 zmm16_011; spl zmm5_zmm16_011h_t zmm5_zmm16_011l_t zmm5_zmm16_011F 52;
umulj zmm5_zmm16_100F zmm5_100 zmm16_100; spl zmm5_zmm16_100h_t zmm5_zmm16_100l_t zmm5_zmm16_100F 52;
umulj zmm5_zmm16_101F zmm5_101 zmm16_101; spl zmm5_zmm16_101h_t zmm5_zmm16_101l_t zmm5_zmm16_101F 52;
umulj zmm5_zmm16_110F zmm5_110 zmm16_110; spl zmm5_zmm16_110h_t zmm5_zmm16_110l_t zmm5_zmm16_110F 52;
umulj zmm5_zmm16_111F zmm5_111 zmm16_111; spl zmm5_zmm16_111h_t zmm5_zmm16_111l_t zmm5_zmm16_111F 52;
vpc zmm5_zmm16_000h_t@uint64 zmm5_zmm16_000h_t; vpc zmm5_zmm16_000l_t@uint64 zmm5_zmm16_000l_t;
vpc zmm5_zmm16_001h_t@uint64 zmm5_zmm16_001h_t; vpc zmm5_zmm16_001l_t@uint64 zmm5_zmm16_001l_t;
vpc zmm5_zmm16_010h_t@uint64 zmm5_zmm16_010h_t; vpc zmm5_zmm16_010l_t@uint64 zmm5_zmm16_010l_t;
vpc zmm5_zmm16_011h_t@uint64 zmm5_zmm16_011h_t; vpc zmm5_zmm16_011l_t@uint64 zmm5_zmm16_011l_t;
vpc zmm5_zmm16_100h_t@uint64 zmm5_zmm16_100h_t; vpc zmm5_zmm16_100l_t@uint64 zmm5_zmm16_100l_t;
vpc zmm5_zmm16_101h_t@uint64 zmm5_zmm16_101h_t; vpc zmm5_zmm16_101l_t@uint64 zmm5_zmm16_101l_t;
vpc zmm5_zmm16_110h_t@uint64 zmm5_zmm16_110h_t; vpc zmm5_zmm16_110l_t@uint64 zmm5_zmm16_110l_t;
vpc zmm5_zmm16_111h_t@uint64 zmm5_zmm16_111h_t; vpc zmm5_zmm16_111l_t@uint64 zmm5_zmm16_111l_t;
add zmm9_000 zmm9_000 zmm5_zmm16_000h_t;
add zmm9_001 zmm9_001 zmm5_zmm16_001h_t;
add zmm9_010 zmm9_010 zmm5_zmm16_010h_t;
add zmm9_011 zmm9_011 zmm5_zmm16_011h_t;
add zmm9_100 zmm9_100 zmm5_zmm16_100h_t;
add zmm9_101 zmm9_101 zmm5_zmm16_101h_t;
add zmm9_110 zmm9_110 zmm5_zmm16_110h_t;
add zmm9_111 zmm9_111 zmm5_zmm16_111h_t;
(* vpmadd52huq %zmm5,%zmm14,%zmm3                  #! PC = 0x5555555564d3 *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm14_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm14_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm14_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm14_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm14_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm14_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm14_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm14_111 <u 0x10000000000000@64
];
umulj zmm5_zmm14_000F zmm5_000 zmm14_000; spl zmm5_zmm14_000h_t zmm5_zmm14_000l_t zmm5_zmm14_000F 52;
umulj zmm5_zmm14_001F zmm5_001 zmm14_001; spl zmm5_zmm14_001h_t zmm5_zmm14_001l_t zmm5_zmm14_001F 52;
umulj zmm5_zmm14_010F zmm5_010 zmm14_010; spl zmm5_zmm14_010h_t zmm5_zmm14_010l_t zmm5_zmm14_010F 52;
umulj zmm5_zmm14_011F zmm5_011 zmm14_011; spl zmm5_zmm14_011h_t zmm5_zmm14_011l_t zmm5_zmm14_011F 52;
umulj zmm5_zmm14_100F zmm5_100 zmm14_100; spl zmm5_zmm14_100h_t zmm5_zmm14_100l_t zmm5_zmm14_100F 52;
umulj zmm5_zmm14_101F zmm5_101 zmm14_101; spl zmm5_zmm14_101h_t zmm5_zmm14_101l_t zmm5_zmm14_101F 52;
umulj zmm5_zmm14_110F zmm5_110 zmm14_110; spl zmm5_zmm14_110h_t zmm5_zmm14_110l_t zmm5_zmm14_110F 52;
umulj zmm5_zmm14_111F zmm5_111 zmm14_111; spl zmm5_zmm14_111h_t zmm5_zmm14_111l_t zmm5_zmm14_111F 52;
vpc zmm5_zmm14_000h_t@uint64 zmm5_zmm14_000h_t; vpc zmm5_zmm14_000l_t@uint64 zmm5_zmm14_000l_t;
vpc zmm5_zmm14_001h_t@uint64 zmm5_zmm14_001h_t; vpc zmm5_zmm14_001l_t@uint64 zmm5_zmm14_001l_t;
vpc zmm5_zmm14_010h_t@uint64 zmm5_zmm14_010h_t; vpc zmm5_zmm14_010l_t@uint64 zmm5_zmm14_010l_t;
vpc zmm5_zmm14_011h_t@uint64 zmm5_zmm14_011h_t; vpc zmm5_zmm14_011l_t@uint64 zmm5_zmm14_011l_t;
vpc zmm5_zmm14_100h_t@uint64 zmm5_zmm14_100h_t; vpc zmm5_zmm14_100l_t@uint64 zmm5_zmm14_100l_t;
vpc zmm5_zmm14_101h_t@uint64 zmm5_zmm14_101h_t; vpc zmm5_zmm14_101l_t@uint64 zmm5_zmm14_101l_t;
vpc zmm5_zmm14_110h_t@uint64 zmm5_zmm14_110h_t; vpc zmm5_zmm14_110l_t@uint64 zmm5_zmm14_110l_t;
vpc zmm5_zmm14_111h_t@uint64 zmm5_zmm14_111h_t; vpc zmm5_zmm14_111l_t@uint64 zmm5_zmm14_111l_t;
add zmm3_000 zmm3_000 zmm5_zmm14_000h_t;
add zmm3_001 zmm3_001 zmm5_zmm14_001h_t;
add zmm3_010 zmm3_010 zmm5_zmm14_010h_t;
add zmm3_011 zmm3_011 zmm5_zmm14_011h_t;
add zmm3_100 zmm3_100 zmm5_zmm14_100h_t;
add zmm3_101 zmm3_101 zmm5_zmm14_101h_t;
add zmm3_110 zmm3_110 zmm5_zmm14_110h_t;
add zmm3_111 zmm3_111 zmm5_zmm14_111h_t;
(* vpsllq $0x1,%zmm1,%zmm0                         #! PC = 0x5555555564d9 *)
shl zmm0_000 zmm1_000 0x1;
shl zmm0_001 zmm1_001 0x1;
shl zmm0_010 zmm1_010 0x1;
shl zmm0_011 zmm1_011 0x1;
shl zmm0_100 zmm1_100 0x1;
shl zmm0_101 zmm1_101 0x1;
shl zmm0_110 zmm1_110 0x1;
shl zmm0_111 zmm1_111 0x1;
(* vmovdqa64 %zmm2,%zmm1                           #! PC = 0x5555555564e0 *)
mov zmm1_000 zmm2_000;
mov zmm1_001 zmm2_001;
mov zmm1_010 zmm2_010;
mov zmm1_011 zmm2_011;
mov zmm1_100 zmm2_100;
mov zmm1_101 zmm2_101;
mov zmm1_110 zmm2_110;
mov zmm1_111 zmm2_111;
(* vpmadd52luq %zmm11,%zmm16,%zmm0                 #! PC = 0x5555555564e6 *)
assert true && and [
zmm11_000 <u 0x10000000000000@64, zmm16_000 <u 0x10000000000000@64, zmm11_001 <u 0x10000000000000@64, zmm16_001 <u 0x10000000000000@64, zmm11_010 <u 0x10000000000000@64, zmm16_010 <u 0x10000000000000@64, zmm11_011 <u 0x10000000000000@64, zmm16_011 <u 0x10000000000000@64, zmm11_100 <u 0x10000000000000@64, zmm16_100 <u 0x10000000000000@64, zmm11_101 <u 0x10000000000000@64, zmm16_101 <u 0x10000000000000@64, zmm11_110 <u 0x10000000000000@64, zmm16_110 <u 0x10000000000000@64, zmm11_111 <u 0x10000000000000@64, zmm16_111 <u 0x10000000000000@64
];
umulj zmm11_zmm16_000F zmm11_000 zmm16_000; spl zmm11_zmm16_000h_t zmm11_zmm16_000l_t zmm11_zmm16_000F 52;
umulj zmm11_zmm16_001F zmm11_001 zmm16_001; spl zmm11_zmm16_001h_t zmm11_zmm16_001l_t zmm11_zmm16_001F 52;
umulj zmm11_zmm16_010F zmm11_010 zmm16_010; spl zmm11_zmm16_010h_t zmm11_zmm16_010l_t zmm11_zmm16_010F 52;
umulj zmm11_zmm16_011F zmm11_011 zmm16_011; spl zmm11_zmm16_011h_t zmm11_zmm16_011l_t zmm11_zmm16_011F 52;
umulj zmm11_zmm16_100F zmm11_100 zmm16_100; spl zmm11_zmm16_100h_t zmm11_zmm16_100l_t zmm11_zmm16_100F 52;
umulj zmm11_zmm16_101F zmm11_101 zmm16_101; spl zmm11_zmm16_101h_t zmm11_zmm16_101l_t zmm11_zmm16_101F 52;
umulj zmm11_zmm16_110F zmm11_110 zmm16_110; spl zmm11_zmm16_110h_t zmm11_zmm16_110l_t zmm11_zmm16_110F 52;
umulj zmm11_zmm16_111F zmm11_111 zmm16_111; spl zmm11_zmm16_111h_t zmm11_zmm16_111l_t zmm11_zmm16_111F 52;
vpc zmm11_zmm16_000h_t@uint64 zmm11_zmm16_000h_t; vpc zmm11_zmm16_000l_t@uint64 zmm11_zmm16_000l_t;
vpc zmm11_zmm16_001h_t@uint64 zmm11_zmm16_001h_t; vpc zmm11_zmm16_001l_t@uint64 zmm11_zmm16_001l_t;
vpc zmm11_zmm16_010h_t@uint64 zmm11_zmm16_010h_t; vpc zmm11_zmm16_010l_t@uint64 zmm11_zmm16_010l_t;
vpc zmm11_zmm16_011h_t@uint64 zmm11_zmm16_011h_t; vpc zmm11_zmm16_011l_t@uint64 zmm11_zmm16_011l_t;
vpc zmm11_zmm16_100h_t@uint64 zmm11_zmm16_100h_t; vpc zmm11_zmm16_100l_t@uint64 zmm11_zmm16_100l_t;
vpc zmm11_zmm16_101h_t@uint64 zmm11_zmm16_101h_t; vpc zmm11_zmm16_101l_t@uint64 zmm11_zmm16_101l_t;
vpc zmm11_zmm16_110h_t@uint64 zmm11_zmm16_110h_t; vpc zmm11_zmm16_110l_t@uint64 zmm11_zmm16_110l_t;
vpc zmm11_zmm16_111h_t@uint64 zmm11_zmm16_111h_t; vpc zmm11_zmm16_111l_t@uint64 zmm11_zmm16_111l_t;
add zmm0_000 zmm0_000 zmm11_zmm16_000l_t;
add zmm0_001 zmm0_001 zmm11_zmm16_001l_t;
add zmm0_010 zmm0_010 zmm11_zmm16_010l_t;
add zmm0_011 zmm0_011 zmm11_zmm16_011l_t;
add zmm0_100 zmm0_100 zmm11_zmm16_100l_t;
add zmm0_101 zmm0_101 zmm11_zmm16_101l_t;
add zmm0_110 zmm0_110 zmm11_zmm16_110l_t;
add zmm0_111 zmm0_111 zmm11_zmm16_111l_t;
(* vpmadd52huq %zmm11,%zmm16,%zmm1                 #! PC = 0x5555555564ec *)
add zmm1_000 zmm1_000 zmm11_zmm16_000h_t;
add zmm1_001 zmm1_001 zmm11_zmm16_001h_t;
add zmm1_010 zmm1_010 zmm11_zmm16_010h_t;
add zmm1_011 zmm1_011 zmm11_zmm16_011h_t;
add zmm1_100 zmm1_100 zmm11_zmm16_100h_t;
add zmm1_101 zmm1_101 zmm11_zmm16_101h_t;
add zmm1_110 zmm1_110 zmm11_zmm16_110h_t;
add zmm1_111 zmm1_111 zmm11_zmm16_111h_t;
(* vpsllq $0x1,%zmm4,%zmm4                         #! PC = 0x5555555564f2 *)
shl zmm4_000 zmm4_000 0x1;
shl zmm4_001 zmm4_001 0x1;
shl zmm4_010 zmm4_010 0x1;
shl zmm4_011 zmm4_011 0x1;
shl zmm4_100 zmm4_100 0x1;
shl zmm4_101 zmm4_101 0x1;
shl zmm4_110 zmm4_110 0x1;
shl zmm4_111 zmm4_111 0x1;
(* vpmadd52luq %zmm7,%zmm16,%zmm4                  #! PC = 0x5555555564f9 *)
add zmm4_000 zmm4_000 zmm7_zmm16_000l_t;
add zmm4_001 zmm4_001 zmm7_zmm16_001l_t;
add zmm4_010 zmm4_010 zmm7_zmm16_010l_t;
add zmm4_011 zmm4_011 zmm7_zmm16_011l_t;
add zmm4_100 zmm4_100 zmm7_zmm16_100l_t;
add zmm4_101 zmm4_101 zmm7_zmm16_101l_t;
add zmm4_110 zmm4_110 zmm7_zmm16_110l_t;
add zmm4_111 zmm4_111 zmm7_zmm16_111l_t;
(* vpsllq $0x1,%zmm3,%zmm3                         #! PC = 0x5555555564ff *)
shl zmm3_000 zmm3_000 0x1;
shl zmm3_001 zmm3_001 0x1;
shl zmm3_010 zmm3_010 0x1;
shl zmm3_011 zmm3_011 0x1;
shl zmm3_100 zmm3_100 0x1;
shl zmm3_101 zmm3_101 0x1;
shl zmm3_110 zmm3_110 0x1;
shl zmm3_111 zmm3_111 0x1;
(* vpmadd52luq %zmm7,%zmm14,%zmm0                  #! PC = 0x555555556506 *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm14_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm14_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm14_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm14_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm14_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm14_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm14_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm14_111 <u 0x10000000000000@64
];
umulj zmm7_zmm14_000F zmm7_000 zmm14_000; spl zmm7_zmm14_000h_t zmm7_zmm14_000l_t zmm7_zmm14_000F 52;
umulj zmm7_zmm14_001F zmm7_001 zmm14_001; spl zmm7_zmm14_001h_t zmm7_zmm14_001l_t zmm7_zmm14_001F 52;
umulj zmm7_zmm14_010F zmm7_010 zmm14_010; spl zmm7_zmm14_010h_t zmm7_zmm14_010l_t zmm7_zmm14_010F 52;
umulj zmm7_zmm14_011F zmm7_011 zmm14_011; spl zmm7_zmm14_011h_t zmm7_zmm14_011l_t zmm7_zmm14_011F 52;
umulj zmm7_zmm14_100F zmm7_100 zmm14_100; spl zmm7_zmm14_100h_t zmm7_zmm14_100l_t zmm7_zmm14_100F 52;
umulj zmm7_zmm14_101F zmm7_101 zmm14_101; spl zmm7_zmm14_101h_t zmm7_zmm14_101l_t zmm7_zmm14_101F 52;
umulj zmm7_zmm14_110F zmm7_110 zmm14_110; spl zmm7_zmm14_110h_t zmm7_zmm14_110l_t zmm7_zmm14_110F 52;
umulj zmm7_zmm14_111F zmm7_111 zmm14_111; spl zmm7_zmm14_111h_t zmm7_zmm14_111l_t zmm7_zmm14_111F 52;
vpc zmm7_zmm14_000h_t@uint64 zmm7_zmm14_000h_t; vpc zmm7_zmm14_000l_t@uint64 zmm7_zmm14_000l_t;
vpc zmm7_zmm14_001h_t@uint64 zmm7_zmm14_001h_t; vpc zmm7_zmm14_001l_t@uint64 zmm7_zmm14_001l_t;
vpc zmm7_zmm14_010h_t@uint64 zmm7_zmm14_010h_t; vpc zmm7_zmm14_010l_t@uint64 zmm7_zmm14_010l_t;
vpc zmm7_zmm14_011h_t@uint64 zmm7_zmm14_011h_t; vpc zmm7_zmm14_011l_t@uint64 zmm7_zmm14_011l_t;
vpc zmm7_zmm14_100h_t@uint64 zmm7_zmm14_100h_t; vpc zmm7_zmm14_100l_t@uint64 zmm7_zmm14_100l_t;
vpc zmm7_zmm14_101h_t@uint64 zmm7_zmm14_101h_t; vpc zmm7_zmm14_101l_t@uint64 zmm7_zmm14_101l_t;
vpc zmm7_zmm14_110h_t@uint64 zmm7_zmm14_110h_t; vpc zmm7_zmm14_110l_t@uint64 zmm7_zmm14_110l_t;
vpc zmm7_zmm14_111h_t@uint64 zmm7_zmm14_111h_t; vpc zmm7_zmm14_111l_t@uint64 zmm7_zmm14_111l_t;
add zmm0_000 zmm0_000 zmm7_zmm14_000l_t;
add zmm0_001 zmm0_001 zmm7_zmm14_001l_t;
add zmm0_010 zmm0_010 zmm7_zmm14_010l_t;
add zmm0_011 zmm0_011 zmm7_zmm14_011l_t;
add zmm0_100 zmm0_100 zmm7_zmm14_100l_t;
add zmm0_101 zmm0_101 zmm7_zmm14_101l_t;
add zmm0_110 zmm0_110 zmm7_zmm14_110l_t;
add zmm0_111 zmm0_111 zmm7_zmm14_111l_t;
(* vpmadd52huq %zmm7,%zmm14,%zmm1                  #! PC = 0x55555555650c *)
add zmm1_000 zmm1_000 zmm7_zmm14_000h_t;
add zmm1_001 zmm1_001 zmm7_zmm14_001h_t;
add zmm1_010 zmm1_010 zmm7_zmm14_010h_t;
add zmm1_011 zmm1_011 zmm7_zmm14_011h_t;
add zmm1_100 zmm1_100 zmm7_zmm14_100h_t;
add zmm1_101 zmm1_101 zmm7_zmm14_101h_t;
add zmm1_110 zmm1_110 zmm7_zmm14_110h_t;
add zmm1_111 zmm1_111 zmm7_zmm14_111h_t;
(* vpmadd52luq %zmm10,%zmm16,%zmm3                 #! PC = 0x555555556512 *)
add zmm3_000 zmm3_000 zmm10_zmm16_000l_t;
add zmm3_001 zmm3_001 zmm10_zmm16_001l_t;
add zmm3_010 zmm3_010 zmm10_zmm16_010l_t;
add zmm3_011 zmm3_011 zmm10_zmm16_011l_t;
add zmm3_100 zmm3_100 zmm10_zmm16_100l_t;
add zmm3_101 zmm3_101 zmm10_zmm16_101l_t;
add zmm3_110 zmm3_110 zmm10_zmm16_110l_t;
add zmm3_111 zmm3_111 zmm10_zmm16_111l_t;
(* vpmadd52luq %zmm10,%zmm14,%zmm4                 #! PC = 0x555555556518 *)
add zmm4_000 zmm4_000 zmm10_zmm14_000l_t;
add zmm4_001 zmm4_001 zmm10_zmm14_001l_t;
add zmm4_010 zmm4_010 zmm10_zmm14_010l_t;
add zmm4_011 zmm4_011 zmm10_zmm14_011l_t;
add zmm4_100 zmm4_100 zmm10_zmm14_100l_t;
add zmm4_101 zmm4_101 zmm10_zmm14_101l_t;
add zmm4_110 zmm4_110 zmm10_zmm14_110l_t;
add zmm4_111 zmm4_111 zmm10_zmm14_111l_t;
(* vpsllq $0x1,%zmm9,%zmm9                         #! PC = 0x55555555651e *)
shl zmm9_000 zmm9_000 0x1;
shl zmm9_001 zmm9_001 0x1;
shl zmm9_010 zmm9_010 0x1;
shl zmm9_011 zmm9_011 0x1;
shl zmm9_100 zmm9_100 0x1;
shl zmm9_101 zmm9_101 0x1;
shl zmm9_110 zmm9_110 0x1;
shl zmm9_111 zmm9_111 0x1;
(* vpmadd52luq %zmm10,%zmm12,%zmm0                 #! PC = 0x555555556525 *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm10_zmm12_000F zmm10_000 zmm12_000; spl zmm10_zmm12_000h_t zmm10_zmm12_000l_t zmm10_zmm12_000F 52;
umulj zmm10_zmm12_001F zmm10_001 zmm12_001; spl zmm10_zmm12_001h_t zmm10_zmm12_001l_t zmm10_zmm12_001F 52;
umulj zmm10_zmm12_010F zmm10_010 zmm12_010; spl zmm10_zmm12_010h_t zmm10_zmm12_010l_t zmm10_zmm12_010F 52;
umulj zmm10_zmm12_011F zmm10_011 zmm12_011; spl zmm10_zmm12_011h_t zmm10_zmm12_011l_t zmm10_zmm12_011F 52;
umulj zmm10_zmm12_100F zmm10_100 zmm12_100; spl zmm10_zmm12_100h_t zmm10_zmm12_100l_t zmm10_zmm12_100F 52;
umulj zmm10_zmm12_101F zmm10_101 zmm12_101; spl zmm10_zmm12_101h_t zmm10_zmm12_101l_t zmm10_zmm12_101F 52;
umulj zmm10_zmm12_110F zmm10_110 zmm12_110; spl zmm10_zmm12_110h_t zmm10_zmm12_110l_t zmm10_zmm12_110F 52;
umulj zmm10_zmm12_111F zmm10_111 zmm12_111; spl zmm10_zmm12_111h_t zmm10_zmm12_111l_t zmm10_zmm12_111F 52;
vpc zmm10_zmm12_000h_t@uint64 zmm10_zmm12_000h_t; vpc zmm10_zmm12_000l_t@uint64 zmm10_zmm12_000l_t;
vpc zmm10_zmm12_001h_t@uint64 zmm10_zmm12_001h_t; vpc zmm10_zmm12_001l_t@uint64 zmm10_zmm12_001l_t;
vpc zmm10_zmm12_010h_t@uint64 zmm10_zmm12_010h_t; vpc zmm10_zmm12_010l_t@uint64 zmm10_zmm12_010l_t;
vpc zmm10_zmm12_011h_t@uint64 zmm10_zmm12_011h_t; vpc zmm10_zmm12_011l_t@uint64 zmm10_zmm12_011l_t;
vpc zmm10_zmm12_100h_t@uint64 zmm10_zmm12_100h_t; vpc zmm10_zmm12_100l_t@uint64 zmm10_zmm12_100l_t;
vpc zmm10_zmm12_101h_t@uint64 zmm10_zmm12_101h_t; vpc zmm10_zmm12_101l_t@uint64 zmm10_zmm12_101l_t;
vpc zmm10_zmm12_110h_t@uint64 zmm10_zmm12_110h_t; vpc zmm10_zmm12_110l_t@uint64 zmm10_zmm12_110l_t;
vpc zmm10_zmm12_111h_t@uint64 zmm10_zmm12_111h_t; vpc zmm10_zmm12_111l_t@uint64 zmm10_zmm12_111l_t;
add zmm0_000 zmm0_000 zmm10_zmm12_000l_t;
add zmm0_001 zmm0_001 zmm10_zmm12_001l_t;
add zmm0_010 zmm0_010 zmm10_zmm12_010l_t;
add zmm0_011 zmm0_011 zmm10_zmm12_011l_t;
add zmm0_100 zmm0_100 zmm10_zmm12_100l_t;
add zmm0_101 zmm0_101 zmm10_zmm12_101l_t;
add zmm0_110 zmm0_110 zmm10_zmm12_110l_t;
add zmm0_111 zmm0_111 zmm10_zmm12_111l_t;
(* vpmadd52huq %zmm10,%zmm12,%zmm1                 #! PC = 0x55555555652b *)
add zmm1_000 zmm1_000 zmm10_zmm12_000h_t;
add zmm1_001 zmm1_001 zmm10_zmm12_001h_t;
add zmm1_010 zmm1_010 zmm10_zmm12_010h_t;
add zmm1_011 zmm1_011 zmm10_zmm12_011h_t;
add zmm1_100 zmm1_100 zmm10_zmm12_100h_t;
add zmm1_101 zmm1_101 zmm10_zmm12_101h_t;
add zmm1_110 zmm1_110 zmm10_zmm12_110h_t;
add zmm1_111 zmm1_111 zmm10_zmm12_111h_t;
(* vpmadd52luq %zmm13,%zmm16,%zmm9                 #! PC = 0x555555556531 *)
add zmm9_000 zmm9_000 zmm13_zmm16_000l_t;
add zmm9_001 zmm9_001 zmm13_zmm16_001l_t;
add zmm9_010 zmm9_010 zmm13_zmm16_010l_t;
add zmm9_011 zmm9_011 zmm13_zmm16_011l_t;
add zmm9_100 zmm9_100 zmm13_zmm16_100l_t;
add zmm9_101 zmm9_101 zmm13_zmm16_101l_t;
add zmm9_110 zmm9_110 zmm13_zmm16_110l_t;
add zmm9_111 zmm9_111 zmm13_zmm16_111l_t;
(* vpmadd52luq %zmm13,%zmm14,%zmm3                 #! PC = 0x555555556537 *)
add zmm3_000 zmm3_000 zmm13_zmm14_000l_t;
add zmm3_001 zmm3_001 zmm13_zmm14_001l_t;
add zmm3_010 zmm3_010 zmm13_zmm14_010l_t;
add zmm3_011 zmm3_011 zmm13_zmm14_011l_t;
add zmm3_100 zmm3_100 zmm13_zmm14_100l_t;
add zmm3_101 zmm3_101 zmm13_zmm14_101l_t;
add zmm3_110 zmm3_110 zmm13_zmm14_110l_t;
add zmm3_111 zmm3_111 zmm13_zmm14_111l_t;
(* vpmadd52luq %zmm13,%zmm12,%zmm4                 #! PC = 0x55555555653d *)
add zmm4_000 zmm4_000 zmm13_zmm12_000l_t;
add zmm4_001 zmm4_001 zmm13_zmm12_001l_t;
add zmm4_010 zmm4_010 zmm13_zmm12_010l_t;
add zmm4_011 zmm4_011 zmm13_zmm12_011l_t;
add zmm4_100 zmm4_100 zmm13_zmm12_100l_t;
add zmm4_101 zmm4_101 zmm13_zmm12_101l_t;
add zmm4_110 zmm4_110 zmm13_zmm12_110l_t;
add zmm4_111 zmm4_111 zmm13_zmm12_111l_t;
(* vpmadd52luq %zmm13,%zmm8,%zmm0                  #! PC = 0x555555556543 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm13_zmm8_000F zmm13_000 zmm8_000; spl zmm13_zmm8_000h_t zmm13_zmm8_000l_t zmm13_zmm8_000F 52;
umulj zmm13_zmm8_001F zmm13_001 zmm8_001; spl zmm13_zmm8_001h_t zmm13_zmm8_001l_t zmm13_zmm8_001F 52;
umulj zmm13_zmm8_010F zmm13_010 zmm8_010; spl zmm13_zmm8_010h_t zmm13_zmm8_010l_t zmm13_zmm8_010F 52;
umulj zmm13_zmm8_011F zmm13_011 zmm8_011; spl zmm13_zmm8_011h_t zmm13_zmm8_011l_t zmm13_zmm8_011F 52;
umulj zmm13_zmm8_100F zmm13_100 zmm8_100; spl zmm13_zmm8_100h_t zmm13_zmm8_100l_t zmm13_zmm8_100F 52;
umulj zmm13_zmm8_101F zmm13_101 zmm8_101; spl zmm13_zmm8_101h_t zmm13_zmm8_101l_t zmm13_zmm8_101F 52;
umulj zmm13_zmm8_110F zmm13_110 zmm8_110; spl zmm13_zmm8_110h_t zmm13_zmm8_110l_t zmm13_zmm8_110F 52;
umulj zmm13_zmm8_111F zmm13_111 zmm8_111; spl zmm13_zmm8_111h_t zmm13_zmm8_111l_t zmm13_zmm8_111F 52;
vpc zmm13_zmm8_000h_t@uint64 zmm13_zmm8_000h_t; vpc zmm13_zmm8_000l_t@uint64 zmm13_zmm8_000l_t;
vpc zmm13_zmm8_001h_t@uint64 zmm13_zmm8_001h_t; vpc zmm13_zmm8_001l_t@uint64 zmm13_zmm8_001l_t;
vpc zmm13_zmm8_010h_t@uint64 zmm13_zmm8_010h_t; vpc zmm13_zmm8_010l_t@uint64 zmm13_zmm8_010l_t;
vpc zmm13_zmm8_011h_t@uint64 zmm13_zmm8_011h_t; vpc zmm13_zmm8_011l_t@uint64 zmm13_zmm8_011l_t;
vpc zmm13_zmm8_100h_t@uint64 zmm13_zmm8_100h_t; vpc zmm13_zmm8_100l_t@uint64 zmm13_zmm8_100l_t;
vpc zmm13_zmm8_101h_t@uint64 zmm13_zmm8_101h_t; vpc zmm13_zmm8_101l_t@uint64 zmm13_zmm8_101l_t;
vpc zmm13_zmm8_110h_t@uint64 zmm13_zmm8_110h_t; vpc zmm13_zmm8_110l_t@uint64 zmm13_zmm8_110l_t;
vpc zmm13_zmm8_111h_t@uint64 zmm13_zmm8_111h_t; vpc zmm13_zmm8_111l_t@uint64 zmm13_zmm8_111l_t;
add zmm0_000 zmm0_000 zmm13_zmm8_000l_t;
add zmm0_001 zmm0_001 zmm13_zmm8_001l_t;
add zmm0_010 zmm0_010 zmm13_zmm8_010l_t;
add zmm0_011 zmm0_011 zmm13_zmm8_011l_t;
add zmm0_100 zmm0_100 zmm13_zmm8_100l_t;
add zmm0_101 zmm0_101 zmm13_zmm8_101l_t;
add zmm0_110 zmm0_110 zmm13_zmm8_110l_t;
add zmm0_111 zmm0_111 zmm13_zmm8_111l_t;
(* vpmadd52huq %zmm13,%zmm8,%zmm1                  #! PC = 0x555555556549 *)
add zmm1_000 zmm1_000 zmm13_zmm8_000h_t;
add zmm1_001 zmm1_001 zmm13_zmm8_001h_t;
add zmm1_010 zmm1_010 zmm13_zmm8_010h_t;
add zmm1_011 zmm1_011 zmm13_zmm8_011h_t;
add zmm1_100 zmm1_100 zmm13_zmm8_100h_t;
add zmm1_101 zmm1_101 zmm13_zmm8_101h_t;
add zmm1_110 zmm1_110 zmm13_zmm8_110h_t;
add zmm1_111 zmm1_111 zmm13_zmm8_111h_t;
(* vmovdqa64 0x100(%rsi),%zmm15                    #! EA = L0x7fffffffd600; Value = 0x0000000000000000; PC = 0x55555555654f *)
mov zmm15_000 L0x7fffffffd600;
mov zmm15_001 L0x7fffffffd608;
mov zmm15_010 L0x7fffffffd610;
mov zmm15_011 L0x7fffffffd618;
mov zmm15_100 L0x7fffffffd620;
mov zmm15_101 L0x7fffffffd628;
mov zmm15_110 L0x7fffffffd630;
mov zmm15_111 L0x7fffffffd638;
(* vmovdqa64 %zmm2,%zmm6                           #! PC = 0x555555556556 *)
mov zmm6_000 zmm2_000;
mov zmm6_001 zmm2_001;
mov zmm6_010 zmm2_010;
mov zmm6_011 zmm2_011;
mov zmm6_100 zmm2_100;
mov zmm6_101 zmm2_101;
mov zmm6_110 zmm2_110;
mov zmm6_111 zmm2_111;
(* vpmadd52luq %zmm5,%zmm16,%zmm6                  #! PC = 0x55555555655c *)
add zmm6_000 zmm6_000 zmm5_zmm16_000l_t;
add zmm6_001 zmm6_001 zmm5_zmm16_001l_t;
add zmm6_010 zmm6_010 zmm5_zmm16_010l_t;
add zmm6_011 zmm6_011 zmm5_zmm16_011l_t;
add zmm6_100 zmm6_100 zmm5_zmm16_100l_t;
add zmm6_101 zmm6_101 zmm5_zmm16_101l_t;
add zmm6_110 zmm6_110 zmm5_zmm16_110l_t;
add zmm6_111 zmm6_111 zmm5_zmm16_111l_t;
(* vpmadd52luq %zmm5,%zmm14,%zmm9                  #! PC = 0x555555556562 *)
add zmm9_000 zmm9_000 zmm5_zmm14_000l_t;
add zmm9_001 zmm9_001 zmm5_zmm14_001l_t;
add zmm9_010 zmm9_010 zmm5_zmm14_010l_t;
add zmm9_011 zmm9_011 zmm5_zmm14_011l_t;
add zmm9_100 zmm9_100 zmm5_zmm14_100l_t;
add zmm9_101 zmm9_101 zmm5_zmm14_101l_t;
add zmm9_110 zmm9_110 zmm5_zmm14_110l_t;
add zmm9_111 zmm9_111 zmm5_zmm14_111l_t;
(* vpmadd52luq %zmm5,%zmm12,%zmm3                  #! PC = 0x555555556568 *)
add zmm3_000 zmm3_000 zmm5_zmm12_000l_t;
add zmm3_001 zmm3_001 zmm5_zmm12_001l_t;
add zmm3_010 zmm3_010 zmm5_zmm12_010l_t;
add zmm3_011 zmm3_011 zmm5_zmm12_011l_t;
add zmm3_100 zmm3_100 zmm5_zmm12_100l_t;
add zmm3_101 zmm3_101 zmm5_zmm12_101l_t;
add zmm3_110 zmm3_110 zmm5_zmm12_110l_t;
add zmm3_111 zmm3_111 zmm5_zmm12_111l_t;
(* vpmadd52luq %zmm5,%zmm8,%zmm4                   #! PC = 0x55555555656e *)
add zmm4_000 zmm4_000 zmm5_zmm8_000l_t;
add zmm4_001 zmm4_001 zmm5_zmm8_001l_t;
add zmm4_010 zmm4_010 zmm5_zmm8_010l_t;
add zmm4_011 zmm4_011 zmm5_zmm8_011l_t;
add zmm4_100 zmm4_100 zmm5_zmm8_100l_t;
add zmm4_101 zmm4_101 zmm5_zmm8_101l_t;
add zmm4_110 zmm4_110 zmm5_zmm8_110l_t;
add zmm4_111 zmm4_111 zmm5_zmm8_111l_t;
(* vpmadd52luq %zmm5,%zmm15,%zmm0                  #! PC = 0x555555556574 *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm15_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm15_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm15_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm15_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm15_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm15_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm15_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm15_111 <u 0x10000000000000@64
];
umulj zmm5_zmm15_000F zmm5_000 zmm15_000; spl zmm5_zmm15_000h_t zmm5_zmm15_000l_t zmm5_zmm15_000F 52;
umulj zmm5_zmm15_001F zmm5_001 zmm15_001; spl zmm5_zmm15_001h_t zmm5_zmm15_001l_t zmm5_zmm15_001F 52;
umulj zmm5_zmm15_010F zmm5_010 zmm15_010; spl zmm5_zmm15_010h_t zmm5_zmm15_010l_t zmm5_zmm15_010F 52;
umulj zmm5_zmm15_011F zmm5_011 zmm15_011; spl zmm5_zmm15_011h_t zmm5_zmm15_011l_t zmm5_zmm15_011F 52;
umulj zmm5_zmm15_100F zmm5_100 zmm15_100; spl zmm5_zmm15_100h_t zmm5_zmm15_100l_t zmm5_zmm15_100F 52;
umulj zmm5_zmm15_101F zmm5_101 zmm15_101; spl zmm5_zmm15_101h_t zmm5_zmm15_101l_t zmm5_zmm15_101F 52;
umulj zmm5_zmm15_110F zmm5_110 zmm15_110; spl zmm5_zmm15_110h_t zmm5_zmm15_110l_t zmm5_zmm15_110F 52;
umulj zmm5_zmm15_111F zmm5_111 zmm15_111; spl zmm5_zmm15_111h_t zmm5_zmm15_111l_t zmm5_zmm15_111F 52;
vpc zmm5_zmm15_000h_t@uint64 zmm5_zmm15_000h_t; vpc zmm5_zmm15_000l_t@uint64 zmm5_zmm15_000l_t;
vpc zmm5_zmm15_001h_t@uint64 zmm5_zmm15_001h_t; vpc zmm5_zmm15_001l_t@uint64 zmm5_zmm15_001l_t;
vpc zmm5_zmm15_010h_t@uint64 zmm5_zmm15_010h_t; vpc zmm5_zmm15_010l_t@uint64 zmm5_zmm15_010l_t;
vpc zmm5_zmm15_011h_t@uint64 zmm5_zmm15_011h_t; vpc zmm5_zmm15_011l_t@uint64 zmm5_zmm15_011l_t;
vpc zmm5_zmm15_100h_t@uint64 zmm5_zmm15_100h_t; vpc zmm5_zmm15_100l_t@uint64 zmm5_zmm15_100l_t;
vpc zmm5_zmm15_101h_t@uint64 zmm5_zmm15_101h_t; vpc zmm5_zmm15_101l_t@uint64 zmm5_zmm15_101l_t;
vpc zmm5_zmm15_110h_t@uint64 zmm5_zmm15_110h_t; vpc zmm5_zmm15_110l_t@uint64 zmm5_zmm15_110l_t;
vpc zmm5_zmm15_111h_t@uint64 zmm5_zmm15_111h_t; vpc zmm5_zmm15_111l_t@uint64 zmm5_zmm15_111l_t;
add zmm0_000 zmm0_000 zmm5_zmm15_000l_t;
add zmm0_001 zmm0_001 zmm5_zmm15_001l_t;
add zmm0_010 zmm0_010 zmm5_zmm15_010l_t;
add zmm0_011 zmm0_011 zmm5_zmm15_011l_t;
add zmm0_100 zmm0_100 zmm5_zmm15_100l_t;
add zmm0_101 zmm0_101 zmm5_zmm15_101l_t;
add zmm0_110 zmm0_110 zmm5_zmm15_110l_t;
add zmm0_111 zmm0_111 zmm5_zmm15_111l_t;
(* vpmadd52huq %zmm5,%zmm15,%zmm1                  #! PC = 0x55555555657a *)
add zmm1_000 zmm1_000 zmm5_zmm15_000h_t;
add zmm1_001 zmm1_001 zmm5_zmm15_001h_t;
add zmm1_010 zmm1_010 zmm5_zmm15_010h_t;
add zmm1_011 zmm1_011 zmm5_zmm15_011h_t;
add zmm1_100 zmm1_100 zmm5_zmm15_100h_t;
add zmm1_101 zmm1_101 zmm5_zmm15_101h_t;
add zmm1_110 zmm1_110 zmm5_zmm15_110h_t;
add zmm1_111 zmm1_111 zmm5_zmm15_111h_t;
(* vmovdqa64 %zmm2,%zmm5                           #! PC = 0x555555556580 *)
mov zmm5_000 zmm2_000;
mov zmm5_001 zmm2_001;
mov zmm5_010 zmm2_010;
mov zmm5_011 zmm2_011;
mov zmm5_100 zmm2_100;
mov zmm5_101 zmm2_101;
mov zmm5_110 zmm2_110;
mov zmm5_111 zmm2_111;
(* vpmadd52huq %zmm11,%zmm14,%zmm5                 #! PC = 0x555555556586 *)
assert true && and [
zmm11_000 <u 0x10000000000000@64, zmm14_000 <u 0x10000000000000@64, zmm11_001 <u 0x10000000000000@64, zmm14_001 <u 0x10000000000000@64, zmm11_010 <u 0x10000000000000@64, zmm14_010 <u 0x10000000000000@64, zmm11_011 <u 0x10000000000000@64, zmm14_011 <u 0x10000000000000@64, zmm11_100 <u 0x10000000000000@64, zmm14_100 <u 0x10000000000000@64, zmm11_101 <u 0x10000000000000@64, zmm14_101 <u 0x10000000000000@64, zmm11_110 <u 0x10000000000000@64, zmm14_110 <u 0x10000000000000@64, zmm11_111 <u 0x10000000000000@64, zmm14_111 <u 0x10000000000000@64
];
umulj zmm11_zmm14_000F zmm11_000 zmm14_000; spl zmm11_zmm14_000h_t zmm11_zmm14_000l_t zmm11_zmm14_000F 52;
umulj zmm11_zmm14_001F zmm11_001 zmm14_001; spl zmm11_zmm14_001h_t zmm11_zmm14_001l_t zmm11_zmm14_001F 52;
umulj zmm11_zmm14_010F zmm11_010 zmm14_010; spl zmm11_zmm14_010h_t zmm11_zmm14_010l_t zmm11_zmm14_010F 52;
umulj zmm11_zmm14_011F zmm11_011 zmm14_011; spl zmm11_zmm14_011h_t zmm11_zmm14_011l_t zmm11_zmm14_011F 52;
umulj zmm11_zmm14_100F zmm11_100 zmm14_100; spl zmm11_zmm14_100h_t zmm11_zmm14_100l_t zmm11_zmm14_100F 52;
umulj zmm11_zmm14_101F zmm11_101 zmm14_101; spl zmm11_zmm14_101h_t zmm11_zmm14_101l_t zmm11_zmm14_101F 52;
umulj zmm11_zmm14_110F zmm11_110 zmm14_110; spl zmm11_zmm14_110h_t zmm11_zmm14_110l_t zmm11_zmm14_110F 52;
umulj zmm11_zmm14_111F zmm11_111 zmm14_111; spl zmm11_zmm14_111h_t zmm11_zmm14_111l_t zmm11_zmm14_111F 52;
vpc zmm11_zmm14_000h_t@uint64 zmm11_zmm14_000h_t; vpc zmm11_zmm14_000l_t@uint64 zmm11_zmm14_000l_t;
vpc zmm11_zmm14_001h_t@uint64 zmm11_zmm14_001h_t; vpc zmm11_zmm14_001l_t@uint64 zmm11_zmm14_001l_t;
vpc zmm11_zmm14_010h_t@uint64 zmm11_zmm14_010h_t; vpc zmm11_zmm14_010l_t@uint64 zmm11_zmm14_010l_t;
vpc zmm11_zmm14_011h_t@uint64 zmm11_zmm14_011h_t; vpc zmm11_zmm14_011l_t@uint64 zmm11_zmm14_011l_t;
vpc zmm11_zmm14_100h_t@uint64 zmm11_zmm14_100h_t; vpc zmm11_zmm14_100l_t@uint64 zmm11_zmm14_100l_t;
vpc zmm11_zmm14_101h_t@uint64 zmm11_zmm14_101h_t; vpc zmm11_zmm14_101l_t@uint64 zmm11_zmm14_101l_t;
vpc zmm11_zmm14_110h_t@uint64 zmm11_zmm14_110h_t; vpc zmm11_zmm14_110l_t@uint64 zmm11_zmm14_110l_t;
vpc zmm11_zmm14_111h_t@uint64 zmm11_zmm14_111h_t; vpc zmm11_zmm14_111l_t@uint64 zmm11_zmm14_111l_t;
add zmm5_000 zmm5_000 zmm11_zmm14_000h_t;
add zmm5_001 zmm5_001 zmm11_zmm14_001h_t;
add zmm5_010 zmm5_010 zmm11_zmm14_010h_t;
add zmm5_011 zmm5_011 zmm11_zmm14_011h_t;
add zmm5_100 zmm5_100 zmm11_zmm14_100h_t;
add zmm5_101 zmm5_101 zmm11_zmm14_101h_t;
add zmm5_110 zmm5_110 zmm11_zmm14_110h_t;
add zmm5_111 zmm5_111 zmm11_zmm14_111h_t;
(* # movzbl %cl,%ecx                                 #! PC = 0x55555555658c *)
# movzbl %cl,%ecx                                 #! 0x55555555658c = 0x55555555658c;
(* # lea    -0x1(%rcx),%eax                          #! PC = 0x55555555658f *)
# lea    -0x1(%rcx),%eax                          #! 0x55555555658f = 0x55555555658f;
(* vpsllq $0x1,%zmm1,%zmm1                         #! PC = 0x555555556592 *)
shl zmm1_000 zmm1_000 0x1;
shl zmm1_001 zmm1_001 0x1;
shl zmm1_010 zmm1_010 0x1;
shl zmm1_011 zmm1_011 0x1;
shl zmm1_100 zmm1_100 0x1;
shl zmm1_101 zmm1_101 0x1;
shl zmm1_110 zmm1_110 0x1;
shl zmm1_111 zmm1_111 0x1;
(* vpmadd52luq %zmm11,%zmm14,%zmm1                 #! PC = 0x555555556599 *)
add zmm1_000 zmm1_000 zmm11_zmm14_000l_t;
add zmm1_001 zmm1_001 zmm11_zmm14_001l_t;
add zmm1_010 zmm1_010 zmm11_zmm14_010l_t;
add zmm1_011 zmm1_011 zmm11_zmm14_011l_t;
add zmm1_100 zmm1_100 zmm11_zmm14_100l_t;
add zmm1_101 zmm1_101 zmm11_zmm14_101l_t;
add zmm1_110 zmm1_110 zmm11_zmm14_110l_t;
add zmm1_111 zmm1_111 zmm11_zmm14_111l_t;
(* vpmadd52huq %zmm7,%zmm12,%zmm5                  #! PC = 0x55555555659f *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm7_zmm12_000F zmm7_000 zmm12_000; spl zmm7_zmm12_000h_t zmm7_zmm12_000l_t zmm7_zmm12_000F 52;
umulj zmm7_zmm12_001F zmm7_001 zmm12_001; spl zmm7_zmm12_001h_t zmm7_zmm12_001l_t zmm7_zmm12_001F 52;
umulj zmm7_zmm12_010F zmm7_010 zmm12_010; spl zmm7_zmm12_010h_t zmm7_zmm12_010l_t zmm7_zmm12_010F 52;
umulj zmm7_zmm12_011F zmm7_011 zmm12_011; spl zmm7_zmm12_011h_t zmm7_zmm12_011l_t zmm7_zmm12_011F 52;
umulj zmm7_zmm12_100F zmm7_100 zmm12_100; spl zmm7_zmm12_100h_t zmm7_zmm12_100l_t zmm7_zmm12_100F 52;
umulj zmm7_zmm12_101F zmm7_101 zmm12_101; spl zmm7_zmm12_101h_t zmm7_zmm12_101l_t zmm7_zmm12_101F 52;
umulj zmm7_zmm12_110F zmm7_110 zmm12_110; spl zmm7_zmm12_110h_t zmm7_zmm12_110l_t zmm7_zmm12_110F 52;
umulj zmm7_zmm12_111F zmm7_111 zmm12_111; spl zmm7_zmm12_111h_t zmm7_zmm12_111l_t zmm7_zmm12_111F 52;
vpc zmm7_zmm12_000h_t@uint64 zmm7_zmm12_000h_t; vpc zmm7_zmm12_000l_t@uint64 zmm7_zmm12_000l_t;
vpc zmm7_zmm12_001h_t@uint64 zmm7_zmm12_001h_t; vpc zmm7_zmm12_001l_t@uint64 zmm7_zmm12_001l_t;
vpc zmm7_zmm12_010h_t@uint64 zmm7_zmm12_010h_t; vpc zmm7_zmm12_010l_t@uint64 zmm7_zmm12_010l_t;
vpc zmm7_zmm12_011h_t@uint64 zmm7_zmm12_011h_t; vpc zmm7_zmm12_011l_t@uint64 zmm7_zmm12_011l_t;
vpc zmm7_zmm12_100h_t@uint64 zmm7_zmm12_100h_t; vpc zmm7_zmm12_100l_t@uint64 zmm7_zmm12_100l_t;
vpc zmm7_zmm12_101h_t@uint64 zmm7_zmm12_101h_t; vpc zmm7_zmm12_101l_t@uint64 zmm7_zmm12_101l_t;
vpc zmm7_zmm12_110h_t@uint64 zmm7_zmm12_110h_t; vpc zmm7_zmm12_110l_t@uint64 zmm7_zmm12_110l_t;
vpc zmm7_zmm12_111h_t@uint64 zmm7_zmm12_111h_t; vpc zmm7_zmm12_111l_t@uint64 zmm7_zmm12_111l_t;
add zmm5_000 zmm5_000 zmm7_zmm12_000h_t;
add zmm5_001 zmm5_001 zmm7_zmm12_001h_t;
add zmm5_010 zmm5_010 zmm7_zmm12_010h_t;
add zmm5_011 zmm5_011 zmm7_zmm12_011h_t;
add zmm5_100 zmm5_100 zmm7_zmm12_100h_t;
add zmm5_101 zmm5_101 zmm7_zmm12_101h_t;
add zmm5_110 zmm5_110 zmm7_zmm12_110h_t;
add zmm5_111 zmm5_111 zmm7_zmm12_111h_t;
(* vpmadd52luq %zmm7,%zmm12,%zmm1                  #! PC = 0x5555555565a5 *)
add zmm1_000 zmm1_000 zmm7_zmm12_000l_t;
add zmm1_001 zmm1_001 zmm7_zmm12_001l_t;
add zmm1_010 zmm1_010 zmm7_zmm12_010l_t;
add zmm1_011 zmm1_011 zmm7_zmm12_011l_t;
add zmm1_100 zmm1_100 zmm7_zmm12_100l_t;
add zmm1_101 zmm1_101 zmm7_zmm12_101l_t;
add zmm1_110 zmm1_110 zmm7_zmm12_110l_t;
add zmm1_111 zmm1_111 zmm7_zmm12_111l_t;
(* vpmadd52huq %zmm10,%zmm8,%zmm5                  #! PC = 0x5555555565ab *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm10_zmm8_000F zmm10_000 zmm8_000; spl zmm10_zmm8_000h_t zmm10_zmm8_000l_t zmm10_zmm8_000F 52;
umulj zmm10_zmm8_001F zmm10_001 zmm8_001; spl zmm10_zmm8_001h_t zmm10_zmm8_001l_t zmm10_zmm8_001F 52;
umulj zmm10_zmm8_010F zmm10_010 zmm8_010; spl zmm10_zmm8_010h_t zmm10_zmm8_010l_t zmm10_zmm8_010F 52;
umulj zmm10_zmm8_011F zmm10_011 zmm8_011; spl zmm10_zmm8_011h_t zmm10_zmm8_011l_t zmm10_zmm8_011F 52;
umulj zmm10_zmm8_100F zmm10_100 zmm8_100; spl zmm10_zmm8_100h_t zmm10_zmm8_100l_t zmm10_zmm8_100F 52;
umulj zmm10_zmm8_101F zmm10_101 zmm8_101; spl zmm10_zmm8_101h_t zmm10_zmm8_101l_t zmm10_zmm8_101F 52;
umulj zmm10_zmm8_110F zmm10_110 zmm8_110; spl zmm10_zmm8_110h_t zmm10_zmm8_110l_t zmm10_zmm8_110F 52;
umulj zmm10_zmm8_111F zmm10_111 zmm8_111; spl zmm10_zmm8_111h_t zmm10_zmm8_111l_t zmm10_zmm8_111F 52;
vpc zmm10_zmm8_000h_t@uint64 zmm10_zmm8_000h_t; vpc zmm10_zmm8_000l_t@uint64 zmm10_zmm8_000l_t;
vpc zmm10_zmm8_001h_t@uint64 zmm10_zmm8_001h_t; vpc zmm10_zmm8_001l_t@uint64 zmm10_zmm8_001l_t;
vpc zmm10_zmm8_010h_t@uint64 zmm10_zmm8_010h_t; vpc zmm10_zmm8_010l_t@uint64 zmm10_zmm8_010l_t;
vpc zmm10_zmm8_011h_t@uint64 zmm10_zmm8_011h_t; vpc zmm10_zmm8_011l_t@uint64 zmm10_zmm8_011l_t;
vpc zmm10_zmm8_100h_t@uint64 zmm10_zmm8_100h_t; vpc zmm10_zmm8_100l_t@uint64 zmm10_zmm8_100l_t;
vpc zmm10_zmm8_101h_t@uint64 zmm10_zmm8_101h_t; vpc zmm10_zmm8_101l_t@uint64 zmm10_zmm8_101l_t;
vpc zmm10_zmm8_110h_t@uint64 zmm10_zmm8_110h_t; vpc zmm10_zmm8_110l_t@uint64 zmm10_zmm8_110l_t;
vpc zmm10_zmm8_111h_t@uint64 zmm10_zmm8_111h_t; vpc zmm10_zmm8_111l_t@uint64 zmm10_zmm8_111l_t;
add zmm5_000 zmm5_000 zmm10_zmm8_000h_t;
add zmm5_001 zmm5_001 zmm10_zmm8_001h_t;
add zmm5_010 zmm5_010 zmm10_zmm8_010h_t;
add zmm5_011 zmm5_011 zmm10_zmm8_011h_t;
add zmm5_100 zmm5_100 zmm10_zmm8_100h_t;
add zmm5_101 zmm5_101 zmm10_zmm8_101h_t;
add zmm5_110 zmm5_110 zmm10_zmm8_110h_t;
add zmm5_111 zmm5_111 zmm10_zmm8_111h_t;
(* vpmadd52luq %zmm10,%zmm8,%zmm1                  #! PC = 0x5555555565b1 *)
add zmm1_000 zmm1_000 zmm10_zmm8_000l_t;
add zmm1_001 zmm1_001 zmm10_zmm8_001l_t;
add zmm1_010 zmm1_010 zmm10_zmm8_010l_t;
add zmm1_011 zmm1_011 zmm10_zmm8_011l_t;
add zmm1_100 zmm1_100 zmm10_zmm8_100l_t;
add zmm1_101 zmm1_101 zmm10_zmm8_101l_t;
add zmm1_110 zmm1_110 zmm10_zmm8_110l_t;
add zmm1_111 zmm1_111 zmm10_zmm8_111l_t;
(* vpmadd52huq %zmm13,%zmm15,%zmm5                 #! PC = 0x5555555565b7 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm15_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm15_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm15_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm15_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm15_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm15_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm15_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm15_111 <u 0x10000000000000@64
];
umulj zmm13_zmm15_000F zmm13_000 zmm15_000; spl zmm13_zmm15_000h_t zmm13_zmm15_000l_t zmm13_zmm15_000F 52;
umulj zmm13_zmm15_001F zmm13_001 zmm15_001; spl zmm13_zmm15_001h_t zmm13_zmm15_001l_t zmm13_zmm15_001F 52;
umulj zmm13_zmm15_010F zmm13_010 zmm15_010; spl zmm13_zmm15_010h_t zmm13_zmm15_010l_t zmm13_zmm15_010F 52;
umulj zmm13_zmm15_011F zmm13_011 zmm15_011; spl zmm13_zmm15_011h_t zmm13_zmm15_011l_t zmm13_zmm15_011F 52;
umulj zmm13_zmm15_100F zmm13_100 zmm15_100; spl zmm13_zmm15_100h_t zmm13_zmm15_100l_t zmm13_zmm15_100F 52;
umulj zmm13_zmm15_101F zmm13_101 zmm15_101; spl zmm13_zmm15_101h_t zmm13_zmm15_101l_t zmm13_zmm15_101F 52;
umulj zmm13_zmm15_110F zmm13_110 zmm15_110; spl zmm13_zmm15_110h_t zmm13_zmm15_110l_t zmm13_zmm15_110F 52;
umulj zmm13_zmm15_111F zmm13_111 zmm15_111; spl zmm13_zmm15_111h_t zmm13_zmm15_111l_t zmm13_zmm15_111F 52;
vpc zmm13_zmm15_000h_t@uint64 zmm13_zmm15_000h_t; vpc zmm13_zmm15_000l_t@uint64 zmm13_zmm15_000l_t;
vpc zmm13_zmm15_001h_t@uint64 zmm13_zmm15_001h_t; vpc zmm13_zmm15_001l_t@uint64 zmm13_zmm15_001l_t;
vpc zmm13_zmm15_010h_t@uint64 zmm13_zmm15_010h_t; vpc zmm13_zmm15_010l_t@uint64 zmm13_zmm15_010l_t;
vpc zmm13_zmm15_011h_t@uint64 zmm13_zmm15_011h_t; vpc zmm13_zmm15_011l_t@uint64 zmm13_zmm15_011l_t;
vpc zmm13_zmm15_100h_t@uint64 zmm13_zmm15_100h_t; vpc zmm13_zmm15_100l_t@uint64 zmm13_zmm15_100l_t;
vpc zmm13_zmm15_101h_t@uint64 zmm13_zmm15_101h_t; vpc zmm13_zmm15_101l_t@uint64 zmm13_zmm15_101l_t;
vpc zmm13_zmm15_110h_t@uint64 zmm13_zmm15_110h_t; vpc zmm13_zmm15_110l_t@uint64 zmm13_zmm15_110l_t;
vpc zmm13_zmm15_111h_t@uint64 zmm13_zmm15_111h_t; vpc zmm13_zmm15_111l_t@uint64 zmm13_zmm15_111l_t;
add zmm5_000 zmm5_000 zmm13_zmm15_000h_t;
add zmm5_001 zmm5_001 zmm13_zmm15_001h_t;
add zmm5_010 zmm5_010 zmm13_zmm15_010h_t;
add zmm5_011 zmm5_011 zmm13_zmm15_011h_t;
add zmm5_100 zmm5_100 zmm13_zmm15_100h_t;
add zmm5_101 zmm5_101 zmm13_zmm15_101h_t;
add zmm5_110 zmm5_110 zmm13_zmm15_110h_t;
add zmm5_111 zmm5_111 zmm13_zmm15_111h_t;
(* vpmadd52luq %zmm13,%zmm15,%zmm1                 #! PC = 0x5555555565bd *)
add zmm1_000 zmm1_000 zmm13_zmm15_000l_t;
add zmm1_001 zmm1_001 zmm13_zmm15_001l_t;
add zmm1_010 zmm1_010 zmm13_zmm15_010l_t;
add zmm1_011 zmm1_011 zmm13_zmm15_011l_t;
add zmm1_100 zmm1_100 zmm13_zmm15_100l_t;
add zmm1_101 zmm1_101 zmm13_zmm15_101l_t;
add zmm1_110 zmm1_110 zmm13_zmm15_110l_t;
add zmm1_111 zmm1_111 zmm13_zmm15_111l_t;
(* vpsllq $0x1,%zmm5,%zmm13                        #! PC = 0x5555555565c3 *)
shl zmm13_000 zmm5_000 0x1;
shl zmm13_001 zmm5_001 0x1;
shl zmm13_010 zmm5_010 0x1;
shl zmm13_011 zmm5_011 0x1;
shl zmm13_100 zmm5_100 0x1;
shl zmm13_101 zmm5_101 0x1;
shl zmm13_110 zmm5_110 0x1;
shl zmm13_111 zmm5_111 0x1;
(* vmovdqa64 %zmm2,%zmm5                           #! PC = 0x5555555565ca *)
mov zmm5_000 zmm2_000;
mov zmm5_001 zmm2_001;
mov zmm5_010 zmm2_010;
mov zmm5_011 zmm2_011;
mov zmm5_100 zmm2_100;
mov zmm5_101 zmm2_101;
mov zmm5_110 zmm2_110;
mov zmm5_111 zmm2_111;
(* vpmadd52huq %zmm11,%zmm12,%zmm5                 #! PC = 0x5555555565d0 *)
assert true && and [
zmm11_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm11_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm11_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm11_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm11_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm11_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm11_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm11_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm11_zmm12_000F zmm11_000 zmm12_000; spl zmm11_zmm12_000h_t zmm11_zmm12_000l_t zmm11_zmm12_000F 52;
umulj zmm11_zmm12_001F zmm11_001 zmm12_001; spl zmm11_zmm12_001h_t zmm11_zmm12_001l_t zmm11_zmm12_001F 52;
umulj zmm11_zmm12_010F zmm11_010 zmm12_010; spl zmm11_zmm12_010h_t zmm11_zmm12_010l_t zmm11_zmm12_010F 52;
umulj zmm11_zmm12_011F zmm11_011 zmm12_011; spl zmm11_zmm12_011h_t zmm11_zmm12_011l_t zmm11_zmm12_011F 52;
umulj zmm11_zmm12_100F zmm11_100 zmm12_100; spl zmm11_zmm12_100h_t zmm11_zmm12_100l_t zmm11_zmm12_100F 52;
umulj zmm11_zmm12_101F zmm11_101 zmm12_101; spl zmm11_zmm12_101h_t zmm11_zmm12_101l_t zmm11_zmm12_101F 52;
umulj zmm11_zmm12_110F zmm11_110 zmm12_110; spl zmm11_zmm12_110h_t zmm11_zmm12_110l_t zmm11_zmm12_110F 52;
umulj zmm11_zmm12_111F zmm11_111 zmm12_111; spl zmm11_zmm12_111h_t zmm11_zmm12_111l_t zmm11_zmm12_111F 52;
vpc zmm11_zmm12_000h_t@uint64 zmm11_zmm12_000h_t; vpc zmm11_zmm12_000l_t@uint64 zmm11_zmm12_000l_t;
vpc zmm11_zmm12_001h_t@uint64 zmm11_zmm12_001h_t; vpc zmm11_zmm12_001l_t@uint64 zmm11_zmm12_001l_t;
vpc zmm11_zmm12_010h_t@uint64 zmm11_zmm12_010h_t; vpc zmm11_zmm12_010l_t@uint64 zmm11_zmm12_010l_t;
vpc zmm11_zmm12_011h_t@uint64 zmm11_zmm12_011h_t; vpc zmm11_zmm12_011l_t@uint64 zmm11_zmm12_011l_t;
vpc zmm11_zmm12_100h_t@uint64 zmm11_zmm12_100h_t; vpc zmm11_zmm12_100l_t@uint64 zmm11_zmm12_100l_t;
vpc zmm11_zmm12_101h_t@uint64 zmm11_zmm12_101h_t; vpc zmm11_zmm12_101l_t@uint64 zmm11_zmm12_101l_t;
vpc zmm11_zmm12_110h_t@uint64 zmm11_zmm12_110h_t; vpc zmm11_zmm12_110l_t@uint64 zmm11_zmm12_110l_t;
vpc zmm11_zmm12_111h_t@uint64 zmm11_zmm12_111h_t; vpc zmm11_zmm12_111l_t@uint64 zmm11_zmm12_111l_t;
add zmm5_000 zmm5_000 zmm11_zmm12_000h_t;
add zmm5_001 zmm5_001 zmm11_zmm12_001h_t;
add zmm5_010 zmm5_010 zmm11_zmm12_010h_t;
add zmm5_011 zmm5_011 zmm11_zmm12_011h_t;
add zmm5_100 zmm5_100 zmm11_zmm12_100h_t;
add zmm5_101 zmm5_101 zmm11_zmm12_101h_t;
add zmm5_110 zmm5_110 zmm11_zmm12_110h_t;
add zmm5_111 zmm5_111 zmm11_zmm12_111h_t;
(* vpmadd52luq %zmm11,%zmm12,%zmm13                #! PC = 0x5555555565d6 *)
add zmm13_000 zmm13_000 zmm11_zmm12_000l_t;
add zmm13_001 zmm13_001 zmm11_zmm12_001l_t;
add zmm13_010 zmm13_010 zmm11_zmm12_010l_t;
add zmm13_011 zmm13_011 zmm11_zmm12_011l_t;
add zmm13_100 zmm13_100 zmm11_zmm12_100l_t;
add zmm13_101 zmm13_101 zmm11_zmm12_101l_t;
add zmm13_110 zmm13_110 zmm11_zmm12_110l_t;
add zmm13_111 zmm13_111 zmm11_zmm12_111l_t;
(* vpmadd52huq %zmm7,%zmm8,%zmm5                   #! PC = 0x5555555565dc *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm7_zmm8_000F zmm7_000 zmm8_000; spl zmm7_zmm8_000h_t zmm7_zmm8_000l_t zmm7_zmm8_000F 52;
umulj zmm7_zmm8_001F zmm7_001 zmm8_001; spl zmm7_zmm8_001h_t zmm7_zmm8_001l_t zmm7_zmm8_001F 52;
umulj zmm7_zmm8_010F zmm7_010 zmm8_010; spl zmm7_zmm8_010h_t zmm7_zmm8_010l_t zmm7_zmm8_010F 52;
umulj zmm7_zmm8_011F zmm7_011 zmm8_011; spl zmm7_zmm8_011h_t zmm7_zmm8_011l_t zmm7_zmm8_011F 52;
umulj zmm7_zmm8_100F zmm7_100 zmm8_100; spl zmm7_zmm8_100h_t zmm7_zmm8_100l_t zmm7_zmm8_100F 52;
umulj zmm7_zmm8_101F zmm7_101 zmm8_101; spl zmm7_zmm8_101h_t zmm7_zmm8_101l_t zmm7_zmm8_101F 52;
umulj zmm7_zmm8_110F zmm7_110 zmm8_110; spl zmm7_zmm8_110h_t zmm7_zmm8_110l_t zmm7_zmm8_110F 52;
umulj zmm7_zmm8_111F zmm7_111 zmm8_111; spl zmm7_zmm8_111h_t zmm7_zmm8_111l_t zmm7_zmm8_111F 52;
vpc zmm7_zmm8_000h_t@uint64 zmm7_zmm8_000h_t; vpc zmm7_zmm8_000l_t@uint64 zmm7_zmm8_000l_t;
vpc zmm7_zmm8_001h_t@uint64 zmm7_zmm8_001h_t; vpc zmm7_zmm8_001l_t@uint64 zmm7_zmm8_001l_t;
vpc zmm7_zmm8_010h_t@uint64 zmm7_zmm8_010h_t; vpc zmm7_zmm8_010l_t@uint64 zmm7_zmm8_010l_t;
vpc zmm7_zmm8_011h_t@uint64 zmm7_zmm8_011h_t; vpc zmm7_zmm8_011l_t@uint64 zmm7_zmm8_011l_t;
vpc zmm7_zmm8_100h_t@uint64 zmm7_zmm8_100h_t; vpc zmm7_zmm8_100l_t@uint64 zmm7_zmm8_100l_t;
vpc zmm7_zmm8_101h_t@uint64 zmm7_zmm8_101h_t; vpc zmm7_zmm8_101l_t@uint64 zmm7_zmm8_101l_t;
vpc zmm7_zmm8_110h_t@uint64 zmm7_zmm8_110h_t; vpc zmm7_zmm8_110l_t@uint64 zmm7_zmm8_110l_t;
vpc zmm7_zmm8_111h_t@uint64 zmm7_zmm8_111h_t; vpc zmm7_zmm8_111l_t@uint64 zmm7_zmm8_111l_t;
add zmm5_000 zmm5_000 zmm7_zmm8_000h_t;
add zmm5_001 zmm5_001 zmm7_zmm8_001h_t;
add zmm5_010 zmm5_010 zmm7_zmm8_010h_t;
add zmm5_011 zmm5_011 zmm7_zmm8_011h_t;
add zmm5_100 zmm5_100 zmm7_zmm8_100h_t;
add zmm5_101 zmm5_101 zmm7_zmm8_101h_t;
add zmm5_110 zmm5_110 zmm7_zmm8_110h_t;
add zmm5_111 zmm5_111 zmm7_zmm8_111h_t;
(* vpmadd52luq %zmm7,%zmm8,%zmm13                  #! PC = 0x5555555565e2 *)
add zmm13_000 zmm13_000 zmm7_zmm8_000l_t;
add zmm13_001 zmm13_001 zmm7_zmm8_001l_t;
add zmm13_010 zmm13_010 zmm7_zmm8_010l_t;
add zmm13_011 zmm13_011 zmm7_zmm8_011l_t;
add zmm13_100 zmm13_100 zmm7_zmm8_100l_t;
add zmm13_101 zmm13_101 zmm7_zmm8_101l_t;
add zmm13_110 zmm13_110 zmm7_zmm8_110l_t;
add zmm13_111 zmm13_111 zmm7_zmm8_111l_t;
(* vpmadd52huq %zmm10,%zmm15,%zmm5                 #! PC = 0x5555555565e8 *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm15_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm15_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm15_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm15_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm15_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm15_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm15_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm15_111 <u 0x10000000000000@64
];
umulj zmm10_zmm15_000F zmm10_000 zmm15_000; spl zmm10_zmm15_000h_t zmm10_zmm15_000l_t zmm10_zmm15_000F 52;
umulj zmm10_zmm15_001F zmm10_001 zmm15_001; spl zmm10_zmm15_001h_t zmm10_zmm15_001l_t zmm10_zmm15_001F 52;
umulj zmm10_zmm15_010F zmm10_010 zmm15_010; spl zmm10_zmm15_010h_t zmm10_zmm15_010l_t zmm10_zmm15_010F 52;
umulj zmm10_zmm15_011F zmm10_011 zmm15_011; spl zmm10_zmm15_011h_t zmm10_zmm15_011l_t zmm10_zmm15_011F 52;
umulj zmm10_zmm15_100F zmm10_100 zmm15_100; spl zmm10_zmm15_100h_t zmm10_zmm15_100l_t zmm10_zmm15_100F 52;
umulj zmm10_zmm15_101F zmm10_101 zmm15_101; spl zmm10_zmm15_101h_t zmm10_zmm15_101l_t zmm10_zmm15_101F 52;
umulj zmm10_zmm15_110F zmm10_110 zmm15_110; spl zmm10_zmm15_110h_t zmm10_zmm15_110l_t zmm10_zmm15_110F 52;
umulj zmm10_zmm15_111F zmm10_111 zmm15_111; spl zmm10_zmm15_111h_t zmm10_zmm15_111l_t zmm10_zmm15_111F 52;
vpc zmm10_zmm15_000h_t@uint64 zmm10_zmm15_000h_t; vpc zmm10_zmm15_000l_t@uint64 zmm10_zmm15_000l_t;
vpc zmm10_zmm15_001h_t@uint64 zmm10_zmm15_001h_t; vpc zmm10_zmm15_001l_t@uint64 zmm10_zmm15_001l_t;
vpc zmm10_zmm15_010h_t@uint64 zmm10_zmm15_010h_t; vpc zmm10_zmm15_010l_t@uint64 zmm10_zmm15_010l_t;
vpc zmm10_zmm15_011h_t@uint64 zmm10_zmm15_011h_t; vpc zmm10_zmm15_011l_t@uint64 zmm10_zmm15_011l_t;
vpc zmm10_zmm15_100h_t@uint64 zmm10_zmm15_100h_t; vpc zmm10_zmm15_100l_t@uint64 zmm10_zmm15_100l_t;
vpc zmm10_zmm15_101h_t@uint64 zmm10_zmm15_101h_t; vpc zmm10_zmm15_101l_t@uint64 zmm10_zmm15_101l_t;
vpc zmm10_zmm15_110h_t@uint64 zmm10_zmm15_110h_t; vpc zmm10_zmm15_110l_t@uint64 zmm10_zmm15_110l_t;
vpc zmm10_zmm15_111h_t@uint64 zmm10_zmm15_111h_t; vpc zmm10_zmm15_111l_t@uint64 zmm10_zmm15_111l_t;
add zmm5_000 zmm5_000 zmm10_zmm15_000h_t;
add zmm5_001 zmm5_001 zmm10_zmm15_001h_t;
add zmm5_010 zmm5_010 zmm10_zmm15_010h_t;
add zmm5_011 zmm5_011 zmm10_zmm15_011h_t;
add zmm5_100 zmm5_100 zmm10_zmm15_100h_t;
add zmm5_101 zmm5_101 zmm10_zmm15_101h_t;
add zmm5_110 zmm5_110 zmm10_zmm15_110h_t;
add zmm5_111 zmm5_111 zmm10_zmm15_111h_t;
(* vpmadd52luq %zmm10,%zmm15,%zmm13                #! PC = 0x5555555565ee *)
add zmm13_000 zmm13_000 zmm10_zmm15_000l_t;
add zmm13_001 zmm13_001 zmm10_zmm15_001l_t;
add zmm13_010 zmm13_010 zmm10_zmm15_010l_t;
add zmm13_011 zmm13_011 zmm10_zmm15_011l_t;
add zmm13_100 zmm13_100 zmm10_zmm15_100l_t;
add zmm13_101 zmm13_101 zmm10_zmm15_101l_t;
add zmm13_110 zmm13_110 zmm10_zmm15_110l_t;
add zmm13_111 zmm13_111 zmm10_zmm15_111l_t;
(* vmovdqa64 %zmm2,%zmm10                          #! PC = 0x5555555565f4 *)
mov zmm10_000 zmm2_000;
mov zmm10_001 zmm2_001;
mov zmm10_010 zmm2_010;
mov zmm10_011 zmm2_011;
mov zmm10_100 zmm2_100;
mov zmm10_101 zmm2_101;
mov zmm10_110 zmm2_110;
mov zmm10_111 zmm2_111;
(* vpmadd52huq %zmm11,%zmm8,%zmm10                 #! PC = 0x5555555565fa *)
assert true && and [
zmm11_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm11_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm11_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm11_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm11_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm11_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm11_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm11_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm11_zmm8_000F zmm11_000 zmm8_000; spl zmm11_zmm8_000h_t zmm11_zmm8_000l_t zmm11_zmm8_000F 52;
umulj zmm11_zmm8_001F zmm11_001 zmm8_001; spl zmm11_zmm8_001h_t zmm11_zmm8_001l_t zmm11_zmm8_001F 52;
umulj zmm11_zmm8_010F zmm11_010 zmm8_010; spl zmm11_zmm8_010h_t zmm11_zmm8_010l_t zmm11_zmm8_010F 52;
umulj zmm11_zmm8_011F zmm11_011 zmm8_011; spl zmm11_zmm8_011h_t zmm11_zmm8_011l_t zmm11_zmm8_011F 52;
umulj zmm11_zmm8_100F zmm11_100 zmm8_100; spl zmm11_zmm8_100h_t zmm11_zmm8_100l_t zmm11_zmm8_100F 52;
umulj zmm11_zmm8_101F zmm11_101 zmm8_101; spl zmm11_zmm8_101h_t zmm11_zmm8_101l_t zmm11_zmm8_101F 52;
umulj zmm11_zmm8_110F zmm11_110 zmm8_110; spl zmm11_zmm8_110h_t zmm11_zmm8_110l_t zmm11_zmm8_110F 52;
umulj zmm11_zmm8_111F zmm11_111 zmm8_111; spl zmm11_zmm8_111h_t zmm11_zmm8_111l_t zmm11_zmm8_111F 52;
vpc zmm11_zmm8_000h_t@uint64 zmm11_zmm8_000h_t; vpc zmm11_zmm8_000l_t@uint64 zmm11_zmm8_000l_t;
vpc zmm11_zmm8_001h_t@uint64 zmm11_zmm8_001h_t; vpc zmm11_zmm8_001l_t@uint64 zmm11_zmm8_001l_t;
vpc zmm11_zmm8_010h_t@uint64 zmm11_zmm8_010h_t; vpc zmm11_zmm8_010l_t@uint64 zmm11_zmm8_010l_t;
vpc zmm11_zmm8_011h_t@uint64 zmm11_zmm8_011h_t; vpc zmm11_zmm8_011l_t@uint64 zmm11_zmm8_011l_t;
vpc zmm11_zmm8_100h_t@uint64 zmm11_zmm8_100h_t; vpc zmm11_zmm8_100l_t@uint64 zmm11_zmm8_100l_t;
vpc zmm11_zmm8_101h_t@uint64 zmm11_zmm8_101h_t; vpc zmm11_zmm8_101l_t@uint64 zmm11_zmm8_101l_t;
vpc zmm11_zmm8_110h_t@uint64 zmm11_zmm8_110h_t; vpc zmm11_zmm8_110l_t@uint64 zmm11_zmm8_110l_t;
vpc zmm11_zmm8_111h_t@uint64 zmm11_zmm8_111h_t; vpc zmm11_zmm8_111l_t@uint64 zmm11_zmm8_111l_t;
add zmm10_000 zmm10_000 zmm11_zmm8_000h_t;
add zmm10_001 zmm10_001 zmm11_zmm8_001h_t;
add zmm10_010 zmm10_010 zmm11_zmm8_010h_t;
add zmm10_011 zmm10_011 zmm11_zmm8_011h_t;
add zmm10_100 zmm10_100 zmm11_zmm8_100h_t;
add zmm10_101 zmm10_101 zmm11_zmm8_101h_t;
add zmm10_110 zmm10_110 zmm11_zmm8_110h_t;
add zmm10_111 zmm10_111 zmm11_zmm8_111h_t;
(* vpsllq $0x1,%zmm5,%zmm12                        #! PC = 0x555555556600 *)
shl zmm12_000 zmm5_000 0x1;
shl zmm12_001 zmm5_001 0x1;
shl zmm12_010 zmm5_010 0x1;
shl zmm12_011 zmm5_011 0x1;
shl zmm12_100 zmm5_100 0x1;
shl zmm12_101 zmm5_101 0x1;
shl zmm12_110 zmm5_110 0x1;
shl zmm12_111 zmm5_111 0x1;
(* vpmadd52luq %zmm11,%zmm8,%zmm12                 #! PC = 0x555555556607 *)
add zmm12_000 zmm12_000 zmm11_zmm8_000l_t;
add zmm12_001 zmm12_001 zmm11_zmm8_001l_t;
add zmm12_010 zmm12_010 zmm11_zmm8_010l_t;
add zmm12_011 zmm12_011 zmm11_zmm8_011l_t;
add zmm12_100 zmm12_100 zmm11_zmm8_100l_t;
add zmm12_101 zmm12_101 zmm11_zmm8_101l_t;
add zmm12_110 zmm12_110 zmm11_zmm8_110l_t;
add zmm12_111 zmm12_111 zmm11_zmm8_111l_t;
(* vmovdqa64 %zmm13,%zmm14                         #! PC = 0x55555555660d *)
mov zmm14_000 zmm13_000;
mov zmm14_001 zmm13_001;
mov zmm14_010 zmm13_010;
mov zmm14_011 zmm13_011;
mov zmm14_100 zmm13_100;
mov zmm14_101 zmm13_101;
mov zmm14_110 zmm13_110;
mov zmm14_111 zmm13_111;
(* vpmadd52huq %zmm7,%zmm15,%zmm10                 #! PC = 0x555555556613 *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm15_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm15_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm15_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm15_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm15_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm15_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm15_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm15_111 <u 0x10000000000000@64
];
umulj zmm7_zmm15_000F zmm7_000 zmm15_000; spl zmm7_zmm15_000h_t zmm7_zmm15_000l_t zmm7_zmm15_000F 52;
umulj zmm7_zmm15_001F zmm7_001 zmm15_001; spl zmm7_zmm15_001h_t zmm7_zmm15_001l_t zmm7_zmm15_001F 52;
umulj zmm7_zmm15_010F zmm7_010 zmm15_010; spl zmm7_zmm15_010h_t zmm7_zmm15_010l_t zmm7_zmm15_010F 52;
umulj zmm7_zmm15_011F zmm7_011 zmm15_011; spl zmm7_zmm15_011h_t zmm7_zmm15_011l_t zmm7_zmm15_011F 52;
umulj zmm7_zmm15_100F zmm7_100 zmm15_100; spl zmm7_zmm15_100h_t zmm7_zmm15_100l_t zmm7_zmm15_100F 52;
umulj zmm7_zmm15_101F zmm7_101 zmm15_101; spl zmm7_zmm15_101h_t zmm7_zmm15_101l_t zmm7_zmm15_101F 52;
umulj zmm7_zmm15_110F zmm7_110 zmm15_110; spl zmm7_zmm15_110h_t zmm7_zmm15_110l_t zmm7_zmm15_110F 52;
umulj zmm7_zmm15_111F zmm7_111 zmm15_111; spl zmm7_zmm15_111h_t zmm7_zmm15_111l_t zmm7_zmm15_111F 52;
vpc zmm7_zmm15_000h_t@uint64 zmm7_zmm15_000h_t; vpc zmm7_zmm15_000l_t@uint64 zmm7_zmm15_000l_t;
vpc zmm7_zmm15_001h_t@uint64 zmm7_zmm15_001h_t; vpc zmm7_zmm15_001l_t@uint64 zmm7_zmm15_001l_t;
vpc zmm7_zmm15_010h_t@uint64 zmm7_zmm15_010h_t; vpc zmm7_zmm15_010l_t@uint64 zmm7_zmm15_010l_t;
vpc zmm7_zmm15_011h_t@uint64 zmm7_zmm15_011h_t; vpc zmm7_zmm15_011l_t@uint64 zmm7_zmm15_011l_t;
vpc zmm7_zmm15_100h_t@uint64 zmm7_zmm15_100h_t; vpc zmm7_zmm15_100l_t@uint64 zmm7_zmm15_100l_t;
vpc zmm7_zmm15_101h_t@uint64 zmm7_zmm15_101h_t; vpc zmm7_zmm15_101l_t@uint64 zmm7_zmm15_101l_t;
vpc zmm7_zmm15_110h_t@uint64 zmm7_zmm15_110h_t; vpc zmm7_zmm15_110l_t@uint64 zmm7_zmm15_110l_t;
vpc zmm7_zmm15_111h_t@uint64 zmm7_zmm15_111h_t; vpc zmm7_zmm15_111l_t@uint64 zmm7_zmm15_111l_t;
add zmm10_000 zmm10_000 zmm7_zmm15_000h_t;
add zmm10_001 zmm10_001 zmm7_zmm15_001h_t;
add zmm10_010 zmm10_010 zmm7_zmm15_010h_t;
add zmm10_011 zmm10_011 zmm7_zmm15_011h_t;
add zmm10_100 zmm10_100 zmm7_zmm15_100h_t;
add zmm10_101 zmm10_101 zmm7_zmm15_101h_t;
add zmm10_110 zmm10_110 zmm7_zmm15_110h_t;
add zmm10_111 zmm10_111 zmm7_zmm15_111h_t;
(* # vmovq  %rax,%xmm13                              #! PC = 0x555555556619 *)
# vmovq  %rax,%xmm13                              #! 0x555555556619 = 0x555555556619;
(* vpsllq %xmm13,%zmm1,%zmm1                       #! PC = 0x55555555661e *)
shl zmm1_000 zmm1_000 1;
shl zmm1_001 zmm1_001 1;
shl zmm1_010 zmm1_010 1;
shl zmm1_011 zmm1_011 1;
shl zmm1_100 zmm1_100 1;
shl zmm1_101 zmm1_101 1;
shl zmm1_110 zmm1_110 1;
shl zmm1_111 zmm1_111 1;
assert true && and [
zmm1_000 <u 0x1c0000000000000@64,
zmm1_001 <u 0x1c0000000000000@64,
zmm1_010 <u 0x1c0000000000000@64,
zmm1_011 <u 0x1c0000000000000@64,
zmm1_100 <u 0x1c0000000000000@64,
zmm1_101 <u 0x1c0000000000000@64,
zmm1_110 <u 0x1c0000000000000@64,
zmm1_111 <u 0x1c0000000000000@64
];
(* vpmadd52luq %zmm7,%zmm15,%zmm12                 #! PC = 0x555555556624 *)
add zmm12_000 zmm12_000 zmm7_zmm15_000l_t;
add zmm12_001 zmm12_001 zmm7_zmm15_001l_t;
add zmm12_010 zmm12_010 zmm7_zmm15_010l_t;
add zmm12_011 zmm12_011 zmm7_zmm15_011l_t;
add zmm12_100 zmm12_100 zmm7_zmm15_100l_t;
add zmm12_101 zmm12_101 zmm7_zmm15_101l_t;
add zmm12_110 zmm12_110 zmm7_zmm15_110l_t;
add zmm12_111 zmm12_111 zmm7_zmm15_111l_t;
(* vmovdqa64 %zmm2,%zmm7                           #! PC = 0x55555555662a *)
mov zmm7_000 zmm2_000;
mov zmm7_001 zmm2_001;
mov zmm7_010 zmm2_010;
mov zmm7_011 zmm2_011;
mov zmm7_100 zmm2_100;
mov zmm7_101 zmm2_101;
mov zmm7_110 zmm2_110;
mov zmm7_111 zmm2_111;
(* vpmadd52huq %zmm11,%zmm15,%zmm7                 #! PC = 0x555555556630 *)
assert true && and [
zmm11_000 <u 0x10000000000000@64, zmm15_000 <u 0x10000000000000@64, zmm11_001 <u 0x10000000000000@64, zmm15_001 <u 0x10000000000000@64, zmm11_010 <u 0x10000000000000@64, zmm15_010 <u 0x10000000000000@64, zmm11_011 <u 0x10000000000000@64, zmm15_011 <u 0x10000000000000@64, zmm11_100 <u 0x10000000000000@64, zmm15_100 <u 0x10000000000000@64, zmm11_101 <u 0x10000000000000@64, zmm15_101 <u 0x10000000000000@64, zmm11_110 <u 0x10000000000000@64, zmm15_110 <u 0x10000000000000@64, zmm11_111 <u 0x10000000000000@64, zmm15_111 <u 0x10000000000000@64
];
umulj zmm11_zmm15_000F zmm11_000 zmm15_000; spl zmm11_zmm15_000h_t zmm11_zmm15_000l_t zmm11_zmm15_000F 52;
umulj zmm11_zmm15_001F zmm11_001 zmm15_001; spl zmm11_zmm15_001h_t zmm11_zmm15_001l_t zmm11_zmm15_001F 52;
umulj zmm11_zmm15_010F zmm11_010 zmm15_010; spl zmm11_zmm15_010h_t zmm11_zmm15_010l_t zmm11_zmm15_010F 52;
umulj zmm11_zmm15_011F zmm11_011 zmm15_011; spl zmm11_zmm15_011h_t zmm11_zmm15_011l_t zmm11_zmm15_011F 52;
umulj zmm11_zmm15_100F zmm11_100 zmm15_100; spl zmm11_zmm15_100h_t zmm11_zmm15_100l_t zmm11_zmm15_100F 52;
umulj zmm11_zmm15_101F zmm11_101 zmm15_101; spl zmm11_zmm15_101h_t zmm11_zmm15_101l_t zmm11_zmm15_101F 52;
umulj zmm11_zmm15_110F zmm11_110 zmm15_110; spl zmm11_zmm15_110h_t zmm11_zmm15_110l_t zmm11_zmm15_110F 52;
umulj zmm11_zmm15_111F zmm11_111 zmm15_111; spl zmm11_zmm15_111h_t zmm11_zmm15_111l_t zmm11_zmm15_111F 52;
vpc zmm11_zmm15_000h_t@uint64 zmm11_zmm15_000h_t; vpc zmm11_zmm15_000l_t@uint64 zmm11_zmm15_000l_t;
vpc zmm11_zmm15_001h_t@uint64 zmm11_zmm15_001h_t; vpc zmm11_zmm15_001l_t@uint64 zmm11_zmm15_001l_t;
vpc zmm11_zmm15_010h_t@uint64 zmm11_zmm15_010h_t; vpc zmm11_zmm15_010l_t@uint64 zmm11_zmm15_010l_t;
vpc zmm11_zmm15_011h_t@uint64 zmm11_zmm15_011h_t; vpc zmm11_zmm15_011l_t@uint64 zmm11_zmm15_011l_t;
vpc zmm11_zmm15_100h_t@uint64 zmm11_zmm15_100h_t; vpc zmm11_zmm15_100l_t@uint64 zmm11_zmm15_100l_t;
vpc zmm11_zmm15_101h_t@uint64 zmm11_zmm15_101h_t; vpc zmm11_zmm15_101l_t@uint64 zmm11_zmm15_101l_t;
vpc zmm11_zmm15_110h_t@uint64 zmm11_zmm15_110h_t; vpc zmm11_zmm15_110l_t@uint64 zmm11_zmm15_110l_t;
vpc zmm11_zmm15_111h_t@uint64 zmm11_zmm15_111h_t; vpc zmm11_zmm15_111l_t@uint64 zmm11_zmm15_111l_t;
add zmm7_000 zmm7_000 zmm11_zmm15_000h_t;
add zmm7_001 zmm7_001 zmm11_zmm15_001h_t;
add zmm7_010 zmm7_010 zmm11_zmm15_010h_t;
add zmm7_011 zmm7_011 zmm11_zmm15_011h_t;
add zmm7_100 zmm7_100 zmm11_zmm15_100h_t;
add zmm7_101 zmm7_101 zmm11_zmm15_101h_t;
add zmm7_110 zmm7_110 zmm11_zmm15_110h_t;
add zmm7_111 zmm7_111 zmm11_zmm15_111h_t;
(* vpsllq $0x1,%zmm10,%zmm8                        #! PC = 0x555555556636 *)
shl zmm8_000 zmm10_000 0x1;
shl zmm8_001 zmm10_001 0x1;
shl zmm8_010 zmm10_010 0x1;
shl zmm8_011 zmm10_011 0x1;
shl zmm8_100 zmm10_100 0x1;
shl zmm8_101 zmm10_101 0x1;
shl zmm8_110 zmm10_110 0x1;
shl zmm8_111 zmm10_111 0x1;
(* vpmadd52luq %zmm11,%zmm15,%zmm8                 #! PC = 0x55555555663d *)
add zmm8_000 zmm8_000 zmm11_zmm15_000l_t;
add zmm8_001 zmm8_001 zmm11_zmm15_001l_t;
add zmm8_010 zmm8_010 zmm11_zmm15_010l_t;
add zmm8_011 zmm8_011 zmm11_zmm15_011l_t;
add zmm8_100 zmm8_100 zmm11_zmm15_100l_t;
add zmm8_101 zmm8_101 zmm11_zmm15_101l_t;
add zmm8_110 zmm8_110 zmm11_zmm15_110l_t;
add zmm8_111 zmm8_111 zmm11_zmm15_111l_t;
(* vpsllq %xmm13,%zmm14,%zmm11                     #! PC = 0x555555556643 *)
shl zmm11_000 zmm14_000 1;
shl zmm11_001 zmm14_001 1;
shl zmm11_010 zmm14_010 1;
shl zmm11_011 zmm14_011 1;
shl zmm11_100 zmm14_100 1;
shl zmm11_101 zmm14_101 1;
shl zmm11_110 zmm14_110 1;
shl zmm11_111 zmm14_111 1;
assert true && and [
zmm11_000 <u 0x160000000000000@64,
zmm11_001 <u 0x160000000000000@64,
zmm11_010 <u 0x160000000000000@64,
zmm11_011 <u 0x160000000000000@64,
zmm11_100 <u 0x160000000000000@64,
zmm11_101 <u 0x160000000000000@64,
zmm11_110 <u 0x160000000000000@64,
zmm11_111 <u 0x160000000000000@64
];
(* vpsllq %xmm13,%zmm12,%zmm14                     #! PC = 0x555555556649 *)
shl zmm14_000 zmm12_000 1;
shl zmm14_001 zmm12_001 1;
shl zmm14_010 zmm12_010 1;
shl zmm14_011 zmm12_011 1;
shl zmm14_100 zmm12_100 1;
shl zmm14_101 zmm12_101 1;
shl zmm14_110 zmm12_110 1;
shl zmm14_111 zmm12_111 1;
assert true && and [
zmm14_000 <u 0x100000000000000@64,
zmm14_001 <u 0x100000000000000@64,
zmm14_010 <u 0x100000000000000@64,
zmm14_011 <u 0x100000000000000@64,
zmm14_100 <u 0x100000000000000@64,
zmm14_101 <u 0x100000000000000@64,
zmm14_110 <u 0x100000000000000@64,
zmm14_111 <u 0x100000000000000@64
];
(* vpsllq $0x1,%zmm7,%zmm15                        #! PC = 0x55555555664f *)
shl zmm15_000 zmm7_000 0x1;
shl zmm15_001 zmm7_001 0x1;
shl zmm15_010 zmm7_010 0x1;
shl zmm15_011 zmm7_011 0x1;
shl zmm15_100 zmm7_100 0x1;
shl zmm15_101 zmm7_101 0x1;
shl zmm15_110 zmm7_110 0x1;
shl zmm15_111 zmm7_111 0x1;
(* vpsrlq $0x33,%zmm1,%zmm12                       #! PC = 0x555555556656 *)
split zmm1_000_h zmm1_000_l zmm1_000 51;
split zmm1_001_h zmm1_001_l zmm1_001 51;
split zmm1_010_h zmm1_010_l zmm1_010 51;
split zmm1_011_h zmm1_011_l zmm1_011 51;
split zmm1_100_h zmm1_100_l zmm1_100 51;
split zmm1_101_h zmm1_101_l zmm1_101 51;
split zmm1_110_h zmm1_110_l zmm1_110 51;
split zmm1_111_h zmm1_111_l zmm1_111 51;
mov zmm12_000 zmm1_000_h;
mov zmm12_001 zmm1_001_h;
mov zmm12_010 zmm1_010_h;
mov zmm12_011 zmm1_011_h;
mov zmm12_100 zmm1_100_h;
mov zmm12_101 zmm1_101_h;
mov zmm12_110 zmm1_110_h;
mov zmm12_111 zmm1_111_h;
assert true && and [
zmm12_000 <u 56@64,
zmm12_001 <u 56@64,
zmm12_010 <u 56@64,
zmm12_011 <u 56@64,
zmm12_100 <u 56@64,
zmm12_101 <u 56@64,
zmm12_110 <u 56@64,
zmm12_111 <u 56@64
];
(* vpsllq %xmm13,%zmm15,%zmm7                      #! PC = 0x55555555665d *)
shl zmm7_000 zmm15_000 1;
shl zmm7_001 zmm15_001 1;
shl zmm7_010 zmm15_010 1;
shl zmm7_011 zmm15_011 1;
shl zmm7_100 zmm15_100 1;
shl zmm7_101 zmm15_101 1;
shl zmm7_110 zmm15_110 1;
shl zmm7_111 zmm15_111 1;
assert true && and [
zmm7_000 <u 0x40000000000000@64,
zmm7_001 <u 0x40000000000000@64,
zmm7_010 <u 0x40000000000000@64,
zmm7_011 <u 0x40000000000000@64,
zmm7_100 <u 0x40000000000000@64,
zmm7_101 <u 0x40000000000000@64,
zmm7_110 <u 0x40000000000000@64,
zmm7_111 <u 0x40000000000000@64
];
(* vpaddq %zmm12,%zmm11,%zmm10 z6 = VADD(z6, VSHR(z5, RADIX_8x1)) #! PC = 0x555555556663 *)
add zmm10_000 zmm11_000 zmm12_000;
add zmm10_001 zmm11_001 zmm12_001;
add zmm10_010 zmm11_010 zmm12_010;
add zmm10_011 zmm11_011 zmm12_011;
add zmm10_100 zmm11_100 zmm12_100;
add zmm10_101 zmm11_101 zmm12_101;
add zmm10_110 zmm11_110 zmm12_110;
add zmm10_111 zmm11_111 zmm12_111;
assert true && and [
zmm10_000 <u 0x160000000000038@64,
zmm10_001 <u 0x160000000000038@64,
zmm10_010 <u 0x160000000000038@64,
zmm10_011 <u 0x160000000000038@64,
zmm10_100 <u 0x160000000000038@64,
zmm10_101 <u 0x160000000000038@64,
zmm10_110 <u 0x160000000000038@64,
zmm10_111 <u 0x160000000000038@64
];
(* vmovdqa32 0x13acd(%rip),%zmm11        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x555555556669 *)
mov zmm11_000 L0x55555556a140;
mov zmm11_001 L0x55555556a148;
mov zmm11_010 L0x55555556a150;
mov zmm11_011 L0x55555556a158;
mov zmm11_100 L0x55555556a160;
mov zmm11_101 L0x55555556a168;
mov zmm11_110 L0x55555556a170;
mov zmm11_111 L0x55555556a178;
(* vpsllq %xmm13,%zmm8,%zmm5                       #! PC = 0x555555556673 *)
shl zmm5_000 zmm8_000 1;
shl zmm5_001 zmm8_001 1;
shl zmm5_010 zmm8_010 1;
shl zmm5_011 zmm8_011 1;
shl zmm5_100 zmm8_100 1;
shl zmm5_101 zmm8_101 1;
shl zmm5_110 zmm8_110 1;
shl zmm5_111 zmm8_111 1;
assert true && and [
zmm5_000 <u 0xa0000000000000@64,
zmm5_001 <u 0xa0000000000000@64,
zmm5_010 <u 0xa0000000000000@64,
zmm5_011 <u 0xa0000000000000@64,
zmm5_100 <u 0xa0000000000000@64,
zmm5_101 <u 0xa0000000000000@64,
zmm5_110 <u 0xa0000000000000@64,
zmm5_111 <u 0xa0000000000000@64
];
(* vpsllq %xmm13,%zmm6,%zmm6                       #! PC = 0x555555556679 *)
shl zmm6_000 zmm6_000 1;
shl zmm6_001 zmm6_001 1;
shl zmm6_010 zmm6_010 1;
shl zmm6_011 zmm6_011 1;
shl zmm6_100 zmm6_100 1;
shl zmm6_101 zmm6_101 1;
shl zmm6_110 zmm6_110 1;
shl zmm6_111 zmm6_111 1;
assert true && and [
zmm6_000 <u 0x20000000000000@64,
zmm6_001 <u 0x20000000000000@64,
zmm6_010 <u 0x20000000000000@64,
zmm6_011 <u 0x20000000000000@64,
zmm6_100 <u 0x20000000000000@64,
zmm6_101 <u 0x20000000000000@64,
zmm6_110 <u 0x20000000000000@64,
zmm6_111 <u 0x20000000000000@64
];
(* vpandd %zmm11,%zmm1,%zmm15 z5 = VAND(z5, vbmask) #! PC = 0x55555555667f *)
mov zmm15_000 zmm1_000_l;
mov zmm15_001 zmm1_001_l;
mov zmm15_010 zmm1_010_l;
mov zmm15_011 zmm1_011_l;
mov zmm15_100 zmm1_100_l;
mov zmm15_101 zmm1_101_l;
mov zmm15_110 zmm1_110_l;
mov zmm15_111 zmm1_111_l;
assert true && and [
zmm15_000 <u 0x8000000000000@64,
zmm15_001 <u 0x8000000000000@64,
zmm15_010 <u 0x8000000000000@64,
zmm15_011 <u 0x8000000000000@64,
zmm15_100 <u 0x8000000000000@64,
zmm15_101 <u 0x8000000000000@64,
zmm15_110 <u 0x8000000000000@64,
zmm15_111 <u 0x8000000000000@64
];
(* vpsrlq $0x33,%zmm14,%zmm8 VSHR(z7, RADIX_8x1) #! PC = 0x555555556685 *)
split zmm14_000_h zmm14_000_l zmm14_000 51;
split zmm14_001_h zmm14_001_l zmm14_001 51;
split zmm14_010_h zmm14_010_l zmm14_010 51;
split zmm14_011_h zmm14_011_l zmm14_011 51;
split zmm14_100_h zmm14_100_l zmm14_100 51;
split zmm14_101_h zmm14_101_l zmm14_101 51;
split zmm14_110_h zmm14_110_l zmm14_110 51;
split zmm14_111_h zmm14_111_l zmm14_111 51;
mov zmm8_000 zmm14_000_h;
mov zmm8_001 zmm14_001_h;
mov zmm8_010 zmm14_010_h;
mov zmm8_011 zmm14_011_h;
mov zmm8_100 zmm14_100_h;
mov zmm8_101 zmm14_101_h;
mov zmm8_110 zmm14_110_h;
mov zmm8_111 zmm14_111_h;
assert true && and [
zmm8_000 <u 32@64,
zmm8_001 <u 32@64,
zmm8_010 <u 32@64,
zmm8_011 <u 32@64,
zmm8_100 <u 32@64,
zmm8_101 <u 32@64,
zmm8_110 <u 32@64,
zmm8_111 <u 32@64
];
(* vpsrlq $0x33,%zmm7,%zmm1 VSHR(z9, RADIX_8x1) #! PC = 0x55555555668c *)
split zmm7_000_h zmm7_000_l zmm7_000 51;
split zmm7_001_h zmm7_001_l zmm7_001 51;
split zmm7_010_h zmm7_010_l zmm7_010 51;
split zmm7_011_h zmm7_011_l zmm7_011 51;
split zmm7_100_h zmm7_100_l zmm7_100 51;
split zmm7_101_h zmm7_101_l zmm7_101 51;
split zmm7_110_h zmm7_110_l zmm7_110 51;
split zmm7_111_h zmm7_111_l zmm7_111 51;
mov zmm1_000 zmm7_000_h;
mov zmm1_001 zmm7_001_h;
mov zmm1_010 zmm7_010_h;
mov zmm1_011 zmm7_011_h;
mov zmm1_100 zmm7_100_h;
mov zmm1_101 zmm7_101_h;
mov zmm1_110 zmm7_110_h;
mov zmm1_111 zmm7_111_h;
assert true && and [
zmm1_000 <u 8@64,
zmm1_001 <u 8@64,
zmm1_010 <u 8@64,
zmm1_011 <u 8@64,
zmm1_100 <u 8@64,
zmm1_101 <u 8@64,
zmm1_110 <u 8@64,
zmm1_111 <u 8@64
];
(* vpmadd52luq 0x13ae3(%rip),%zmm1,%zmm6 z0 = VMACLO(z0, t, vconstc2) # 0x55555556a180#! EA = L0x55555556a180; Value = 0x0000000000000169; PC = 0x555555556693 *)
assert true && and [
L0x55555556a180 <u 0x10000000000000@64, zmm1_000 <u 0x10000000000000@64, L0x55555556a188 <u 0x10000000000000@64, zmm1_001 <u 0x10000000000000@64, L0x55555556a190 <u 0x10000000000000@64, zmm1_010 <u 0x10000000000000@64, L0x55555556a198 <u 0x10000000000000@64, zmm1_011 <u 0x10000000000000@64, L0x55555556a1a0 <u 0x10000000000000@64, zmm1_100 <u 0x10000000000000@64, L0x55555556a1a8 <u 0x10000000000000@64, zmm1_101 <u 0x10000000000000@64, L0x55555556a1b0 <u 0x10000000000000@64, zmm1_110 <u 0x10000000000000@64, L0x55555556a1b8 <u 0x10000000000000@64, zmm1_111 <u 0x10000000000000@64
];
umulj L0x55555556a180_zmm1_000F L0x55555556a180 zmm1_000; spl L0x55555556a180_zmm1_000h_t L0x55555556a180_zmm1_000l_t L0x55555556a180_zmm1_000F 52;
umulj L0x55555556a180_zmm1_001F L0x55555556a188 zmm1_001; spl L0x55555556a180_zmm1_001h_t L0x55555556a180_zmm1_001l_t L0x55555556a180_zmm1_001F 52;
umulj L0x55555556a180_zmm1_010F L0x55555556a190 zmm1_010; spl L0x55555556a180_zmm1_010h_t L0x55555556a180_zmm1_010l_t L0x55555556a180_zmm1_010F 52;
umulj L0x55555556a180_zmm1_011F L0x55555556a198 zmm1_011; spl L0x55555556a180_zmm1_011h_t L0x55555556a180_zmm1_011l_t L0x55555556a180_zmm1_011F 52;
umulj L0x55555556a180_zmm1_100F L0x55555556a1a0 zmm1_100; spl L0x55555556a180_zmm1_100h_t L0x55555556a180_zmm1_100l_t L0x55555556a180_zmm1_100F 52;
umulj L0x55555556a180_zmm1_101F L0x55555556a1a8 zmm1_101; spl L0x55555556a180_zmm1_101h_t L0x55555556a180_zmm1_101l_t L0x55555556a180_zmm1_101F 52;
umulj L0x55555556a180_zmm1_110F L0x55555556a1b0 zmm1_110; spl L0x55555556a180_zmm1_110h_t L0x55555556a180_zmm1_110l_t L0x55555556a180_zmm1_110F 52;
umulj L0x55555556a180_zmm1_111F L0x55555556a1b8 zmm1_111; spl L0x55555556a180_zmm1_111h_t L0x55555556a180_zmm1_111l_t L0x55555556a180_zmm1_111F 52;
vpc L0x55555556a180_zmm1_000h_t@uint64 L0x55555556a180_zmm1_000h_t; vpc L0x55555556a180_zmm1_000l_t@uint64 L0x55555556a180_zmm1_000l_t;
vpc L0x55555556a180_zmm1_001h_t@uint64 L0x55555556a180_zmm1_001h_t; vpc L0x55555556a180_zmm1_001l_t@uint64 L0x55555556a180_zmm1_001l_t;
vpc L0x55555556a180_zmm1_010h_t@uint64 L0x55555556a180_zmm1_010h_t; vpc L0x55555556a180_zmm1_010l_t@uint64 L0x55555556a180_zmm1_010l_t;
vpc L0x55555556a180_zmm1_011h_t@uint64 L0x55555556a180_zmm1_011h_t; vpc L0x55555556a180_zmm1_011l_t@uint64 L0x55555556a180_zmm1_011l_t;
vpc L0x55555556a180_zmm1_100h_t@uint64 L0x55555556a180_zmm1_100h_t; vpc L0x55555556a180_zmm1_100l_t@uint64 L0x55555556a180_zmm1_100l_t;
vpc L0x55555556a180_zmm1_101h_t@uint64 L0x55555556a180_zmm1_101h_t; vpc L0x55555556a180_zmm1_101l_t@uint64 L0x55555556a180_zmm1_101l_t;
vpc L0x55555556a180_zmm1_110h_t@uint64 L0x55555556a180_zmm1_110h_t; vpc L0x55555556a180_zmm1_110l_t@uint64 L0x55555556a180_zmm1_110l_t;
vpc L0x55555556a180_zmm1_111h_t@uint64 L0x55555556a180_zmm1_111h_t; vpc L0x55555556a180_zmm1_111l_t@uint64 L0x55555556a180_zmm1_111l_t;
add zmm6_000 zmm6_000 L0x55555556a180_zmm1_000l_t;
add zmm6_001 zmm6_001 L0x55555556a180_zmm1_001l_t;
add zmm6_010 zmm6_010 L0x55555556a180_zmm1_010l_t;
add zmm6_011 zmm6_011 L0x55555556a180_zmm1_011l_t;
add zmm6_100 zmm6_100 L0x55555556a180_zmm1_100l_t;
add zmm6_101 zmm6_101 L0x55555556a180_zmm1_101l_t;
add zmm6_110 zmm6_110 L0x55555556a180_zmm1_110l_t;
add zmm6_111 zmm6_111 L0x55555556a180_zmm1_111l_t;
assert true && and [
L0x55555556a180_zmm1_000h_t = 0@64,
L0x55555556a180_zmm1_001h_t = 0@64,
L0x55555556a180_zmm1_010h_t = 0@64,
L0x55555556a180_zmm1_011h_t = 0@64,
L0x55555556a180_zmm1_100h_t = 0@64,
L0x55555556a180_zmm1_101h_t = 0@64,
L0x55555556a180_zmm1_110h_t = 0@64,
L0x55555556a180_zmm1_111h_t = 0@64
];
assume and [
L0x55555556a180_zmm1_000h_t = 0,
L0x55555556a180_zmm1_001h_t = 0,
L0x55555556a180_zmm1_010h_t = 0,
L0x55555556a180_zmm1_011h_t = 0,
L0x55555556a180_zmm1_100h_t = 0,
L0x55555556a180_zmm1_101h_t = 0,
L0x55555556a180_zmm1_110h_t = 0,
L0x55555556a180_zmm1_111h_t = 0
] && true;
assert true && and [
zmm6_000 <u 0x20000000001000@64,
zmm6_001 <u 0x20000000001000@64,
zmm6_010 <u 0x20000000001000@64,
zmm6_011 <u 0x20000000001000@64,
zmm6_100 <u 0x20000000001000@64,
zmm6_101 <u 0x20000000001000@64,
zmm6_110 <u 0x20000000001000@64,
zmm6_111 <u 0x20000000001000@64
];
(* vpsllq %xmm13,%zmm9,%zmm9                       #! PC = 0x55555555669d *)
shl zmm9_000 zmm9_000 1;
shl zmm9_001 zmm9_001 1;
shl zmm9_010 zmm9_010 1;
shl zmm9_011 zmm9_011 1;
shl zmm9_100 zmm9_100 1;
shl zmm9_101 zmm9_101 1;
shl zmm9_110 zmm9_110 1;
shl zmm9_111 zmm9_111 1;
assert true && and [
zmm9_000 <u 0x80000000000000@64,
zmm9_001 <u 0x80000000000000@64,
zmm9_010 <u 0x80000000000000@64,
zmm9_011 <u 0x80000000000000@64,
zmm9_100 <u 0x80000000000000@64,
zmm9_101 <u 0x80000000000000@64,
zmm9_110 <u 0x80000000000000@64,
zmm9_111 <u 0x80000000000000@64
];
(* vpsllq %xmm13,%zmm3,%zmm3                       #! PC = 0x5555555566a3 *)
shl zmm3_000 zmm3_000 1;
shl zmm3_001 zmm3_001 1;
shl zmm3_010 zmm3_010 1;
shl zmm3_011 zmm3_011 1;
shl zmm3_100 zmm3_100 1;
shl zmm3_101 zmm3_101 1;
shl zmm3_110 zmm3_110 1;
shl zmm3_111 zmm3_111 1;
assert true && and [
zmm3_000 <u 0xe0000000000000@64,
zmm3_001 <u 0xe0000000000000@64,
zmm3_010 <u 0xe0000000000000@64,
zmm3_011 <u 0xe0000000000000@64,
zmm3_100 <u 0xe0000000000000@64,
zmm3_101 <u 0xe0000000000000@64,
zmm3_110 <u 0xe0000000000000@64,
zmm3_111 <u 0xe0000000000000@64
];
(* vpsllq %xmm13,%zmm4,%zmm4                       #! PC = 0x5555555566a9 *)
shl zmm4_000 zmm4_000 1;
shl zmm4_001 zmm4_001 1;
shl zmm4_010 zmm4_010 1;
shl zmm4_011 zmm4_011 1;
shl zmm4_100 zmm4_100 1;
shl zmm4_101 zmm4_101 1;
shl zmm4_110 zmm4_110 1;
shl zmm4_111 zmm4_111 1;
assert true && and [
zmm4_000 <u 0x140000000000000@64,
zmm4_001 <u 0x140000000000000@64,
zmm4_010 <u 0x140000000000000@64,
zmm4_011 <u 0x140000000000000@64,
zmm4_100 <u 0x140000000000000@64,
zmm4_101 <u 0x140000000000000@64,
zmm4_110 <u 0x140000000000000@64,
zmm4_111 <u 0x140000000000000@64
];
(* vpsllq %xmm13,%zmm0,%zmm0                       #! PC = 0x5555555566af *)
shl zmm0_000 zmm0_000 1;
shl zmm0_001 zmm0_001 1;
shl zmm0_010 zmm0_010 1;
shl zmm0_011 zmm0_011 1;
shl zmm0_100 zmm0_100 1;
shl zmm0_101 zmm0_101 1;
shl zmm0_110 zmm0_110 1;
shl zmm0_111 zmm0_111 1;
assert true && and [
zmm0_000 <u 0x1a0000000000000@64,
zmm0_001 <u 0x1a0000000000000@64,
zmm0_010 <u 0x1a0000000000000@64,
zmm0_011 <u 0x1a0000000000000@64,
zmm0_100 <u 0x1a0000000000000@64,
zmm0_101 <u 0x1a0000000000000@64,
zmm0_110 <u 0x1a0000000000000@64,
zmm0_111 <u 0x1a0000000000000@64
];
(* vpaddq %zmm5,%zmm8,%zmm13 z8 = VADD(z8, VSHR(z7, RADIX_8x1)) #! PC = 0x5555555566b5 *)
add zmm13_000 zmm8_000 zmm5_000;
add zmm13_001 zmm8_001 zmm5_001;
add zmm13_010 zmm8_010 zmm5_010;
add zmm13_011 zmm8_011 zmm5_011;
add zmm13_100 zmm8_100 zmm5_100;
add zmm13_101 zmm8_101 zmm5_101;
add zmm13_110 zmm8_110 zmm5_110;
add zmm13_111 zmm8_111 zmm5_111;
assert true && and [
zmm13_000 <u 0xa0000000000020@64,
zmm13_001 <u 0xa0000000000020@64,
zmm13_010 <u 0xa0000000000020@64,
zmm13_011 <u 0xa0000000000020@64,
zmm13_100 <u 0xa0000000000020@64,
zmm13_101 <u 0xa0000000000020@64,
zmm13_110 <u 0xa0000000000020@64,
zmm13_111 <u 0xa0000000000020@64
];
(* vpandd %zmm11,%zmm7,%zmm7 z9 = VAND(z9, vbmask) #! PC = 0x5555555566bb *)
mov zmm7_000 zmm7_000_l;
mov zmm7_001 zmm7_001_l;
mov zmm7_010 zmm7_010_l;
mov zmm7_011 zmm7_011_l;
mov zmm7_100 zmm7_100_l;
mov zmm7_101 zmm7_101_l;
mov zmm7_110 zmm7_110_l;
mov zmm7_111 zmm7_111_l;
assert true && and [
zmm7_000 <u 0x8000000000000@64,
zmm7_001 <u 0x8000000000000@64,
zmm7_010 <u 0x8000000000000@64,
zmm7_011 <u 0x8000000000000@64,
zmm7_100 <u 0x8000000000000@64,
zmm7_101 <u 0x8000000000000@64,
zmm7_110 <u 0x8000000000000@64,
zmm7_111 <u 0x8000000000000@64
];
(* vpandd %zmm11,%zmm10,%zmm5 z6 = VAND(z6, vbmask) #! PC = 0x5555555566c1 *)
split zmm10_000_h zmm10_000_l zmm10_000 51;
split zmm10_001_h zmm10_001_l zmm10_001 51;
split zmm10_010_h zmm10_010_l zmm10_010 51;
split zmm10_011_h zmm10_011_l zmm10_011 51;
split zmm10_100_h zmm10_100_l zmm10_100 51;
split zmm10_101_h zmm10_101_l zmm10_101 51;
split zmm10_110_h zmm10_110_l zmm10_110 51;
split zmm10_111_h zmm10_111_l zmm10_111 51;
mov zmm5_000 zmm10_000_l;
mov zmm5_001 zmm10_001_l;
mov zmm5_010 zmm10_010_l;
mov zmm5_011 zmm10_011_l;
mov zmm5_100 zmm10_100_l;
mov zmm5_101 zmm10_101_l;
mov zmm5_110 zmm10_110_l;
mov zmm5_111 zmm10_111_l;
assert true && and [
zmm5_000 <u 0x8000000000000@64,
zmm5_001 <u 0x8000000000000@64,
zmm5_010 <u 0x8000000000000@64,
zmm5_011 <u 0x8000000000000@64,
zmm5_100 <u 0x8000000000000@64,
zmm5_101 <u 0x8000000000000@64,
zmm5_110 <u 0x8000000000000@64,
zmm5_111 <u 0x8000000000000@64
];
(* vpsrlq $0x33,%zmm10,%zmm12 VSHR(z6, RADIX_8x1) #! PC = 0x5555555566c7 *)
mov zmm12_000 zmm10_000_h;
mov zmm12_001 zmm10_001_h;
mov zmm12_010 zmm10_010_h;
mov zmm12_011 zmm10_011_h;
mov zmm12_100 zmm10_100_h;
mov zmm12_101 zmm10_101_h;
mov zmm12_110 zmm10_110_h;
mov zmm12_111 zmm10_111_h;
assert true && and [
zmm12_000 <u 44@64,
zmm12_001 <u 44@64,
zmm12_010 <u 44@64,
zmm12_011 <u 44@64,
zmm12_100 <u 44@64,
zmm12_101 <u 44@64,
zmm12_110 <u 44@64,
zmm12_111 <u 44@64
];
(* vpsrlq $0x33,%zmm13,%zmm10 VSHR(z8, RADIX_8x1) #! PC = 0x5555555566ce *)
split zmm13_000_h zmm13_000_l zmm13_000 51;
split zmm13_001_h zmm13_001_l zmm13_001 51;
split zmm13_010_h zmm13_010_l zmm13_010 51;
split zmm13_011_h zmm13_011_l zmm13_011 51;
split zmm13_100_h zmm13_100_l zmm13_100 51;
split zmm13_101_h zmm13_101_l zmm13_101 51;
split zmm13_110_h zmm13_110_l zmm13_110 51;
split zmm13_111_h zmm13_111_l zmm13_111 51;
mov zmm10_000 zmm13_000_h;
mov zmm10_001 zmm13_001_h;
mov zmm10_010 zmm13_010_h;
mov zmm10_011 zmm13_011_h;
mov zmm10_100 zmm13_100_h;
mov zmm10_101 zmm13_101_h;
mov zmm10_110 zmm13_110_h;
mov zmm10_111 zmm13_111_h;
assert true && and [
zmm10_000 <u 20@64,
zmm10_001 <u 20@64,
zmm10_010 <u 20@64,
zmm10_011 <u 20@64,
zmm10_100 <u 20@64,
zmm10_101 <u 20@64,
zmm10_110 <u 20@64,
zmm10_111 <u 20@64
];
(* vpaddq %zmm7,%zmm10,%zmm8 z9 = VADD(z9, VSHR(z8, RADIX_8x1)) #! PC = 0x5555555566d5 *)
add zmm8_000 zmm10_000 zmm7_000;
add zmm8_001 zmm10_001 zmm7_001;
add zmm8_010 zmm10_010 zmm7_010;
add zmm8_011 zmm10_011 zmm7_011;
add zmm8_100 zmm10_100 zmm7_100;
add zmm8_101 zmm10_101 zmm7_101;
add zmm8_110 zmm10_110 zmm7_110;
add zmm8_111 zmm10_111 zmm7_111;
assert true && and [
zmm8_000 <u 0x8000000000014@64,
zmm8_001 <u 0x8000000000014@64,
zmm8_010 <u 0x8000000000014@64,
zmm8_011 <u 0x8000000000014@64,
zmm8_100 <u 0x8000000000014@64,
zmm8_101 <u 0x8000000000014@64,
zmm8_110 <u 0x8000000000014@64,
zmm8_111 <u 0x8000000000014@64
];
(* vpandd %zmm11,%zmm13,%zmm10 z8 = VAND(z8, vbmask) #! PC = 0x5555555566db *)
mov zmm10_000 zmm13_000_l;
mov zmm10_001 zmm13_001_l;
mov zmm10_010 zmm13_010_l;
mov zmm10_011 zmm13_011_l;
mov zmm10_100 zmm13_100_l;
mov zmm10_101 zmm13_101_l;
mov zmm10_110 zmm13_110_l;
mov zmm10_111 zmm13_111_l;
assert true && and [
zmm10_000 <u 0x8000000000000@64,
zmm10_001 <u 0x8000000000000@64,
zmm10_010 <u 0x8000000000000@64,
zmm10_011 <u 0x8000000000000@64,
zmm10_100 <u 0x8000000000000@64,
zmm10_101 <u 0x8000000000000@64,
zmm10_110 <u 0x8000000000000@64,
zmm10_111 <u 0x8000000000000@64
];
(* vpbroadcastq 0x13a15(%rip),%zmm13        # 0x55555556a100#! EA = L0x55555556a100; Value = 0x0000000000000013; PC = 0x5555555566e1 *)
mov zmm13_000 L0x55555556a100;
mov zmm13_001 L0x55555556a100;
mov zmm13_010 L0x55555556a100;
mov zmm13_011 L0x55555556a100;
mov zmm13_100 L0x55555556a100;
mov zmm13_101 L0x55555556a100;
mov zmm13_110 L0x55555556a100;
mov zmm13_111 L0x55555556a100;
(* vpandd %zmm11,%zmm14,%zmm14 z7 = VAND(z7, vbmask) #! PC = 0x5555555566eb *)
mov zmm14_000 zmm14_000_l;
mov zmm14_001 zmm14_001_l;
mov zmm14_010 zmm14_010_l;
mov zmm14_011 zmm14_011_l;
mov zmm14_100 zmm14_100_l;
mov zmm14_101 zmm14_101_l;
mov zmm14_110 zmm14_110_l;
mov zmm14_111 zmm14_111_l;
assert true && and [
zmm14_000 <u 0x8000000000000@64,
zmm14_001 <u 0x8000000000000@64,
zmm14_010 <u 0x8000000000000@64,
zmm14_011 <u 0x8000000000000@64,
zmm14_100 <u 0x8000000000000@64,
zmm14_101 <u 0x8000000000000@64,
zmm14_110 <u 0x8000000000000@64,
zmm14_111 <u 0x8000000000000@64
];
(* vpmadd52luq %zmm13,%zmm8,%zmm0 z4 = VMACLO(z4, z9, vconstc) #! PC = 0x5555555566f1 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm13_zmm8_000F zmm13_000 zmm8_000; spl zmm13_zmm8_000h_t zmm13_zmm8_000l_t zmm13_zmm8_000F 52;
umulj zmm13_zmm8_001F zmm13_001 zmm8_001; spl zmm13_zmm8_001h_t zmm13_zmm8_001l_t zmm13_zmm8_001F 52;
umulj zmm13_zmm8_010F zmm13_010 zmm8_010; spl zmm13_zmm8_010h_t zmm13_zmm8_010l_t zmm13_zmm8_010F 52;
umulj zmm13_zmm8_011F zmm13_011 zmm8_011; spl zmm13_zmm8_011h_t zmm13_zmm8_011l_t zmm13_zmm8_011F 52;
umulj zmm13_zmm8_100F zmm13_100 zmm8_100; spl zmm13_zmm8_100h_t zmm13_zmm8_100l_t zmm13_zmm8_100F 52;
umulj zmm13_zmm8_101F zmm13_101 zmm8_101; spl zmm13_zmm8_101h_t zmm13_zmm8_101l_t zmm13_zmm8_101F 52;
umulj zmm13_zmm8_110F zmm13_110 zmm8_110; spl zmm13_zmm8_110h_t zmm13_zmm8_110l_t zmm13_zmm8_110F 52;
umulj zmm13_zmm8_111F zmm13_111 zmm8_111; spl zmm13_zmm8_111h_t zmm13_zmm8_111l_t zmm13_zmm8_111F 52;
vpc zmm13_zmm8_000h_t@uint64 zmm13_zmm8_000h_t; vpc zmm13_zmm8_000l_t@uint64 zmm13_zmm8_000l_t;
vpc zmm13_zmm8_001h_t@uint64 zmm13_zmm8_001h_t; vpc zmm13_zmm8_001l_t@uint64 zmm13_zmm8_001l_t;
vpc zmm13_zmm8_010h_t@uint64 zmm13_zmm8_010h_t; vpc zmm13_zmm8_010l_t@uint64 zmm13_zmm8_010l_t;
vpc zmm13_zmm8_011h_t@uint64 zmm13_zmm8_011h_t; vpc zmm13_zmm8_011l_t@uint64 zmm13_zmm8_011l_t;
vpc zmm13_zmm8_100h_t@uint64 zmm13_zmm8_100h_t; vpc zmm13_zmm8_100l_t@uint64 zmm13_zmm8_100l_t;
vpc zmm13_zmm8_101h_t@uint64 zmm13_zmm8_101h_t; vpc zmm13_zmm8_101l_t@uint64 zmm13_zmm8_101l_t;
vpc zmm13_zmm8_110h_t@uint64 zmm13_zmm8_110h_t; vpc zmm13_zmm8_110l_t@uint64 zmm13_zmm8_110l_t;
vpc zmm13_zmm8_111h_t@uint64 zmm13_zmm8_111h_t; vpc zmm13_zmm8_111l_t@uint64 zmm13_zmm8_111l_t;
add zmm0_000 zmm0_000 zmm13_zmm8_000l_t;
add zmm0_001 zmm0_001 zmm13_zmm8_001l_t;
add zmm0_010 zmm0_010 zmm13_zmm8_010l_t;
add zmm0_011 zmm0_011 zmm13_zmm8_011l_t;
add zmm0_100 zmm0_100 zmm13_zmm8_100l_t;
add zmm0_101 zmm0_101 zmm13_zmm8_101l_t;
add zmm0_110 zmm0_110 zmm13_zmm8_110l_t;
add zmm0_111 zmm0_111 zmm13_zmm8_111l_t;
assert true && and [
zmm0_000 <u 0x1b0000000000000@64,
zmm0_001 <u 0x1b0000000000000@64,
zmm0_010 <u 0x1b0000000000000@64,
zmm0_011 <u 0x1b0000000000000@64,
zmm0_100 <u 0x1b0000000000000@64,
zmm0_101 <u 0x1b0000000000000@64,
zmm0_110 <u 0x1b0000000000000@64,
zmm0_111 <u 0x1b0000000000000@64
];
(* vmovdqa64 %zmm2,%zmm1                           #! PC = 0x5555555566f7 *)
mov zmm1_000 zmm2_000;
mov zmm1_001 zmm2_001;
mov zmm1_010 zmm2_010;
mov zmm1_011 zmm2_011;
mov zmm1_100 zmm2_100;
mov zmm1_101 zmm2_101;
mov zmm1_110 zmm2_110;
mov zmm1_111 zmm2_111;
(* vpmadd52luq %zmm13,%zmm15,%zmm6 z0 = VMACLO(z0, z5, vconstc) #! PC = 0x5555555566fd *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm15_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm15_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm15_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm15_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm15_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm15_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm15_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm15_111 <u 0x10000000000000@64
];
umulj zmm13_zmm15_000F zmm13_000 zmm15_000; spl zmm13_zmm15_000h_t zmm13_zmm15_000l_t zmm13_zmm15_000F 52;
umulj zmm13_zmm15_001F zmm13_001 zmm15_001; spl zmm13_zmm15_001h_t zmm13_zmm15_001l_t zmm13_zmm15_001F 52;
umulj zmm13_zmm15_010F zmm13_010 zmm15_010; spl zmm13_zmm15_010h_t zmm13_zmm15_010l_t zmm13_zmm15_010F 52;
umulj zmm13_zmm15_011F zmm13_011 zmm15_011; spl zmm13_zmm15_011h_t zmm13_zmm15_011l_t zmm13_zmm15_011F 52;
umulj zmm13_zmm15_100F zmm13_100 zmm15_100; spl zmm13_zmm15_100h_t zmm13_zmm15_100l_t zmm13_zmm15_100F 52;
umulj zmm13_zmm15_101F zmm13_101 zmm15_101; spl zmm13_zmm15_101h_t zmm13_zmm15_101l_t zmm13_zmm15_101F 52;
umulj zmm13_zmm15_110F zmm13_110 zmm15_110; spl zmm13_zmm15_110h_t zmm13_zmm15_110l_t zmm13_zmm15_110F 52;
umulj zmm13_zmm15_111F zmm13_111 zmm15_111; spl zmm13_zmm15_111h_t zmm13_zmm15_111l_t zmm13_zmm15_111F 52;
vpc zmm13_zmm15_000h_t@uint64 zmm13_zmm15_000h_t; vpc zmm13_zmm15_000l_t@uint64 zmm13_zmm15_000l_t;
vpc zmm13_zmm15_001h_t@uint64 zmm13_zmm15_001h_t; vpc zmm13_zmm15_001l_t@uint64 zmm13_zmm15_001l_t;
vpc zmm13_zmm15_010h_t@uint64 zmm13_zmm15_010h_t; vpc zmm13_zmm15_010l_t@uint64 zmm13_zmm15_010l_t;
vpc zmm13_zmm15_011h_t@uint64 zmm13_zmm15_011h_t; vpc zmm13_zmm15_011l_t@uint64 zmm13_zmm15_011l_t;
vpc zmm13_zmm15_100h_t@uint64 zmm13_zmm15_100h_t; vpc zmm13_zmm15_100l_t@uint64 zmm13_zmm15_100l_t;
vpc zmm13_zmm15_101h_t@uint64 zmm13_zmm15_101h_t; vpc zmm13_zmm15_101l_t@uint64 zmm13_zmm15_101l_t;
vpc zmm13_zmm15_110h_t@uint64 zmm13_zmm15_110h_t; vpc zmm13_zmm15_110l_t@uint64 zmm13_zmm15_110l_t;
vpc zmm13_zmm15_111h_t@uint64 zmm13_zmm15_111h_t; vpc zmm13_zmm15_111l_t@uint64 zmm13_zmm15_111l_t;
add zmm6_000 zmm6_000 zmm13_zmm15_000l_t;
add zmm6_001 zmm6_001 zmm13_zmm15_001l_t;
add zmm6_010 zmm6_010 zmm13_zmm15_010l_t;
add zmm6_011 zmm6_011 zmm13_zmm15_011l_t;
add zmm6_100 zmm6_100 zmm13_zmm15_100l_t;
add zmm6_101 zmm6_101 zmm13_zmm15_101l_t;
add zmm6_110 zmm6_110 zmm13_zmm15_110l_t;
add zmm6_111 zmm6_111 zmm13_zmm15_111l_t;
assert true && and [
zmm6_000 <u 0x30000000001000@64,
zmm6_001 <u 0x30000000001000@64,
zmm6_010 <u 0x30000000001000@64,
zmm6_011 <u 0x30000000001000@64,
zmm6_100 <u 0x30000000001000@64,
zmm6_101 <u 0x30000000001000@64,
zmm6_110 <u 0x30000000001000@64,
zmm6_111 <u 0x30000000001000@64
];
(* vpmadd52huq %zmm13,%zmm15,%zmm1 t = VMACHI(t, z5, vconstc) #! PC = 0x555555556703 *)
add zmm1_000 zmm1_000 zmm13_zmm15_000h_t;
add zmm1_001 zmm1_001 zmm13_zmm15_001h_t;
add zmm1_010 zmm1_010 zmm13_zmm15_010h_t;
add zmm1_011 zmm1_011 zmm13_zmm15_011h_t;
add zmm1_100 zmm1_100 zmm13_zmm15_100h_t;
add zmm1_101 zmm1_101 zmm13_zmm15_101h_t;
add zmm1_110 zmm1_110 zmm13_zmm15_110h_t;
add zmm1_111 zmm1_111 zmm13_zmm15_111h_t;
assert true && and [
zmm1_000 <u 16@64,
zmm1_001 <u 16@64,
zmm1_010 <u 16@64,
zmm1_011 <u 16@64,
zmm1_100 <u 16@64,
zmm1_101 <u 16@64,
zmm1_110 <u 16@64,
zmm1_111 <u 16@64
];
(* vpaddq %zmm14,%zmm12,%zmm12 z7 = VADD(z7, VSHR(z6, RADIX_8x1)) #! PC = 0x555555556709 *)
add zmm12_000 zmm12_000 zmm14_000;
add zmm12_001 zmm12_001 zmm14_001;
add zmm12_010 zmm12_010 zmm14_010;
add zmm12_011 zmm12_011 zmm14_011;
add zmm12_100 zmm12_100 zmm14_100;
add zmm12_101 zmm12_101 zmm14_101;
add zmm12_110 zmm12_110 zmm14_110;
add zmm12_111 zmm12_111 zmm14_111;
assert true && and [
zmm12_000 <u 0x800000000002c@64,
zmm12_001 <u 0x800000000002c@64,
zmm12_010 <u 0x800000000002c@64,
zmm12_011 <u 0x800000000002c@64,
zmm12_100 <u 0x800000000002c@64,
zmm12_101 <u 0x800000000002c@64,
zmm12_110 <u 0x800000000002c@64,
zmm12_111 <u 0x800000000002c@64
];
(* vmovdqa64 %zmm2,%zmm15                          #! PC = 0x55555555670f *)
mov zmm15_000 zmm2_000;
mov zmm15_001 zmm2_001;
mov zmm15_010 zmm2_010;
mov zmm15_011 zmm2_011;
mov zmm15_100 zmm2_100;
mov zmm15_101 zmm2_101;
mov zmm15_110 zmm2_110;
mov zmm15_111 zmm2_111;
(* vpmadd52huq %zmm13,%zmm12,%zmm15 t = VMACHI(t, z7, vconstc) #! PC = 0x555555556715 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm13_zmm12_000F zmm13_000 zmm12_000; spl zmm13_zmm12_000h_t zmm13_zmm12_000l_t zmm13_zmm12_000F 52;
umulj zmm13_zmm12_001F zmm13_001 zmm12_001; spl zmm13_zmm12_001h_t zmm13_zmm12_001l_t zmm13_zmm12_001F 52;
umulj zmm13_zmm12_010F zmm13_010 zmm12_010; spl zmm13_zmm12_010h_t zmm13_zmm12_010l_t zmm13_zmm12_010F 52;
umulj zmm13_zmm12_011F zmm13_011 zmm12_011; spl zmm13_zmm12_011h_t zmm13_zmm12_011l_t zmm13_zmm12_011F 52;
umulj zmm13_zmm12_100F zmm13_100 zmm12_100; spl zmm13_zmm12_100h_t zmm13_zmm12_100l_t zmm13_zmm12_100F 52;
umulj zmm13_zmm12_101F zmm13_101 zmm12_101; spl zmm13_zmm12_101h_t zmm13_zmm12_101l_t zmm13_zmm12_101F 52;
umulj zmm13_zmm12_110F zmm13_110 zmm12_110; spl zmm13_zmm12_110h_t zmm13_zmm12_110l_t zmm13_zmm12_110F 52;
umulj zmm13_zmm12_111F zmm13_111 zmm12_111; spl zmm13_zmm12_111h_t zmm13_zmm12_111l_t zmm13_zmm12_111F 52;
vpc zmm13_zmm12_000h_t@uint64 zmm13_zmm12_000h_t; vpc zmm13_zmm12_000l_t@uint64 zmm13_zmm12_000l_t;
vpc zmm13_zmm12_001h_t@uint64 zmm13_zmm12_001h_t; vpc zmm13_zmm12_001l_t@uint64 zmm13_zmm12_001l_t;
vpc zmm13_zmm12_010h_t@uint64 zmm13_zmm12_010h_t; vpc zmm13_zmm12_010l_t@uint64 zmm13_zmm12_010l_t;
vpc zmm13_zmm12_011h_t@uint64 zmm13_zmm12_011h_t; vpc zmm13_zmm12_011l_t@uint64 zmm13_zmm12_011l_t;
vpc zmm13_zmm12_100h_t@uint64 zmm13_zmm12_100h_t; vpc zmm13_zmm12_100l_t@uint64 zmm13_zmm12_100l_t;
vpc zmm13_zmm12_101h_t@uint64 zmm13_zmm12_101h_t; vpc zmm13_zmm12_101l_t@uint64 zmm13_zmm12_101l_t;
vpc zmm13_zmm12_110h_t@uint64 zmm13_zmm12_110h_t; vpc zmm13_zmm12_110l_t@uint64 zmm13_zmm12_110l_t;
vpc zmm13_zmm12_111h_t@uint64 zmm13_zmm12_111h_t; vpc zmm13_zmm12_111l_t@uint64 zmm13_zmm12_111l_t;
add zmm15_000 zmm15_000 zmm13_zmm12_000h_t;
add zmm15_001 zmm15_001 zmm13_zmm12_001h_t;
add zmm15_010 zmm15_010 zmm13_zmm12_010h_t;
add zmm15_011 zmm15_011 zmm13_zmm12_011h_t;
add zmm15_100 zmm15_100 zmm13_zmm12_100h_t;
add zmm15_101 zmm15_101 zmm13_zmm12_101h_t;
add zmm15_110 zmm15_110 zmm13_zmm12_110h_t;
add zmm15_111 zmm15_111 zmm13_zmm12_111h_t;
assert true && and [
zmm15_000 <u 16@64,
zmm15_001 <u 16@64,
zmm15_010 <u 16@64,
zmm15_011 <u 16@64,
zmm15_100 <u 16@64,
zmm15_101 <u 16@64,
zmm15_110 <u 16@64,
zmm15_111 <u 16@64
];
(* vpmadd52luq %zmm13,%zmm12,%zmm3 z2 = VMACLO(z2, z7, vconstc) #! PC = 0x55555555671b *)
add zmm3_000 zmm3_000 zmm13_zmm12_000l_t;
add zmm3_001 zmm3_001 zmm13_zmm12_001l_t;
add zmm3_010 zmm3_010 zmm13_zmm12_010l_t;
add zmm3_011 zmm3_011 zmm13_zmm12_011l_t;
add zmm3_100 zmm3_100 zmm13_zmm12_100l_t;
add zmm3_101 zmm3_101 zmm13_zmm12_101l_t;
add zmm3_110 zmm3_110 zmm13_zmm12_110l_t;
add zmm3_111 zmm3_111 zmm13_zmm12_111l_t;
assert true && and [
zmm3_000 <u 0xf0000000000000@64,
zmm3_001 <u 0xf0000000000000@64,
zmm3_010 <u 0xf0000000000000@64,
zmm3_011 <u 0xf0000000000000@64,
zmm3_100 <u 0xf0000000000000@64,
zmm3_101 <u 0xf0000000000000@64,
zmm3_110 <u 0xf0000000000000@64,
zmm3_111 <u 0xf0000000000000@64
];
(* vmovdqa64 %zmm0,%zmm14                          #! PC = 0x555555556721 *)
mov zmm14_000 zmm0_000;
mov zmm14_001 zmm0_001;
mov zmm14_010 zmm0_010;
mov zmm14_011 zmm0_011;
mov zmm14_100 zmm0_100;
mov zmm14_101 zmm0_101;
mov zmm14_110 zmm0_110;
mov zmm14_111 zmm0_111;
(* vmovdqa64 %zmm2,%zmm0                           #! PC = 0x555555556727 *)
mov zmm0_000 zmm2_000;
mov zmm0_001 zmm2_001;
mov zmm0_010 zmm2_010;
mov zmm0_011 zmm2_011;
mov zmm0_100 zmm2_100;
mov zmm0_101 zmm2_101;
mov zmm0_110 zmm2_110;
mov zmm0_111 zmm2_111;
(* vpmadd52huq %zmm13,%zmm8,%zmm0 t = VMACHI(t, z9, vconstc) #! PC = 0x55555555672d *)
add zmm0_000 zmm0_000 zmm13_zmm8_000h_t;
add zmm0_001 zmm0_001 zmm13_zmm8_001h_t;
add zmm0_010 zmm0_010 zmm13_zmm8_010h_t;
add zmm0_011 zmm0_011 zmm13_zmm8_011h_t;
add zmm0_100 zmm0_100 zmm13_zmm8_100h_t;
add zmm0_101 zmm0_101 zmm13_zmm8_101h_t;
add zmm0_110 zmm0_110 zmm13_zmm8_110h_t;
add zmm0_111 zmm0_111 zmm13_zmm8_111h_t;
assert true && and [
zmm0_000 <u 16@64,
zmm0_001 <u 16@64,
zmm0_010 <u 16@64,
zmm0_011 <u 16@64,
zmm0_100 <u 16@64,
zmm0_101 <u 16@64,
zmm0_110 <u 16@64,
zmm0_111 <u 16@64
];
(* vpsllq $0x1,%zmm1,%zmm7 VSHL(t, 1) in z5 = VADD(z5, VSHL(t, 1)) #! PC = 0x555555556733 *)
shl zmm7_000 zmm1_000 0x1;
shl zmm7_001 zmm1_001 0x1;
shl zmm7_010 zmm1_010 0x1;
shl zmm7_011 zmm1_011 0x1;
shl zmm7_100 zmm1_100 0x1;
shl zmm7_101 zmm1_101 0x1;
shl zmm7_110 zmm1_110 0x1;
shl zmm7_111 zmm1_111 0x1;
(* vpsllq $0x1,%zmm15,%zmm1 VSHL(t, 1) in z3 = VADD(z3, VSHL(t, 1)) #! PC = 0x55555555673a *)
shl zmm1_000 zmm15_000 0x1;
shl zmm1_001 zmm15_001 0x1;
shl zmm1_010 zmm15_010 0x1;
shl zmm1_011 zmm15_011 0x1;
shl zmm1_100 zmm15_100 0x1;
shl zmm1_101 zmm15_101 0x1;
shl zmm1_110 zmm15_110 0x1;
shl zmm1_111 zmm15_111 0x1;
(* vpsrlq $0x33,%zmm6,%zmm17 VSHR(z0, RADIX_8x1) in z1 = VADD(z1, VSHR(z0, RADIX_8x1)) #! PC = 0x555555556741 *)
split zmm6_000_h zmm6_000_l zmm6_000 51;
split zmm6_001_h zmm6_001_l zmm6_001 51;
split zmm6_010_h zmm6_010_l zmm6_010 51;
split zmm6_011_h zmm6_011_l zmm6_011 51;
split zmm6_100_h zmm6_100_l zmm6_100 51;
split zmm6_101_h zmm6_101_l zmm6_101 51;
split zmm6_110_h zmm6_110_l zmm6_110 51;
split zmm6_111_h zmm6_111_l zmm6_111 51;
mov zmm17_000 zmm6_000_h;
mov zmm17_001 zmm6_001_h;
mov zmm17_010 zmm6_010_h;
mov zmm17_011 zmm6_011_h;
mov zmm17_100 zmm6_100_h;
mov zmm17_101 zmm6_101_h;
mov zmm17_110 zmm6_110_h;
mov zmm17_111 zmm6_111_h;
assert true && and [
zmm17_000 <u 7@64,
zmm17_001 <u 7@64,
zmm17_010 <u 7@64,
zmm17_011 <u 7@64,
zmm17_100 <u 7@64,
zmm17_101 <u 7@64,
zmm17_110 <u 7@64,
zmm17_111 <u 7@64
];
(* vpsrlq $0x33,%zmm3,%zmm18 VSHR(z2, RADIX_8x1) in z3 = VADD(z3, VSHR(z2, RADIX_8x1)) #! PC = 0x555555556748 *)
split zmm3_000_h zmm3_000_l zmm3_000 51;
split zmm3_001_h zmm3_001_l zmm3_001 51;
split zmm3_010_h zmm3_010_l zmm3_010 51;
split zmm3_011_h zmm3_011_l zmm3_011 51;
split zmm3_100_h zmm3_100_l zmm3_100 51;
split zmm3_101_h zmm3_101_l zmm3_101 51;
split zmm3_110_h zmm3_110_l zmm3_110 51;
split zmm3_111_h zmm3_111_l zmm3_111 51;
mov zmm18_000 zmm3_000_h;
mov zmm18_001 zmm3_001_h;
mov zmm18_010 zmm3_010_h;
mov zmm18_011 zmm3_011_h;
mov zmm18_100 zmm3_100_h;
mov zmm18_101 zmm3_101_h;
mov zmm18_110 zmm3_110_h;
mov zmm18_111 zmm3_111_h;
assert true && and [
zmm18_000 <u 30@64,
zmm18_001 <u 30@64,
zmm18_010 <u 30@64,
zmm18_011 <u 30@64,
zmm18_100 <u 30@64,
zmm18_101 <u 30@64,
zmm18_110 <u 30@64,
zmm18_111 <u 30@64
];
(* vpaddq %zmm9,%zmm7,%zmm9 z1 = VADD(z1, VSHL(t, 1)) #! PC = 0x55555555674f *)
add zmm9_000 zmm7_000 zmm9_000;
add zmm9_001 zmm7_001 zmm9_001;
add zmm9_010 zmm7_010 zmm9_010;
add zmm9_011 zmm7_011 zmm9_011;
add zmm9_100 zmm7_100 zmm9_100;
add zmm9_101 zmm7_101 zmm9_101;
add zmm9_110 zmm7_110 zmm9_110;
add zmm9_111 zmm7_111 zmm9_111;
assert true && and [
zmm9_000 <u 0x80000000000020@64,
zmm9_001 <u 0x80000000000020@64,
zmm9_010 <u 0x80000000000020@64,
zmm9_011 <u 0x80000000000020@64,
zmm9_100 <u 0x80000000000020@64,
zmm9_101 <u 0x80000000000020@64,
zmm9_110 <u 0x80000000000020@64,
zmm9_111 <u 0x80000000000020@64
];
(* vpaddq %zmm4,%zmm1,%zmm4 z3 = VADD(z3, VSHL(t, 1)) #! PC = 0x555555556755 *)
add zmm4_000 zmm1_000 zmm4_000;
add zmm4_001 zmm1_001 zmm4_001;
add zmm4_010 zmm1_010 zmm4_010;
add zmm4_011 zmm1_011 zmm4_011;
add zmm4_100 zmm1_100 zmm4_100;
add zmm4_101 zmm1_101 zmm4_101;
add zmm4_110 zmm1_110 zmm4_110;
add zmm4_111 zmm1_111 zmm4_111;
assert true && and [
zmm4_000 <u 0x140000000000020@64,
zmm4_001 <u 0x140000000000020@64,
zmm4_010 <u 0x140000000000020@64,
zmm4_011 <u 0x140000000000020@64,
zmm4_100 <u 0x140000000000020@64,
zmm4_101 <u 0x140000000000020@64,
zmm4_110 <u 0x140000000000020@64,
zmm4_111 <u 0x140000000000020@64
];
(* vpaddq %zmm17,%zmm9,%zmm7 z1 = VADD(z1, VSHR(z0, RADIX_8x1)) #! PC = 0x55555555675b *)
add zmm7_000 zmm9_000 zmm17_000;
add zmm7_001 zmm9_001 zmm17_001;
add zmm7_010 zmm9_010 zmm17_010;
add zmm7_011 zmm9_011 zmm17_011;
add zmm7_100 zmm9_100 zmm17_100;
add zmm7_101 zmm9_101 zmm17_101;
add zmm7_110 zmm9_110 zmm17_110;
add zmm7_111 zmm9_111 zmm17_111;
assert true && and [
zmm7_000 <u 0x80000000000027@64,
zmm7_001 <u 0x80000000000027@64,
zmm7_010 <u 0x80000000000027@64,
zmm7_011 <u 0x80000000000027@64,
zmm7_100 <u 0x80000000000027@64,
zmm7_101 <u 0x80000000000027@64,
zmm7_110 <u 0x80000000000027@64,
zmm7_111 <u 0x80000000000027@64
];
(* vmovdqa64 %zmm2,%zmm8                           #! PC = 0x555555556761 *)
mov zmm8_000 zmm2_000;
mov zmm8_001 zmm2_001;
mov zmm8_010 zmm2_010;
mov zmm8_011 zmm2_011;
mov zmm8_100 zmm2_100;
mov zmm8_101 zmm2_101;
mov zmm8_110 zmm2_110;
mov zmm8_111 zmm2_111;
(* vpaddq %zmm18,%zmm4,%zmm1 z3 = VADD(z3, VSHR(z2, RADIX_8x1)) #! PC = 0x555555556767 *)
add zmm1_000 zmm4_000 zmm18_000;
add zmm1_001 zmm4_001 zmm18_001;
add zmm1_010 zmm4_010 zmm18_010;
add zmm1_011 zmm4_011 zmm18_011;
add zmm1_100 zmm4_100 zmm18_100;
add zmm1_101 zmm4_101 zmm18_101;
add zmm1_110 zmm4_110 zmm18_110;
add zmm1_111 zmm4_111 zmm18_111;
assert true && and [
zmm1_000 <u 0x14000000000003e@64,
zmm1_001 <u 0x14000000000003e@64,
zmm1_010 <u 0x14000000000003e@64,
zmm1_011 <u 0x14000000000003e@64,
zmm1_100 <u 0x14000000000003e@64,
zmm1_101 <u 0x14000000000003e@64,
zmm1_110 <u 0x14000000000003e@64,
zmm1_111 <u 0x14000000000003e@64
];
(* vpmadd52luq %zmm13,%zmm10,%zmm1 z3 = VMACLO(z3, z8, vconstc) #! PC = 0x55555555676d *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm10_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64
];
umulj zmm13_zmm10_000F zmm13_000 zmm10_000; spl zmm13_zmm10_000h_t zmm13_zmm10_000l_t zmm13_zmm10_000F 52;
umulj zmm13_zmm10_001F zmm13_001 zmm10_001; spl zmm13_zmm10_001h_t zmm13_zmm10_001l_t zmm13_zmm10_001F 52;
umulj zmm13_zmm10_010F zmm13_010 zmm10_010; spl zmm13_zmm10_010h_t zmm13_zmm10_010l_t zmm13_zmm10_010F 52;
umulj zmm13_zmm10_011F zmm13_011 zmm10_011; spl zmm13_zmm10_011h_t zmm13_zmm10_011l_t zmm13_zmm10_011F 52;
umulj zmm13_zmm10_100F zmm13_100 zmm10_100; spl zmm13_zmm10_100h_t zmm13_zmm10_100l_t zmm13_zmm10_100F 52;
umulj zmm13_zmm10_101F zmm13_101 zmm10_101; spl zmm13_zmm10_101h_t zmm13_zmm10_101l_t zmm13_zmm10_101F 52;
umulj zmm13_zmm10_110F zmm13_110 zmm10_110; spl zmm13_zmm10_110h_t zmm13_zmm10_110l_t zmm13_zmm10_110F 52;
umulj zmm13_zmm10_111F zmm13_111 zmm10_111; spl zmm13_zmm10_111h_t zmm13_zmm10_111l_t zmm13_zmm10_111F 52;
vpc zmm13_zmm10_000h_t@uint64 zmm13_zmm10_000h_t; vpc zmm13_zmm10_000l_t@uint64 zmm13_zmm10_000l_t;
vpc zmm13_zmm10_001h_t@uint64 zmm13_zmm10_001h_t; vpc zmm13_zmm10_001l_t@uint64 zmm13_zmm10_001l_t;
vpc zmm13_zmm10_010h_t@uint64 zmm13_zmm10_010h_t; vpc zmm13_zmm10_010l_t@uint64 zmm13_zmm10_010l_t;
vpc zmm13_zmm10_011h_t@uint64 zmm13_zmm10_011h_t; vpc zmm13_zmm10_011l_t@uint64 zmm13_zmm10_011l_t;
vpc zmm13_zmm10_100h_t@uint64 zmm13_zmm10_100h_t; vpc zmm13_zmm10_100l_t@uint64 zmm13_zmm10_100l_t;
vpc zmm13_zmm10_101h_t@uint64 zmm13_zmm10_101h_t; vpc zmm13_zmm10_101l_t@uint64 zmm13_zmm10_101l_t;
vpc zmm13_zmm10_110h_t@uint64 zmm13_zmm10_110h_t; vpc zmm13_zmm10_110l_t@uint64 zmm13_zmm10_110l_t;
vpc zmm13_zmm10_111h_t@uint64 zmm13_zmm10_111h_t; vpc zmm13_zmm10_111l_t@uint64 zmm13_zmm10_111l_t;
add zmm1_000 zmm1_000 zmm13_zmm10_000l_t;
add zmm1_001 zmm1_001 zmm13_zmm10_001l_t;
add zmm1_010 zmm1_010 zmm13_zmm10_010l_t;
add zmm1_011 zmm1_011 zmm13_zmm10_011l_t;
add zmm1_100 zmm1_100 zmm13_zmm10_100l_t;
add zmm1_101 zmm1_101 zmm13_zmm10_101l_t;
add zmm1_110 zmm1_110 zmm13_zmm10_110l_t;
add zmm1_111 zmm1_111 zmm13_zmm10_111l_t;
assert true && and [
zmm1_000 <u 0x15000000000003e@64,
zmm1_001 <u 0x15000000000003e@64,
zmm1_010 <u 0x15000000000003e@64,
zmm1_011 <u 0x15000000000003e@64,
zmm1_100 <u 0x15000000000003e@64,
zmm1_101 <u 0x15000000000003e@64,
zmm1_110 <u 0x15000000000003e@64,
zmm1_111 <u 0x15000000000003e@64
];
(* vpmadd52luq %zmm13,%zmm5,%zmm7 z1 = VMACLO(z1, z6, vconstc) #! PC = 0x555555556773 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm5_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64
];
umulj zmm13_zmm5_000F zmm13_000 zmm5_000; spl zmm13_zmm5_000h_t zmm13_zmm5_000l_t zmm13_zmm5_000F 52;
umulj zmm13_zmm5_001F zmm13_001 zmm5_001; spl zmm13_zmm5_001h_t zmm13_zmm5_001l_t zmm13_zmm5_001F 52;
umulj zmm13_zmm5_010F zmm13_010 zmm5_010; spl zmm13_zmm5_010h_t zmm13_zmm5_010l_t zmm13_zmm5_010F 52;
umulj zmm13_zmm5_011F zmm13_011 zmm5_011; spl zmm13_zmm5_011h_t zmm13_zmm5_011l_t zmm13_zmm5_011F 52;
umulj zmm13_zmm5_100F zmm13_100 zmm5_100; spl zmm13_zmm5_100h_t zmm13_zmm5_100l_t zmm13_zmm5_100F 52;
umulj zmm13_zmm5_101F zmm13_101 zmm5_101; spl zmm13_zmm5_101h_t zmm13_zmm5_101l_t zmm13_zmm5_101F 52;
umulj zmm13_zmm5_110F zmm13_110 zmm5_110; spl zmm13_zmm5_110h_t zmm13_zmm5_110l_t zmm13_zmm5_110F 52;
umulj zmm13_zmm5_111F zmm13_111 zmm5_111; spl zmm13_zmm5_111h_t zmm13_zmm5_111l_t zmm13_zmm5_111F 52;
vpc zmm13_zmm5_000h_t@uint64 zmm13_zmm5_000h_t; vpc zmm13_zmm5_000l_t@uint64 zmm13_zmm5_000l_t;
vpc zmm13_zmm5_001h_t@uint64 zmm13_zmm5_001h_t; vpc zmm13_zmm5_001l_t@uint64 zmm13_zmm5_001l_t;
vpc zmm13_zmm5_010h_t@uint64 zmm13_zmm5_010h_t; vpc zmm13_zmm5_010l_t@uint64 zmm13_zmm5_010l_t;
vpc zmm13_zmm5_011h_t@uint64 zmm13_zmm5_011h_t; vpc zmm13_zmm5_011l_t@uint64 zmm13_zmm5_011l_t;
vpc zmm13_zmm5_100h_t@uint64 zmm13_zmm5_100h_t; vpc zmm13_zmm5_100l_t@uint64 zmm13_zmm5_100l_t;
vpc zmm13_zmm5_101h_t@uint64 zmm13_zmm5_101h_t; vpc zmm13_zmm5_101l_t@uint64 zmm13_zmm5_101l_t;
vpc zmm13_zmm5_110h_t@uint64 zmm13_zmm5_110h_t; vpc zmm13_zmm5_110l_t@uint64 zmm13_zmm5_110l_t;
vpc zmm13_zmm5_111h_t@uint64 zmm13_zmm5_111h_t; vpc zmm13_zmm5_111l_t@uint64 zmm13_zmm5_111l_t;
add zmm7_000 zmm7_000 zmm13_zmm5_000l_t;
add zmm7_001 zmm7_001 zmm13_zmm5_001l_t;
add zmm7_010 zmm7_010 zmm13_zmm5_010l_t;
add zmm7_011 zmm7_011 zmm13_zmm5_011l_t;
add zmm7_100 zmm7_100 zmm13_zmm5_100l_t;
add zmm7_101 zmm7_101 zmm13_zmm5_101l_t;
add zmm7_110 zmm7_110 zmm13_zmm5_110l_t;
add zmm7_111 zmm7_111 zmm13_zmm5_111l_t;
assert true && and [
zmm7_000 <u 0x90000000000027@64,
zmm7_001 <u 0x90000000000027@64,
zmm7_010 <u 0x90000000000027@64,
zmm7_011 <u 0x90000000000027@64,
zmm7_100 <u 0x90000000000027@64,
zmm7_101 <u 0x90000000000027@64,
zmm7_110 <u 0x90000000000027@64,
zmm7_111 <u 0x90000000000027@64
];
(* vpmadd52huq %zmm13,%zmm5,%zmm8 t = VMACHI(t, z6, vconstc) #! PC = 0x555555556779 *)
add zmm8_000 zmm8_000 zmm13_zmm5_000h_t;
add zmm8_001 zmm8_001 zmm13_zmm5_001h_t;
add zmm8_010 zmm8_010 zmm13_zmm5_010h_t;
add zmm8_011 zmm8_011 zmm13_zmm5_011h_t;
add zmm8_100 zmm8_100 zmm13_zmm5_100h_t;
add zmm8_101 zmm8_101 zmm13_zmm5_101h_t;
add zmm8_110 zmm8_110 zmm13_zmm5_110h_t;
add zmm8_111 zmm8_111 zmm13_zmm5_111h_t;
assert true && and [
zmm8_000 <u 16@64,
zmm8_001 <u 16@64,
zmm8_010 <u 16@64,
zmm8_011 <u 16@64,
zmm8_100 <u 16@64,
zmm8_101 <u 16@64,
zmm8_110 <u 16@64,
zmm8_111 <u 16@64
];
(* vpmadd52huq %zmm13,%zmm10,%zmm2 t = VMACHI(t, z8, vconstc) #! PC = 0x55555555677f *)
add zmm2_000 zmm2_000 zmm13_zmm10_000h_t;
add zmm2_001 zmm2_001 zmm13_zmm10_001h_t;
add zmm2_010 zmm2_010 zmm13_zmm10_010h_t;
add zmm2_011 zmm2_011 zmm13_zmm10_011h_t;
add zmm2_100 zmm2_100 zmm13_zmm10_100h_t;
add zmm2_101 zmm2_101 zmm13_zmm10_101h_t;
add zmm2_110 zmm2_110 zmm13_zmm10_110h_t;
add zmm2_111 zmm2_111 zmm13_zmm10_111h_t;
assert true && and [
zmm2_000 <u 16@64,
zmm2_001 <u 16@64,
zmm2_010 <u 16@64,
zmm2_011 <u 16@64,
zmm2_100 <u 16@64,
zmm2_101 <u 16@64,
zmm2_110 <u 16@64,
zmm2_111 <u 16@64
];
(* vpsrlq $0x33,%zmm14,%zmm15 VSHR(z4, RADIX_8x1) in z5 = VADD(z5, VSHR(z4, RADIX_8x1)) #! PC = 0x555555556785 *)
split zmm14_000_h zmm14_000_l zmm14_000 51;
split zmm14_001_h zmm14_001_l zmm14_001 51;
split zmm14_010_h zmm14_010_l zmm14_010 51;
split zmm14_011_h zmm14_011_l zmm14_011 51;
split zmm14_100_h zmm14_100_l zmm14_100 51;
split zmm14_101_h zmm14_101_l zmm14_101 51;
split zmm14_110_h zmm14_110_l zmm14_110 51;
split zmm14_111_h zmm14_111_l zmm14_111 51;
mov zmm15_000 zmm14_000_h;
mov zmm15_001 zmm14_001_h;
mov zmm15_010 zmm14_010_h;
mov zmm15_011 zmm14_011_h;
mov zmm15_100 zmm14_100_h;
mov zmm15_101 zmm14_101_h;
mov zmm15_110 zmm14_110_h;
mov zmm15_111 zmm14_111_h;
assert true && and [
zmm15_000 <u 54@64,
zmm15_001 <u 54@64,
zmm15_010 <u 54@64,
zmm15_011 <u 54@64,
zmm15_100 <u 54@64,
zmm15_101 <u 54@64,
zmm15_110 <u 54@64,
zmm15_111 <u 54@64
];
(* vpsllq $0x1,%zmm0,%zmm12 VSHL(t, 1) in z5 = VADD(z5, VSHL(t, 1)) #! PC = 0x55555555678c *)
shl zmm12_000 zmm0_000 0x1;
shl zmm12_001 zmm0_001 0x1;
shl zmm12_010 zmm0_010 0x1;
shl zmm12_011 zmm0_011 0x1;
shl zmm12_100 zmm0_100 0x1;
shl zmm12_101 zmm0_101 0x1;
shl zmm12_110 zmm0_110 0x1;
shl zmm12_111 zmm0_111 0x1;
assert true && and [
zmm12_000 <u 32@64,
zmm12_001 <u 32@64,
zmm12_010 <u 32@64,
zmm12_011 <u 32@64,
zmm12_100 <u 32@64,
zmm12_101 <u 32@64,
zmm12_110 <u 32@64,
zmm12_111 <u 32@64
];
(* vpaddq %zmm15,%zmm12,%zmm12 z5 = VADD(z5, VSHR(z4, RADIX_8x1)) #! PC = 0x555555556793 *)
add zmm12_000 zmm12_000 zmm15_000;
add zmm12_001 zmm12_001 zmm15_001;
add zmm12_010 zmm12_010 zmm15_010;
add zmm12_011 zmm12_011 zmm15_011;
add zmm12_100 zmm12_100 zmm15_100;
add zmm12_101 zmm12_101 zmm15_101;
add zmm12_110 zmm12_110 zmm15_110;
add zmm12_111 zmm12_111 zmm15_111;
assert true && and [
zmm12_000 <u 86@64,
zmm12_001 <u 86@64,
zmm12_010 <u 86@64,
zmm12_011 <u 86@64,
zmm12_100 <u 86@64,
zmm12_101 <u 86@64,
zmm12_110 <u 86@64,
zmm12_111 <u 86@64
];
(* vpandd %zmm11,%zmm6,%zmm6                       #! PC = 0x555555556799 *)
mov zmm6_000 zmm6_000_l;
mov zmm6_001 zmm6_001_l;
mov zmm6_010 zmm6_010_l;
mov zmm6_011 zmm6_011_l;
mov zmm6_100 zmm6_100_l;
mov zmm6_101 zmm6_101_l;
mov zmm6_110 zmm6_110_l;
mov zmm6_111 zmm6_111_l;
assert true && and [
zmm6_000 <u 0x8000000000000@64,
zmm6_001 <u 0x8000000000000@64,
zmm6_010 <u 0x8000000000000@64,
zmm6_011 <u 0x8000000000000@64,
zmm6_100 <u 0x8000000000000@64,
zmm6_101 <u 0x8000000000000@64,
zmm6_110 <u 0x8000000000000@64,
zmm6_111 <u 0x8000000000000@64
];
(* vpmadd52luq %zmm13,%zmm12,%zmm6                 #! PC = 0x55555555679f *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm12_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm12_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm12_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm12_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm12_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm12_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm12_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm12_111 <u 0x10000000000000@64
];
umulj zmm13_zmm12_000F zmm13_000 zmm12_000; spl zmm13_zmm12_000h_t zmm13_zmm12_000l_t zmm13_zmm12_000F 52;
umulj zmm13_zmm12_001F zmm13_001 zmm12_001; spl zmm13_zmm12_001h_t zmm13_zmm12_001l_t zmm13_zmm12_001F 52;
umulj zmm13_zmm12_010F zmm13_010 zmm12_010; spl zmm13_zmm12_010h_t zmm13_zmm12_010l_t zmm13_zmm12_010F 52;
umulj zmm13_zmm12_011F zmm13_011 zmm12_011; spl zmm13_zmm12_011h_t zmm13_zmm12_011l_t zmm13_zmm12_011F 52;
umulj zmm13_zmm12_100F zmm13_100 zmm12_100; spl zmm13_zmm12_100h_t zmm13_zmm12_100l_t zmm13_zmm12_100F 52;
umulj zmm13_zmm12_101F zmm13_101 zmm12_101; spl zmm13_zmm12_101h_t zmm13_zmm12_101l_t zmm13_zmm12_101F 52;
umulj zmm13_zmm12_110F zmm13_110 zmm12_110; spl zmm13_zmm12_110h_t zmm13_zmm12_110l_t zmm13_zmm12_110F 52;
umulj zmm13_zmm12_111F zmm13_111 zmm12_111; spl zmm13_zmm12_111h_t zmm13_zmm12_111l_t zmm13_zmm12_111F 52;
vpc zmm13_zmm12_000h_t@uint64 zmm13_zmm12_000h_t; vpc zmm13_zmm12_000l_t@uint64 zmm13_zmm12_000l_t;
vpc zmm13_zmm12_001h_t@uint64 zmm13_zmm12_001h_t; vpc zmm13_zmm12_001l_t@uint64 zmm13_zmm12_001l_t;
vpc zmm13_zmm12_010h_t@uint64 zmm13_zmm12_010h_t; vpc zmm13_zmm12_010l_t@uint64 zmm13_zmm12_010l_t;
vpc zmm13_zmm12_011h_t@uint64 zmm13_zmm12_011h_t; vpc zmm13_zmm12_011l_t@uint64 zmm13_zmm12_011l_t;
vpc zmm13_zmm12_100h_t@uint64 zmm13_zmm12_100h_t; vpc zmm13_zmm12_100l_t@uint64 zmm13_zmm12_100l_t;
vpc zmm13_zmm12_101h_t@uint64 zmm13_zmm12_101h_t; vpc zmm13_zmm12_101l_t@uint64 zmm13_zmm12_101l_t;
vpc zmm13_zmm12_110h_t@uint64 zmm13_zmm12_110h_t; vpc zmm13_zmm12_110l_t@uint64 zmm13_zmm12_110l_t;
vpc zmm13_zmm12_111h_t@uint64 zmm13_zmm12_111h_t; vpc zmm13_zmm12_111l_t@uint64 zmm13_zmm12_111l_t;
add zmm6_000 zmm6_000 zmm13_zmm12_000l_t;
add zmm6_001 zmm6_001 zmm13_zmm12_001l_t;
add zmm6_010 zmm6_010 zmm13_zmm12_010l_t;
add zmm6_011 zmm6_011 zmm13_zmm12_011l_t;
add zmm6_100 zmm6_100 zmm13_zmm12_100l_t;
add zmm6_101 zmm6_101 zmm13_zmm12_101l_t;
add zmm6_110 zmm6_110 zmm13_zmm12_110l_t;
add zmm6_111 zmm6_111 zmm13_zmm12_111l_t;
assert true && and [
zmm13_zmm12_000h_t = 0@64,
zmm13_zmm12_001h_t = 0@64,
zmm13_zmm12_010h_t = 0@64,
zmm13_zmm12_011h_t = 0@64,
zmm13_zmm12_100h_t = 0@64,
zmm13_zmm12_101h_t = 0@64,
zmm13_zmm12_110h_t = 0@64,
zmm13_zmm12_111h_t = 0@64
];
assume and [
zmm13_zmm12_000h_t = 0,
zmm13_zmm12_001h_t = 0,
zmm13_zmm12_010h_t = 0,
zmm13_zmm12_011h_t = 0,
zmm13_zmm12_100h_t = 0,
zmm13_zmm12_101h_t = 0,
zmm13_zmm12_110h_t = 0,
zmm13_zmm12_111h_t = 0
] && true;
(* vpsllq $0x1,%zmm8,%zmm5                         #! PC = 0x5555555567a5 *)
shl zmm5_000 zmm8_000 0x1;
shl zmm5_001 zmm8_001 0x1;
shl zmm5_010 zmm8_010 0x1;
shl zmm5_011 zmm8_011 0x1;
shl zmm5_100 zmm8_100 0x1;
shl zmm5_101 zmm8_101 0x1;
shl zmm5_110 zmm8_110 0x1;
shl zmm5_111 zmm8_111 0x1;
(* vpsrlq $0x33,%zmm7,%zmm9                        #! PC = 0x5555555567ac *)
split zmm7_000_h zmm7_000_l zmm7_000 51;
split zmm7_001_h zmm7_001_l zmm7_001 51;
split zmm7_010_h zmm7_010_l zmm7_010 51;
split zmm7_011_h zmm7_011_l zmm7_011 51;
split zmm7_100_h zmm7_100_l zmm7_100 51;
split zmm7_101_h zmm7_101_l zmm7_101 51;
split zmm7_110_h zmm7_110_l zmm7_110 51;
split zmm7_111_h zmm7_111_l zmm7_111 51;
mov zmm9_000 zmm7_000_h;
mov zmm9_001 zmm7_001_h;
mov zmm9_010 zmm7_010_h;
mov zmm9_011 zmm7_011_h;
mov zmm9_100 zmm7_100_h;
mov zmm9_101 zmm7_101_h;
mov zmm9_110 zmm7_110_h;
mov zmm9_111 zmm7_111_h;
(* vpsllq $0x1,%zmm2,%zmm10                        #! PC = 0x5555555567b3 *)
shl zmm10_000 zmm2_000 0x1;
shl zmm10_001 zmm2_001 0x1;
shl zmm10_010 zmm2_010 0x1;
shl zmm10_011 zmm2_011 0x1;
shl zmm10_100 zmm2_100 0x1;
shl zmm10_101 zmm2_101 0x1;
shl zmm10_110 zmm2_110 0x1;
shl zmm10_111 zmm2_111 0x1;
(* vpsrlq $0x33,%zmm1,%zmm0                        #! PC = 0x5555555567ba *)
split zmm1_000_h zmm1_000_l zmm1_000 51;
split zmm1_001_h zmm1_001_l zmm1_001 51;
split zmm1_010_h zmm1_010_l zmm1_010 51;
split zmm1_011_h zmm1_011_l zmm1_011 51;
split zmm1_100_h zmm1_100_l zmm1_100 51;
split zmm1_101_h zmm1_101_l zmm1_101 51;
split zmm1_110_h zmm1_110_l zmm1_110 51;
split zmm1_111_h zmm1_111_l zmm1_111 51;
mov zmm0_000 zmm1_000_h;
mov zmm0_001 zmm1_001_h;
mov zmm0_010 zmm1_010_h;
mov zmm0_011 zmm1_011_h;
mov zmm0_100 zmm1_100_h;
mov zmm0_101 zmm1_101_h;
mov zmm0_110 zmm1_110_h;
mov zmm0_111 zmm1_111_h;
(* vpandd %zmm11,%zmm7,%zmm13                      #! PC = 0x5555555567c1 *)
mov zmm13_000 zmm7_000_l;
mov zmm13_001 zmm7_001_l;
mov zmm13_010 zmm7_010_l;
mov zmm13_011 zmm7_011_l;
mov zmm13_100 zmm7_100_l;
mov zmm13_101 zmm7_101_l;
mov zmm13_110 zmm7_110_l;
mov zmm13_111 zmm7_111_l;
(* vpandd %zmm11,%zmm3,%zmm3                       #! PC = 0x5555555567c7 *)
mov zmm3_000 zmm3_000_l;
mov zmm3_001 zmm3_001_l;
mov zmm3_010 zmm3_010_l;
mov zmm3_011 zmm3_011_l;
mov zmm3_100 zmm3_100_l;
mov zmm3_101 zmm3_101_l;
mov zmm3_110 zmm3_110_l;
mov zmm3_111 zmm3_111_l;
(* vpaddq %zmm9,%zmm5,%zmm15                       #! PC = 0x5555555567cd *)
add zmm15_000 zmm5_000 zmm9_000;
add zmm15_001 zmm5_001 zmm9_001;
add zmm15_010 zmm5_010 zmm9_010;
add zmm15_011 zmm5_011 zmm9_011;
add zmm15_100 zmm5_100 zmm9_100;
add zmm15_101 zmm5_101 zmm9_101;
add zmm15_110 zmm5_110 zmm9_110;
add zmm15_111 zmm5_111 zmm9_111;
(* vpandd %zmm11,%zmm1,%zmm8                       #! PC = 0x5555555567d3 *)
mov zmm8_000 zmm1_000_l;
mov zmm8_001 zmm1_001_l;
mov zmm8_010 zmm1_010_l;
mov zmm8_011 zmm1_011_l;
mov zmm8_100 zmm1_100_l;
mov zmm8_101 zmm1_101_l;
mov zmm8_110 zmm1_110_l;
mov zmm8_111 zmm1_111_l;
(* vpandd %zmm11,%zmm14,%zmm11                     #! PC = 0x5555555567d9 *)
mov zmm11_000 zmm14_000_l;
mov zmm11_001 zmm14_001_l;
mov zmm11_010 zmm14_010_l;
mov zmm11_011 zmm14_011_l;
mov zmm11_100 zmm14_100_l;
mov zmm11_101 zmm14_101_l;
mov zmm11_110 zmm14_110_l;
mov zmm11_111 zmm14_111_l;
(* vpaddq %zmm0,%zmm10,%zmm14                      #! PC = 0x5555555567df *)
add zmm14_000 zmm10_000 zmm0_000;
add zmm14_001 zmm10_001 zmm0_001;
add zmm14_010 zmm10_010 zmm0_010;
add zmm14_011 zmm10_011 zmm0_011;
add zmm14_100 zmm10_100 zmm0_100;
add zmm14_101 zmm10_101 zmm0_101;
add zmm14_110 zmm10_110 zmm0_110;
add zmm14_111 zmm10_111 zmm0_111;
(* vpaddq %zmm3,%zmm15,%zmm7                       #! PC = 0x5555555567e5 *)
add zmm7_000 zmm15_000 zmm3_000;
add zmm7_001 zmm15_001 zmm3_001;
add zmm7_010 zmm15_010 zmm3_010;
add zmm7_011 zmm15_011 zmm3_011;
add zmm7_100 zmm15_100 zmm3_100;
add zmm7_101 zmm15_101 zmm3_101;
add zmm7_110 zmm15_110 zmm3_110;
add zmm7_111 zmm15_111 zmm3_111;
(* vpaddq %zmm11,%zmm14,%zmm5                      #! PC = 0x5555555567eb *)
add zmm5_000 zmm14_000 zmm11_000;
add zmm5_001 zmm14_001 zmm11_001;
add zmm5_010 zmm14_010 zmm11_010;
add zmm5_011 zmm14_011 zmm11_011;
add zmm5_100 zmm14_100 zmm11_100;
add zmm5_101 zmm14_101 zmm11_101;
add zmm5_110 zmm14_110 zmm11_110;
add zmm5_111 zmm14_111 zmm11_111;
(* vmovdqa64 %zmm6,(%rdi)                          #! EA = L0x7fffffffd780; PC = 0x5555555567f1 *)
mov L0x7fffffffd780 zmm6_000;
mov L0x7fffffffd788 zmm6_001;
mov L0x7fffffffd790 zmm6_010;
mov L0x7fffffffd798 zmm6_011;
mov L0x7fffffffd7a0 zmm6_100;
mov L0x7fffffffd7a8 zmm6_101;
mov L0x7fffffffd7b0 zmm6_110;
mov L0x7fffffffd7b8 zmm6_111;
(* vmovdqa32 %zmm13,0x40(%rdi)                     #! EA = L0x7fffffffd7c0; PC = 0x5555555567f7 *)
mov L0x7fffffffd7c0 zmm13_000;
mov L0x7fffffffd7c8 zmm13_001;
mov L0x7fffffffd7d0 zmm13_010;
mov L0x7fffffffd7d8 zmm13_011;
mov L0x7fffffffd7e0 zmm13_100;
mov L0x7fffffffd7e8 zmm13_101;
mov L0x7fffffffd7f0 zmm13_110;
mov L0x7fffffffd7f8 zmm13_111;
(* vmovdqa64 %zmm7,0x80(%rdi)                      #! EA = L0x7fffffffd800; PC = 0x5555555567fe *)
mov L0x7fffffffd800 zmm7_000;
mov L0x7fffffffd808 zmm7_001;
mov L0x7fffffffd810 zmm7_010;
mov L0x7fffffffd818 zmm7_011;
mov L0x7fffffffd820 zmm7_100;
mov L0x7fffffffd828 zmm7_101;
mov L0x7fffffffd830 zmm7_110;
mov L0x7fffffffd838 zmm7_111;
(* vmovdqa32 %zmm8,0xc0(%rdi)                      #! EA = L0x7fffffffd840; PC = 0x555555556805 *)
mov L0x7fffffffd840 zmm8_000;
mov L0x7fffffffd848 zmm8_001;
mov L0x7fffffffd850 zmm8_010;
mov L0x7fffffffd858 zmm8_011;
mov L0x7fffffffd860 zmm8_100;
mov L0x7fffffffd868 zmm8_101;
mov L0x7fffffffd870 zmm8_110;
mov L0x7fffffffd878 zmm8_111;
(* vmovdqa64 %zmm5,0x100(%rdi)                     #! EA = L0x7fffffffd880; PC = 0x55555555680c *)
mov L0x7fffffffd880 zmm5_000;
mov L0x7fffffffd888 zmm5_001;
mov L0x7fffffffd890 zmm5_010;
mov L0x7fffffffd898 zmm5_011;
mov L0x7fffffffd8a0 zmm5_100;
mov L0x7fffffffd8a8 zmm5_101;
mov L0x7fffffffd8b0 zmm5_110;
mov L0x7fffffffd8b8 zmm5_111;
(* #! <- SP = 0x7fffffffd4b8 *)
#! 0x7fffffffd4b8 = 0x7fffffffd4b8;
(* # ret                                            #! PC = 0x555555556816 *)
# ret                                            #! 0x555555556816 = 0x555555556816;

mov c00 L0x7fffffffd780;
mov c10 L0x7fffffffd788;
mov c20 L0x7fffffffd790;
mov c30 L0x7fffffffd798;
mov c40 L0x7fffffffd7a0;
mov c50 L0x7fffffffd7a8;
mov c60 L0x7fffffffd7b0;
mov c70 L0x7fffffffd7b8;
mov c01 L0x7fffffffd7c0;
mov c11 L0x7fffffffd7c8;
mov c21 L0x7fffffffd7d0;
mov c31 L0x7fffffffd7d8;
mov c41 L0x7fffffffd7e0;
mov c51 L0x7fffffffd7e8;
mov c61 L0x7fffffffd7f0;
mov c71 L0x7fffffffd7f8;
mov c02 L0x7fffffffd800;
mov c12 L0x7fffffffd808;
mov c22 L0x7fffffffd810;
mov c32 L0x7fffffffd818;
mov c42 L0x7fffffffd820;
mov c52 L0x7fffffffd828;
mov c62 L0x7fffffffd830;
mov c72 L0x7fffffffd838;
mov c03 L0x7fffffffd840;
mov c13 L0x7fffffffd848;
mov c23 L0x7fffffffd850;
mov c33 L0x7fffffffd858;
mov c43 L0x7fffffffd860;
mov c53 L0x7fffffffd868;
mov c63 L0x7fffffffd870;
mov c73 L0x7fffffffd878;
mov c04 L0x7fffffffd880;
mov c14 L0x7fffffffd888;
mov c24 L0x7fffffffd890;
mov c34 L0x7fffffffd898;
mov c44 L0x7fffffffd8a0;
mov c54 L0x7fffffffd8a8;
mov c64 L0x7fffffffd8b0;
mov c74 L0x7fffffffd8b8;

assert and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
                  limbs 51 [a00, a01, a02, a03, a04] * limbs 51 [b00, b01, b02, b03, b04] * 2
                  p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
                  limbs 51 [a10, a11, a12, a13, a14] * limbs 51 [b10, b11, b12, b13, b14] * 2
                  p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
                  limbs 51 [a20, a21, a22, a23, a24] * limbs 51 [b20, b21, b22, b23, b24] * 2
                  p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
                  limbs 51 [a30, a31, a32, a33, a34] * limbs 51 [b30, b31, b32, b33, b34] * 2
                  p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
                  limbs 51 [a40, a41, a42, a43, a44] * limbs 51 [b40, b41, b42, b43, b44] * 2
                  p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
                  limbs 51 [a50, a51, a52, a53, a54] * limbs 51 [b50, b51, b52, b53, b54] * 2
                  p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
                  limbs 51 [a60, a61, a62, a63, a64] * limbs 51 [b60, b61, b62, b63, b64] * 2
                  p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
                  limbs 51 [a70, a71, a72, a73, a74] * limbs 51 [b70, b71, b72, b73, b74] * 2
                  p
  ] && true;

assume true &&
  and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
                  limbs 51 [a00, a01, a02, a03, a04] * limbs 51 [b00, b01, b02, b03, b04] * 2@268
                  p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
                  limbs 51 [a10, a11, a12, a13, a14] * limbs 51 [b10, b11, b12, b13, b14] * 2@268
                  p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
                  limbs 51 [a20, a21, a22, a23, a24] * limbs 51 [b20, b21, b22, b23, b24] * 2@268
                  p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
                  limbs 51 [a30, a31, a32, a33, a34] * limbs 51 [b30, b31, b32, b33, b34] * 2@268
                  p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
                  limbs 51 [a40, a41, a42, a43, a44] * limbs 51 [b40, b41, b42, b43, b44] * 2@268
                  p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
                  limbs 51 [a50, a51, a52, a53, a54] * limbs 51 [b50, b51, b52, b53, b54] * 2@268
                  p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
                  limbs 51 [a60, a61, a62, a63, a64] * limbs 51 [b60, b61, b62, b63, b64] * 2@268
                  p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
                  limbs 51 [a70, a71, a72, a73, a74] * limbs 51 [b70, b71, b72, b73, b74] * 2@268
                  p
  ];

assert true &&
  and [
      c00 <u 0x8000000000662@64, c01 <u 0x8000000000000@64, c02 <u 0x8000000000033@64, c03 <u 0x8000000000000@64, c04 <u 0x800000000004b@64,
      c10 <u 0x8000000000662@64, c11 <u 0x8000000000000@64, c12 <u 0x8000000000033@64, c13 <u 0x8000000000000@64, c14 <u 0x800000000004b@64,
      c20 <u 0x8000000000662@64, c21 <u 0x8000000000000@64, c22 <u 0x8000000000033@64, c23 <u 0x8000000000000@64, c24 <u 0x800000000004b@64,
      c30 <u 0x8000000000662@64, c31 <u 0x8000000000000@64, c32 <u 0x8000000000033@64, c33 <u 0x8000000000000@64, c34 <u 0x800000000004b@64,
      c40 <u 0x8000000000662@64, c41 <u 0x8000000000000@64, c42 <u 0x8000000000033@64, c43 <u 0x8000000000000@64, c44 <u 0x800000000004b@64,
      c50 <u 0x8000000000662@64, c51 <u 0x8000000000000@64, c52 <u 0x8000000000033@64, c53 <u 0x8000000000000@64, c54 <u 0x800000000004b@64,
      c60 <u 0x8000000000662@64, c61 <u 0x8000000000000@64, c62 <u 0x8000000000033@64, c63 <u 0x8000000000000@64, c64 <u 0x800000000004b@64,
      c70 <u 0x8000000000662@64, c71 <u 0x8000000000000@64, c72 <u 0x8000000000033@64, c73 <u 0x8000000000000@64, c74 <u 0x800000000004b@64
  ];

{
  true
  &&
  true
}
