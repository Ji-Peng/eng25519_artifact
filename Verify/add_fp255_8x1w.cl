(*
cv -v -disable_safety add_fp255_8x1w.cl
Parsing CryptoLine file:		      [OK]		0.000777 seconds
Checking well-formedness:		      [OK]		0.000624 seconds
Transforming to SSA form:		      [OK]		0.000089 seconds
Normalizing specification:		      [OK]		0.000089 seconds
Rewriting assignments:			      [OK]		0.000142 seconds
Verifying range specification:		[OK]		0.087263 seconds
Rewriting value-preserved casting:	[OK]		0.000012 seconds
Verifying algebraic specification:	[OK]		0.008744 seconds
Verification result:			         [OK]		0.097953 seconds
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
           uint64 c04, uint64 c14, uint64 c24, uint64 c34, uint64 c44, uint64 c54, uint64 c64, uint64 c74) =
{
  true
  &&
  and [
        a00 <=u 0x8000000000662@64, a01 <=u 0x8000000000000@64, a02 <=u 0x8000000000033@64, a03 <=u 0x8000000000000@64, a04 <=u 0x800000000004b@64,
        a10 <=u 0x8000000000662@64, a11 <=u 0x8000000000000@64, a12 <=u 0x8000000000033@64, a13 <=u 0x8000000000000@64, a14 <=u 0x800000000004b@64,
        a20 <=u 0x8000000000662@64, a21 <=u 0x8000000000000@64, a22 <=u 0x8000000000033@64, a23 <=u 0x8000000000000@64, a24 <=u 0x800000000004b@64,
        a30 <=u 0x8000000000662@64, a31 <=u 0x8000000000000@64, a32 <=u 0x8000000000033@64, a33 <=u 0x8000000000000@64, a34 <=u 0x800000000004b@64,
        a40 <=u 0x8000000000662@64, a41 <=u 0x8000000000000@64, a42 <=u 0x8000000000033@64, a43 <=u 0x8000000000000@64, a44 <=u 0x800000000004b@64,
        a50 <=u 0x8000000000662@64, a51 <=u 0x8000000000000@64, a52 <=u 0x8000000000033@64, a53 <=u 0x8000000000000@64, a54 <=u 0x800000000004b@64,
        a60 <=u 0x8000000000662@64, a61 <=u 0x8000000000000@64, a62 <=u 0x8000000000033@64, a63 <=u 0x8000000000000@64, a64 <=u 0x800000000004b@64,
        a70 <=u 0x8000000000662@64, a71 <=u 0x8000000000000@64, a72 <=u 0x8000000000033@64, a73 <=u 0x8000000000000@64, a74 <=u 0x800000000004b@64,
        b00 <=u 0x8000000000662@64, b01 <=u 0x8000000000000@64, b02 <=u 0x8000000000033@64, b03 <=u 0x8000000000000@64, b04 <=u 0x800000000004b@64,
        b10 <=u 0x8000000000662@64, b11 <=u 0x8000000000000@64, b12 <=u 0x8000000000033@64, b13 <=u 0x8000000000000@64, b14 <=u 0x800000000004b@64,
        b20 <=u 0x8000000000662@64, b21 <=u 0x8000000000000@64, b22 <=u 0x8000000000033@64, b23 <=u 0x8000000000000@64, b24 <=u 0x800000000004b@64,
        b30 <=u 0x8000000000662@64, b31 <=u 0x8000000000000@64, b32 <=u 0x8000000000033@64, b33 <=u 0x8000000000000@64, b34 <=u 0x800000000004b@64,
        b40 <=u 0x8000000000662@64, b41 <=u 0x8000000000000@64, b42 <=u 0x8000000000033@64, b43 <=u 0x8000000000000@64, b44 <=u 0x800000000004b@64,
        b50 <=u 0x8000000000662@64, b51 <=u 0x8000000000000@64, b52 <=u 0x8000000000033@64, b53 <=u 0x8000000000000@64, b54 <=u 0x800000000004b@64,
        b60 <=u 0x8000000000662@64, b61 <=u 0x8000000000000@64, b62 <=u 0x8000000000033@64, b63 <=u 0x8000000000000@64, b64 <=u 0x800000000004b@64,
        b70 <=u 0x8000000000662@64, b71 <=u 0x8000000000000@64, b72 <=u 0x8000000000033@64, b73 <=u 0x8000000000000@64, b74 <=u 0x800000000004b@64
      ]
}

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
(* #endbr64                                         #! PC = 0x555555556150 *)
#endbr64                                         #! 0x555555556150 = 0x555555556150;
(* vmovdqa64 (%rdx),%zmm1                          #! EA = L0x7fffffffd640; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x555555556154 *)
mov zmm1_000 L0x7fffffffd640;
mov zmm1_001 L0x7fffffffd648;
mov zmm1_010 L0x7fffffffd650;
mov zmm1_011 L0x7fffffffd658;
mov zmm1_100 L0x7fffffffd660;
mov zmm1_101 L0x7fffffffd668;
mov zmm1_110 L0x7fffffffd670;
mov zmm1_111 L0x7fffffffd678;
(* vpaddq (%rsi),%zmm1,%zmm0                       #! EA = L0x7fffffffd500; Value = 0x00007fffffffd610; PC = 0x55555555615a *)
add zmm0_000 zmm1_000 L0x7fffffffd500;
add zmm0_001 zmm1_001 L0x7fffffffd508;
add zmm0_010 zmm1_010 L0x7fffffffd510;
add zmm0_011 zmm1_011 L0x7fffffffd518;
add zmm0_100 zmm1_100 L0x7fffffffd520;
add zmm0_101 zmm1_101 L0x7fffffffd528;
add zmm0_110 zmm1_110 L0x7fffffffd530;
add zmm0_111 zmm1_111 L0x7fffffffd538;
(* vmovdqa64 %zmm0,(%rdi)                          #! EA = L0x7fffffffd780; PC = 0x555555556160 *)
mov L0x7fffffffd780 zmm0_000;
mov L0x7fffffffd788 zmm0_001;
mov L0x7fffffffd790 zmm0_010;
mov L0x7fffffffd798 zmm0_011;
mov L0x7fffffffd7a0 zmm0_100;
mov L0x7fffffffd7a8 zmm0_101;
mov L0x7fffffffd7b0 zmm0_110;
mov L0x7fffffffd7b8 zmm0_111;
(* vmovdqa64 0x40(%rsi),%zmm2                      #! EA = L0x7fffffffd540; Value = 0x0000000000000009; PC = 0x555555556166 *)
mov zmm2_000 L0x7fffffffd540;
mov zmm2_001 L0x7fffffffd548;
mov zmm2_010 L0x7fffffffd550;
mov zmm2_011 L0x7fffffffd558;
mov zmm2_100 L0x7fffffffd560;
mov zmm2_101 L0x7fffffffd568;
mov zmm2_110 L0x7fffffffd570;
mov zmm2_111 L0x7fffffffd578;
(* vpaddq 0x40(%rdx),%zmm2,%zmm3                   #! EA = L0x7fffffffd680; Value = 0x4553550074736574; PC = 0x55555555616d *)
add zmm3_000 zmm2_000 L0x7fffffffd680;
add zmm3_001 zmm2_001 L0x7fffffffd688;
add zmm3_010 zmm2_010 L0x7fffffffd690;
add zmm3_011 zmm2_011 L0x7fffffffd698;
add zmm3_100 zmm2_100 L0x7fffffffd6a0;
add zmm3_101 zmm2_101 L0x7fffffffd6a8;
add zmm3_110 zmm2_110 L0x7fffffffd6b0;
add zmm3_111 zmm2_111 L0x7fffffffd6b8;
(* vmovdqa64 %zmm3,0x40(%rdi)                      #! EA = L0x7fffffffd7c0; PC = 0x555555556174 *)
mov L0x7fffffffd7c0 zmm3_000;
mov L0x7fffffffd7c8 zmm3_001;
mov L0x7fffffffd7d0 zmm3_010;
mov L0x7fffffffd7d8 zmm3_011;
mov L0x7fffffffd7e0 zmm3_100;
mov L0x7fffffffd7e8 zmm3_101;
mov L0x7fffffffd7f0 zmm3_110;
mov L0x7fffffffd7f8 zmm3_111;
(* vmovdqa64 0x80(%rsi),%zmm4                      #! EA = L0x7fffffffd580; Value = 0x0000000000000000; PC = 0x55555555617b *)
mov zmm4_000 L0x7fffffffd580;
mov zmm4_001 L0x7fffffffd588;
mov zmm4_010 L0x7fffffffd590;
mov zmm4_011 L0x7fffffffd598;
mov zmm4_100 L0x7fffffffd5a0;
mov zmm4_101 L0x7fffffffd5a8;
mov zmm4_110 L0x7fffffffd5b0;
mov zmm4_111 L0x7fffffffd5b8;
(* vpaddq 0x80(%rdx),%zmm4,%zmm5                   #! EA = L0x7fffffffd6c0; Value = 0x0000000000000000; PC = 0x555555556182 *)
add zmm5_000 zmm4_000 L0x7fffffffd6c0;
add zmm5_001 zmm4_001 L0x7fffffffd6c8;
add zmm5_010 zmm4_010 L0x7fffffffd6d0;
add zmm5_011 zmm4_011 L0x7fffffffd6d8;
add zmm5_100 zmm4_100 L0x7fffffffd6e0;
add zmm5_101 zmm4_101 L0x7fffffffd6e8;
add zmm5_110 zmm4_110 L0x7fffffffd6f0;
add zmm5_111 zmm4_111 L0x7fffffffd6f8;
(* vmovdqa64 %zmm5,0x80(%rdi)                      #! EA = L0x7fffffffd800; PC = 0x555555556189 *)
mov L0x7fffffffd800 zmm5_000;
mov L0x7fffffffd808 zmm5_001;
mov L0x7fffffffd810 zmm5_010;
mov L0x7fffffffd818 zmm5_011;
mov L0x7fffffffd820 zmm5_100;
mov L0x7fffffffd828 zmm5_101;
mov L0x7fffffffd830 zmm5_110;
mov L0x7fffffffd838 zmm5_111;
(* vmovdqa64 0xc0(%rsi),%zmm6                      #! EA = L0x7fffffffd5c0; Value = 0x2f2f2f2f2f2f2f2f; PC = 0x555555556190 *)
mov zmm6_000 L0x7fffffffd5c0;
mov zmm6_001 L0x7fffffffd5c8;
mov zmm6_010 L0x7fffffffd5d0;
mov zmm6_011 L0x7fffffffd5d8;
mov zmm6_100 L0x7fffffffd5e0;
mov zmm6_101 L0x7fffffffd5e8;
mov zmm6_110 L0x7fffffffd5f0;
mov zmm6_111 L0x7fffffffd5f8;
(* vpaddq 0xc0(%rdx),%zmm6,%zmm7                   #! EA = L0x7fffffffd700; Value = 0x0000004000000000; PC = 0x555555556197 *)
add zmm7_000 zmm6_000 L0x7fffffffd700;
add zmm7_001 zmm6_001 L0x7fffffffd708;
add zmm7_010 zmm6_010 L0x7fffffffd710;
add zmm7_011 zmm6_011 L0x7fffffffd718;
add zmm7_100 zmm6_100 L0x7fffffffd720;
add zmm7_101 zmm6_101 L0x7fffffffd728;
add zmm7_110 zmm6_110 L0x7fffffffd730;
add zmm7_111 zmm6_111 L0x7fffffffd738;
(* vmovdqa64 %zmm7,0xc0(%rdi)                      #! EA = L0x7fffffffd840; PC = 0x55555555619e *)
mov L0x7fffffffd840 zmm7_000;
mov L0x7fffffffd848 zmm7_001;
mov L0x7fffffffd850 zmm7_010;
mov L0x7fffffffd858 zmm7_011;
mov L0x7fffffffd860 zmm7_100;
mov L0x7fffffffd868 zmm7_101;
mov L0x7fffffffd870 zmm7_110;
mov L0x7fffffffd878 zmm7_111;
(* vmovdqa64 0x100(%rsi),%zmm8                     #! EA = L0x7fffffffd600; Value = 0x0000000000000000; PC = 0x5555555561a5 *)
mov zmm8_000 L0x7fffffffd600;
mov zmm8_001 L0x7fffffffd608;
mov zmm8_010 L0x7fffffffd610;
mov zmm8_011 L0x7fffffffd618;
mov zmm8_100 L0x7fffffffd620;
mov zmm8_101 L0x7fffffffd628;
mov zmm8_110 L0x7fffffffd630;
mov zmm8_111 L0x7fffffffd638;
(* vpaddq 0x100(%rdx),%zmm8,%zmm9                  #! EA = L0x7fffffffd740; Value = 0x0000000000000002; PC = 0x5555555561ac *)
add zmm9_000 zmm8_000 L0x7fffffffd740;
add zmm9_001 zmm8_001 L0x7fffffffd748;
add zmm9_010 zmm8_010 L0x7fffffffd750;
add zmm9_011 zmm8_011 L0x7fffffffd758;
add zmm9_100 zmm8_100 L0x7fffffffd760;
add zmm9_101 zmm8_101 L0x7fffffffd768;
add zmm9_110 zmm8_110 L0x7fffffffd770;
add zmm9_111 zmm8_111 L0x7fffffffd778;
(* vmovdqa64 %zmm9,0x100(%rdi)                     #! EA = L0x7fffffffd880; PC = 0x5555555561b3 *)
mov L0x7fffffffd880 zmm9_000;
mov L0x7fffffffd888 zmm9_001;
mov L0x7fffffffd890 zmm9_010;
mov L0x7fffffffd898 zmm9_011;
mov L0x7fffffffd8a0 zmm9_100;
mov L0x7fffffffd8a8 zmm9_101;
mov L0x7fffffffd8b0 zmm9_110;
mov L0x7fffffffd8b8 zmm9_111;
(* #vzeroupper                                      #! PC = 0x5555555561ba *)
#vzeroupper                                      #! 0x5555555561ba = 0x5555555561ba;
(* #! <- SP = 0x7fffffffd4b8 *)
#! 0x7fffffffd4b8 = 0x7fffffffd4b8;
(* #ret                                            #! PC = 0x5555555561bd *)
#ret                                            #! 0x5555555561bd = 0x5555555561bd;

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
  and
  [
  eq limbs 64 [a00, a01, a02, a03, a04] + limbs 64 [b00, b01, b02, b03, b04]
     limbs 64 [c00, c01, c02, c03, c04],
  eq limbs 64 [a10, a11, a12, a13, a14] + limbs 64 [b10, b11, b12, b13, b14]
     limbs 64 [c10, c11, c12, c13, c14],
  eq limbs 64 [a20, a21, a22, a23, a24] + limbs 64 [b20, b21, b22, b23, b24]
     limbs 64 [c20, c21, c22, c23, c24],
  eq limbs 64 [a30, a31, a32, a33, a34] + limbs 64 [b30, b31, b32, b33, b34]
     limbs 64 [c30, c31, c32, c33, c34],
  eq limbs 64 [a40, a41, a42, a43, a44] + limbs 64 [b40, b41, b42, b43, b44]
     limbs 64 [c40, c41, c42, c43, c44],
  eq limbs 64 [a50, a51, a52, a53, a54] + limbs 64 [b50, b51, b52, b53, b54]
     limbs 64 [c50, c51, c52, c53, c54],
  eq limbs 64 [a60, a61, a62, a63, a64] + limbs 64 [b60, b61, b62, b63, b64]
     limbs 64 [c60, c61, c62, c63, c64],
  eq limbs 64 [a70, a71, a72, a73, a74] + limbs 64 [b70, b71, b72, b73, b74]
     limbs 64 [c70, c71, c72, c73, c74]
  ] &&
    and [
      c00 <=u 0x10000000000cc4@64, c01 <=u 0x10000000000000@64, c02 <=u 0x10000000000066@64, c03 <=u 0x10000000000000@64, c04 <=u 0x10000000000096@64, 
      c10 <=u 0x10000000000cc4@64, c11 <=u 0x10000000000000@64, c12 <=u 0x10000000000066@64, c13 <=u 0x10000000000000@64, c14 <=u 0x10000000000096@64, 
      c20 <=u 0x10000000000cc4@64, c21 <=u 0x10000000000000@64, c22 <=u 0x10000000000066@64, c23 <=u 0x10000000000000@64, c24 <=u 0x10000000000096@64, 
      c30 <=u 0x10000000000cc4@64, c31 <=u 0x10000000000000@64, c32 <=u 0x10000000000066@64, c33 <=u 0x10000000000000@64, c34 <=u 0x10000000000096@64, 
      c40 <=u 0x10000000000cc4@64, c41 <=u 0x10000000000000@64, c42 <=u 0x10000000000066@64, c43 <=u 0x10000000000000@64, c44 <=u 0x10000000000096@64, 
      c50 <=u 0x10000000000cc4@64, c51 <=u 0x10000000000000@64, c52 <=u 0x10000000000066@64, c53 <=u 0x10000000000000@64, c54 <=u 0x10000000000096@64, 
      c60 <=u 0x10000000000cc4@64, c61 <=u 0x10000000000000@64, c62 <=u 0x10000000000066@64, c63 <=u 0x10000000000000@64, c64 <=u 0x10000000000096@64, 
      c70 <=u 0x10000000000cc4@64, c71 <=u 0x10000000000000@64, c72 <=u 0x10000000000066@64, c73 <=u 0x10000000000000@64, c74 <=u 0x10000000000096@64
  ]
}

