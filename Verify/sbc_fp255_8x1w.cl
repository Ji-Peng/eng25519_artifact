(*
cv -v -disable_safety sbc_fp255_8x1w.cl
Parsing CryptoLine file:                [OK]            0.005077 seconds
Checking well-formedness:               [OK]            0.000540 seconds
Transforming to SSA form:               [OK]            0.000229 seconds
Normalizing specification:              [OK]            0.000367 seconds
Rewriting assignments:                  [OK]            0.000216 seconds
Verifying range assertions:             [OK]            0.070725 seconds
Verifying range specification:          [OK]            0.041728 seconds
Rewriting value-preserved casting:      [OK]            0.000037 seconds
Verifying algebraic assertions:         [OK]            0.000105 seconds
Verifying algebraic specification:      [OK]            0.013844 seconds
Verification result:                    [OK]            0.133484 seconds
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
        a00 <u 0x10000000000cc4@64, a01 <u 0x10000000000000@64, a02 <u 0x10000000000066@64, a03 <u 0x10000000000000@64, a04 <u 0x10000000000096@64, 
        a10 <u 0x10000000000cc4@64, a11 <u 0x10000000000000@64, a12 <u 0x10000000000066@64, a13 <u 0x10000000000000@64, a14 <u 0x10000000000096@64, 
        a20 <u 0x10000000000cc4@64, a21 <u 0x10000000000000@64, a22 <u 0x10000000000066@64, a23 <u 0x10000000000000@64, a24 <u 0x10000000000096@64, 
        a30 <u 0x10000000000cc4@64, a31 <u 0x10000000000000@64, a32 <u 0x10000000000066@64, a33 <u 0x10000000000000@64, a34 <u 0x10000000000096@64, 
        a40 <u 0x10000000000cc4@64, a41 <u 0x10000000000000@64, a42 <u 0x10000000000066@64, a43 <u 0x10000000000000@64, a44 <u 0x10000000000096@64, 
        a50 <u 0x10000000000cc4@64, a51 <u 0x10000000000000@64, a52 <u 0x10000000000066@64, a53 <u 0x10000000000000@64, a54 <u 0x10000000000096@64,
        a60 <u 0x10000000000cc4@64, a61 <u 0x10000000000000@64, a62 <u 0x10000000000066@64, a63 <u 0x10000000000000@64, a64 <u 0x10000000000096@64,
        a70 <u 0x10000000000cc4@64, a71 <u 0x10000000000000@64, a72 <u 0x10000000000066@64, a73 <u 0x10000000000000@64, a74 <u 0x10000000000096@64, 
        b00 <u 0x8000000000662@64, b01 <u 0x8000000000000@64, b02 <u 0x8000000000033@64, b03 <u 0x8000000000000@64, b04 <u 0x800000000004b@64, 
        b10 <u 0x8000000000662@64, b11 <u 0x8000000000000@64, b12 <u 0x8000000000033@64, b13 <u 0x8000000000000@64, b14 <u 0x800000000004b@64, 
        b20 <u 0x8000000000662@64, b21 <u 0x8000000000000@64, b22 <u 0x8000000000033@64, b23 <u 0x8000000000000@64, b24 <u 0x800000000004b@64, 
        b30 <u 0x8000000000662@64, b31 <u 0x8000000000000@64, b32 <u 0x8000000000033@64, b33 <u 0x8000000000000@64, b34 <u 0x800000000004b@64, 
        b40 <u 0x8000000000662@64, b41 <u 0x8000000000000@64, b42 <u 0x8000000000033@64, b43 <u 0x8000000000000@64, b44 <u 0x800000000004b@64, 
        b50 <u 0x8000000000662@64, b51 <u 0x8000000000000@64, b52 <u 0x8000000000033@64, b53 <u 0x8000000000000@64, b54 <u 0x800000000004b@64,
        b60 <u 0x8000000000662@64, b61 <u 0x8000000000000@64, b62 <u 0x8000000000033@64, b63 <u 0x8000000000000@64, b64 <u 0x800000000004b@64,
        b70 <u 0x8000000000662@64, b71 <u 0x8000000000000@64, b72 <u 0x8000000000033@64, b73 <u 0x8000000000000@64, b74 <u 0x800000000004b@64
      ]
}

