(*
cv -v -disable_safety carry_fp255_8x1w.cl
Parsing CryptoLine file:		        [OK]		0.001024 seconds
Checking well-formedness:		        [OK]		0.000604 seconds
Transforming to SSA form:		        [OK]		0.000128 seconds
Normalizing specification:		      [OK]		0.000121 seconds
Rewriting assignments:			        [OK]		0.000189 seconds
Verifying range assertions:		      [OK]		0.046620 seconds
Verifying range specification:		  [OK]		0.000019 seconds
Rewriting value-preserved casting:	[OK]		0.000011 seconds
Verifying algebraic assertions:		  [OK]		0.017594 seconds
Verifying algebraic specification:	[OK]		0.000010 seconds
Verification result:			          [OK]		0.066549 seconds
*)

proc main (uint64 a00, uint64 a10, uint64 a20, uint64 a30, uint64 a40, uint64 a50, uint64 a60, uint64 a70,
           uint64 a01, uint64 a11, uint64 a21, uint64 a31, uint64 a41, uint64 a51, uint64 a61, uint64 a71,
           uint64 a02, uint64 a12, uint64 a22, uint64 a32, uint64 a42, uint64 a52, uint64 a62, uint64 a72,
           uint64 a03, uint64 a13, uint64 a23, uint64 a33, uint64 a43, uint64 a53, uint64 a63, uint64 a73,
           uint64 a04, uint64 a14, uint64 a24, uint64 a34, uint64 a44, uint64 a54, uint64 a64, uint64 a74,
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
        a70 <=u 0xfffffffffffff@64, a71 <=u 0xfffffffffffff@64, a72 <=u 0xfffffffffffff@64, a73 <=u 0xfffffffffffff@64, a74 <=u 0xfffffffffffff@64
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
mov L0x7fffffffd8c0 a00;
mov L0x7fffffffd8c8 a10;
mov L0x7fffffffd8d0 a20;
mov L0x7fffffffd8d8 a30;
mov L0x7fffffffd8e0 a40;
mov L0x7fffffffd8e8 a50;
mov L0x7fffffffd8f0 a60;
mov L0x7fffffffd8f8 a70;
mov L0x7fffffffd900 a01;
mov L0x7fffffffd908 a11;
mov L0x7fffffffd910 a21;
mov L0x7fffffffd918 a31;
mov L0x7fffffffd920 a41;
mov L0x7fffffffd928 a51;
mov L0x7fffffffd930 a61;
mov L0x7fffffffd938 a71;
mov L0x7fffffffd940 a02;
mov L0x7fffffffd948 a12;
mov L0x7fffffffd950 a22;
mov L0x7fffffffd958 a32;
mov L0x7fffffffd960 a42;
mov L0x7fffffffd968 a52;
mov L0x7fffffffd970 a62;
mov L0x7fffffffd978 a72;
mov L0x7fffffffd980 a03;
mov L0x7fffffffd988 a13;
mov L0x7fffffffd990 a23;
mov L0x7fffffffd998 a33;
mov L0x7fffffffd9a0 a43;
mov L0x7fffffffd9a8 a53;
mov L0x7fffffffd9b0 a63;
mov L0x7fffffffd9b8 a73;
mov L0x7fffffffd9c0 a04;
mov L0x7fffffffd9c8 a14;
mov L0x7fffffffd9d0 a24;
mov L0x7fffffffd9d8 a34;
mov L0x7fffffffd9e0 a44;
mov L0x7fffffffd9e8 a54;
mov L0x7fffffffd9f0 a64;
mov L0x7fffffffd9f8 a74;

(* #! -> SP = 0x7fffffffd5f8 *)
#! 0x7fffffffd5f8 = 0x7fffffffd5f8;
(* # endbr64                                         #! PC = 0x5555555571c0 *)
# endbr64                                         #! 0x5555555571c0 = 0x5555555571c0;
(* vpsrlq $0x33,(%rdi),%zmm1                       #! EA = L0x7fffffffd8c0; Value = 0x000f80000803c702; PC = 0x5555555571c4 *)
split L0x7fffffffd8c0_h L0x7fffffffd8c0_l L0x7fffffffd8c0 51;
split L0x7fffffffd8c8_h L0x7fffffffd8c8_l L0x7fffffffd8c8 51;
split L0x7fffffffd8d0_h L0x7fffffffd8d0_l L0x7fffffffd8d0 51;
split L0x7fffffffd8d8_h L0x7fffffffd8d8_l L0x7fffffffd8d8 51;
split L0x7fffffffd8e0_h L0x7fffffffd8e0_l L0x7fffffffd8e0 51;
split L0x7fffffffd8e8_h L0x7fffffffd8e8_l L0x7fffffffd8e8 51;
split L0x7fffffffd8f0_h L0x7fffffffd8f0_l L0x7fffffffd8f0 51;
split L0x7fffffffd8f8_h L0x7fffffffd8f8_l L0x7fffffffd8f8 51;
mov zmm1_000 L0x7fffffffd8c0_h;
mov zmm1_001 L0x7fffffffd8c8_h;
mov zmm1_010 L0x7fffffffd8d0_h;
mov zmm1_011 L0x7fffffffd8d8_h;
mov zmm1_100 L0x7fffffffd8e0_h;
mov zmm1_101 L0x7fffffffd8e8_h;
mov zmm1_110 L0x7fffffffd8f0_h;
mov zmm1_111 L0x7fffffffd8f8_h;
(* vpsrlq $0x33,0x80(%rdi),%zmm0                   #! EA = L0x7fffffffd940; Value = 0x000ffffffffffffe; PC = 0x5555555571cb *)
split L0x7fffffffd940_h L0x7fffffffd940_l L0x7fffffffd940 51;
split L0x7fffffffd948_h L0x7fffffffd948_l L0x7fffffffd948 51;
split L0x7fffffffd950_h L0x7fffffffd950_l L0x7fffffffd950 51;
split L0x7fffffffd958_h L0x7fffffffd958_l L0x7fffffffd958 51;
split L0x7fffffffd960_h L0x7fffffffd960_l L0x7fffffffd960 51;
split L0x7fffffffd968_h L0x7fffffffd968_l L0x7fffffffd968 51;
split L0x7fffffffd970_h L0x7fffffffd970_l L0x7fffffffd970 51;
split L0x7fffffffd978_h L0x7fffffffd978_l L0x7fffffffd978 51;
mov zmm0_000 L0x7fffffffd940_h;
mov zmm0_001 L0x7fffffffd948_h;
mov zmm0_010 L0x7fffffffd950_h;
mov zmm0_011 L0x7fffffffd958_h;
mov zmm0_100 L0x7fffffffd960_h;
mov zmm0_101 L0x7fffffffd968_h;
mov zmm0_110 L0x7fffffffd970_h;
mov zmm0_111 L0x7fffffffd978_h;
(* vmovdqa32 0x12f63(%rip),%zmm2        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x5555555571d3 *)
mov zmm2_000 L0x55555556a140;
mov zmm2_001 L0x55555556a148;
mov zmm2_010 L0x55555556a150;
mov zmm2_011 L0x55555556a158;
mov zmm2_100 L0x55555556a160;
mov zmm2_101 L0x55555556a168;
mov zmm2_110 L0x55555556a170;
mov zmm2_111 L0x55555556a178;
(* vpaddq 0x40(%rdi),%zmm1,%zmm5                   #! EA = L0x7fffffffd900; Value = 0x000ffffffffffffe; PC = 0x5555555571dd *)
add zmm5_000 zmm1_000 L0x7fffffffd900;
add zmm5_001 zmm1_001 L0x7fffffffd908;
add zmm5_010 zmm1_010 L0x7fffffffd910;
add zmm5_011 zmm1_011 L0x7fffffffd918;
add zmm5_100 zmm1_100 L0x7fffffffd920;
add zmm5_101 zmm1_101 L0x7fffffffd928;
add zmm5_110 zmm1_110 L0x7fffffffd930;
add zmm5_111 zmm1_111 L0x7fffffffd938;
(* vpaddq 0xc0(%rdi),%zmm0,%zmm6                   #! EA = L0x7fffffffd980; Value = 0x000ffffffffffffe; PC = 0x5555555571e4 *)
add zmm6_000 zmm0_000 L0x7fffffffd980;
add zmm6_001 zmm0_001 L0x7fffffffd988;
add zmm6_010 zmm0_010 L0x7fffffffd990;
add zmm6_011 zmm0_011 L0x7fffffffd998;
add zmm6_100 zmm0_100 L0x7fffffffd9a0;
add zmm6_101 zmm0_101 L0x7fffffffd9a8;
add zmm6_110 zmm0_110 L0x7fffffffd9b0;
add zmm6_111 zmm0_111 L0x7fffffffd9b8;
(* vpsrlq $0x33,0x100(%rdi),%zmm3                  #! EA = L0x7fffffffd9c0; Value = 0x000f80000835137e; PC = 0x5555555571eb *)
split L0x7fffffffd9c0_h L0x7fffffffd9c0_l L0x7fffffffd9c0 51;
split L0x7fffffffd9c8_h L0x7fffffffd9c8_l L0x7fffffffd9c8 51;
split L0x7fffffffd9d0_h L0x7fffffffd9d0_l L0x7fffffffd9d0 51;
split L0x7fffffffd9d8_h L0x7fffffffd9d8_l L0x7fffffffd9d8 51;
split L0x7fffffffd9e0_h L0x7fffffffd9e0_l L0x7fffffffd9e0 51;
split L0x7fffffffd9e8_h L0x7fffffffd9e8_l L0x7fffffffd9e8 51;
split L0x7fffffffd9f0_h L0x7fffffffd9f0_l L0x7fffffffd9f0 51;
split L0x7fffffffd9f8_h L0x7fffffffd9f8_l L0x7fffffffd9f8 51;
mov zmm3_000 L0x7fffffffd9c0_h;
mov zmm3_001 L0x7fffffffd9c8_h;
mov zmm3_010 L0x7fffffffd9d0_h;
mov zmm3_011 L0x7fffffffd9d8_h;
mov zmm3_100 L0x7fffffffd9e0_h;
mov zmm3_101 L0x7fffffffd9e8_h;
mov zmm3_110 L0x7fffffffd9f0_h;
mov zmm3_111 L0x7fffffffd9f8_h;
(* vpandd (%rdi),%zmm2,%zmm4                       #! EA = L0x7fffffffd8c0; Value = 0x000f80000803c702; PC = 0x5555555571f3 *)
mov zmm4_000 L0x7fffffffd8c0_l;
mov zmm4_001 L0x7fffffffd8c8_l;
mov zmm4_010 L0x7fffffffd8d0_l;
mov zmm4_011 L0x7fffffffd8d8_l;
mov zmm4_100 L0x7fffffffd8e0_l;
mov zmm4_101 L0x7fffffffd8e8_l;
mov zmm4_110 L0x7fffffffd8f0_l;
mov zmm4_111 L0x7fffffffd8f8_l;
(* vpandd 0x80(%rdi),%zmm2,%zmm10                  #! EA = L0x7fffffffd940; Value = 0x000ffffffffffffe; PC = 0x5555555571f9 *)
mov zmm10_000 L0x7fffffffd940_l;
mov zmm10_001 L0x7fffffffd948_l;
mov zmm10_010 L0x7fffffffd950_l;
mov zmm10_011 L0x7fffffffd958_l;
mov zmm10_100 L0x7fffffffd960_l;
mov zmm10_101 L0x7fffffffd968_l;
mov zmm10_110 L0x7fffffffd970_l;
mov zmm10_111 L0x7fffffffd978_l;
(* vpandd 0x100(%rdi),%zmm2,%zmm14                 #! EA = L0x7fffffffd9c0; Value = 0x000f80000835137e; PC = 0x555555557200 *)
mov zmm14_000 L0x7fffffffd9c0_l;
mov zmm14_001 L0x7fffffffd9c8_l;
mov zmm14_010 L0x7fffffffd9d0_l;
mov zmm14_011 L0x7fffffffd9d8_l;
mov zmm14_100 L0x7fffffffd9e0_l;
mov zmm14_101 L0x7fffffffd9e8_l;
mov zmm14_110 L0x7fffffffd9f0_l;
mov zmm14_111 L0x7fffffffd9f8_l;
(* vpsrlq $0x33,%zmm5,%zmm9                        #! PC = 0x555555557207 *)
split zmm5_000_h zmm5_000_l zmm5_000 51;
split zmm5_001_h zmm5_001_l zmm5_001 51;
split zmm5_010_h zmm5_010_l zmm5_010 51;
split zmm5_011_h zmm5_011_l zmm5_011 51;
split zmm5_100_h zmm5_100_l zmm5_100 51;
split zmm5_101_h zmm5_101_l zmm5_101 51;
split zmm5_110_h zmm5_110_l zmm5_110 51;
split zmm5_111_h zmm5_111_l zmm5_111 51;
mov zmm9_000 zmm5_000_h;
mov zmm9_001 zmm5_001_h;
mov zmm9_010 zmm5_010_h;
mov zmm9_011 zmm5_011_h;
mov zmm9_100 zmm5_100_h;
mov zmm9_101 zmm5_101_h;
mov zmm9_110 zmm5_110_h;
mov zmm9_111 zmm5_111_h;
(* vpsrlq $0x33,%zmm6,%zmm13                       #! PC = 0x55555555720e *)
split zmm6_000_h zmm6_000_l zmm6_000 51;
split zmm6_001_h zmm6_001_l zmm6_001 51;
split zmm6_010_h zmm6_010_l zmm6_010 51;
split zmm6_011_h zmm6_011_l zmm6_011 51;
split zmm6_100_h zmm6_100_l zmm6_100 51;
split zmm6_101_h zmm6_101_l zmm6_101 51;
split zmm6_110_h zmm6_110_l zmm6_110 51;
split zmm6_111_h zmm6_111_l zmm6_111 51;
mov zmm13_000 zmm6_000_h;
mov zmm13_001 zmm6_001_h;
mov zmm13_010 zmm6_010_h;
mov zmm13_011 zmm6_011_h;
mov zmm13_100 zmm6_100_h;
mov zmm13_101 zmm6_101_h;
mov zmm13_110 zmm6_110_h;
mov zmm13_111 zmm6_111_h;
(* vpaddq %zmm10,%zmm9,%zmm11                      #! PC = 0x555555557215 *)
add zmm11_000 zmm9_000 zmm10_000;
add zmm11_001 zmm9_001 zmm10_001;
add zmm11_010 zmm9_010 zmm10_010;
add zmm11_011 zmm9_011 zmm10_011;
add zmm11_100 zmm9_100 zmm10_100;
add zmm11_101 zmm9_101 zmm10_101;
add zmm11_110 zmm9_110 zmm10_110;
add zmm11_111 zmm9_111 zmm10_111;
(* vpandd %zmm2,%zmm5,%zmm12                       #! PC = 0x55555555721b *)
mov zmm12_000 zmm5_000_l;
mov zmm12_001 zmm5_001_l;
mov zmm12_010 zmm5_010_l;
mov zmm12_011 zmm5_011_l;
mov zmm12_100 zmm5_100_l;
mov zmm12_101 zmm5_101_l;
mov zmm12_110 zmm5_110_l;
mov zmm12_111 zmm5_111_l;
(* vpaddq %zmm14,%zmm13,%zmm15                     #! PC = 0x555555557221 *)
add zmm15_000 zmm13_000 zmm14_000;
add zmm15_001 zmm13_001 zmm14_001;
add zmm15_010 zmm13_010 zmm14_010;
add zmm15_011 zmm13_011 zmm14_011;
add zmm15_100 zmm13_100 zmm14_100;
add zmm15_101 zmm13_101 zmm14_101;
add zmm15_110 zmm13_110 zmm14_110;
add zmm15_111 zmm13_111 zmm14_111;
(* vpandd %zmm2,%zmm6,%zmm1                        #! PC = 0x555555557227 *)
mov zmm1_000 zmm6_000_l;
mov zmm1_001 zmm6_001_l;
mov zmm1_010 zmm6_010_l;
mov zmm1_011 zmm6_011_l;
mov zmm1_100 zmm6_100_l;
mov zmm1_101 zmm6_101_l;
mov zmm1_110 zmm6_110_l;
mov zmm1_111 zmm6_111_l;
(* vpmuludq 0x12ec9(%rip),%zmm3,%zmm7        # 0x55555556a100#! EA = L0x55555556a100; Value = 0x0000000000000013; PC = 0x55555555722d *)
mul zmm7_000 zmm3_000 L0x55555556a100;
mul zmm7_001 zmm3_001 L0x55555556a100;
mul zmm7_010 zmm3_010 L0x55555556a100;
mul zmm7_011 zmm3_011 L0x55555556a100;
mul zmm7_100 zmm3_100 L0x55555556a100;
mul zmm7_101 zmm3_101 L0x55555556a100;
mul zmm7_110 zmm3_110 L0x55555556a100;
mul zmm7_111 zmm3_111 L0x55555556a100;
(* vpaddq %zmm4,%zmm7,%zmm8                        #! PC = 0x555555557237 *)
add zmm8_000 zmm7_000 zmm4_000;
add zmm8_001 zmm7_001 zmm4_001;
add zmm8_010 zmm7_010 zmm4_010;
add zmm8_011 zmm7_011 zmm4_011;
add zmm8_100 zmm7_100 zmm4_100;
add zmm8_101 zmm7_101 zmm4_101;
add zmm8_110 zmm7_110 zmm4_110;
add zmm8_111 zmm7_111 zmm4_111;
(* vmovdqa64 %zmm8,(%rdi)                          #! EA = L0x7fffffffd8c0; PC = 0x55555555723d *)
mov L0x7fffffffd8c0 zmm8_000;
mov L0x7fffffffd8c8 zmm8_001;
mov L0x7fffffffd8d0 zmm8_010;
mov L0x7fffffffd8d8 zmm8_011;
mov L0x7fffffffd8e0 zmm8_100;
mov L0x7fffffffd8e8 zmm8_101;
mov L0x7fffffffd8f0 zmm8_110;
mov L0x7fffffffd8f8 zmm8_111;
(* vmovdqa64 %zmm11,0x80(%rdi)                     #! EA = L0x7fffffffd940; PC = 0x555555557243 *)
mov L0x7fffffffd940 zmm11_000;
mov L0x7fffffffd948 zmm11_001;
mov L0x7fffffffd950 zmm11_010;
mov L0x7fffffffd958 zmm11_011;
mov L0x7fffffffd960 zmm11_100;
mov L0x7fffffffd968 zmm11_101;
mov L0x7fffffffd970 zmm11_110;
mov L0x7fffffffd978 zmm11_111;
(* vmovdqa32 %zmm12,0x40(%rdi)                     #! EA = L0x7fffffffd900; PC = 0x55555555724a *)
mov L0x7fffffffd900 zmm12_000;
mov L0x7fffffffd908 zmm12_001;
mov L0x7fffffffd910 zmm12_010;
mov L0x7fffffffd918 zmm12_011;
mov L0x7fffffffd920 zmm12_100;
mov L0x7fffffffd928 zmm12_101;
mov L0x7fffffffd930 zmm12_110;
mov L0x7fffffffd938 zmm12_111;
(* vmovdqa64 %zmm15,0x100(%rdi)                    #! EA = L0x7fffffffd9c0; PC = 0x555555557251 *)
mov L0x7fffffffd9c0 zmm15_000;
mov L0x7fffffffd9c8 zmm15_001;
mov L0x7fffffffd9d0 zmm15_010;
mov L0x7fffffffd9d8 zmm15_011;
mov L0x7fffffffd9e0 zmm15_100;
mov L0x7fffffffd9e8 zmm15_101;
mov L0x7fffffffd9f0 zmm15_110;
mov L0x7fffffffd9f8 zmm15_111;
(* vmovdqa32 %zmm1,0xc0(%rdi)                      #! EA = L0x7fffffffd980; PC = 0x555555557258 *)
mov L0x7fffffffd980 zmm1_000;
mov L0x7fffffffd988 zmm1_001;
mov L0x7fffffffd990 zmm1_010;
mov L0x7fffffffd998 zmm1_011;
mov L0x7fffffffd9a0 zmm1_100;
mov L0x7fffffffd9a8 zmm1_101;
mov L0x7fffffffd9b0 zmm1_110;
mov L0x7fffffffd9b8 zmm1_111;
(* #! <- SP = 0x7fffffffd5f8 *)
#! 0x7fffffffd5f8 = 0x7fffffffd5f8;
(* #ret                                            #! PC = 0x555555557262 *)
#ret                                            #! 0x555555557262 = 0x555555557262;

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

assert and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
                  limbs 51 [a00, a01, a02, a03, a04]
                  p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
                  limbs 51 [a10, a11, a12, a13, a14]
                  p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
                  limbs 51 [a20, a21, a22, a23, a24]
                  p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
                  limbs 51 [a30, a31, a32, a33, a34]
                  p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
                  limbs 51 [a40, a41, a42, a43, a44]
                  p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
                  limbs 51 [a50, a51, a52, a53, a54]
                  p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
                  limbs 51 [a60, a61, a62, a63, a64]
                  p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
                  limbs 51 [a70, a71, a72, a73, a74]
                  p
] && true;

assert true &&
  and [
      c00 <u 0x8000000000026@64, c01 <u 0x8000000000000@64, c02 <u 0x8000000000002@64, c03 <u 0x8000000000000@64, c04 <u 0x8000000000002@64,
      c10 <u 0x8000000000026@64, c11 <u 0x8000000000000@64, c12 <u 0x8000000000002@64, c13 <u 0x8000000000000@64, c14 <u 0x8000000000002@64,
      c20 <u 0x8000000000026@64, c21 <u 0x8000000000000@64, c22 <u 0x8000000000002@64, c23 <u 0x8000000000000@64, c24 <u 0x8000000000002@64,
      c30 <u 0x8000000000026@64, c31 <u 0x8000000000000@64, c32 <u 0x8000000000002@64, c33 <u 0x8000000000000@64, c34 <u 0x8000000000002@64,
      c40 <u 0x8000000000026@64, c41 <u 0x8000000000000@64, c42 <u 0x8000000000002@64, c43 <u 0x8000000000000@64, c44 <u 0x8000000000002@64,
      c50 <u 0x8000000000026@64, c51 <u 0x8000000000000@64, c52 <u 0x8000000000002@64, c53 <u 0x8000000000000@64, c54 <u 0x8000000000002@64,
      c60 <u 0x8000000000026@64, c61 <u 0x8000000000000@64, c62 <u 0x8000000000002@64, c63 <u 0x8000000000000@64, c64 <u 0x8000000000002@64,
      c70 <u 0x8000000000026@64, c71 <u 0x8000000000000@64, c72 <u 0x8000000000002@64, c73 <u 0x8000000000000@64, c74 <u 0x8000000000002@64
  ];

{
  true
  &&
  true
}

