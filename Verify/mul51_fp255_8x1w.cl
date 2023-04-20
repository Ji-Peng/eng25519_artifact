(*
cv -v -disable_safety mul51_fp255_8x1w.cl
Parsing CryptoLine file:		[OK]		0.002418 seconds
Checking well-formedness:		[OK]		0.000932 seconds
Transforming to SSA form:		[OK]		0.000356 seconds
Normalizing specification:		[OK]		0.000356 seconds
Rewriting assignments:			[OK]		0.000516 seconds
Verifying range assertions:		[OK]		0.362883 seconds
Verifying range specification:	[OK]		0.825948 seconds
Rewriting value-preserved casting:	[OK]		0.000243 seconds
Verifying algebraic assertions:	[OK]		0.000040 seconds
Verifying algebraic specification:	[OK]		0.027401 seconds
Verification result:			[OK]		1.221535 seconds
*)

proc main (uint64 a00, uint64 a10, uint64 a20, uint64 a30, uint64 a40, uint64 a50, uint64 a60, uint64 a70,
           uint64 a01, uint64 a11, uint64 a21, uint64 a31, uint64 a41, uint64 a51, uint64 a61, uint64 a71,
           uint64 a02, uint64 a12, uint64 a22, uint64 a32, uint64 a42, uint64 a52, uint64 a62, uint64 a72,
           uint64 a03, uint64 a13, uint64 a23, uint64 a33, uint64 a43, uint64 a53, uint64 a63, uint64 a73,
           uint64 a04, uint64 a14, uint64 a24, uint64 a34, uint64 a44, uint64 a54, uint64 a64, uint64 a74,
           uint64 c00, uint64 c10, uint64 c20, uint64 c30, uint64 c40, uint64 c50, uint64 c60, uint64 c70,
           uint64 c01, uint64 c11, uint64 c21, uint64 c31, uint64 c41, uint64 c51, uint64 c61, uint64 c71,
           uint64 c02, uint64 c12, uint64 c22, uint64 c32, uint64 c42, uint64 c52, uint64 c62, uint64 c72,
           uint64 c03, uint64 c13, uint64 c23, uint64 c33, uint64 c43, uint64 c53, uint64 c63, uint64 c73,
           uint64 c04, uint64 c14, uint64 c24, uint64 c34, uint64 c44, uint64 c54, uint64 c64, uint64 c74,
           uint64 b, uint268 p) =
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
        b <=u 0xfffffffffffff@64
  ]
}

mov rdx b;
mov L0x55555556a100 0x13@uint64;
mov L0x55555556a140 0x0007ffffffffffff@uint64;
mov L0x55555556a148 0x0007ffffffffffff@uint64;
mov L0x55555556a150 0x0007ffffffffffff@uint64;
mov L0x55555556a158 0x0007ffffffffffff@uint64;
mov L0x55555556a160 0x0007ffffffffffff@uint64;
mov L0x55555556a168 0x0007ffffffffffff@uint64;
mov L0x55555556a170 0x0007ffffffffffff@uint64;
mov L0x55555556a178 0x0007ffffffffffff@uint64;
mov L0x7fffffffd640 a00;
mov L0x7fffffffd648 a10;
mov L0x7fffffffd650 a20;
mov L0x7fffffffd658 a30;
mov L0x7fffffffd660 a40;
mov L0x7fffffffd668 a50;
mov L0x7fffffffd670 a60;
mov L0x7fffffffd678 a70;
mov L0x7fffffffd680 a01;
mov L0x7fffffffd688 a11;
mov L0x7fffffffd690 a21;
mov L0x7fffffffd698 a31;
mov L0x7fffffffd6a0 a41;
mov L0x7fffffffd6a8 a51;
mov L0x7fffffffd6b0 a61;
mov L0x7fffffffd6b8 a71;
mov L0x7fffffffd6c0 a02;
mov L0x7fffffffd6c8 a12;
mov L0x7fffffffd6d0 a22;
mov L0x7fffffffd6d8 a32;
mov L0x7fffffffd6e0 a42;
mov L0x7fffffffd6e8 a52;
mov L0x7fffffffd6f0 a62;
mov L0x7fffffffd6f8 a72;
mov L0x7fffffffd700 a03;
mov L0x7fffffffd708 a13;
mov L0x7fffffffd710 a23;
mov L0x7fffffffd718 a33;
mov L0x7fffffffd720 a43;
mov L0x7fffffffd728 a53;
mov L0x7fffffffd730 a63;
mov L0x7fffffffd738 a73;
mov L0x7fffffffd740 a04;
mov L0x7fffffffd748 a14;
mov L0x7fffffffd750 a24;
mov L0x7fffffffd758 a34;
mov L0x7fffffffd760 a44;
mov L0x7fffffffd768 a54;
mov L0x7fffffffd770 a64;
mov L0x7fffffffd778 a74;

