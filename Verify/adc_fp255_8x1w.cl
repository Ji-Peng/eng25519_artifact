(*
cv -v -disable_safety adc_fp255_8x1w.cl
Parsing CryptoLine file:		      [OK]		0.001717 seconds
Checking well-formedness:		      [OK]		0.000545 seconds
Transforming to SSA form:		      [OK]		0.000199 seconds
Normalizing specification:		      [OK]		0.000207 seconds
Rewriting assignments:			      [OK]		0.000309 seconds
Verifying range assertions:		      [OK]		0.077246 seconds
Verifying range specification:	      [OK]		0.087141 seconds
Rewriting value-preserved casting:	      [OK]		0.000030 seconds
Verifying algebraic assertions:		[OK]		0.000028 seconds
Verifying algebraic specification:	      [OK]		0.022886 seconds
Verification result:			      [OK]		0.190914 seconds
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

mov L0x55555556a100 19@uint64;
mov L0x55555556a140 0x7ffffffffffff@uint64;
mov L0x55555556a148 0x7ffffffffffff@uint64;
mov L0x55555556a150 0x7ffffffffffff@uint64;
mov L0x55555556a158 0x7ffffffffffff@uint64;
mov L0x55555556a160 0x7ffffffffffff@uint64;
mov L0x55555556a168 0x7ffffffffffff@uint64;
mov L0x55555556a170 0x7ffffffffffff@uint64;
mov L0x55555556a178 0x7ffffffffffff@uint64;

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
(* vmovdqa64 (%rsi),%zmm7                          #! EA = L0x7fffffffd500; Value = 0x00007fffffffd610; PC = 0x5555555561c4 *)
mov zmm7_000 L0x7fffffffd500; (* a00 *)
mov zmm7_001 L0x7fffffffd508;
mov zmm7_010 L0x7fffffffd510;
mov zmm7_011 L0x7fffffffd518;
mov zmm7_100 L0x7fffffffd520;
mov zmm7_101 L0x7fffffffd528;
mov zmm7_110 L0x7fffffffd530;
mov zmm7_111 L0x7fffffffd538;
(* vmovdqa64 0x80(%rsi),%zmm6                      #! EA = L0x7fffffffd580; Value = 0x0000000000000000; PC = 0x5555555561ca *)
mov zmm6_000 L0x7fffffffd580; (* a02 *)
mov zmm6_001 L0x7fffffffd588;
mov zmm6_010 L0x7fffffffd590;
mov zmm6_011 L0x7fffffffd598;
mov zmm6_100 L0x7fffffffd5a0;
mov zmm6_101 L0x7fffffffd5a8;
mov zmm6_110 L0x7fffffffd5b0;
mov zmm6_111 L0x7fffffffd5b8;
(* vpaddq (%rdx),%zmm7,%zmm4                       #! EA = L0x7fffffffd640; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x5555555561d1 *)
add zmm4_000 zmm7_000 L0x7fffffffd640; (* zmm4_000=a00+b00 *)
add zmm4_001 zmm7_001 L0x7fffffffd648;
add zmm4_010 zmm7_010 L0x7fffffffd650;
add zmm4_011 zmm7_011 L0x7fffffffd658;
add zmm4_100 zmm7_100 L0x7fffffffd660;
add zmm4_101 zmm7_101 L0x7fffffffd668;
add zmm4_110 zmm7_110 L0x7fffffffd670;
add zmm4_111 zmm7_111 L0x7fffffffd678;
(* vpaddq 0x80(%rdx),%zmm6,%zmm3                   #! EA = L0x7fffffffd6c0; Value = 0x0000000000000000; PC = 0x5555555561d7 *)
add zmm3_000 zmm6_000 L0x7fffffffd6c0; (* zmm3_000=a02+b02 *)
add zmm3_001 zmm6_001 L0x7fffffffd6c8;
add zmm3_010 zmm6_010 L0x7fffffffd6d0;
add zmm3_011 zmm6_011 L0x7fffffffd6d8;
add zmm3_100 zmm6_100 L0x7fffffffd6e0;
add zmm3_101 zmm6_101 L0x7fffffffd6e8;
add zmm3_110 zmm6_110 L0x7fffffffd6f0;
add zmm3_111 zmm6_111 L0x7fffffffd6f8;
(* vpsrlq $0x33,%zmm4,%zmm1                        #! PC = 0x5555555561de *)
split zmm1_000 tmp zmm4_000 0x33; (* zmm1=(a00+b00)>>51 *)
split zmm1_001 tmp zmm4_001 0x33;
split zmm1_010 tmp zmm4_010 0x33;
split zmm1_011 tmp zmm4_011 0x33;
split zmm1_100 tmp zmm4_100 0x33;
split zmm1_101 tmp zmm4_101 0x33;
split zmm1_110 tmp zmm4_110 0x33;
split zmm1_111 tmp zmm4_111 0x33;
(* vpsrlq $0x33,%zmm3,%zmm8                        #! PC = 0x5555555561e5 *)
split zmm8_000 tmp zmm3_000 0x33; (* zmm8=(a02+b02)>>51 *)
split zmm8_001 tmp zmm3_001 0x33;
split zmm8_010 tmp zmm3_010 0x33;
split zmm8_011 tmp zmm3_011 0x33;
split zmm8_100 tmp zmm3_100 0x33;
split zmm8_101 tmp zmm3_101 0x33;
split zmm8_110 tmp zmm3_110 0x33;
split zmm8_111 tmp zmm3_111 0x33;
(* vpaddq 0x40(%rdx),%zmm1,%zmm5                   #! EA = L0x7fffffffd680; Value = 0x5500747365745f32; PC = 0x5555555561ec *)
add zmm5_000 zmm1_000 L0x7fffffffd680; (* zmm5 = (a00+b00)>>51 + b01 *)
add zmm5_001 zmm1_001 L0x7fffffffd688;
add zmm5_010 zmm1_010 L0x7fffffffd690;
add zmm5_011 zmm1_011 L0x7fffffffd698;
add zmm5_100 zmm1_100 L0x7fffffffd6a0;
add zmm5_101 zmm1_101 L0x7fffffffd6a8;
add zmm5_110 zmm1_110 L0x7fffffffd6b0;
add zmm5_111 zmm1_111 L0x7fffffffd6b8;
(* vmovdqa64 0x100(%rsi),%zmm0                     #! EA = L0x7fffffffd600; Value = 0x0000000000000000; PC = 0x5555555561f3 *)
mov zmm0_000 L0x7fffffffd600; (* a04 *)
mov zmm0_001 L0x7fffffffd608;
mov zmm0_010 L0x7fffffffd610;
mov zmm0_011 L0x7fffffffd618;
mov zmm0_100 L0x7fffffffd620;
mov zmm0_101 L0x7fffffffd628;
mov zmm0_110 L0x7fffffffd630;
mov zmm0_111 L0x7fffffffd638;
(* vpaddq 0xc0(%rdx),%zmm8,%zmm10                  #! EA = L0x7fffffffd700; Value = 0x0000004000000000; PC = 0x5555555561fa *)
add zmm10_000 zmm8_000 L0x7fffffffd700; (* zmm10 = (a02 + b02) >> 51 + b03 *)
add zmm10_001 zmm8_001 L0x7fffffffd708;
add zmm10_010 zmm8_010 L0x7fffffffd710;
add zmm10_011 zmm8_011 L0x7fffffffd718;
add zmm10_100 zmm8_100 L0x7fffffffd720;
add zmm10_101 zmm8_101 L0x7fffffffd728;
add zmm10_110 zmm8_110 L0x7fffffffd730;
add zmm10_111 zmm8_111 L0x7fffffffd738;
(* vpaddq 0x40(%rsi),%zmm5,%zmm9                   #! EA = L0x7fffffffd540; Value = 0x0000000000000009; PC = 0x555555556201 *)
add zmm9_000 zmm5_000 L0x7fffffffd540; (* zmm9 = (a00+b00)>>51 + b01 + a01 *)
add zmm9_001 zmm5_001 L0x7fffffffd548;
add zmm9_010 zmm5_010 L0x7fffffffd550;
add zmm9_011 zmm5_011 L0x7fffffffd558;
add zmm9_100 zmm5_100 L0x7fffffffd560;
add zmm9_101 zmm5_101 L0x7fffffffd568;
add zmm9_110 zmm5_110 L0x7fffffffd570;
add zmm9_111 zmm5_111 L0x7fffffffd578;
(* vpaddq 0x100(%rdx),%zmm0,%zmm2                  #! EA = L0x7fffffffd740; Value = 0x0000000000000002; PC = 0x555555556208 *)
add zmm2_000 zmm0_000 L0x7fffffffd740; (* zmm2 = a04 + b04 *)
add zmm2_001 zmm0_001 L0x7fffffffd748;
add zmm2_010 zmm0_010 L0x7fffffffd750;
add zmm2_011 zmm0_011 L0x7fffffffd758;
add zmm2_100 zmm0_100 L0x7fffffffd760;
add zmm2_101 zmm0_101 L0x7fffffffd768;
add zmm2_110 zmm0_110 L0x7fffffffd770;
add zmm2_111 zmm0_111 L0x7fffffffd778;
(* vpaddq 0xc0(%rsi),%zmm10,%zmm11                 #! EA = L0x7fffffffd5c0; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x55555555620f *)
add zmm11_000 zmm10_000 L0x7fffffffd5c0; (* zmm11 = (a02 + b02) >> 51 + b03 + a03 *)
add zmm11_001 zmm10_001 L0x7fffffffd5c8;
add zmm11_010 zmm10_010 L0x7fffffffd5d0;
add zmm11_011 zmm10_011 L0x7fffffffd5d8;
add zmm11_100 zmm10_100 L0x7fffffffd5e0;
add zmm11_101 zmm10_101 L0x7fffffffd5e8;
add zmm11_110 zmm10_110 L0x7fffffffd5f0;
add zmm11_111 zmm10_111 L0x7fffffffd5f8;
(* vmovdqa32 0x13f20(%rip),%zmm7        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x555555556216 *)
mov zmm7_000 L0x55555556a140; (* zmm7 = 0x7ffffffffffff *)
mov zmm7_001 L0x55555556a148;
mov zmm7_010 L0x55555556a150;
mov zmm7_011 L0x55555556a158;
mov zmm7_100 L0x55555556a160;
mov zmm7_101 L0x55555556a168;
mov zmm7_110 L0x55555556a170;
mov zmm7_111 L0x55555556a178;
(* vpsrlq $0x33,%zmm2,%zmm12                       #! PC = 0x555555556220 *)
split zmm12_000 tmp zmm2_000 0x33; (* zmm12 = (a04 + b04) >> 51 *)
split zmm12_001 tmp zmm2_001 0x33;
split zmm12_010 tmp zmm2_010 0x33;
split zmm12_011 tmp zmm2_011 0x33;
split zmm12_100 tmp zmm2_100 0x33;
split zmm12_101 tmp zmm2_101 0x33;
split zmm12_110 tmp zmm2_110 0x33;
split zmm12_111 tmp zmm2_111 0x33;
(* vpsrlq $0x33,%zmm9,%zmm14                       #! PC = 0x555555556227 *)
split zmm14_000 tmp zmm9_000 0x33; (* zmm14 = ((a00+b00)>>51 + b01 + a01) >> 51 *)
split zmm14_001 tmp zmm9_001 0x33;
split zmm14_010 tmp zmm9_010 0x33;
split zmm14_011 tmp zmm9_011 0x33;
split zmm14_100 tmp zmm9_100 0x33;
split zmm14_101 tmp zmm9_101 0x33;
split zmm14_110 tmp zmm9_110 0x33;
split zmm14_111 tmp zmm9_111 0x33;
(* vpsrlq $0x33,%zmm11,%zmm15                      #! PC = 0x55555555622e *)
split zmm15_000 tmp zmm11_000 0x33; (* zmm15 = ((a02 + b02) >> 51 + b03 + a03) >> 51 *)
split zmm15_001 tmp zmm11_001 0x33;
split zmm15_010 tmp zmm11_010 0x33;
split zmm15_011 tmp zmm11_011 0x33;
split zmm15_100 tmp zmm11_100 0x33;
split zmm15_101 tmp zmm11_101 0x33;
split zmm15_110 tmp zmm11_110 0x33;
split zmm15_111 tmp zmm11_111 0x33;

ghost zmm4_000o@uint64,
      zmm4_001o@uint64,
      zmm4_010o@uint64,
      zmm4_011o@uint64,
      zmm4_100o@uint64,
      zmm4_101o@uint64,
      zmm4_110o@uint64,
      zmm4_111o@uint64 :
      and [
      zmm4_000o=zmm4_000,
      zmm4_001o=zmm4_001,
      zmm4_010o=zmm4_010,
      zmm4_011o=zmm4_011,
      zmm4_100o=zmm4_100,
      zmm4_101o=zmm4_101,
      zmm4_110o=zmm4_110,
      zmm4_111o=zmm4_111
      ] &&
      and [
      zmm4_000o=zmm4_000,
      zmm4_001o=zmm4_001,
      zmm4_010o=zmm4_010,
      zmm4_011o=zmm4_011,
      zmm4_100o=zmm4_100,
      zmm4_101o=zmm4_101,
      zmm4_110o=zmm4_110,
      zmm4_111o=zmm4_111
      ];
(* vpandd %zmm7,%zmm4,%zmm4                        #! PC = 0x555555556235 *)
and zmm4_000@uint64 zmm4_000 zmm7_000; (* zmm4_000 = (a00 + b00) & MASK51 *)
and zmm4_001@uint64 zmm4_001 zmm7_001;
and zmm4_010@uint64 zmm4_010 zmm7_010;
and zmm4_011@uint64 zmm4_011 zmm7_011;
and zmm4_100@uint64 zmm4_100 zmm7_100;
and zmm4_101@uint64 zmm4_101 zmm7_101;
and zmm4_110@uint64 zmm4_110 zmm7_110;
and zmm4_111@uint64 zmm4_111 zmm7_111;
assert true && and [
      zmm4_000o = zmm4_000 + zmm1_000 * (2**51)@64,
      zmm4_001o = zmm4_001 + zmm1_001 * (2**51)@64,
      zmm4_010o = zmm4_010 + zmm1_010 * (2**51)@64,
      zmm4_011o = zmm4_011 + zmm1_011 * (2**51)@64,
      zmm4_100o = zmm4_100 + zmm1_100 * (2**51)@64,
      zmm4_101o = zmm4_101 + zmm1_101 * (2**51)@64,
      zmm4_110o = zmm4_110 + zmm1_110 * (2**51)@64,
      zmm4_111o = zmm4_111 + zmm1_111 * (2**51)@64
];
assume and [
      zmm4_000o = zmm4_000 + zmm1_000 * (2**51),
      zmm4_001o = zmm4_001 + zmm1_001 * (2**51),
      zmm4_010o = zmm4_010 + zmm1_010 * (2**51),
      zmm4_011o = zmm4_011 + zmm1_011 * (2**51),
      zmm4_100o = zmm4_100 + zmm1_100 * (2**51),
      zmm4_101o = zmm4_101 + zmm1_101 * (2**51),
      zmm4_110o = zmm4_110 + zmm1_110 * (2**51),
      zmm4_111o = zmm4_111 + zmm1_111 * (2**51)
] && true;

ghost zmm3_000o@uint64,
      zmm3_001o@uint64,
      zmm3_010o@uint64,
      zmm3_011o@uint64,
      zmm3_100o@uint64,
      zmm3_101o@uint64,
      zmm3_110o@uint64,
      zmm3_111o@uint64 :
      and [
      zmm3_000o=zmm3_000,
      zmm3_001o=zmm3_001,
      zmm3_010o=zmm3_010,
      zmm3_011o=zmm3_011,
      zmm3_100o=zmm3_100,
      zmm3_101o=zmm3_101,
      zmm3_110o=zmm3_110,
      zmm3_111o=zmm3_111
      ] &&
      and [
      zmm3_000o=zmm3_000,
      zmm3_001o=zmm3_001,
      zmm3_010o=zmm3_010,
      zmm3_011o=zmm3_011,
      zmm3_100o=zmm3_100,
      zmm3_101o=zmm3_101,
      zmm3_110o=zmm3_110,
      zmm3_111o=zmm3_111
      ];
(* vpandd %zmm7,%zmm3,%zmm3                        #! PC = 0x55555555623b *)
and zmm3_000@uint64 zmm3_000 zmm7_000; (* zmm3 = (a02 + b02) & MASK51 *)
and zmm3_001@uint64 zmm3_001 zmm7_001;
and zmm3_010@uint64 zmm3_010 zmm7_010;
and zmm3_011@uint64 zmm3_011 zmm7_011;
and zmm3_100@uint64 zmm3_100 zmm7_100;
and zmm3_101@uint64 zmm3_101 zmm7_101;
and zmm3_110@uint64 zmm3_110 zmm7_110;
and zmm3_111@uint64 zmm3_111 zmm7_111;
assert true && and [
      zmm3_000o = zmm3_000 + zmm8_000 * (2**51)@64,
      zmm3_001o = zmm3_001 + zmm8_001 * (2**51)@64,
      zmm3_010o = zmm3_010 + zmm8_010 * (2**51)@64,
      zmm3_011o = zmm3_011 + zmm8_011 * (2**51)@64,
      zmm3_100o = zmm3_100 + zmm8_100 * (2**51)@64,
      zmm3_101o = zmm3_101 + zmm8_101 * (2**51)@64,
      zmm3_110o = zmm3_110 + zmm8_110 * (2**51)@64,
      zmm3_111o = zmm3_111 + zmm8_111 * (2**51)@64
];
assume and [
      zmm3_000o = zmm3_000 + zmm8_000 * (2**51),
      zmm3_001o = zmm3_001 + zmm8_001 * (2**51),
      zmm3_010o = zmm3_010 + zmm8_010 * (2**51),
      zmm3_011o = zmm3_011 + zmm8_011 * (2**51),
      zmm3_100o = zmm3_100 + zmm8_100 * (2**51),
      zmm3_101o = zmm3_101 + zmm8_101 * (2**51),
      zmm3_110o = zmm3_110 + zmm8_110 * (2**51),
      zmm3_111o = zmm3_111 + zmm8_111 * (2**51)
] && true;

ghost zmm2_000o@uint64,
      zmm2_001o@uint64,
      zmm2_010o@uint64,
      zmm2_011o@uint64,
      zmm2_100o@uint64,
      zmm2_101o@uint64,
      zmm2_110o@uint64,
      zmm2_111o@uint64 :
      and [
      zmm2_000o=zmm2_000,
      zmm2_001o=zmm2_001,
      zmm2_010o=zmm2_010,
      zmm2_011o=zmm2_011,
      zmm2_100o=zmm2_100,
      zmm2_101o=zmm2_101,
      zmm2_110o=zmm2_110,
      zmm2_111o=zmm2_111
      ] &&
      and [
      zmm2_000o=zmm2_000,
      zmm2_001o=zmm2_001,
      zmm2_010o=zmm2_010,
      zmm2_011o=zmm2_011,
      zmm2_100o=zmm2_100,
      zmm2_101o=zmm2_101,
      zmm2_110o=zmm2_110,
      zmm2_111o=zmm2_111
      ];
(* vpandd %zmm7,%zmm2,%zmm2                        #! PC = 0x555555556241 *)
and zmm2_000@uint64 zmm2_000 zmm7_000; (* zmm2 = (a04 + b04) & MASK51 *)
and zmm2_001@uint64 zmm2_001 zmm7_001;
and zmm2_010@uint64 zmm2_010 zmm7_010;
and zmm2_011@uint64 zmm2_011 zmm7_011;
and zmm2_100@uint64 zmm2_100 zmm7_100;
and zmm2_101@uint64 zmm2_101 zmm7_101;
and zmm2_110@uint64 zmm2_110 zmm7_110;
and zmm2_111@uint64 zmm2_111 zmm7_111;
assert true && and [
      zmm2_000o = zmm2_000 + zmm12_000 * (2**51)@64,
      zmm2_001o = zmm2_001 + zmm12_001 * (2**51)@64,
      zmm2_010o = zmm2_010 + zmm12_010 * (2**51)@64,
      zmm2_011o = zmm2_011 + zmm12_011 * (2**51)@64,
      zmm2_100o = zmm2_100 + zmm12_100 * (2**51)@64,
      zmm2_101o = zmm2_101 + zmm12_101 * (2**51)@64,
      zmm2_110o = zmm2_110 + zmm12_110 * (2**51)@64,
      zmm2_111o = zmm2_111 + zmm12_111 * (2**51)@64
];
assume and [
      zmm2_000o = zmm2_000 + zmm12_000 * (2**51),
      zmm2_001o = zmm2_001 + zmm12_001 * (2**51),
      zmm2_010o = zmm2_010 + zmm12_010 * (2**51),
      zmm2_011o = zmm2_011 + zmm12_011 * (2**51),
      zmm2_100o = zmm2_100 + zmm12_100 * (2**51),
      zmm2_101o = zmm2_101 + zmm12_101 * (2**51),
      zmm2_110o = zmm2_110 + zmm12_110 * (2**51),
      zmm2_111o = zmm2_111 + zmm12_111 * (2**51)
] && true;

ghost zmm9_000o@uint64,
      zmm9_001o@uint64,
      zmm9_010o@uint64,
      zmm9_011o@uint64,
      zmm9_100o@uint64,
      zmm9_101o@uint64,
      zmm9_110o@uint64,
      zmm9_111o@uint64 :
      and [
      zmm9_000o=zmm9_000,
      zmm9_001o=zmm9_001,
      zmm9_010o=zmm9_010,
      zmm9_011o=zmm9_011,
      zmm9_100o=zmm9_100,
      zmm9_101o=zmm9_101,
      zmm9_110o=zmm9_110,
      zmm9_111o=zmm9_111
      ] &&
      and [
      zmm9_000o=zmm9_000,
      zmm9_001o=zmm9_001,
      zmm9_010o=zmm9_010,
      zmm9_011o=zmm9_011,
      zmm9_100o=zmm9_100,
      zmm9_101o=zmm9_101,
      zmm9_110o=zmm9_110,
      zmm9_111o=zmm9_111
      ];
(* vpandd %zmm7,%zmm9,%zmm0                        #! PC = 0x555555556247 *)
and zmm0_000@uint64 zmm9_000 zmm7_000; (* zmm0 = ((a00+b00)>>51 + b01 + a01) & MASK51 *)
and zmm0_001@uint64 zmm9_001 zmm7_001;
and zmm0_010@uint64 zmm9_010 zmm7_010;
and zmm0_011@uint64 zmm9_011 zmm7_011;
and zmm0_100@uint64 zmm9_100 zmm7_100;
and zmm0_101@uint64 zmm9_101 zmm7_101;
and zmm0_110@uint64 zmm9_110 zmm7_110;
and zmm0_111@uint64 zmm9_111 zmm7_111;
assert true && and [
      zmm9_000o = zmm0_000 + zmm14_000 * (2**51)@64,
      zmm9_001o = zmm0_001 + zmm14_001 * (2**51)@64,
      zmm9_010o = zmm0_010 + zmm14_010 * (2**51)@64,
      zmm9_011o = zmm0_011 + zmm14_011 * (2**51)@64,
      zmm9_100o = zmm0_100 + zmm14_100 * (2**51)@64,
      zmm9_101o = zmm0_101 + zmm14_101 * (2**51)@64,
      zmm9_110o = zmm0_110 + zmm14_110 * (2**51)@64,
      zmm9_111o = zmm0_111 + zmm14_111 * (2**51)@64
];
assume and [
      zmm9_000o = zmm0_000 + zmm14_000 * (2**51),
      zmm9_001o = zmm0_001 + zmm14_001 * (2**51),
      zmm9_010o = zmm0_010 + zmm14_010 * (2**51),
      zmm9_011o = zmm0_011 + zmm14_011 * (2**51),
      zmm9_100o = zmm0_100 + zmm14_100 * (2**51),
      zmm9_101o = zmm0_101 + zmm14_101 * (2**51),
      zmm9_110o = zmm0_110 + zmm14_110 * (2**51),
      zmm9_111o = zmm0_111 + zmm14_111 * (2**51)
] && true;

(* vpaddq %zmm3,%zmm14,%zmm1                       #! PC = 0x55555555624d *)
add zmm1_000 zmm14_000 zmm3_000; (* zmm1 = ((a00+b00)>>51 + b01 + a01) >> 51 + (a02 + b02) & MASK51 *)
add zmm1_001 zmm14_001 zmm3_001;
add zmm1_010 zmm14_010 zmm3_010;
add zmm1_011 zmm14_011 zmm3_011;
add zmm1_100 zmm14_100 zmm3_100;
add zmm1_101 zmm14_101 zmm3_101;
add zmm1_110 zmm14_110 zmm3_110;
add zmm1_111 zmm14_111 zmm3_111;

ghost zmm11_000o@uint64,
      zmm11_001o@uint64,
      zmm11_010o@uint64,
      zmm11_011o@uint64,
      zmm11_100o@uint64,
      zmm11_101o@uint64,
      zmm11_110o@uint64,
      zmm11_111o@uint64 :
      and [
      zmm11_000o=zmm11_000,
      zmm11_001o=zmm11_001,
      zmm11_010o=zmm11_010,
      zmm11_011o=zmm11_011,
      zmm11_100o=zmm11_100,
      zmm11_101o=zmm11_101,
      zmm11_110o=zmm11_110,
      zmm11_111o=zmm11_111
      ] &&
      and [
      zmm11_000o=zmm11_000,
      zmm11_001o=zmm11_001,
      zmm11_010o=zmm11_010,
      zmm11_011o=zmm11_011,
      zmm11_100o=zmm11_100,
      zmm11_101o=zmm11_101,
      zmm11_110o=zmm11_110,
      zmm11_111o=zmm11_111
      ];
(* vpandd %zmm7,%zmm11,%zmm5                       #! PC = 0x555555556253 *)
and zmm5_000@uint64 zmm11_000 zmm7_000; (* zmm5 = ((a02 + b02) >> 51 + b03 + a03) & MASK51 *)
and zmm5_001@uint64 zmm11_001 zmm7_001;
and zmm5_010@uint64 zmm11_010 zmm7_010;
and zmm5_011@uint64 zmm11_011 zmm7_011;
and zmm5_100@uint64 zmm11_100 zmm7_100;
and zmm5_101@uint64 zmm11_101 zmm7_101;
and zmm5_110@uint64 zmm11_110 zmm7_110;
and zmm5_111@uint64 zmm11_111 zmm7_111;
assert true && and [
      zmm11_000o = zmm5_000 + zmm15_000 * (2**51)@64,
      zmm11_001o = zmm5_001 + zmm15_001 * (2**51)@64,
      zmm11_010o = zmm5_010 + zmm15_010 * (2**51)@64,
      zmm11_011o = zmm5_011 + zmm15_011 * (2**51)@64,
      zmm11_100o = zmm5_100 + zmm15_100 * (2**51)@64,
      zmm11_101o = zmm5_101 + zmm15_101 * (2**51)@64,
      zmm11_110o = zmm5_110 + zmm15_110 * (2**51)@64,
      zmm11_111o = zmm5_111 + zmm15_111 * (2**51)@64
];
assume and [
      zmm11_000o = zmm5_000 + zmm15_000 * (2**51),
      zmm11_001o = zmm5_001 + zmm15_001 * (2**51),
      zmm11_010o = zmm5_010 + zmm15_010 * (2**51),
      zmm11_011o = zmm5_011 + zmm15_011 * (2**51),
      zmm11_100o = zmm5_100 + zmm15_100 * (2**51),
      zmm11_101o = zmm5_101 + zmm15_101 * (2**51),
      zmm11_110o = zmm5_110 + zmm15_110 * (2**51),
      zmm11_111o = zmm5_111 + zmm15_111 * (2**51)
] && true;

(* vpaddq %zmm2,%zmm15,%zmm9                       #! PC = 0x555555556259 *)
add zmm9_000 zmm15_000 zmm2_000; (* zmm9 = ((a02 + b02) >> 51 + b03 + a03) >> 51 + (a04 + b04) & MASK51 *)
add zmm9_001 zmm15_001 zmm2_001;
add zmm9_010 zmm15_010 zmm2_010;
add zmm9_011 zmm15_011 zmm2_011;
add zmm9_100 zmm15_100 zmm2_100;
add zmm9_101 zmm15_101 zmm2_101;
add zmm9_110 zmm15_110 zmm2_110;
add zmm9_111 zmm15_111 zmm2_111;
(* vpmuludq 0x13e97(%rip),%zmm12,%zmm13        # 0x55555556a100#! EA = L0x55555556a100; Value = 0x0000000000000013; PC = 0x55555555625f *)
mul zmm13_000 zmm12_000 L0x55555556a100; (* zmm13 = ((a04 + b04) >> 51) * 19 *)
mul zmm13_001 zmm12_001 L0x55555556a100;
mul zmm13_010 zmm12_010 L0x55555556a100;
mul zmm13_011 zmm12_011 L0x55555556a100;
mul zmm13_100 zmm12_100 L0x55555556a100;
mul zmm13_101 zmm12_101 L0x55555556a100;
mul zmm13_110 zmm12_110 L0x55555556a100;
mul zmm13_111 zmm12_111 L0x55555556a100;
(* vpaddq %zmm4,%zmm13,%zmm6                       #! PC = 0x555555556269 *)
add zmm6_000 zmm13_000 zmm4_000; (* zmm6 = ((a04 + b04) >> 51) * 19 + (a00 + b00) & MASK51 *)
add zmm6_001 zmm13_001 zmm4_001;
add zmm6_010 zmm13_010 zmm4_010;
add zmm6_011 zmm13_011 zmm4_011;
add zmm6_100 zmm13_100 zmm4_100;
add zmm6_101 zmm13_101 zmm4_101;
add zmm6_110 zmm13_110 zmm4_110;
add zmm6_111 zmm13_111 zmm4_111;
(* vmovdqa64 %zmm6,(%rdi)                          #! EA = L0x7fffffffd780; PC = 0x55555555626f *)
mov L0x7fffffffd780 zmm6_000;
mov L0x7fffffffd788 zmm6_001;
mov L0x7fffffffd790 zmm6_010;
mov L0x7fffffffd798 zmm6_011;
mov L0x7fffffffd7a0 zmm6_100;
mov L0x7fffffffd7a8 zmm6_101;
mov L0x7fffffffd7b0 zmm6_110;
mov L0x7fffffffd7b8 zmm6_111;
(* vmovdqa32 %zmm0,0x40(%rdi)                      #! EA = L0x7fffffffd7c0; PC = 0x555555556275 *)
mov L0x7fffffffd7c0 zmm0_000;
mov L0x7fffffffd7c8 zmm0_001;
mov L0x7fffffffd7d0 zmm0_010;
mov L0x7fffffffd7d8 zmm0_011;
mov L0x7fffffffd7e0 zmm0_100;
mov L0x7fffffffd7e8 zmm0_101;
mov L0x7fffffffd7f0 zmm0_110;
mov L0x7fffffffd7f8 zmm0_111;
(* vmovdqa64 %zmm1,0x80(%rdi)                      #! EA = L0x7fffffffd800; PC = 0x55555555627c *)
mov L0x7fffffffd800 zmm1_000;
mov L0x7fffffffd808 zmm1_001;
mov L0x7fffffffd810 zmm1_010;
mov L0x7fffffffd818 zmm1_011;
mov L0x7fffffffd820 zmm1_100;
mov L0x7fffffffd828 zmm1_101;
mov L0x7fffffffd830 zmm1_110;
mov L0x7fffffffd838 zmm1_111;
(* vmovdqa32 %zmm5,0xc0(%rdi)                      #! EA = L0x7fffffffd840; PC = 0x555555556283 *)
mov L0x7fffffffd840 zmm5_000;
mov L0x7fffffffd848 zmm5_001;
mov L0x7fffffffd850 zmm5_010;
mov L0x7fffffffd858 zmm5_011;
mov L0x7fffffffd860 zmm5_100;
mov L0x7fffffffd868 zmm5_101;
mov L0x7fffffffd870 zmm5_110;
mov L0x7fffffffd878 zmm5_111;
(* vmovdqa64 %zmm9,0x100(%rdi)                     #! EA = L0x7fffffffd880; PC = 0x55555555628a *)
mov L0x7fffffffd880 zmm9_000;
mov L0x7fffffffd888 zmm9_001;
mov L0x7fffffffd890 zmm9_010;
mov L0x7fffffffd898 zmm9_011;
mov L0x7fffffffd8a0 zmm9_100;
mov L0x7fffffffd8a8 zmm9_101;
mov L0x7fffffffd8b0 zmm9_110;
mov L0x7fffffffd8b8 zmm9_111;
(* #! <- SP = 0x7fffffffd4b8 *)
#! 0x7fffffffd4b8 = 0x7fffffffd4b8;

mov c00 L0x7fffffffd780; (* c00 = ((a04 + b04) >> 51) * 19 + (a00 + b00) & MASK51 *)
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

{
  and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
            limbs 51 [a00, a01, a02, a03, a04] + limbs 51 [b00, b01, b02, b03, b04]
            p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
            limbs 51 [a10, a11, a12, a13, a14] + limbs 51 [b10, b11, b12, b13, b14]
            p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
            limbs 51 [a20, a21, a22, a23, a24] + limbs 51 [b20, b21, b22, b23, b24]
            p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
            limbs 51 [a30, a31, a32, a33, a34] + limbs 51 [b30, b31, b32, b33, b34]
            p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
            limbs 51 [a40, a41, a42, a43, a44] + limbs 51 [b40, b41, b42, b43, b44]
            p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
            limbs 51 [a50, a51, a52, a53, a54] + limbs 51 [b50, b51, b52, b53, b54]
            p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
            limbs 51 [a60, a61, a62, a63, a64] + limbs 51 [b60, b61, b62, b63, b64]
            p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
            limbs 51 [a70, a71, a72, a73, a74] + limbs 51 [b70, b71, b72, b73, b74]
            p
  ]
  &&
  and [
      c00 <=u 0x8000000000080@64, c01 <=u 0x8000000000000@64, c02 <=u 0x8000000000005@64, c03 <=u 0x8000000000000@64, c04 <=u 0x8000000000005@64,
      c10 <=u 0x8000000000080@64, c11 <=u 0x8000000000000@64, c12 <=u 0x8000000000005@64, c13 <=u 0x8000000000000@64, c14 <=u 0x8000000000005@64,
      c20 <=u 0x8000000000080@64, c21 <=u 0x8000000000000@64, c22 <=u 0x8000000000005@64, c23 <=u 0x8000000000000@64, c24 <=u 0x8000000000005@64,
      c30 <=u 0x8000000000080@64, c31 <=u 0x8000000000000@64, c32 <=u 0x8000000000005@64, c33 <=u 0x8000000000000@64, c34 <=u 0x8000000000005@64,
      c40 <=u 0x8000000000080@64, c41 <=u 0x8000000000000@64, c42 <=u 0x8000000000005@64, c43 <=u 0x8000000000000@64, c44 <=u 0x8000000000005@64,
      c50 <=u 0x8000000000080@64, c51 <=u 0x8000000000000@64, c52 <=u 0x8000000000005@64, c53 <=u 0x8000000000000@64, c54 <=u 0x8000000000005@64,
      c60 <=u 0x8000000000080@64, c61 <=u 0x8000000000000@64, c62 <=u 0x8000000000005@64, c63 <=u 0x8000000000000@64, c64 <=u 0x8000000000005@64,
      c70 <=u 0x8000000000080@64, c71 <=u 0x8000000000000@64, c72 <=u 0x8000000000005@64, c73 <=u 0x8000000000000@64, c74 <=u 0x8000000000005@64
  ]
}