mov L0x55555556a100 0x13@uint64;
mov L0x55555556a200 0x000fffffffffffda@uint64;
mov L0x55555556a208 0x000ffffffffffffe@uint64;
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
(* vmovdqa64 (%rsi),%zmm7                          #! EA = L0x7fffffffd500; Value = 0x00007fffffffd610; PC = 0x555555556334 *)
mov zmm7_000 L0x7fffffffd500; (* zmm7_000=a00 *)
mov zmm7_001 L0x7fffffffd508;
mov zmm7_010 L0x7fffffffd510;
mov zmm7_011 L0x7fffffffd518;
mov zmm7_100 L0x7fffffffd520;
mov zmm7_101 L0x7fffffffd528;
mov zmm7_110 L0x7fffffffd530;
mov zmm7_111 L0x7fffffffd538;
(* vmovdqa64 0x80(%rsi),%zmm0                      #! EA = L0x7fffffffd580; Value = 0x0000000000000000; PC = 0x55555555633a *)
mov zmm0_000 L0x7fffffffd580; (* zmm0_000=a02 *)
mov zmm0_001 L0x7fffffffd588;
mov zmm0_010 L0x7fffffffd590;
mov zmm0_011 L0x7fffffffd598;
mov zmm0_100 L0x7fffffffd5a0;
mov zmm0_101 L0x7fffffffd5a8;
mov zmm0_110 L0x7fffffffd5b0;
mov zmm0_111 L0x7fffffffd5b8;
(* vpsubq (%rdx),%zmm7,%zmm3                       #! EA = L0x7fffffffd640; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x555555556341 *)
sub zmm3_000 zmm7_000 L0x7fffffffd640; (* zmm3_000=a00-b00 *)
sub zmm3_001 zmm7_001 L0x7fffffffd648;
sub zmm3_010 zmm7_010 L0x7fffffffd650;
sub zmm3_011 zmm7_011 L0x7fffffffd658;
sub zmm3_100 zmm7_100 L0x7fffffffd660;
sub zmm3_101 zmm7_101 L0x7fffffffd668;
sub zmm3_110 zmm7_110 L0x7fffffffd670;
sub zmm3_111 zmm7_111 L0x7fffffffd678;
(* vpsubq 0x80(%rdx),%zmm0,%zmm1                   #! EA = L0x7fffffffd6c0; Value = 0x0000000000000000; PC = 0x555555556347 *)
sub zmm1_000 zmm0_000 L0x7fffffffd6c0; (* zmm1_000=a02-b02 *)
sub zmm1_001 zmm0_001 L0x7fffffffd6c8;
sub zmm1_010 zmm0_010 L0x7fffffffd6d0;
sub zmm1_011 zmm0_011 L0x7fffffffd6d8;
sub zmm1_100 zmm0_100 L0x7fffffffd6e0;
sub zmm1_101 zmm0_101 L0x7fffffffd6e8;
sub zmm1_110 zmm0_110 L0x7fffffffd6f0;
sub zmm1_111 zmm0_111 L0x7fffffffd6f8;
(* vpbroadcastq 0x13eb0(%rip),%zmm5        # 0x55555556a208#! EA = L0x55555556a208; Value = 0x000ffffffffffffe; PC = 0x55555555634e *)
mov zmm5_000 L0x55555556a208; (* zmm5_000=0x000ffffffffffffe *)
mov zmm5_001 L0x55555556a208;
mov zmm5_010 L0x55555556a208;
mov zmm5_011 L0x55555556a208;
mov zmm5_100 L0x55555556a208;
mov zmm5_101 L0x55555556a208;
mov zmm5_110 L0x55555556a208;
mov zmm5_111 L0x55555556a208;
(* vmovdqa64 0x40(%rsi),%zmm6                      #! EA = L0x7fffffffd540; Value = 0x0000000000000009; PC = 0x555555556358 *)
mov zmm6_000 L0x7fffffffd540; (* zmm6_000=a01 *)
mov zmm6_001 L0x7fffffffd548;
mov zmm6_010 L0x7fffffffd550;
mov zmm6_011 L0x7fffffffd558;
mov zmm6_100 L0x7fffffffd560;
mov zmm6_101 L0x7fffffffd568;
mov zmm6_110 L0x7fffffffd570;
mov zmm6_111 L0x7fffffffd578;
(* vmovdqa64 0xc0(%rsi),%zmm15                     #! EA = L0x7fffffffd5c0; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x55555555635f *)
mov zmm15_000 L0x7fffffffd5c0; (* zmm15_000=a03 *)
mov zmm15_001 L0x7fffffffd5c8;
mov zmm15_010 L0x7fffffffd5d0;
mov zmm15_011 L0x7fffffffd5d8;
mov zmm15_100 L0x7fffffffd5e0;
mov zmm15_101 L0x7fffffffd5e8;
mov zmm15_110 L0x7fffffffd5f0;
mov zmm15_111 L0x7fffffffd5f8;
(* vpaddq 0x100(%rsi),%zmm5,%zmm4                  #! EA = L0x7fffffffd600; Value = 0x0000000000000000; PC = 0x555555556366 *)
add zmm4_000 zmm5_000 L0x7fffffffd600; (* zmm4_000=0x000ffffffffffffe+a04 *)
add zmm4_001 zmm5_001 L0x7fffffffd608;
add zmm4_010 zmm5_010 L0x7fffffffd610;
add zmm4_011 zmm5_011 L0x7fffffffd618;
add zmm4_100 zmm5_100 L0x7fffffffd620;
add zmm4_101 zmm5_101 L0x7fffffffd628;
add zmm4_110 zmm5_110 L0x7fffffffd630;
add zmm4_111 zmm5_111 L0x7fffffffd638;
(* vpaddq 0x13e89(%rip){1to8},%zmm3,%zmm9        # 0x55555556a200#! EA = L0x55555556a200; PC = 0x55555555636d *)
add zmm9_000 zmm3_000 L0x55555556a200; (* zmm9_000=a00-b00+0x000fffffffffffda *)
add zmm9_001 zmm3_001 L0x55555556a200;
add zmm9_010 zmm3_010 L0x55555556a200;
add zmm9_011 zmm3_011 L0x55555556a200;
add zmm9_100 zmm3_100 L0x55555556a200;
add zmm9_101 zmm3_101 L0x55555556a200;
add zmm9_110 zmm3_110 L0x55555556a200;
add zmm9_111 zmm3_111 L0x55555556a200;
(* vpaddq %zmm5,%zmm1,%zmm10                       #! PC = 0x555555556377 *)
add zmm10_000 zmm1_000 zmm5_000; (* zmm10_000=a02-b02+0x000ffffffffffffe *)
add zmm10_001 zmm1_001 zmm5_001;
add zmm10_010 zmm1_010 zmm5_010;
add zmm10_011 zmm1_011 zmm5_011;
add zmm10_100 zmm1_100 zmm5_100;
add zmm10_101 zmm1_101 zmm5_101;
add zmm10_110 zmm1_110 zmm5_110;
add zmm10_111 zmm1_111 zmm5_111;
(* vpsubq 0x40(%rdx),%zmm6,%zmm2                   #! EA = L0x7fffffffd680; Value = 0x5500747365745f32; PC = 0x55555555637d *)
sub zmm2_000 zmm6_000 L0x7fffffffd680; (* zmm2_000=a01-b01 *)
sub zmm2_001 zmm6_001 L0x7fffffffd688;
sub zmm2_010 zmm6_010 L0x7fffffffd690;
sub zmm2_011 zmm6_011 L0x7fffffffd698;
sub zmm2_100 zmm6_100 L0x7fffffffd6a0;
sub zmm2_101 zmm6_101 L0x7fffffffd6a8;
sub zmm2_110 zmm6_110 L0x7fffffffd6b0;
sub zmm2_111 zmm6_111 L0x7fffffffd6b8;
(* vpsubq 0xc0(%rdx),%zmm15,%zmm7                  #! EA = L0x7fffffffd700; Value = 0x0000004000000000; PC = 0x555555556384 *)
sub zmm7_000 zmm15_000 L0x7fffffffd700; (* zmm7_000=a03-b03 *)
sub zmm7_001 zmm15_001 L0x7fffffffd708;
sub zmm7_010 zmm15_010 L0x7fffffffd710;
sub zmm7_011 zmm15_011 L0x7fffffffd718;
sub zmm7_100 zmm15_100 L0x7fffffffd720;
sub zmm7_101 zmm15_101 L0x7fffffffd728;
sub zmm7_110 zmm15_110 L0x7fffffffd730;
sub zmm7_111 zmm15_111 L0x7fffffffd738;
(* vpsrlq $0x33,%zmm9,%zmm8                        #! PC = 0x55555555638b *)
split zmm8_000 tmp zmm9_000 0x33; (* zmm8_000=(a00-b00+0x000fffffffffffda)>>51 *)
split zmm8_001 tmp zmm9_001 0x33;
split zmm8_010 tmp zmm9_010 0x33;
split zmm8_011 tmp zmm9_011 0x33;
split zmm8_100 tmp zmm9_100 0x33;
split zmm8_101 tmp zmm9_101 0x33;
split zmm8_110 tmp zmm9_110 0x33;
split zmm8_111 tmp zmm9_111 0x33;
ghost
 zmm8_000o1@uint64,
 zmm8_001o1@uint64,
 zmm8_010o1@uint64,
 zmm8_011o1@uint64,
 zmm8_100o1@uint64,
 zmm8_101o1@uint64,
 zmm8_110o1@uint64,
 zmm8_111o1@uint64 :
 and [
  zmm8_000o1=zmm8_000,
  zmm8_001o1=zmm8_001,
  zmm8_010o1=zmm8_010,
  zmm8_011o1=zmm8_011,
  zmm8_100o1=zmm8_100,
  zmm8_101o1=zmm8_101,
  zmm8_110o1=zmm8_110,
  zmm8_111o1=zmm8_111
 ] &&
 and [
  zmm8_000o1=zmm8_000,
  zmm8_001o1=zmm8_001,
  zmm8_010o1=zmm8_010,
  zmm8_011o1=zmm8_011,
  zmm8_100o1=zmm8_100,
  zmm8_101o1=zmm8_101,
  zmm8_110o1=zmm8_110,
  zmm8_111o1=zmm8_111
 ];
(* vpsrlq $0x33,%zmm10,%zmm14                      #! PC = 0x555555556392 *)
split zmm14_000 tmp zmm10_000 0x33; (* zmm14_000=(a02-b02+0x000ffffffffffffe)>>51 *)
split zmm14_001 tmp zmm10_001 0x33;
split zmm14_010 tmp zmm10_010 0x33;
split zmm14_011 tmp zmm10_011 0x33;
split zmm14_100 tmp zmm10_100 0x33;
split zmm14_101 tmp zmm10_101 0x33;
split zmm14_110 tmp zmm10_110 0x33;
split zmm14_111 tmp zmm10_111 0x33;
(* vpsubq 0x100(%rdx),%zmm4,%zmm11                 #! EA = L0x7fffffffd740; Value = 0x0000000000000002; PC = 0x555555556399 *)
sub zmm11_000 zmm4_000 L0x7fffffffd740; (* zmm11_000=0x000ffffffffffffe+a04-b04 *)
sub zmm11_001 zmm4_001 L0x7fffffffd748;
sub zmm11_010 zmm4_010 L0x7fffffffd750;
sub zmm11_011 zmm4_011 L0x7fffffffd758;
sub zmm11_100 zmm4_100 L0x7fffffffd760;
sub zmm11_101 zmm4_101 L0x7fffffffd768;
sub zmm11_110 zmm4_110 L0x7fffffffd770;
sub zmm11_111 zmm4_111 L0x7fffffffd778;
(* vpaddq %zmm5,%zmm8,%zmm12                       #! PC = 0x5555555563a0 *)
add zmm12_000 zmm8_000 zmm5_000; (* zmm12_000=(a00-b00+0x000fffffffffffda)>>51+0x000ffffffffffffe *)
add zmm12_001 zmm8_001 zmm5_001;
add zmm12_010 zmm8_010 zmm5_010;
add zmm12_011 zmm8_011 zmm5_011;
add zmm12_100 zmm8_100 zmm5_100;
add zmm12_101 zmm8_101 zmm5_101;
add zmm12_110 zmm8_110 zmm5_110;
add zmm12_111 zmm8_111 zmm5_111;
(* vpaddq %zmm5,%zmm14,%zmm3                       #! PC = 0x5555555563a6 *)
add zmm3_000 zmm14_000 zmm5_000; (* zmm3_000=(a02-b02+0x000ffffffffffffe)>>51+0x000ffffffffffffe *)
add zmm3_001 zmm14_001 zmm5_001;
add zmm3_010 zmm14_010 zmm5_010;
add zmm3_011 zmm14_011 zmm5_011;
add zmm3_100 zmm14_100 zmm5_100;
add zmm3_101 zmm14_101 zmm5_101;
add zmm3_110 zmm14_110 zmm5_110;
add zmm3_111 zmm14_111 zmm5_111;
(* vmovdqa32 0x13d8a(%rip),%zmm5        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x5555555563ac *)
(* vmovdqa32 %%L0x55555556a140,%%zmm5        # 0x55555556a140#! L0x55555556a140 = L0x55555556a140; 0x0007ffffffffffff = 0x0007ffffffffffff; 0x5555555563ac = 0x5555555563ac; *)
mov zmm5_000 0x0007ffffffffffff@uint64; (* zmm5_000=mask51b *)
mov zmm5_001 0x0007ffffffffffff@uint64;
mov zmm5_010 0x0007ffffffffffff@uint64;
mov zmm5_011 0x0007ffffffffffff@uint64;
mov zmm5_100 0x0007ffffffffffff@uint64;
mov zmm5_101 0x0007ffffffffffff@uint64;
mov zmm5_110 0x0007ffffffffffff@uint64;
mov zmm5_111 0x0007ffffffffffff@uint64;
(* vpaddq %zmm12,%zmm2,%zmm13                      #! PC = 0x5555555563b6 *)
add zmm13_000 zmm2_000 zmm12_000; (* zmm13_000=a01-b01+(a00-b00+0x000fffffffffffda)>>51+0x000ffffffffffffe *)
add zmm13_001 zmm2_001 zmm12_001;
add zmm13_010 zmm2_010 zmm12_010;
add zmm13_011 zmm2_011 zmm12_011;
add zmm13_100 zmm2_100 zmm12_100;
add zmm13_101 zmm2_101 zmm12_101;
add zmm13_110 zmm2_110 zmm12_110;
add zmm13_111 zmm2_111 zmm12_111;
(* vpaddq %zmm3,%zmm7,%zmm0                        #! PC = 0x5555555563bc *)
add zmm0_000 zmm7_000 zmm3_000; (* zmm0_000=a03-b03+(a02-b02+0x000ffffffffffffe)>>51+0x000ffffffffffffe *)
add zmm0_001 zmm7_001 zmm3_001;
add zmm0_010 zmm7_010 zmm3_010;
add zmm0_011 zmm7_011 zmm3_011;
add zmm0_100 zmm7_100 zmm3_100;
add zmm0_101 zmm7_101 zmm3_101;
add zmm0_110 zmm7_110 zmm3_110;
add zmm0_111 zmm7_111 zmm3_111;
(* vpsrlq $0x33,%zmm11,%zmm1                       #! PC = 0x5555555563c2 *)
split zmm1_000 tmp zmm11_000 0x33; (* zmm1_000=(0x000ffffffffffffe+a04-b04)>>51 *)
split zmm1_001 tmp zmm11_001 0x33;
split zmm1_010 tmp zmm11_010 0x33;
split zmm1_011 tmp zmm11_011 0x33;
split zmm1_100 tmp zmm11_100 0x33;
split zmm1_101 tmp zmm11_101 0x33;
split zmm1_110 tmp zmm11_110 0x33;
split zmm1_111 tmp zmm11_111 0x33;
(* vpsrlq $0x33,%zmm13,%zmm8                       #! PC = 0x5555555563c9 *)
split zmm8_000 tmp zmm13_000 0x33;
split zmm8_001 tmp zmm13_001 0x33;
split zmm8_010 tmp zmm13_010 0x33;
split zmm8_011 tmp zmm13_011 0x33;
split zmm8_100 tmp zmm13_100 0x33;
split zmm8_101 tmp zmm13_101 0x33;
split zmm8_110 tmp zmm13_110 0x33;
split zmm8_111 tmp zmm13_111 0x33;
(* vpsrlq $0x33,%zmm0,%zmm6                        #! PC = 0x5555555563d0 *)
split zmm6_000 tmp zmm0_000 0x33;
split zmm6_001 tmp zmm0_001 0x33;
split zmm6_010 tmp zmm0_010 0x33;
split zmm6_011 tmp zmm0_011 0x33;
split zmm6_100 tmp zmm0_100 0x33;
split zmm6_101 tmp zmm0_101 0x33;
split zmm6_110 tmp zmm0_110 0x33;
split zmm6_111 tmp zmm0_111 0x33;
ghost 
  zmm9_000o@uint64,
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
(* vpandd %zmm5,%zmm9,%zmm9                        #! PC = 0x5555555563d7 *)
and zmm9_000@uint64 zmm9_000 zmm5_000;
and zmm9_001@uint64 zmm9_001 zmm5_001;
and zmm9_010@uint64 zmm9_010 zmm5_010;
and zmm9_011@uint64 zmm9_011 zmm5_011;
and zmm9_100@uint64 zmm9_100 zmm5_100;
and zmm9_101@uint64 zmm9_101 zmm5_101;
and zmm9_110@uint64 zmm9_110 zmm5_110;
and zmm9_111@uint64 zmm9_111 zmm5_111;
assert true && and [
      zmm9_000o = zmm9_000 + zmm8_000o1 * (2**51)@64,
      zmm9_001o = zmm9_001 + zmm8_001o1 * (2**51)@64,
      zmm9_010o = zmm9_010 + zmm8_010o1 * (2**51)@64,
      zmm9_011o = zmm9_011 + zmm8_011o1 * (2**51)@64,
      zmm9_100o = zmm9_100 + zmm8_100o1 * (2**51)@64,
      zmm9_101o = zmm9_101 + zmm8_101o1 * (2**51)@64,
      zmm9_110o = zmm9_110 + zmm8_110o1 * (2**51)@64,
      zmm9_111o = zmm9_111 + zmm8_111o1 * (2**51)@64
];
assume and [
      zmm9_000o = zmm9_000 + zmm8_000o1 * (2**51),
      zmm9_001o = zmm9_001 + zmm8_001o1 * (2**51),
      zmm9_010o = zmm9_010 + zmm8_010o1 * (2**51),
      zmm9_011o = zmm9_011 + zmm8_011o1 * (2**51),
      zmm9_100o = zmm9_100 + zmm8_100o1 * (2**51),
      zmm9_101o = zmm9_101 + zmm8_101o1 * (2**51),
      zmm9_110o = zmm9_110 + zmm8_110o1 * (2**51),
      zmm9_111o = zmm9_111 + zmm8_111o1 * (2**51)
] && true;

ghost 
  zmm10_000o@uint64,
  zmm10_001o@uint64,
  zmm10_010o@uint64,
  zmm10_011o@uint64,
  zmm10_100o@uint64,
  zmm10_101o@uint64,
  zmm10_110o@uint64,
  zmm10_111o@uint64 :
  and [
  zmm10_000o=zmm10_000,
  zmm10_001o=zmm10_001,
  zmm10_010o=zmm10_010,
  zmm10_011o=zmm10_011,
  zmm10_100o=zmm10_100,
  zmm10_101o=zmm10_101,
  zmm10_110o=zmm10_110,
  zmm10_111o=zmm10_111
  ] &&
  and [
  zmm10_000o=zmm10_000,
  zmm10_001o=zmm10_001,
  zmm10_010o=zmm10_010,
  zmm10_011o=zmm10_011,
  zmm10_100o=zmm10_100,
  zmm10_101o=zmm10_101,
  zmm10_110o=zmm10_110,
  zmm10_111o=zmm10_111
  ];
(* vpandd %zmm5,%zmm10,%zmm10                      #! PC = 0x5555555563dd *)
and zmm10_000@uint64 zmm10_000 zmm5_000;
and zmm10_001@uint64 zmm10_001 zmm5_001;
and zmm10_010@uint64 zmm10_010 zmm5_010;
and zmm10_011@uint64 zmm10_011 zmm5_011;
and zmm10_100@uint64 zmm10_100 zmm5_100;
and zmm10_101@uint64 zmm10_101 zmm5_101;
and zmm10_110@uint64 zmm10_110 zmm5_110;
and zmm10_111@uint64 zmm10_111 zmm5_111;
assert true && and [
      zmm10_000o = zmm10_000 + zmm14_000 * (2**51)@64,
      zmm10_001o = zmm10_001 + zmm14_001 * (2**51)@64,
      zmm10_010o = zmm10_010 + zmm14_010 * (2**51)@64,
      zmm10_011o = zmm10_011 + zmm14_011 * (2**51)@64,
      zmm10_100o = zmm10_100 + zmm14_100 * (2**51)@64,
      zmm10_101o = zmm10_101 + zmm14_101 * (2**51)@64,
      zmm10_110o = zmm10_110 + zmm14_110 * (2**51)@64,
      zmm10_111o = zmm10_111 + zmm14_111 * (2**51)@64
];
assume and [
      zmm10_000o = zmm10_000 + zmm14_000 * (2**51),
      zmm10_001o = zmm10_001 + zmm14_001 * (2**51),
      zmm10_010o = zmm10_010 + zmm14_010 * (2**51),
      zmm10_011o = zmm10_011 + zmm14_011 * (2**51),
      zmm10_100o = zmm10_100 + zmm14_100 * (2**51),
      zmm10_101o = zmm10_101 + zmm14_101 * (2**51),
      zmm10_110o = zmm10_110 + zmm14_110 * (2**51),
      zmm10_111o = zmm10_111 + zmm14_111 * (2**51)
] && true;

ghost 
  zmm11_000o@uint64,
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
(* vpandd %zmm5,%zmm11,%zmm11                      #! PC = 0x5555555563e3 *)
and zmm11_000@uint64 zmm11_000 zmm5_000;
and zmm11_001@uint64 zmm11_001 zmm5_001;
and zmm11_010@uint64 zmm11_010 zmm5_010;
and zmm11_011@uint64 zmm11_011 zmm5_011;
and zmm11_100@uint64 zmm11_100 zmm5_100;
and zmm11_101@uint64 zmm11_101 zmm5_101;
and zmm11_110@uint64 zmm11_110 zmm5_110;
and zmm11_111@uint64 zmm11_111 zmm5_111;
assert true && and [
      zmm11_000o = zmm11_000 + zmm1_000 * (2**51)@64,
      zmm11_001o = zmm11_001 + zmm1_001 * (2**51)@64,
      zmm11_010o = zmm11_010 + zmm1_010 * (2**51)@64,
      zmm11_011o = zmm11_011 + zmm1_011 * (2**51)@64,
      zmm11_100o = zmm11_100 + zmm1_100 * (2**51)@64,
      zmm11_101o = zmm11_101 + zmm1_101 * (2**51)@64,
      zmm11_110o = zmm11_110 + zmm1_110 * (2**51)@64,
      zmm11_111o = zmm11_111 + zmm1_111 * (2**51)@64
];
assume and [
      zmm11_000o = zmm11_000 + zmm1_000 * (2**51),
      zmm11_001o = zmm11_001 + zmm1_001 * (2**51),
      zmm11_010o = zmm11_010 + zmm1_010 * (2**51),
      zmm11_011o = zmm11_011 + zmm1_011 * (2**51),
      zmm11_100o = zmm11_100 + zmm1_100 * (2**51),
      zmm11_101o = zmm11_101 + zmm1_101 * (2**51),
      zmm11_110o = zmm11_110 + zmm1_110 * (2**51),
      zmm11_111o = zmm11_111 + zmm1_111 * (2**51)
] && true;

ghost 
  zmm13_000o@uint64,
  zmm13_001o@uint64,
  zmm13_010o@uint64,
  zmm13_011o@uint64,
  zmm13_100o@uint64,
  zmm13_101o@uint64,
  zmm13_110o@uint64,
  zmm13_111o@uint64 :
  and [
  zmm13_000o=zmm13_000,
  zmm13_001o=zmm13_001,
  zmm13_010o=zmm13_010,
  zmm13_011o=zmm13_011,
  zmm13_100o=zmm13_100,
  zmm13_101o=zmm13_101,
  zmm13_110o=zmm13_110,
  zmm13_111o=zmm13_111
  ] &&
  and [
  zmm13_000o=zmm13_000,
  zmm13_001o=zmm13_001,
  zmm13_010o=zmm13_010,
  zmm13_011o=zmm13_011,
  zmm13_100o=zmm13_100,
  zmm13_101o=zmm13_101,
  zmm13_110o=zmm13_110,
  zmm13_111o=zmm13_111
  ];
(* vpandd %zmm5,%zmm13,%zmm12                      #! PC = 0x5555555563e9 *)
and zmm12_000@uint64 zmm13_000 zmm5_000;
and zmm12_001@uint64 zmm13_001 zmm5_001;
and zmm12_010@uint64 zmm13_010 zmm5_010;
and zmm12_011@uint64 zmm13_011 zmm5_011;
and zmm12_100@uint64 zmm13_100 zmm5_100;
and zmm12_101@uint64 zmm13_101 zmm5_101;
and zmm12_110@uint64 zmm13_110 zmm5_110;
and zmm12_111@uint64 zmm13_111 zmm5_111;
assert true && and [
      zmm13_000o = zmm12_000 + zmm8_000 * (2**51)@64,
      zmm13_001o = zmm12_001 + zmm8_001 * (2**51)@64,
      zmm13_010o = zmm12_010 + zmm8_010 * (2**51)@64,
      zmm13_011o = zmm12_011 + zmm8_011 * (2**51)@64,
      zmm13_100o = zmm12_100 + zmm8_100 * (2**51)@64,
      zmm13_101o = zmm12_101 + zmm8_101 * (2**51)@64,
      zmm13_110o = zmm12_110 + zmm8_110 * (2**51)@64,
      zmm13_111o = zmm12_111 + zmm8_111 * (2**51)@64
];
assume and [
      zmm13_000o = zmm12_000 + zmm8_000 * (2**51),
      zmm13_001o = zmm12_001 + zmm8_001 * (2**51),
      zmm13_010o = zmm12_010 + zmm8_010 * (2**51),
      zmm13_011o = zmm12_011 + zmm8_011 * (2**51),
      zmm13_100o = zmm12_100 + zmm8_100 * (2**51),
      zmm13_101o = zmm12_101 + zmm8_101 * (2**51),
      zmm13_110o = zmm12_110 + zmm8_110 * (2**51),
      zmm13_111o = zmm12_111 + zmm8_111 * (2**51)
] && true;

ghost 
  zmm0_000o@uint64,
  zmm0_001o@uint64,
  zmm0_010o@uint64,
  zmm0_011o@uint64,
  zmm0_100o@uint64,
  zmm0_101o@uint64,
  zmm0_110o@uint64,
  zmm0_111o@uint64 :
  and [
  zmm0_000o=zmm0_000,
  zmm0_001o=zmm0_001,
  zmm0_010o=zmm0_010,
  zmm0_011o=zmm0_011,
  zmm0_100o=zmm0_100,
  zmm0_101o=zmm0_101,
  zmm0_110o=zmm0_110,
  zmm0_111o=zmm0_111
  ] &&
  and [
  zmm0_000o=zmm0_000,
  zmm0_001o=zmm0_001,
  zmm0_010o=zmm0_010,
  zmm0_011o=zmm0_011,
  zmm0_100o=zmm0_100,
  zmm0_101o=zmm0_101,
  zmm0_110o=zmm0_110,
  zmm0_111o=zmm0_111
  ];
(* vpandd %zmm5,%zmm0,%zmm14                       #! PC = 0x5555555563ef *)
and zmm14_000@uint64 zmm0_000 zmm5_000;
and zmm14_001@uint64 zmm0_001 zmm5_001;
and zmm14_010@uint64 zmm0_010 zmm5_010;
and zmm14_011@uint64 zmm0_011 zmm5_011;
and zmm14_100@uint64 zmm0_100 zmm5_100;
and zmm14_101@uint64 zmm0_101 zmm5_101;
and zmm14_110@uint64 zmm0_110 zmm5_110;
and zmm14_111@uint64 zmm0_111 zmm5_111;
assert true && and [
      zmm0_000o = zmm14_000 + zmm6_000 * (2**51)@64,
      zmm0_001o = zmm14_001 + zmm6_001 * (2**51)@64,
      zmm0_010o = zmm14_010 + zmm6_010 * (2**51)@64,
      zmm0_011o = zmm14_011 + zmm6_011 * (2**51)@64,
      zmm0_100o = zmm14_100 + zmm6_100 * (2**51)@64,
      zmm0_101o = zmm14_101 + zmm6_101 * (2**51)@64,
      zmm0_110o = zmm14_110 + zmm6_110 * (2**51)@64,
      zmm0_111o = zmm14_111 + zmm6_111 * (2**51)@64
];
assume and [
      zmm0_000o = zmm14_000 + zmm6_000 * (2**51),
      zmm0_001o = zmm14_001 + zmm6_001 * (2**51),
      zmm0_010o = zmm14_010 + zmm6_010 * (2**51),
      zmm0_011o = zmm14_011 + zmm6_011 * (2**51),
      zmm0_100o = zmm14_100 + zmm6_100 * (2**51),
      zmm0_101o = zmm14_101 + zmm6_101 * (2**51),
      zmm0_110o = zmm14_110 + zmm6_110 * (2**51),
      zmm0_111o = zmm14_111 + zmm6_111 * (2**51)
] && true;

(* vpaddq %zmm10,%zmm8,%zmm13                      #! PC = 0x5555555563f5 *)
add zmm13_000 zmm8_000 zmm10_000;
add zmm13_001 zmm8_001 zmm10_001;
add zmm13_010 zmm8_010 zmm10_010;
add zmm13_011 zmm8_011 zmm10_011;
add zmm13_100 zmm8_100 zmm10_100;
add zmm13_101 zmm8_101 zmm10_101;
add zmm13_110 zmm8_110 zmm10_110;
add zmm13_111 zmm8_111 zmm10_111;
(* vpaddq %zmm11,%zmm6,%zmm15                      #! PC = 0x5555555563fb *)
add zmm15_000 zmm6_000 zmm11_000;
add zmm15_001 zmm6_001 zmm11_001;
add zmm15_010 zmm6_010 zmm11_010;
add zmm15_011 zmm6_011 zmm11_011;
add zmm15_100 zmm6_100 zmm11_100;
add zmm15_101 zmm6_101 zmm11_101;
add zmm15_110 zmm6_110 zmm11_110;
add zmm15_111 zmm6_111 zmm11_111;
(* vpmuludq 0x13cf5(%rip),%zmm1,%zmm4        # 0x55555556a100#! EA = L0x55555556a100; Value = 0x0000000000000013; PC = 0x555555556401 *)
mul zmm4_000 zmm1_000 L0x55555556a100;
mul zmm4_001 zmm1_001 L0x55555556a100;
mul zmm4_010 zmm1_010 L0x55555556a100;
mul zmm4_011 zmm1_011 L0x55555556a100;
mul zmm4_100 zmm1_100 L0x55555556a100;
mul zmm4_101 zmm1_101 L0x55555556a100;
mul zmm4_110 zmm1_110 L0x55555556a100;
mul zmm4_111 zmm1_111 L0x55555556a100;
(* vpaddq %zmm9,%zmm4,%zmm2                        #! PC = 0x55555555640b *)
add zmm2_000 zmm4_000 zmm9_000;
add zmm2_001 zmm4_001 zmm9_001;
add zmm2_010 zmm4_010 zmm9_010;
add zmm2_011 zmm4_011 zmm9_011;
add zmm2_100 zmm4_100 zmm9_100;
add zmm2_101 zmm4_101 zmm9_101;
add zmm2_110 zmm4_110 zmm9_110;
add zmm2_111 zmm4_111 zmm9_111;
(* vmovdqa64 %zmm2,(%rdi)                          #! EA = L0x7fffffffd780; PC = 0x555555556411 *)
mov L0x7fffffffd780 zmm2_000;
mov L0x7fffffffd788 zmm2_001;
mov L0x7fffffffd790 zmm2_010;
mov L0x7fffffffd798 zmm2_011;
mov L0x7fffffffd7a0 zmm2_100;
mov L0x7fffffffd7a8 zmm2_101;
mov L0x7fffffffd7b0 zmm2_110;
mov L0x7fffffffd7b8 zmm2_111;
(* vmovdqa32 %zmm12,0x40(%rdi)                     #! EA = L0x7fffffffd7c0; PC = 0x555555556417 *)
mov L0x7fffffffd7c0 zmm12_000;
mov L0x7fffffffd7c8 zmm12_001;
mov L0x7fffffffd7d0 zmm12_010;
mov L0x7fffffffd7d8 zmm12_011;
mov L0x7fffffffd7e0 zmm12_100;
mov L0x7fffffffd7e8 zmm12_101;
mov L0x7fffffffd7f0 zmm12_110;
mov L0x7fffffffd7f8 zmm12_111;
(* vmovdqa64 %zmm13,0x80(%rdi)                     #! EA = L0x7fffffffd800; PC = 0x55555555641e *)
mov L0x7fffffffd800 zmm13_000;
mov L0x7fffffffd808 zmm13_001;
mov L0x7fffffffd810 zmm13_010;
mov L0x7fffffffd818 zmm13_011;
mov L0x7fffffffd820 zmm13_100;
mov L0x7fffffffd828 zmm13_101;
mov L0x7fffffffd830 zmm13_110;
mov L0x7fffffffd838 zmm13_111;
(* vmovdqa32 %zmm14,0xc0(%rdi)                     #! EA = L0x7fffffffd840; PC = 0x555555556425 *)
mov L0x7fffffffd840 zmm14_000;
mov L0x7fffffffd848 zmm14_001;
mov L0x7fffffffd850 zmm14_010;
mov L0x7fffffffd858 zmm14_011;
mov L0x7fffffffd860 zmm14_100;
mov L0x7fffffffd868 zmm14_101;
mov L0x7fffffffd870 zmm14_110;
mov L0x7fffffffd878 zmm14_111;
(* vmovdqa64 %zmm15,0x100(%rdi)                    #! EA = L0x7fffffffd880; PC = 0x55555555642c *)
mov L0x7fffffffd880 zmm15_000;
mov L0x7fffffffd888 zmm15_001;
mov L0x7fffffffd890 zmm15_010;
mov L0x7fffffffd898 zmm15_011;
mov L0x7fffffffd8a0 zmm15_100;
mov L0x7fffffffd8a8 zmm15_101;
mov L0x7fffffffd8b0 zmm15_110;
mov L0x7fffffffd8b8 zmm15_111;
(* #! <- SP = 0x7fffffffd4b8 *)
#! 0x7fffffffd4b8 = 0x7fffffffd4b8;
(* #ret                                            #! PC = 0x555555556436 *)
#ret                                            #! 0x555555556436 = 0x555555556436;

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

{
  and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
            limbs 51 [a00, a01, a02, a03, a04] - limbs 51 [b00, b01, b02, b03, b04]
            p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
            limbs 51 [a10, a11, a12, a13, a14] - limbs 51 [b10, b11, b12, b13, b14]
            p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
            limbs 51 [a20, a21, a22, a23, a24] - limbs 51 [b20, b21, b22, b23, b24]
            p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
            limbs 51 [a30, a31, a32, a33, a34] - limbs 51 [b30, b31, b32, b33, b34]
            p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
            limbs 51 [a40, a41, a42, a43, a44] - limbs 51 [b40, b41, b42, b43, b44]
            p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
            limbs 51 [a50, a51, a52, a53, a54] - limbs 51 [b50, b51, b52, b53, b54]
            p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
            limbs 51 [a60, a61, a62, a63, a64] - limbs 51 [b60, b61, b62, b63, b64]
            p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
            limbs 51 [a70, a71, a72, a73, a74] - limbs 51 [b70, b71, b72, b73, b74]
            p
  ]
  &&
  and [
      c00 <=u 0x8000000000072@64, c01 <=u 0x8000000000000@64, c02 <=u 0x8000000000006@64, c03 <=u 0x8000000000000@64, c04 <=u 0x8000000000006@64,
      c10 <=u 0x8000000000072@64, c11 <=u 0x8000000000000@64, c12 <=u 0x8000000000006@64, c13 <=u 0x8000000000000@64, c14 <=u 0x8000000000006@64,
      c20 <=u 0x8000000000072@64, c21 <=u 0x8000000000000@64, c22 <=u 0x8000000000006@64, c23 <=u 0x8000000000000@64, c24 <=u 0x8000000000006@64,
      c30 <=u 0x8000000000072@64, c31 <=u 0x8000000000000@64, c32 <=u 0x8000000000006@64, c33 <=u 0x8000000000000@64, c34 <=u 0x8000000000006@64,
      c40 <=u 0x8000000000072@64, c41 <=u 0x8000000000000@64, c42 <=u 0x8000000000006@64, c43 <=u 0x8000000000000@64, c44 <=u 0x8000000000006@64,
      c50 <=u 0x8000000000072@64, c51 <=u 0x8000000000000@64, c52 <=u 0x8000000000006@64, c53 <=u 0x8000000000000@64, c54 <=u 0x8000000000006@64,
      c60 <=u 0x8000000000072@64, c61 <=u 0x8000000000000@64, c62 <=u 0x8000000000006@64, c63 <=u 0x8000000000000@64, c64 <=u 0x8000000000006@64,
      c70 <=u 0x8000000000072@64, c71 <=u 0x8000000000000@64, c72 <=u 0x8000000000006@64, c73 <=u 0x8000000000000@64, c74 <=u 0x8000000000006@64
  ]
}