(* #! -> SP = 0x7fffffffd5f8 *)
#! 0x7fffffffd5f8 = 0x7fffffffd5f8;
(* vmovdqa64 0xc0(%rsi),%zmm5                      #! EA = L0x7fffffffd700; Value = 0x0000000000000000; PC = 0x555555556824 *)
mov zmm5_000 L0x7fffffffd700;
mov zmm5_001 L0x7fffffffd708;
mov zmm5_010 L0x7fffffffd710;
mov zmm5_011 L0x7fffffffd718;
mov zmm5_100 L0x7fffffffd720;
mov zmm5_101 L0x7fffffffd728;
mov zmm5_110 L0x7fffffffd730;
mov zmm5_111 L0x7fffffffd738;
(* vpxor  %zmm0,%zmm0,%zmm0                        #! PC = 0x55555555682b *)
mov zmm0_000 0@uint64;
mov zmm0_001 0@uint64;
mov zmm0_010 0@uint64;
mov zmm0_011 0@uint64;
mov zmm0_100 0@uint64;
mov zmm0_101 0@uint64;
mov zmm0_110 0@uint64;
mov zmm0_111 0@uint64;
(* vpbroadcastq %rdx,%zmm1                         #! PC = 0x55555555682f *)
mov zmm1_000 rdx;
mov zmm1_001 rdx;
mov zmm1_010 rdx;
mov zmm1_011 rdx;
mov zmm1_100 rdx;
mov zmm1_101 rdx;
mov zmm1_110 rdx;
mov zmm1_111 rdx;
(* vmovdqa64 %zmm0,%zmm14                          #! PC = 0x555555556835 *)
mov zmm14_000 zmm0_000;
mov zmm14_001 zmm0_001;
mov zmm14_010 zmm0_010;
mov zmm14_011 zmm0_011;
mov zmm14_100 zmm0_100;
mov zmm14_101 zmm0_101;
mov zmm14_110 zmm0_110;
mov zmm14_111 zmm0_111;
(* vmovdqa64 (%rsi),%zmm8                          #! EA = L0x7fffffffd640; Value = 0x00007ffff7fc38d8; PC = 0x55555555683b *)
mov zmm8_000 L0x7fffffffd640;
mov zmm8_001 L0x7fffffffd648;
mov zmm8_010 L0x7fffffffd650;
mov zmm8_011 L0x7fffffffd658;
mov zmm8_100 L0x7fffffffd660;
mov zmm8_101 L0x7fffffffd668;
mov zmm8_110 L0x7fffffffd670;
mov zmm8_111 L0x7fffffffd678;
(* vmovdqa64 0x40(%rsi),%zmm2                      #! EA = L0x7fffffffd680; Value = 0x0000000000000000; PC = 0x555555556841 *)
mov zmm2_000 L0x7fffffffd680;
mov zmm2_001 L0x7fffffffd688;
mov zmm2_010 L0x7fffffffd690;
mov zmm2_011 L0x7fffffffd698;
mov zmm2_100 L0x7fffffffd6a0;
mov zmm2_101 L0x7fffffffd6a8;
mov zmm2_110 L0x7fffffffd6b0;
mov zmm2_111 L0x7fffffffd6b8;
(* vpmadd52huq %zmm1,%zmm5,%zmm14                  #! PC = 0x555555556848 *)
assert true && and [
zmm1_000 <u 0x10000000000000@64, zmm5_000 <u 0x10000000000000@64, zmm1_001 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm1_010 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm1_011 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm1_100 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm1_101 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm1_110 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm1_111 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64
];
umulj zmm1_zmm5_000F zmm1_000 zmm5_000; spl zmm1_zmm5_000h_t zmm1_zmm5_000l_t zmm1_zmm5_000F 52;
umulj zmm1_zmm5_001F zmm1_001 zmm5_001; spl zmm1_zmm5_001h_t zmm1_zmm5_001l_t zmm1_zmm5_001F 52;
umulj zmm1_zmm5_010F zmm1_010 zmm5_010; spl zmm1_zmm5_010h_t zmm1_zmm5_010l_t zmm1_zmm5_010F 52;
umulj zmm1_zmm5_011F zmm1_011 zmm5_011; spl zmm1_zmm5_011h_t zmm1_zmm5_011l_t zmm1_zmm5_011F 52;
umulj zmm1_zmm5_100F zmm1_100 zmm5_100; spl zmm1_zmm5_100h_t zmm1_zmm5_100l_t zmm1_zmm5_100F 52;
umulj zmm1_zmm5_101F zmm1_101 zmm5_101; spl zmm1_zmm5_101h_t zmm1_zmm5_101l_t zmm1_zmm5_101F 52;
umulj zmm1_zmm5_110F zmm1_110 zmm5_110; spl zmm1_zmm5_110h_t zmm1_zmm5_110l_t zmm1_zmm5_110F 52;
umulj zmm1_zmm5_111F zmm1_111 zmm5_111; spl zmm1_zmm5_111h_t zmm1_zmm5_111l_t zmm1_zmm5_111F 52;
vpc zmm1_zmm5_000h_t@uint64 zmm1_zmm5_000h_t; vpc zmm1_zmm5_000l_t@uint64 zmm1_zmm5_000l_t;
vpc zmm1_zmm5_001h_t@uint64 zmm1_zmm5_001h_t; vpc zmm1_zmm5_001l_t@uint64 zmm1_zmm5_001l_t;
vpc zmm1_zmm5_010h_t@uint64 zmm1_zmm5_010h_t; vpc zmm1_zmm5_010l_t@uint64 zmm1_zmm5_010l_t;
vpc zmm1_zmm5_011h_t@uint64 zmm1_zmm5_011h_t; vpc zmm1_zmm5_011l_t@uint64 zmm1_zmm5_011l_t;
vpc zmm1_zmm5_100h_t@uint64 zmm1_zmm5_100h_t; vpc zmm1_zmm5_100l_t@uint64 zmm1_zmm5_100l_t;
vpc zmm1_zmm5_101h_t@uint64 zmm1_zmm5_101h_t; vpc zmm1_zmm5_101l_t@uint64 zmm1_zmm5_101l_t;
vpc zmm1_zmm5_110h_t@uint64 zmm1_zmm5_110h_t; vpc zmm1_zmm5_110l_t@uint64 zmm1_zmm5_110l_t;
vpc zmm1_zmm5_111h_t@uint64 zmm1_zmm5_111h_t; vpc zmm1_zmm5_111l_t@uint64 zmm1_zmm5_111l_t;
add zmm14_000 zmm14_000 zmm1_zmm5_000h_t;
add zmm14_001 zmm14_001 zmm1_zmm5_001h_t;
add zmm14_010 zmm14_010 zmm1_zmm5_010h_t;
add zmm14_011 zmm14_011 zmm1_zmm5_011h_t;
add zmm14_100 zmm14_100 zmm1_zmm5_100h_t;
add zmm14_101 zmm14_101 zmm1_zmm5_101h_t;
add zmm14_110 zmm14_110 zmm1_zmm5_110h_t;
add zmm14_111 zmm14_111 zmm1_zmm5_111h_t;
(* vmovdqa64 0x80(%rsi),%zmm6                      #! EA = L0x7fffffffd6c0; Value = 0x0000000000000000; PC = 0x55555555684e *)
mov zmm6_000 L0x7fffffffd6c0;
mov zmm6_001 L0x7fffffffd6c8;
mov zmm6_010 L0x7fffffffd6d0;
mov zmm6_011 L0x7fffffffd6d8;
mov zmm6_100 L0x7fffffffd6e0;
mov zmm6_101 L0x7fffffffd6e8;
mov zmm6_110 L0x7fffffffd6f0;
mov zmm6_111 L0x7fffffffd6f8;
(* vmovdqa64 %zmm0,%zmm3                           #! PC = 0x555555556855 *)
mov zmm3_000 zmm0_000;
mov zmm3_001 zmm0_001;
mov zmm3_010 zmm0_010;
mov zmm3_011 zmm0_011;
mov zmm3_100 zmm0_100;
mov zmm3_101 zmm0_101;
mov zmm3_110 zmm0_110;
mov zmm3_111 zmm0_111;
(* vmovdqa64 %zmm0,%zmm11                          #! PC = 0x55555555685b *)
mov zmm11_000 zmm0_000;
mov zmm11_001 zmm0_001;
mov zmm11_010 zmm0_010;
mov zmm11_011 zmm0_011;
mov zmm11_100 zmm0_100;
mov zmm11_101 zmm0_101;
mov zmm11_110 zmm0_110;
mov zmm11_111 zmm0_111;
(* vpmadd52huq %zmm1,%zmm8,%zmm3                   #! PC = 0x555555556861 *)
assert true && and [
zmm1_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm1_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm1_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm1_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm1_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm1_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm1_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm1_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm1_zmm8_000F zmm1_000 zmm8_000; spl zmm1_zmm8_000h_t zmm1_zmm8_000l_t zmm1_zmm8_000F 52;
umulj zmm1_zmm8_001F zmm1_001 zmm8_001; spl zmm1_zmm8_001h_t zmm1_zmm8_001l_t zmm1_zmm8_001F 52;
umulj zmm1_zmm8_010F zmm1_010 zmm8_010; spl zmm1_zmm8_010h_t zmm1_zmm8_010l_t zmm1_zmm8_010F 52;
umulj zmm1_zmm8_011F zmm1_011 zmm8_011; spl zmm1_zmm8_011h_t zmm1_zmm8_011l_t zmm1_zmm8_011F 52;
umulj zmm1_zmm8_100F zmm1_100 zmm8_100; spl zmm1_zmm8_100h_t zmm1_zmm8_100l_t zmm1_zmm8_100F 52;
umulj zmm1_zmm8_101F zmm1_101 zmm8_101; spl zmm1_zmm8_101h_t zmm1_zmm8_101l_t zmm1_zmm8_101F 52;
umulj zmm1_zmm8_110F zmm1_110 zmm8_110; spl zmm1_zmm8_110h_t zmm1_zmm8_110l_t zmm1_zmm8_110F 52;
umulj zmm1_zmm8_111F zmm1_111 zmm8_111; spl zmm1_zmm8_111h_t zmm1_zmm8_111l_t zmm1_zmm8_111F 52;
vpc zmm1_zmm8_000h_t@uint64 zmm1_zmm8_000h_t; vpc zmm1_zmm8_000l_t@uint64 zmm1_zmm8_000l_t;
vpc zmm1_zmm8_001h_t@uint64 zmm1_zmm8_001h_t; vpc zmm1_zmm8_001l_t@uint64 zmm1_zmm8_001l_t;
vpc zmm1_zmm8_010h_t@uint64 zmm1_zmm8_010h_t; vpc zmm1_zmm8_010l_t@uint64 zmm1_zmm8_010l_t;
vpc zmm1_zmm8_011h_t@uint64 zmm1_zmm8_011h_t; vpc zmm1_zmm8_011l_t@uint64 zmm1_zmm8_011l_t;
vpc zmm1_zmm8_100h_t@uint64 zmm1_zmm8_100h_t; vpc zmm1_zmm8_100l_t@uint64 zmm1_zmm8_100l_t;
vpc zmm1_zmm8_101h_t@uint64 zmm1_zmm8_101h_t; vpc zmm1_zmm8_101l_t@uint64 zmm1_zmm8_101l_t;
vpc zmm1_zmm8_110h_t@uint64 zmm1_zmm8_110h_t; vpc zmm1_zmm8_110l_t@uint64 zmm1_zmm8_110l_t;
vpc zmm1_zmm8_111h_t@uint64 zmm1_zmm8_111h_t; vpc zmm1_zmm8_111l_t@uint64 zmm1_zmm8_111l_t;
add zmm3_000 zmm3_000 zmm1_zmm8_000h_t;
add zmm3_001 zmm3_001 zmm1_zmm8_001h_t;
add zmm3_010 zmm3_010 zmm1_zmm8_010h_t;
add zmm3_011 zmm3_011 zmm1_zmm8_011h_t;
add zmm3_100 zmm3_100 zmm1_zmm8_100h_t;
add zmm3_101 zmm3_101 zmm1_zmm8_101h_t;
add zmm3_110 zmm3_110 zmm1_zmm8_110h_t;
add zmm3_111 zmm3_111 zmm1_zmm8_111h_t;
(* vpmadd52huq %zmm1,%zmm2,%zmm11                  #! PC = 0x555555556867 *)
assert true && and [
zmm1_000 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, zmm1_001 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm1_010 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm1_011 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm1_100 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm1_101 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm1_110 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm1_111 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj zmm1_zmm2_000F zmm1_000 zmm2_000; spl zmm1_zmm2_000h_t zmm1_zmm2_000l_t zmm1_zmm2_000F 52;
umulj zmm1_zmm2_001F zmm1_001 zmm2_001; spl zmm1_zmm2_001h_t zmm1_zmm2_001l_t zmm1_zmm2_001F 52;
umulj zmm1_zmm2_010F zmm1_010 zmm2_010; spl zmm1_zmm2_010h_t zmm1_zmm2_010l_t zmm1_zmm2_010F 52;
umulj zmm1_zmm2_011F zmm1_011 zmm2_011; spl zmm1_zmm2_011h_t zmm1_zmm2_011l_t zmm1_zmm2_011F 52;
umulj zmm1_zmm2_100F zmm1_100 zmm2_100; spl zmm1_zmm2_100h_t zmm1_zmm2_100l_t zmm1_zmm2_100F 52;
umulj zmm1_zmm2_101F zmm1_101 zmm2_101; spl zmm1_zmm2_101h_t zmm1_zmm2_101l_t zmm1_zmm2_101F 52;
umulj zmm1_zmm2_110F zmm1_110 zmm2_110; spl zmm1_zmm2_110h_t zmm1_zmm2_110l_t zmm1_zmm2_110F 52;
umulj zmm1_zmm2_111F zmm1_111 zmm2_111; spl zmm1_zmm2_111h_t zmm1_zmm2_111l_t zmm1_zmm2_111F 52;
vpc zmm1_zmm2_000h_t@uint64 zmm1_zmm2_000h_t; vpc zmm1_zmm2_000l_t@uint64 zmm1_zmm2_000l_t;
vpc zmm1_zmm2_001h_t@uint64 zmm1_zmm2_001h_t; vpc zmm1_zmm2_001l_t@uint64 zmm1_zmm2_001l_t;
vpc zmm1_zmm2_010h_t@uint64 zmm1_zmm2_010h_t; vpc zmm1_zmm2_010l_t@uint64 zmm1_zmm2_010l_t;
vpc zmm1_zmm2_011h_t@uint64 zmm1_zmm2_011h_t; vpc zmm1_zmm2_011l_t@uint64 zmm1_zmm2_011l_t;
vpc zmm1_zmm2_100h_t@uint64 zmm1_zmm2_100h_t; vpc zmm1_zmm2_100l_t@uint64 zmm1_zmm2_100l_t;
vpc zmm1_zmm2_101h_t@uint64 zmm1_zmm2_101h_t; vpc zmm1_zmm2_101l_t@uint64 zmm1_zmm2_101l_t;
vpc zmm1_zmm2_110h_t@uint64 zmm1_zmm2_110h_t; vpc zmm1_zmm2_110l_t@uint64 zmm1_zmm2_110l_t;
vpc zmm1_zmm2_111h_t@uint64 zmm1_zmm2_111h_t; vpc zmm1_zmm2_111l_t@uint64 zmm1_zmm2_111l_t;
add zmm11_000 zmm11_000 zmm1_zmm2_000h_t;
add zmm11_001 zmm11_001 zmm1_zmm2_001h_t;
add zmm11_010 zmm11_010 zmm1_zmm2_010h_t;
add zmm11_011 zmm11_011 zmm1_zmm2_011h_t;
add zmm11_100 zmm11_100 zmm1_zmm2_100h_t;
add zmm11_101 zmm11_101 zmm1_zmm2_101h_t;
add zmm11_110 zmm11_110 zmm1_zmm2_110h_t;
add zmm11_111 zmm11_111 zmm1_zmm2_111h_t;
(* vmovdqa64 %zmm0,%zmm10                          #! PC = 0x55555555686d *)
mov zmm10_000 zmm0_000;
mov zmm10_001 zmm0_001;
mov zmm10_010 zmm0_010;
mov zmm10_011 zmm0_011;
mov zmm10_100 zmm0_100;
mov zmm10_101 zmm0_101;
mov zmm10_110 zmm0_110;
mov zmm10_111 zmm0_111;
(* vpmadd52huq %zmm1,%zmm6,%zmm10                  #! PC = 0x555555556873 *)
assert true && and [
zmm1_000 <u 0x10000000000000@64, zmm6_000 <u 0x10000000000000@64, zmm1_001 <u 0x10000000000000@64, zmm6_001 <u 0x10000000000000@64, zmm1_010 <u 0x10000000000000@64, zmm6_010 <u 0x10000000000000@64, zmm1_011 <u 0x10000000000000@64, zmm6_011 <u 0x10000000000000@64, zmm1_100 <u 0x10000000000000@64, zmm6_100 <u 0x10000000000000@64, zmm1_101 <u 0x10000000000000@64, zmm6_101 <u 0x10000000000000@64, zmm1_110 <u 0x10000000000000@64, zmm6_110 <u 0x10000000000000@64, zmm1_111 <u 0x10000000000000@64, zmm6_111 <u 0x10000000000000@64
];
umulj zmm1_zmm6_000F zmm1_000 zmm6_000; spl zmm1_zmm6_000h_t zmm1_zmm6_000l_t zmm1_zmm6_000F 52;
umulj zmm1_zmm6_001F zmm1_001 zmm6_001; spl zmm1_zmm6_001h_t zmm1_zmm6_001l_t zmm1_zmm6_001F 52;
umulj zmm1_zmm6_010F zmm1_010 zmm6_010; spl zmm1_zmm6_010h_t zmm1_zmm6_010l_t zmm1_zmm6_010F 52;
umulj zmm1_zmm6_011F zmm1_011 zmm6_011; spl zmm1_zmm6_011h_t zmm1_zmm6_011l_t zmm1_zmm6_011F 52;
umulj zmm1_zmm6_100F zmm1_100 zmm6_100; spl zmm1_zmm6_100h_t zmm1_zmm6_100l_t zmm1_zmm6_100F 52;
umulj zmm1_zmm6_101F zmm1_101 zmm6_101; spl zmm1_zmm6_101h_t zmm1_zmm6_101l_t zmm1_zmm6_101F 52;
umulj zmm1_zmm6_110F zmm1_110 zmm6_110; spl zmm1_zmm6_110h_t zmm1_zmm6_110l_t zmm1_zmm6_110F 52;
umulj zmm1_zmm6_111F zmm1_111 zmm6_111; spl zmm1_zmm6_111h_t zmm1_zmm6_111l_t zmm1_zmm6_111F 52;
vpc zmm1_zmm6_000h_t@uint64 zmm1_zmm6_000h_t; vpc zmm1_zmm6_000l_t@uint64 zmm1_zmm6_000l_t;
vpc zmm1_zmm6_001h_t@uint64 zmm1_zmm6_001h_t; vpc zmm1_zmm6_001l_t@uint64 zmm1_zmm6_001l_t;
vpc zmm1_zmm6_010h_t@uint64 zmm1_zmm6_010h_t; vpc zmm1_zmm6_010l_t@uint64 zmm1_zmm6_010l_t;
vpc zmm1_zmm6_011h_t@uint64 zmm1_zmm6_011h_t; vpc zmm1_zmm6_011l_t@uint64 zmm1_zmm6_011l_t;
vpc zmm1_zmm6_100h_t@uint64 zmm1_zmm6_100h_t; vpc zmm1_zmm6_100l_t@uint64 zmm1_zmm6_100l_t;
vpc zmm1_zmm6_101h_t@uint64 zmm1_zmm6_101h_t; vpc zmm1_zmm6_101l_t@uint64 zmm1_zmm6_101l_t;
vpc zmm1_zmm6_110h_t@uint64 zmm1_zmm6_110h_t; vpc zmm1_zmm6_110l_t@uint64 zmm1_zmm6_110l_t;
vpc zmm1_zmm6_111h_t@uint64 zmm1_zmm6_111h_t; vpc zmm1_zmm6_111l_t@uint64 zmm1_zmm6_111l_t;
add zmm10_000 zmm10_000 zmm1_zmm6_000h_t;
add zmm10_001 zmm10_001 zmm1_zmm6_001h_t;
add zmm10_010 zmm10_010 zmm1_zmm6_010h_t;
add zmm10_011 zmm10_011 zmm1_zmm6_011h_t;
add zmm10_100 zmm10_100 zmm1_zmm6_100h_t;
add zmm10_101 zmm10_101 zmm1_zmm6_101h_t;
add zmm10_110 zmm10_110 zmm1_zmm6_110h_t;
add zmm10_111 zmm10_111 zmm1_zmm6_111h_t;
(* vmovdqa64 0x100(%rsi),%zmm7                     #! EA = L0x7fffffffd740; Value = 0x00007ffff7caec80; PC = 0x555555556879 *)
mov zmm7_000 L0x7fffffffd740;
mov zmm7_001 L0x7fffffffd748;
mov zmm7_010 L0x7fffffffd750;
mov zmm7_011 L0x7fffffffd758;
mov zmm7_100 L0x7fffffffd760;
mov zmm7_101 L0x7fffffffd768;
mov zmm7_110 L0x7fffffffd770;
mov zmm7_111 L0x7fffffffd778;
(* vmovdqa64 %zmm0,%zmm4                           #! PC = 0x555555556880 *)
mov zmm4_000 zmm0_000;
mov zmm4_001 zmm0_001;
mov zmm4_010 zmm0_010;
mov zmm4_011 zmm0_011;
mov zmm4_100 zmm0_100;
mov zmm4_101 zmm0_101;
mov zmm4_110 zmm0_110;
mov zmm4_111 zmm0_111;
(* vpmadd52luq %zmm1,%zmm8,%zmm4                   #! PC = 0x555555556886 *)
add zmm4_000 zmm4_000 zmm1_zmm8_000l_t;
add zmm4_001 zmm4_001 zmm1_zmm8_001l_t;
add zmm4_010 zmm4_010 zmm1_zmm8_010l_t;
add zmm4_011 zmm4_011 zmm1_zmm8_011l_t;
add zmm4_100 zmm4_100 zmm1_zmm8_100l_t;
add zmm4_101 zmm4_101 zmm1_zmm8_101l_t;
add zmm4_110 zmm4_110 zmm1_zmm8_110l_t;
add zmm4_111 zmm4_111 zmm1_zmm8_111l_t;
(* vpsllq $0x1,%zmm14,%zmm15                       #! PC = 0x55555555688c *)
shl zmm15_000 zmm14_000 0x1;
shl zmm15_001 zmm14_001 0x1;
shl zmm15_010 zmm14_010 0x1;
shl zmm15_011 zmm14_011 0x1;
shl zmm15_100 zmm14_100 0x1;
shl zmm15_101 zmm14_101 0x1;
shl zmm15_110 zmm14_110 0x1;
shl zmm15_111 zmm14_111 0x1;
(* vmovdqa64 %zmm0,%zmm8                           #! PC = 0x555555556893 *)
mov zmm8_000 zmm0_000;
mov zmm8_001 zmm0_001;
mov zmm8_010 zmm0_010;
mov zmm8_011 zmm0_011;
mov zmm8_100 zmm0_100;
mov zmm8_101 zmm0_101;
mov zmm8_110 zmm0_110;
mov zmm8_111 zmm0_111;
(* vpmadd52huq %zmm1,%zmm7,%zmm8                   #! PC = 0x555555556899 *)
assert true && and [
zmm1_000 <u 0x10000000000000@64, zmm7_000 <u 0x10000000000000@64, zmm1_001 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm1_010 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm1_011 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm1_100 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm1_101 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm1_110 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm1_111 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64
];
umulj zmm1_zmm7_000F zmm1_000 zmm7_000; spl zmm1_zmm7_000h_t zmm1_zmm7_000l_t zmm1_zmm7_000F 52;
umulj zmm1_zmm7_001F zmm1_001 zmm7_001; spl zmm1_zmm7_001h_t zmm1_zmm7_001l_t zmm1_zmm7_001F 52;
umulj zmm1_zmm7_010F zmm1_010 zmm7_010; spl zmm1_zmm7_010h_t zmm1_zmm7_010l_t zmm1_zmm7_010F 52;
umulj zmm1_zmm7_011F zmm1_011 zmm7_011; spl zmm1_zmm7_011h_t zmm1_zmm7_011l_t zmm1_zmm7_011F 52;
umulj zmm1_zmm7_100F zmm1_100 zmm7_100; spl zmm1_zmm7_100h_t zmm1_zmm7_100l_t zmm1_zmm7_100F 52;
umulj zmm1_zmm7_101F zmm1_101 zmm7_101; spl zmm1_zmm7_101h_t zmm1_zmm7_101l_t zmm1_zmm7_101F 52;
umulj zmm1_zmm7_110F zmm1_110 zmm7_110; spl zmm1_zmm7_110h_t zmm1_zmm7_110l_t zmm1_zmm7_110F 52;
umulj zmm1_zmm7_111F zmm1_111 zmm7_111; spl zmm1_zmm7_111h_t zmm1_zmm7_111l_t zmm1_zmm7_111F 52;
vpc zmm1_zmm7_000h_t@uint64 zmm1_zmm7_000h_t; vpc zmm1_zmm7_000l_t@uint64 zmm1_zmm7_000l_t;
vpc zmm1_zmm7_001h_t@uint64 zmm1_zmm7_001h_t; vpc zmm1_zmm7_001l_t@uint64 zmm1_zmm7_001l_t;
vpc zmm1_zmm7_010h_t@uint64 zmm1_zmm7_010h_t; vpc zmm1_zmm7_010l_t@uint64 zmm1_zmm7_010l_t;
vpc zmm1_zmm7_011h_t@uint64 zmm1_zmm7_011h_t; vpc zmm1_zmm7_011l_t@uint64 zmm1_zmm7_011l_t;
vpc zmm1_zmm7_100h_t@uint64 zmm1_zmm7_100h_t; vpc zmm1_zmm7_100l_t@uint64 zmm1_zmm7_100l_t;
vpc zmm1_zmm7_101h_t@uint64 zmm1_zmm7_101h_t; vpc zmm1_zmm7_101l_t@uint64 zmm1_zmm7_101l_t;
vpc zmm1_zmm7_110h_t@uint64 zmm1_zmm7_110h_t; vpc zmm1_zmm7_110l_t@uint64 zmm1_zmm7_110l_t;
vpc zmm1_zmm7_111h_t@uint64 zmm1_zmm7_111h_t; vpc zmm1_zmm7_111l_t@uint64 zmm1_zmm7_111l_t;
add zmm8_000 zmm8_000 zmm1_zmm7_000h_t;
add zmm8_001 zmm8_001 zmm1_zmm7_001h_t;
add zmm8_010 zmm8_010 zmm1_zmm7_010h_t;
add zmm8_011 zmm8_011 zmm1_zmm7_011h_t;
add zmm8_100 zmm8_100 zmm1_zmm7_100h_t;
add zmm8_101 zmm8_101 zmm1_zmm7_101h_t;
add zmm8_110 zmm8_110 zmm1_zmm7_110h_t;
add zmm8_111 zmm8_111 zmm1_zmm7_111h_t;
(* vpmadd52luq %zmm1,%zmm7,%zmm15                  #! PC = 0x55555555689f *)
add zmm15_000 zmm15_000 zmm1_zmm7_000l_t;
add zmm15_001 zmm15_001 zmm1_zmm7_001l_t;
add zmm15_010 zmm15_010 zmm1_zmm7_010l_t;
add zmm15_011 zmm15_011 zmm1_zmm7_011l_t;
add zmm15_100 zmm15_100 zmm1_zmm7_100l_t;
add zmm15_101 zmm15_101 zmm1_zmm7_101l_t;
add zmm15_110 zmm15_110 zmm1_zmm7_110l_t;
add zmm15_111 zmm15_111 zmm1_zmm7_111l_t;
(* vpsllq $0x1,%zmm3,%zmm9                         #! PC = 0x5555555568a5 *)
shl zmm9_000 zmm3_000 0x1;
shl zmm9_001 zmm3_001 0x1;
shl zmm9_010 zmm3_010 0x1;
shl zmm9_011 zmm3_011 0x1;
shl zmm9_100 zmm3_100 0x1;
shl zmm9_101 zmm3_101 0x1;
shl zmm9_110 zmm3_110 0x1;
shl zmm9_111 zmm3_111 0x1;
(* vpsllq $0x1,%zmm11,%zmm13                       #! PC = 0x5555555568ac *)
shl zmm13_000 zmm11_000 0x1;
shl zmm13_001 zmm11_001 0x1;
shl zmm13_010 zmm11_010 0x1;
shl zmm13_011 zmm11_011 0x1;
shl zmm13_100 zmm11_100 0x1;
shl zmm13_101 zmm11_101 0x1;
shl zmm13_110 zmm11_110 0x1;
shl zmm13_111 zmm11_111 0x1;
(* vpmadd52luq %zmm1,%zmm2,%zmm9                   #! PC = 0x5555555568b3 *)
add zmm9_000 zmm9_000 zmm1_zmm2_000l_t;
add zmm9_001 zmm9_001 zmm1_zmm2_001l_t;
add zmm9_010 zmm9_010 zmm1_zmm2_010l_t;
add zmm9_011 zmm9_011 zmm1_zmm2_011l_t;
add zmm9_100 zmm9_100 zmm1_zmm2_100l_t;
add zmm9_101 zmm9_101 zmm1_zmm2_101l_t;
add zmm9_110 zmm9_110 zmm1_zmm2_110l_t;
add zmm9_111 zmm9_111 zmm1_zmm2_111l_t;
(* vpmadd52luq %zmm1,%zmm6,%zmm13                  #! PC = 0x5555555568b9 *)
add zmm13_000 zmm13_000 zmm1_zmm6_000l_t;
add zmm13_001 zmm13_001 zmm1_zmm6_001l_t;
add zmm13_010 zmm13_010 zmm1_zmm6_010l_t;
add zmm13_011 zmm13_011 zmm1_zmm6_011l_t;
add zmm13_100 zmm13_100 zmm1_zmm6_100l_t;
add zmm13_101 zmm13_101 zmm1_zmm6_101l_t;
add zmm13_110 zmm13_110 zmm1_zmm6_110l_t;
add zmm13_111 zmm13_111 zmm1_zmm6_111l_t;
(* vpsllq $0x1,%zmm10,%zmm12                       #! PC = 0x5555555568bf *)
shl zmm12_000 zmm10_000 0x1;
shl zmm12_001 zmm10_001 0x1;
shl zmm12_010 zmm10_010 0x1;
shl zmm12_011 zmm10_011 0x1;
shl zmm12_100 zmm10_100 0x1;
shl zmm12_101 zmm10_101 0x1;
shl zmm12_110 zmm10_110 0x1;
shl zmm12_111 zmm10_111 0x1;
(* vpmadd52luq %zmm1,%zmm5,%zmm12                  #! PC = 0x5555555568c6 *)
add zmm12_000 zmm12_000 zmm1_zmm5_000l_t;
add zmm12_001 zmm12_001 zmm1_zmm5_001l_t;
add zmm12_010 zmm12_010 zmm1_zmm5_010l_t;
add zmm12_011 zmm12_011 zmm1_zmm5_011l_t;
add zmm12_100 zmm12_100 zmm1_zmm5_100l_t;
add zmm12_101 zmm12_101 zmm1_zmm5_101l_t;
add zmm12_110 zmm12_110 zmm1_zmm5_110l_t;
add zmm12_111 zmm12_111 zmm1_zmm5_111l_t;
(* vpsllq $0x1,%zmm8,%zmm6                         #! PC = 0x5555555568cc *)
shl zmm6_000 zmm8_000 0x1;
shl zmm6_001 zmm8_001 0x1;
shl zmm6_010 zmm8_010 0x1;
shl zmm6_011 zmm8_011 0x1;
shl zmm6_100 zmm8_100 0x1;
shl zmm6_101 zmm8_101 0x1;
shl zmm6_110 zmm8_110 0x1;
shl zmm6_111 zmm8_111 0x1;
(* vpsrlq $0x33,%zmm15,%zmm7                       #! PC = 0x5555555568d3 *)
split zmm15_000_h zmm15_000_l zmm15_000 51;
split zmm15_001_h zmm15_001_l zmm15_001 51;
split zmm15_010_h zmm15_010_l zmm15_010 51;
split zmm15_011_h zmm15_011_l zmm15_011 51;
split zmm15_100_h zmm15_100_l zmm15_100 51;
split zmm15_101_h zmm15_101_l zmm15_101 51;
split zmm15_110_h zmm15_110_l zmm15_110 51;
split zmm15_111_h zmm15_111_l zmm15_111 51;
mov zmm7_000 zmm15_000_h;
mov zmm7_001 zmm15_001_h;
mov zmm7_010 zmm15_010_h;
mov zmm7_011 zmm15_011_h;
mov zmm7_100 zmm15_100_h;
mov zmm7_101 zmm15_101_h;
mov zmm7_110 zmm15_110_h;
mov zmm7_111 zmm15_111_h;
(* vmovdqa32 0x1385c(%rip),%zmm8        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x5555555568da *)
mov zmm8_000 L0x55555556a140;
mov zmm8_001 L0x55555556a148;
mov zmm8_010 L0x55555556a150;
mov zmm8_011 L0x55555556a158;
mov zmm8_100 L0x55555556a160;
mov zmm8_101 L0x55555556a168;
mov zmm8_110 L0x55555556a170;
mov zmm8_111 L0x55555556a178;
(* vpbroadcastq 0x13812(%rip),%zmm10        # 0x55555556a100#! EA = L0x55555556a100; Value = 0x0000000000000013; PC = 0x5555555568e4 *)
mov zmm10_000 L0x55555556a100;
mov zmm10_001 L0x55555556a100;
mov zmm10_010 L0x55555556a100;
mov zmm10_011 L0x55555556a100;
mov zmm10_100 L0x55555556a100;
mov zmm10_101 L0x55555556a100;
mov zmm10_110 L0x55555556a100;
mov zmm10_111 L0x55555556a100;
(* vpaddq %zmm7,%zmm6,%zmm11                       #! PC = 0x5555555568ee *)
add zmm11_000 zmm6_000 zmm7_000;
add zmm11_001 zmm6_001 zmm7_001;
add zmm11_010 zmm6_010 zmm7_010;
add zmm11_011 zmm6_011 zmm7_011;
add zmm11_100 zmm6_100 zmm7_100;
add zmm11_101 zmm6_101 zmm7_101;
add zmm11_110 zmm6_110 zmm7_110;
add zmm11_111 zmm6_111 zmm7_111;
(* vpsrlq $0x33,%zmm4,%zmm2                        #! PC = 0x5555555568f4 *)
split zmm4_000_h zmm4_000_l zmm4_000 51;
split zmm4_001_h zmm4_001_l zmm4_001 51;
split zmm4_010_h zmm4_010_l zmm4_010 51;
split zmm4_011_h zmm4_011_l zmm4_011 51;
split zmm4_100_h zmm4_100_l zmm4_100 51;
split zmm4_101_h zmm4_101_l zmm4_101 51;
split zmm4_110_h zmm4_110_l zmm4_110 51;
split zmm4_111_h zmm4_111_l zmm4_111 51;
mov zmm2_000 zmm4_000_h;
mov zmm2_001 zmm4_001_h;
mov zmm2_010 zmm4_010_h;
mov zmm2_011 zmm4_011_h;
mov zmm2_100 zmm4_100_h;
mov zmm2_101 zmm4_101_h;
mov zmm2_110 zmm4_110_h;
mov zmm2_111 zmm4_111_h;
(* vpandd %zmm8,%zmm11,%zmm6                       #! PC = 0x5555555568fb *)
split zmm11_000_h zmm11_000_l zmm11_000 51;
split zmm11_001_h zmm11_001_l zmm11_001 51;
split zmm11_010_h zmm11_010_l zmm11_010 51;
split zmm11_011_h zmm11_011_l zmm11_011 51;
split zmm11_100_h zmm11_100_l zmm11_100 51;
split zmm11_101_h zmm11_101_l zmm11_101 51;
split zmm11_110_h zmm11_110_l zmm11_110 51;
split zmm11_111_h zmm11_111_l zmm11_111 51;
mov zmm6_000 zmm11_000_l;
mov zmm6_001 zmm11_001_l;
mov zmm6_010 zmm11_010_l;
mov zmm6_011 zmm11_011_l;
mov zmm6_100 zmm11_100_l;
mov zmm6_101 zmm11_101_l;
mov zmm6_110 zmm11_110_l;
mov zmm6_111 zmm11_111_l;
(* vpaddq %zmm2,%zmm9,%zmm3                        #! PC = 0x555555556901 *)
add zmm3_000 zmm9_000 zmm2_000;
add zmm3_001 zmm9_001 zmm2_001;
add zmm3_010 zmm9_010 zmm2_010;
add zmm3_011 zmm9_011 zmm2_011;
add zmm3_100 zmm9_100 zmm2_100;
add zmm3_101 zmm9_101 zmm2_101;
add zmm3_110 zmm9_110 zmm2_110;
add zmm3_111 zmm9_111 zmm2_111;
(* vpsrlq $0x33,%zmm13,%zmm5                       #! PC = 0x555555556907 *)
split zmm13_000_h zmm13_000_l zmm13_000 51;
split zmm13_001_h zmm13_001_l zmm13_001 51;
split zmm13_010_h zmm13_010_l zmm13_010 51;
split zmm13_011_h zmm13_011_l zmm13_011 51;
split zmm13_100_h zmm13_100_l zmm13_100 51;
split zmm13_101_h zmm13_101_l zmm13_101 51;
split zmm13_110_h zmm13_110_l zmm13_110 51;
split zmm13_111_h zmm13_111_l zmm13_111 51;
mov zmm5_000 zmm13_000_h;
mov zmm5_001 zmm13_001_h;
mov zmm5_010 zmm13_010_h;
mov zmm5_011 zmm13_011_h;
mov zmm5_100 zmm13_100_h;
mov zmm5_101 zmm13_101_h;
mov zmm5_110 zmm13_110_h;
mov zmm5_111 zmm13_111_h;
(* vpandd %zmm8,%zmm4,%zmm2                        #! PC = 0x55555555690e *)
mov zmm2_000 zmm4_000_l;
mov zmm2_001 zmm4_001_l;
mov zmm2_010 zmm4_010_l;
mov zmm2_011 zmm4_011_l;
mov zmm2_100 zmm4_100_l;
mov zmm2_101 zmm4_101_l;
mov zmm2_110 zmm4_110_l;
mov zmm2_111 zmm4_111_l;
(* vmovdqa64 %zmm0,%zmm4                           #! PC = 0x555555556914 *)
mov zmm4_000 zmm0_000;
mov zmm4_001 zmm0_001;
mov zmm4_010 zmm0_010;
mov zmm4_011 zmm0_011;
mov zmm4_100 zmm0_100;
mov zmm4_101 zmm0_101;
mov zmm4_110 zmm0_110;
mov zmm4_111 zmm0_111;
(* vpmadd52luq %zmm10,%zmm6,%zmm2                  #! PC = 0x55555555691a *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm6_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm6_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm6_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm6_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm6_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm6_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm6_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm6_111 <u 0x10000000000000@64
];
umulj zmm10_zmm6_000F zmm10_000 zmm6_000; spl zmm10_zmm6_000h_t zmm10_zmm6_000l_t zmm10_zmm6_000F 52;
umulj zmm10_zmm6_001F zmm10_001 zmm6_001; spl zmm10_zmm6_001h_t zmm10_zmm6_001l_t zmm10_zmm6_001F 52;
umulj zmm10_zmm6_010F zmm10_010 zmm6_010; spl zmm10_zmm6_010h_t zmm10_zmm6_010l_t zmm10_zmm6_010F 52;
umulj zmm10_zmm6_011F zmm10_011 zmm6_011; spl zmm10_zmm6_011h_t zmm10_zmm6_011l_t zmm10_zmm6_011F 52;
umulj zmm10_zmm6_100F zmm10_100 zmm6_100; spl zmm10_zmm6_100h_t zmm10_zmm6_100l_t zmm10_zmm6_100F 52;
umulj zmm10_zmm6_101F zmm10_101 zmm6_101; spl zmm10_zmm6_101h_t zmm10_zmm6_101l_t zmm10_zmm6_101F 52;
umulj zmm10_zmm6_110F zmm10_110 zmm6_110; spl zmm10_zmm6_110h_t zmm10_zmm6_110l_t zmm10_zmm6_110F 52;
umulj zmm10_zmm6_111F zmm10_111 zmm6_111; spl zmm10_zmm6_111h_t zmm10_zmm6_111l_t zmm10_zmm6_111F 52;
vpc zmm10_zmm6_000h_t@uint64 zmm10_zmm6_000h_t; vpc zmm10_zmm6_000l_t@uint64 zmm10_zmm6_000l_t;
vpc zmm10_zmm6_001h_t@uint64 zmm10_zmm6_001h_t; vpc zmm10_zmm6_001l_t@uint64 zmm10_zmm6_001l_t;
vpc zmm10_zmm6_010h_t@uint64 zmm10_zmm6_010h_t; vpc zmm10_zmm6_010l_t@uint64 zmm10_zmm6_010l_t;
vpc zmm10_zmm6_011h_t@uint64 zmm10_zmm6_011h_t; vpc zmm10_zmm6_011l_t@uint64 zmm10_zmm6_011l_t;
vpc zmm10_zmm6_100h_t@uint64 zmm10_zmm6_100h_t; vpc zmm10_zmm6_100l_t@uint64 zmm10_zmm6_100l_t;
vpc zmm10_zmm6_101h_t@uint64 zmm10_zmm6_101h_t; vpc zmm10_zmm6_101l_t@uint64 zmm10_zmm6_101l_t;
vpc zmm10_zmm6_110h_t@uint64 zmm10_zmm6_110h_t; vpc zmm10_zmm6_110l_t@uint64 zmm10_zmm6_110l_t;
vpc zmm10_zmm6_111h_t@uint64 zmm10_zmm6_111h_t; vpc zmm10_zmm6_111l_t@uint64 zmm10_zmm6_111l_t;
add zmm2_000 zmm2_000 zmm10_zmm6_000l_t;
add zmm2_001 zmm2_001 zmm10_zmm6_001l_t;
add zmm2_010 zmm2_010 zmm10_zmm6_010l_t;
add zmm2_011 zmm2_011 zmm10_zmm6_011l_t;
add zmm2_100 zmm2_100 zmm10_zmm6_100l_t;
add zmm2_101 zmm2_101 zmm10_zmm6_101l_t;
add zmm2_110 zmm2_110 zmm10_zmm6_110l_t;
add zmm2_111 zmm2_111 zmm10_zmm6_111l_t;
(* vpaddq %zmm5,%zmm12,%zmm1                       #! PC = 0x555555556920 *)
add zmm1_000 zmm12_000 zmm5_000;
add zmm1_001 zmm12_001 zmm5_001;
add zmm1_010 zmm12_010 zmm5_010;
add zmm1_011 zmm12_011 zmm5_011;
add zmm1_100 zmm12_100 zmm5_100;
add zmm1_101 zmm12_101 zmm5_101;
add zmm1_110 zmm12_110 zmm5_110;
add zmm1_111 zmm12_111 zmm5_111;
(* vpmadd52huq %zmm10,%zmm6,%zmm4                  #! PC = 0x555555556926 *)
add zmm4_000 zmm4_000 zmm10_zmm6_000h_t;
add zmm4_001 zmm4_001 zmm10_zmm6_001h_t;
add zmm4_010 zmm4_010 zmm10_zmm6_010h_t;
add zmm4_011 zmm4_011 zmm10_zmm6_011h_t;
add zmm4_100 zmm4_100 zmm10_zmm6_100h_t;
add zmm4_101 zmm4_101 zmm10_zmm6_101h_t;
add zmm4_110 zmm4_110 zmm10_zmm6_110h_t;
add zmm4_111 zmm4_111 zmm10_zmm6_111h_t;
(* vpsrlq $0x33,%zmm11,%zmm12                      #! PC = 0x55555555692c *)
mov zmm12_000 zmm11_000_h;
mov zmm12_001 zmm11_001_h;
mov zmm12_010 zmm11_010_h;
mov zmm12_011 zmm11_011_h;
mov zmm12_100 zmm11_100_h;
mov zmm12_101 zmm11_101_h;
mov zmm12_110 zmm11_110_h;
mov zmm12_111 zmm11_111_h;
(* vpmadd52luq %zmm10,%zmm12,%zmm0                 #! PC = 0x555555556933 *)
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
assert true && and [
zmm10_zmm12_000h_t = 0@64,
zmm10_zmm12_001h_t = 0@64,
zmm10_zmm12_010h_t = 0@64,
zmm10_zmm12_011h_t = 0@64,
zmm10_zmm12_100h_t = 0@64,
zmm10_zmm12_101h_t = 0@64,
zmm10_zmm12_110h_t = 0@64,
zmm10_zmm12_111h_t = 0@64
];
assume and [
zmm10_zmm12_000h_t = 0,
zmm10_zmm12_001h_t = 0,
zmm10_zmm12_010h_t = 0,
zmm10_zmm12_011h_t = 0,
zmm10_zmm12_100h_t = 0,
zmm10_zmm12_101h_t = 0,
zmm10_zmm12_110h_t = 0,
zmm10_zmm12_111h_t = 0
] && true;
(* vpsrlq $0x33,%zmm3,%zmm9                        #! PC = 0x555555556939 *)
split zmm3_000_h zmm3_000_l zmm3_000 51;
split zmm3_001_h zmm3_001_l zmm3_001 51;
split zmm3_010_h zmm3_010_l zmm3_010 51;
split zmm3_011_h zmm3_011_l zmm3_011 51;
split zmm3_100_h zmm3_100_l zmm3_100 51;
split zmm3_101_h zmm3_101_l zmm3_101 51;
split zmm3_110_h zmm3_110_l zmm3_110 51;
split zmm3_111_h zmm3_111_l zmm3_111 51;
mov zmm9_000 zmm3_000_h;
mov zmm9_001 zmm3_001_h;
mov zmm9_010 zmm3_010_h;
mov zmm9_011 zmm3_011_h;
mov zmm9_100 zmm3_100_h;
mov zmm9_101 zmm3_101_h;
mov zmm9_110 zmm3_110_h;
mov zmm9_111 zmm3_111_h;
(* vpsrlq $0x33,%zmm2,%zmm5                        #! PC = 0x555555556940 *)
split zmm2_000_h zmm2_000_l zmm2_000 51;
split zmm2_001_h zmm2_001_l zmm2_001 51;
split zmm2_010_h zmm2_010_l zmm2_010 51;
split zmm2_011_h zmm2_011_l zmm2_011 51;
split zmm2_100_h zmm2_100_l zmm2_100 51;
split zmm2_101_h zmm2_101_l zmm2_101 51;
split zmm2_110_h zmm2_110_l zmm2_110 51;
split zmm2_111_h zmm2_111_l zmm2_111 51;
mov zmm5_000 zmm2_000_h;
mov zmm5_001 zmm2_001_h;
mov zmm5_010 zmm2_010_h;
mov zmm5_011 zmm2_011_h;
mov zmm5_100 zmm2_100_h;
mov zmm5_101 zmm2_101_h;
mov zmm5_110 zmm2_110_h;
mov zmm5_111 zmm2_111_h;
(* vpsllq $0x1,%zmm4,%zmm7                         #! PC = 0x555555556947 *)
shl zmm7_000 zmm4_000 0x1;
shl zmm7_001 zmm4_001 0x1;
shl zmm7_010 zmm4_010 0x1;
shl zmm7_011 zmm4_011 0x1;
shl zmm7_100 zmm4_100 0x1;
shl zmm7_101 zmm4_101 0x1;
shl zmm7_110 zmm4_110 0x1;
shl zmm7_111 zmm4_111 0x1;
(* vpandd %zmm8,%zmm3,%zmm3                        #! PC = 0x55555555694e *)
mov zmm3_000 zmm3_000_l;
mov zmm3_001 zmm3_001_l;
mov zmm3_010 zmm3_010_l;
mov zmm3_011 zmm3_011_l;
mov zmm3_100 zmm3_100_l;
mov zmm3_101 zmm3_101_l;
mov zmm3_110 zmm3_110_l;
mov zmm3_111 zmm3_111_l;
(* vpsrlq $0x33,%zmm1,%zmm14                       #! PC = 0x555555556954 *)
split zmm1_000_h zmm1_000_l zmm1_000 51;
split zmm1_001_h zmm1_001_l zmm1_001 51;
split zmm1_010_h zmm1_010_l zmm1_010 51;
split zmm1_011_h zmm1_011_l zmm1_011 51;
split zmm1_100_h zmm1_100_l zmm1_100 51;
split zmm1_101_h zmm1_101_l zmm1_101 51;
split zmm1_110_h zmm1_110_l zmm1_110 51;
split zmm1_111_h zmm1_111_l zmm1_111 51;
mov zmm14_000 zmm1_000_h;
mov zmm14_001 zmm1_001_h;
mov zmm14_010 zmm1_010_h;
mov zmm14_011 zmm1_011_h;
mov zmm14_100 zmm1_100_h;
mov zmm14_101 zmm1_101_h;
mov zmm14_110 zmm1_110_h;
mov zmm14_111 zmm1_111_h;
(* vpaddq %zmm3,%zmm0,%zmm0                        #! PC = 0x55555555695b *)
add zmm0_000 zmm0_000 zmm3_000;
add zmm0_001 zmm0_001 zmm3_001;
add zmm0_010 zmm0_010 zmm3_010;
add zmm0_011 zmm0_011 zmm3_011;
add zmm0_100 zmm0_100 zmm3_100;
add zmm0_101 zmm0_101 zmm3_101;
add zmm0_110 zmm0_110 zmm3_110;
add zmm0_111 zmm0_111 zmm3_111;
(* vpaddq %zmm5,%zmm7,%zmm12                       #! PC = 0x555555556961 *)
add zmm12_000 zmm7_000 zmm5_000;
add zmm12_001 zmm7_001 zmm5_001;
add zmm12_010 zmm7_010 zmm5_010;
add zmm12_011 zmm7_011 zmm5_011;
add zmm12_100 zmm7_100 zmm5_100;
add zmm12_101 zmm7_101 zmm5_101;
add zmm12_110 zmm7_110 zmm5_110;
add zmm12_111 zmm7_111 zmm5_111;
(* vpandd %zmm8,%zmm13,%zmm13                      #! PC = 0x555555556967 *)
mov zmm13_000 zmm13_000_l;
mov zmm13_001 zmm13_001_l;
mov zmm13_010 zmm13_010_l;
mov zmm13_011 zmm13_011_l;
mov zmm13_100 zmm13_100_l;
mov zmm13_101 zmm13_101_l;
mov zmm13_110 zmm13_110_l;
mov zmm13_111 zmm13_111_l;
(* vpandd %zmm8,%zmm15,%zmm15                      #! PC = 0x55555555696d *)
mov zmm15_000 zmm15_000_l;
mov zmm15_001 zmm15_001_l;
mov zmm15_010 zmm15_010_l;
mov zmm15_011 zmm15_011_l;
mov zmm15_100 zmm15_100_l;
mov zmm15_101 zmm15_101_l;
mov zmm15_110 zmm15_110_l;
mov zmm15_111 zmm15_111_l;
(* vpandd %zmm8,%zmm2,%zmm11                       #! PC = 0x555555556973 *)
mov zmm11_000 zmm2_000_l;
mov zmm11_001 zmm2_001_l;
mov zmm11_010 zmm2_010_l;
mov zmm11_011 zmm2_011_l;
mov zmm11_100 zmm2_100_l;
mov zmm11_101 zmm2_101_l;
mov zmm11_110 zmm2_110_l;
mov zmm11_111 zmm2_111_l;
(* vpaddq %zmm12,%zmm0,%zmm6                       #! PC = 0x555555556979 *)
add zmm6_000 zmm0_000 zmm12_000;
add zmm6_001 zmm0_001 zmm12_001;
add zmm6_010 zmm0_010 zmm12_010;
add zmm6_011 zmm0_011 zmm12_011;
add zmm6_100 zmm0_100 zmm12_100;
add zmm6_101 zmm0_101 zmm12_101;
add zmm6_110 zmm0_110 zmm12_110;
add zmm6_111 zmm0_111 zmm12_111;
(* vpaddq %zmm13,%zmm9,%zmm9                       #! PC = 0x55555555697f *)
add zmm9_000 zmm9_000 zmm13_000;
add zmm9_001 zmm9_001 zmm13_001;
add zmm9_010 zmm9_010 zmm13_010;
add zmm9_011 zmm9_011 zmm13_011;
add zmm9_100 zmm9_100 zmm13_100;
add zmm9_101 zmm9_101 zmm13_101;
add zmm9_110 zmm9_110 zmm13_110;
add zmm9_111 zmm9_111 zmm13_111;
(* vpandd %zmm8,%zmm1,%zmm1                        #! PC = 0x555555556985 *)
mov zmm1_000 zmm1_000_l;
mov zmm1_001 zmm1_001_l;
mov zmm1_010 zmm1_010_l;
mov zmm1_011 zmm1_011_l;
mov zmm1_100 zmm1_100_l;
mov zmm1_101 zmm1_101_l;
mov zmm1_110 zmm1_110_l;
mov zmm1_111 zmm1_111_l;
(* vpaddq %zmm15,%zmm14,%zmm14                     #! PC = 0x55555555698b *)
add zmm14_000 zmm14_000 zmm15_000;
add zmm14_001 zmm14_001 zmm15_001;
add zmm14_010 zmm14_010 zmm15_010;
add zmm14_011 zmm14_011 zmm15_011;
add zmm14_100 zmm14_100 zmm15_100;
add zmm14_101 zmm14_101 zmm15_101;
add zmm14_110 zmm14_110 zmm15_110;
add zmm14_111 zmm14_111 zmm15_111;
(* vmovdqa32 %zmm11,(%rdi)                         #! EA = L0x7fffffffd8c0; PC = 0x555555556991 *)
mov L0x7fffffffd8c0 zmm11_000;
mov L0x7fffffffd8c8 zmm11_001;
mov L0x7fffffffd8d0 zmm11_010;
mov L0x7fffffffd8d8 zmm11_011;
mov L0x7fffffffd8e0 zmm11_100;
mov L0x7fffffffd8e8 zmm11_101;
mov L0x7fffffffd8f0 zmm11_110;
mov L0x7fffffffd8f8 zmm11_111;
(* vmovdqa64 %zmm6,0x40(%rdi)                      #! EA = L0x7fffffffd900; PC = 0x555555556997 *)
mov L0x7fffffffd900 zmm6_000;
mov L0x7fffffffd908 zmm6_001;
mov L0x7fffffffd910 zmm6_010;
mov L0x7fffffffd918 zmm6_011;
mov L0x7fffffffd920 zmm6_100;
mov L0x7fffffffd928 zmm6_101;
mov L0x7fffffffd930 zmm6_110;
mov L0x7fffffffd938 zmm6_111;
(* vmovdqa64 %zmm9,0x80(%rdi)                      #! EA = L0x7fffffffd940; PC = 0x55555555699e *)
mov L0x7fffffffd940 zmm9_000;
mov L0x7fffffffd948 zmm9_001;
mov L0x7fffffffd950 zmm9_010;
mov L0x7fffffffd958 zmm9_011;
mov L0x7fffffffd960 zmm9_100;
mov L0x7fffffffd968 zmm9_101;
mov L0x7fffffffd970 zmm9_110;
mov L0x7fffffffd978 zmm9_111;
(* vmovdqa32 %zmm1,0xc0(%rdi)                      #! EA = L0x7fffffffd980; PC = 0x5555555569a5 *)
mov L0x7fffffffd980 zmm1_000;
mov L0x7fffffffd988 zmm1_001;
mov L0x7fffffffd990 zmm1_010;
mov L0x7fffffffd998 zmm1_011;
mov L0x7fffffffd9a0 zmm1_100;
mov L0x7fffffffd9a8 zmm1_101;
mov L0x7fffffffd9b0 zmm1_110;
mov L0x7fffffffd9b8 zmm1_111;
(* vmovdqa64 %zmm14,0x100(%rdi)                    #! EA = L0x7fffffffd9c0; PC = 0x5555555569ac *)
mov L0x7fffffffd9c0 zmm14_000;
mov L0x7fffffffd9c8 zmm14_001;
mov L0x7fffffffd9d0 zmm14_010;
mov L0x7fffffffd9d8 zmm14_011;
mov L0x7fffffffd9e0 zmm14_100;
mov L0x7fffffffd9e8 zmm14_101;
mov L0x7fffffffd9f0 zmm14_110;
mov L0x7fffffffd9f8 zmm14_111;
(* #! <- SP = 0x7fffffffd5f8 *)
#! 0x7fffffffd5f8 = 0x7fffffffd5f8;
(* #ret                                            #! PC = 0x5555555569b6 *)
#ret                                            #! 0x5555555569b6 = 0x5555555569b6;

mov c00 L0x7fffffffd8c0;
mov c10 L0x7fffffffd8c8;
mov c20 L0x7fffffffd8d0;
mov c30 L0x7fffffffd8d8;
mov c40 L0x7fffffffd8e0;
mov c50 L0x7fffffffd8e8;
mov c60 L0x7fffffffd8f0;
mov c70 L0x7fffffffd8f8;
mov c01 L0x7fffffffd900;
mov c11 L0x7fffffffd908;
mov c21 L0x7fffffffd910;
mov c31 L0x7fffffffd918;
mov c41 L0x7fffffffd920;
mov c51 L0x7fffffffd928;
mov c61 L0x7fffffffd930;
mov c71 L0x7fffffffd938;
mov c02 L0x7fffffffd940;
mov c12 L0x7fffffffd948;
mov c22 L0x7fffffffd950;
mov c32 L0x7fffffffd958;
mov c42 L0x7fffffffd960;
mov c52 L0x7fffffffd968;
mov c62 L0x7fffffffd970;
mov c72 L0x7fffffffd978;
mov c03 L0x7fffffffd980;
mov c13 L0x7fffffffd988;
mov c23 L0x7fffffffd990;
mov c33 L0x7fffffffd998;
mov c43 L0x7fffffffd9a0;
mov c53 L0x7fffffffd9a8;
mov c63 L0x7fffffffd9b0;
mov c73 L0x7fffffffd9b8;
mov c04 L0x7fffffffd9c0;
mov c14 L0x7fffffffd9c8;
mov c24 L0x7fffffffd9d0;
mov c34 L0x7fffffffd9d8;
mov c44 L0x7fffffffd9e0;
mov c54 L0x7fffffffd9e8;
mov c64 L0x7fffffffd9f0;
mov c74 L0x7fffffffd9f8;

{
  and [
    eqmod limbs 51 [c00, c01, c02, c03, c04]
          limbs 51 [a00, a01, a02, a03, a04] * b
          p,
    eqmod limbs 51 [c10, c11, c12, c13, c14]
          limbs 51 [a10, a11, a12, a13, a14] * b
          p,
    eqmod limbs 51 [c20, c21, c22, c23, c24]
          limbs 51 [a20, a21, a22, a23, a24] * b
          p,
    eqmod limbs 51 [c30, c31, c32, c33, c34]
          limbs 51 [a30, a31, a32, a33, a34] * b
          p,
    eqmod limbs 51 [c40, c41, c42, c43, c44]
          limbs 51 [a40, a41, a42, a43, a44] * b
          p,
    eqmod limbs 51 [c50, c51, c52, c53, c54]
          limbs 51 [a50, a51, a52, a53, a54] * b
          p,
    eqmod limbs 51 [c60, c61, c62, c63, c64]
          limbs 51 [a60, a61, a62, a63, a64] * b
          p,
    eqmod limbs 51 [c70, c71, c72, c73, c74]
          limbs 51 [a70, a71, a72, a73, a74] * b
          p
  ]
  &&
  and [
    c00 <u 0x8000000000000@64, c01 <u 0x80000000000c3@64, c02 <u 0x8000000000006@64, c03 <u 0x8000000000000@64, c04 <u 0x8000000000006@64,
    c10 <u 0x8000000000000@64, c11 <u 0x80000000000c3@64, c12 <u 0x8000000000006@64, c13 <u 0x8000000000000@64, c14 <u 0x8000000000006@64,
    c20 <u 0x8000000000000@64, c21 <u 0x80000000000c3@64, c22 <u 0x8000000000006@64, c23 <u 0x8000000000000@64, c24 <u 0x8000000000006@64,
    c30 <u 0x8000000000000@64, c31 <u 0x80000000000c3@64, c32 <u 0x8000000000006@64, c33 <u 0x8000000000000@64, c34 <u 0x8000000000006@64,
    c40 <u 0x8000000000000@64, c41 <u 0x80000000000c3@64, c42 <u 0x8000000000006@64, c43 <u 0x8000000000000@64, c44 <u 0x8000000000006@64,
    c50 <u 0x8000000000000@64, c51 <u 0x80000000000c3@64, c52 <u 0x8000000000006@64, c53 <u 0x8000000000000@64, c54 <u 0x8000000000006@64,
    c60 <u 0x8000000000000@64, c61 <u 0x80000000000c3@64, c62 <u 0x8000000000006@64, c63 <u 0x8000000000000@64, c64 <u 0x8000000000006@64,
    c70 <u 0x8000000000000@64, c71 <u 0x80000000000c3@64, c72 <u 0x8000000000006@64, c73 <u 0x8000000000000@64, c74 <u 0x8000000000006@64
  ]
}

