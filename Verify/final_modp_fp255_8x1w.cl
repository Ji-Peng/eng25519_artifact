(*
cv -v -disable_safety final_modp_fp255_8x1w_3.cl
Parsing CryptoLine file:                [OK]            0.003372 seconds
Checking well-formedness:               [OK]            0.000493 seconds
Transforming to SSA form:               [OK]            0.000323 seconds
Normalizing specification:              [OK]            0.000416 seconds
Rewriting assignments:                  [OK]            0.000327 seconds
Verifying range assertions:             [OK]            3.588487 seconds
Verifying range specification:          [OK]            0.000044 seconds
Rewriting value-preserved casting:      [OK]            0.000029 seconds
Verifying algebraic assertions:         [OK]            0.000021 seconds
Verifying algebraic specification:      [OK]            0.000067 seconds
Verification result:                    [OK]            3.594275 seconds
*)

proc main (int64 a00, int64 a10, int64 a20, int64 a30, int64 a40, int64 a50, int64 a60, int64 a70,
           int64 a01, int64 a11, int64 a21, int64 a31, int64 a41, int64 a51, int64 a61, int64 a71,
           int64 a02, int64 a12, int64 a22, int64 a32, int64 a42, int64 a52, int64 a62, int64 a72,
           int64 a03, int64 a13, int64 a23, int64 a33, int64 a43, int64 a53, int64 a63, int64 a73,
           int64 a04, int64 a14, int64 a24, int64 a34, int64 a44, int64 a54, int64 a64, int64 a74,
           uint268 p) =
{
  and [
    p = 0x007fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed
  ]
  &&
  and [
        p = 0x07fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed@268,
        a00 <u 0x8000000000662@64, a01 <u 0x8000000000000@64, a02 <u 0x8000000000033@64, a03 <u 0x8000000000000@64, a04 <u 0x800000000004b@64, 
        a10 <u 0x8000000000662@64, a11 <u 0x8000000000000@64, a12 <u 0x8000000000033@64, a13 <u 0x8000000000000@64, a14 <u 0x800000000004b@64, 
        a20 <u 0x8000000000662@64, a21 <u 0x8000000000000@64, a22 <u 0x8000000000033@64, a23 <u 0x8000000000000@64, a24 <u 0x800000000004b@64, 
        a30 <u 0x8000000000662@64, a31 <u 0x8000000000000@64, a32 <u 0x8000000000033@64, a33 <u 0x8000000000000@64, a34 <u 0x800000000004b@64, 
        a40 <u 0x8000000000662@64, a41 <u 0x8000000000000@64, a42 <u 0x8000000000033@64, a43 <u 0x8000000000000@64, a44 <u 0x800000000004b@64, 
        a50 <u 0x8000000000662@64, a51 <u 0x8000000000000@64, a52 <u 0x8000000000033@64, a53 <u 0x8000000000000@64, a54 <u 0x800000000004b@64,
        a60 <u 0x8000000000662@64, a61 <u 0x8000000000000@64, a62 <u 0x8000000000033@64, a63 <u 0x8000000000000@64, a64 <u 0x800000000004b@64,
        a70 <u 0x8000000000662@64, a71 <u 0x8000000000000@64, a72 <u 0x8000000000033@64, a73 <u 0x8000000000000@64, a74 <u 0x800000000004b@64
      ]
}

mov L0x55555556a140 0x0007ffffffffffff@int64;
mov L0x55555556a148 0x0007ffffffffffff@int64;
mov L0x55555556a150 0x0007ffffffffffff@int64;
mov L0x55555556a158 0x0007ffffffffffff@int64;
mov L0x55555556a160 0x0007ffffffffffff@int64;
mov L0x55555556a168 0x0007ffffffffffff@int64;
mov L0x55555556a170 0x0007ffffffffffff@int64;
mov L0x55555556a178 0x0007ffffffffffff@int64;
mov L0x55555556a1c0 0x0007ffffffffffed@int64;
mov L0x55555556a1c8 0x0007ffffffffffed@int64;
mov L0x55555556a1d0 0x0007ffffffffffed@int64;
mov L0x55555556a1d8 0x0007ffffffffffed@int64;
mov L0x55555556a1e0 0x0007ffffffffffed@int64;
mov L0x55555556a1e8 0x0007ffffffffffed@int64;
mov L0x55555556a1f0 0x0007ffffffffffed@int64;
mov L0x55555556a1f8 0x0007ffffffffffed@int64;
mov L0x55555556a210 0xfff8000000000013@int64;
mov L0x55555556a218 0xfff8000000000001@int64;

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
(* vpbroadcastq 0x12f22(%rip),%zmm4        # 0x55555556a210#! EA = L0x55555556a210; Value = 0xfff8000000000013; PC = 0x5555555572e4 *)
mov zmm4_000 L0x55555556a210;
mov zmm4_001 L0x55555556a210;
mov zmm4_010 L0x55555556a210;
mov zmm4_011 L0x55555556a210;
mov zmm4_100 L0x55555556a210;
mov zmm4_101 L0x55555556a210;
mov zmm4_110 L0x55555556a210;
mov zmm4_111 L0x55555556a210;
(* vpbroadcastq 0x12f20(%rip),%zmm0        # 0x55555556a218#! EA = L0x55555556a218; Value = 0xfff8000000000001; PC = 0x5555555572ee *)
mov zmm0_000 L0x55555556a218;
mov zmm0_001 L0x55555556a218;
mov zmm0_010 L0x55555556a218;
mov zmm0_011 L0x55555556a218;
mov zmm0_100 L0x55555556a218;
mov zmm0_101 L0x55555556a218;
mov zmm0_110 L0x55555556a218;
mov zmm0_111 L0x55555556a218;
(* vpaddq (%rdi),%zmm4,%zmm7                       #! EA = L0x7fffffffd8c0; Value = 0x00007ffff7ffdaf0; PC = 0x5555555572f8 *)
add zmm7_000 zmm4_000 L0x7fffffffd8c0;
add zmm7_001 zmm4_001 L0x7fffffffd8c8;
add zmm7_010 zmm4_010 L0x7fffffffd8d0;
add zmm7_011 zmm4_011 L0x7fffffffd8d8;
add zmm7_100 zmm4_100 L0x7fffffffd8e0;
add zmm7_101 zmm4_101 L0x7fffffffd8e8;
add zmm7_110 zmm4_110 L0x7fffffffd8f0;
add zmm7_111 zmm4_111 L0x7fffffffd8f8;
(* vpaddq 0x40(%rdi),%zmm0,%zmm2                   #! EA = L0x7fffffffd900; Value = 0x0000000000000000; PC = 0x5555555572fe *)
add zmm2_000 zmm0_000 L0x7fffffffd900;
add zmm2_001 zmm0_001 L0x7fffffffd908;
add zmm2_010 zmm0_010 L0x7fffffffd910;
add zmm2_011 zmm0_011 L0x7fffffffd918;
add zmm2_100 zmm0_100 L0x7fffffffd920;
add zmm2_101 zmm0_101 L0x7fffffffd928;
add zmm2_110 zmm0_110 L0x7fffffffd930;
add zmm2_111 zmm0_111 L0x7fffffffd938;
(* vpsraq $0x33,%zmm7,%zmm3                        #! PC = 0x555555557305 *)
ssplit zmm7_000_h zmm7_000_l zmm7_000 51;
ssplit zmm7_001_h zmm7_001_l zmm7_001 51;
ssplit zmm7_010_h zmm7_010_l zmm7_010 51;
ssplit zmm7_011_h zmm7_011_l zmm7_011 51;
ssplit zmm7_100_h zmm7_100_l zmm7_100 51;
ssplit zmm7_101_h zmm7_101_l zmm7_101 51;
ssplit zmm7_110_h zmm7_110_l zmm7_110 51;
ssplit zmm7_111_h zmm7_111_l zmm7_111 51;
mov zmm3_000 zmm7_000_h;
mov zmm3_001 zmm7_001_h;
mov zmm3_010 zmm7_010_h;
mov zmm3_011 zmm7_011_h;
mov zmm3_100 zmm7_100_h;
mov zmm3_101 zmm7_101_h;
mov zmm3_110 zmm7_110_h;
mov zmm3_111 zmm7_111_h;
(* vpaddq 0x80(%rdi),%zmm0,%zmm1                   #! EA = L0x7fffffffd940; Value = 0x00072f2f2f2f2f2f; PC = 0x55555555730c *)
add zmm1_000 zmm0_000 L0x7fffffffd940;
add zmm1_001 zmm0_001 L0x7fffffffd948;
add zmm1_010 zmm0_010 L0x7fffffffd950;
add zmm1_011 zmm0_011 L0x7fffffffd958;
add zmm1_100 zmm0_100 L0x7fffffffd960;
add zmm1_101 zmm0_101 L0x7fffffffd968;
add zmm1_110 zmm0_110 L0x7fffffffd970;
add zmm1_111 zmm0_111 L0x7fffffffd978;
(* vpaddq %zmm2,%zmm3,%zmm8                        #! PC = 0x555555557313 *)
add zmm8_000 zmm3_000 zmm2_000;
add zmm8_001 zmm3_001 zmm2_001;
add zmm8_010 zmm3_010 zmm2_010;
add zmm8_011 zmm3_011 zmm2_011;
add zmm8_100 zmm3_100 zmm2_100;
add zmm8_101 zmm3_101 zmm2_101;
add zmm8_110 zmm3_110 zmm2_110;
add zmm8_111 zmm3_111 zmm2_111;
(* vpsraq $0x33,%zmm8,%zmm6                        #! PC = 0x555555557319 *)
ssplit zmm8_000_h zmm8_000_l zmm8_000 51;
ssplit zmm8_001_h zmm8_001_l zmm8_001 51;
ssplit zmm8_010_h zmm8_010_l zmm8_010 51;
ssplit zmm8_011_h zmm8_011_l zmm8_011 51;
ssplit zmm8_100_h zmm8_100_l zmm8_100 51;
ssplit zmm8_101_h zmm8_101_l zmm8_101 51;
ssplit zmm8_110_h zmm8_110_l zmm8_110 51;
ssplit zmm8_111_h zmm8_111_l zmm8_111 51;
mov zmm6_000 zmm8_000_h;
mov zmm6_001 zmm8_001_h;
mov zmm6_010 zmm8_010_h;
mov zmm6_011 zmm8_011_h;
mov zmm6_100 zmm8_100_h;
mov zmm6_101 zmm8_101_h;
mov zmm6_110 zmm8_110_h;
mov zmm6_111 zmm8_111_h;
(* vpaddq 0xc0(%rdi),%zmm0,%zmm5                   #! EA = L0x7fffffffd980; Value = 0x00000000000005e5; PC = 0x555555557320 *)
add zmm5_000 zmm0_000 L0x7fffffffd980;
add zmm5_001 zmm0_001 L0x7fffffffd988;
add zmm5_010 zmm0_010 L0x7fffffffd990;
add zmm5_011 zmm0_011 L0x7fffffffd998;
add zmm5_100 zmm0_100 L0x7fffffffd9a0;
add zmm5_101 zmm0_101 L0x7fffffffd9a8;
add zmm5_110 zmm0_110 L0x7fffffffd9b0;
add zmm5_111 zmm0_111 L0x7fffffffd9b8;
(* vpaddq %zmm1,%zmm6,%zmm9                        #! PC = 0x555555557327 *)
add zmm9_000 zmm6_000 zmm1_000;
add zmm9_001 zmm6_001 zmm1_001;
add zmm9_010 zmm6_010 zmm1_010;
add zmm9_011 zmm6_011 zmm1_011;
add zmm9_100 zmm6_100 zmm1_100;
add zmm9_101 zmm6_101 zmm1_101;
add zmm9_110 zmm6_110 zmm1_110;
add zmm9_111 zmm6_111 zmm1_111;
(* vpsraq $0x33,%zmm9,%zmm10                       #! PC = 0x55555555732d *)
ssplit zmm9_000_h zmm9_000_l zmm9_000 51;
ssplit zmm9_001_h zmm9_001_l zmm9_001 51;
ssplit zmm9_010_h zmm9_010_l zmm9_010 51;
ssplit zmm9_011_h zmm9_011_l zmm9_011 51;
ssplit zmm9_100_h zmm9_100_l zmm9_100 51;
ssplit zmm9_101_h zmm9_101_l zmm9_101 51;
ssplit zmm9_110_h zmm9_110_l zmm9_110 51;
ssplit zmm9_111_h zmm9_111_l zmm9_111 51;
mov zmm10_000 zmm9_000_h;
mov zmm10_001 zmm9_001_h;
mov zmm10_010 zmm9_010_h;
mov zmm10_011 zmm9_011_h;
mov zmm10_100 zmm9_100_h;
mov zmm10_101 zmm9_101_h;
mov zmm10_110 zmm9_110_h;
mov zmm10_111 zmm9_111_h;
(* vpaddq 0x100(%rdi),%zmm0,%zmm13                 #! EA = L0x7fffffffd9c0; Value = 0x0000000000000000; PC = 0x555555557334 *)
add zmm13_000 zmm0_000 L0x7fffffffd9c0;
add zmm13_001 zmm0_001 L0x7fffffffd9c8;
add zmm13_010 zmm0_010 L0x7fffffffd9d0;
add zmm13_011 zmm0_011 L0x7fffffffd9d8;
add zmm13_100 zmm0_100 L0x7fffffffd9e0;
add zmm13_101 zmm0_101 L0x7fffffffd9e8;
add zmm13_110 zmm0_110 L0x7fffffffd9f0;
add zmm13_111 zmm0_111 L0x7fffffffd9f8;
(* vpaddq %zmm5,%zmm10,%zmm11                      #! PC = 0x55555555733b *)
add zmm11_000 zmm10_000 zmm5_000;
add zmm11_001 zmm10_001 zmm5_001;
add zmm11_010 zmm10_010 zmm5_010;
add zmm11_011 zmm10_011 zmm5_011;
add zmm11_100 zmm10_100 zmm5_100;
add zmm11_101 zmm10_101 zmm5_101;
add zmm11_110 zmm10_110 zmm5_110;
add zmm11_111 zmm10_111 zmm5_111;
(* vpsraq $0x33,%zmm11,%zmm12                      #! PC = 0x555555557341 *)
ssplit zmm11_000_h zmm11_000_l zmm11_000 51;
ssplit zmm11_001_h zmm11_001_l zmm11_001 51;
ssplit zmm11_010_h zmm11_010_l zmm11_010 51;
ssplit zmm11_011_h zmm11_011_l zmm11_011 51;
ssplit zmm11_100_h zmm11_100_l zmm11_100 51;
ssplit zmm11_101_h zmm11_101_l zmm11_101 51;
ssplit zmm11_110_h zmm11_110_l zmm11_110 51;
ssplit zmm11_111_h zmm11_111_l zmm11_111 51;
mov zmm12_000 zmm11_000_h;
mov zmm12_001 zmm11_001_h;
mov zmm12_010 zmm11_010_h;
mov zmm12_011 zmm11_011_h;
mov zmm12_100 zmm11_100_h;
mov zmm12_101 zmm11_101_h;
mov zmm12_110 zmm11_110_h;
mov zmm12_111 zmm11_111_h;
(* vmovdqa32 0x12dee(%rip),%zmm5        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x555555557348 *)
mov zmm5_000 L0x55555556a140;
mov zmm5_001 L0x55555556a148;
mov zmm5_010 L0x55555556a150;
mov zmm5_011 L0x55555556a158;
mov zmm5_100 L0x55555556a160;
mov zmm5_101 L0x55555556a168;
mov zmm5_110 L0x55555556a170;
mov zmm5_111 L0x55555556a178;
(* vpaddq %zmm12,%zmm13,%zmm14                     #! PC = 0x555555557352 *)
add zmm14_000 zmm13_000 zmm12_000;
add zmm14_001 zmm13_001 zmm12_001;
add zmm14_010 zmm13_010 zmm12_010;
add zmm14_011 zmm13_011 zmm12_011;
add zmm14_100 zmm13_100 zmm12_100;
add zmm14_101 zmm13_101 zmm12_101;
add zmm14_110 zmm13_110 zmm12_110;
add zmm14_111 zmm13_111 zmm12_111;
(* vpsraq $0x3f,%zmm14,%zmm15                      #! PC = 0x555555557358 *)
ssplit zmm14_000_h zmm14_000_l zmm14_000 51;
ssplit zmm14_001_h zmm14_001_l zmm14_001 51;
ssplit zmm14_010_h zmm14_010_l zmm14_010 51;
ssplit zmm14_011_h zmm14_011_l zmm14_011 51;
ssplit zmm14_100_h zmm14_100_l zmm14_100 51;
ssplit zmm14_101_h zmm14_101_l zmm14_101 51;
ssplit zmm14_110_h zmm14_110_l zmm14_110 51;
ssplit zmm14_111_h zmm14_111_l zmm14_111 51;
mov zmm15_000 zmm14_000_h;
mov zmm15_001 zmm14_001_h;
mov zmm15_010 zmm14_010_h;
mov zmm15_011 zmm14_011_h;
mov zmm15_100 zmm14_100_h;
mov zmm15_101 zmm14_101_h;
mov zmm15_110 zmm14_110_h;
mov zmm15_111 zmm14_111_h;
(* vpandd %zmm5,%zmm7,%zmm4                        #! PC = 0x55555555735f *)
split zmm7_000_h zmm7_000_l zmm7_000 51;
split zmm7_001_h zmm7_001_l zmm7_001 51;
split zmm7_010_h zmm7_010_l zmm7_010 51;
split zmm7_011_h zmm7_011_l zmm7_011 51;
split zmm7_100_h zmm7_100_l zmm7_100 51;
split zmm7_101_h zmm7_101_l zmm7_101 51;
split zmm7_110_h zmm7_110_l zmm7_110 51;
split zmm7_111_h zmm7_111_l zmm7_111 51;
cast zmm7_000_l@int64 zmm7_000_l;
cast zmm7_001_l@int64 zmm7_001_l;
cast zmm7_010_l@int64 zmm7_010_l;
cast zmm7_011_l@int64 zmm7_011_l;
cast zmm7_100_l@int64 zmm7_100_l;
cast zmm7_101_l@int64 zmm7_101_l;
cast zmm7_110_l@int64 zmm7_110_l;
cast zmm7_111_l@int64 zmm7_111_l;
mov zmm4_000 zmm7_000_l;
mov zmm4_001 zmm7_001_l;
mov zmm4_010 zmm7_010_l;
mov zmm4_011 zmm7_011_l;
mov zmm4_100 zmm7_100_l;
mov zmm4_101 zmm7_101_l;
mov zmm4_110 zmm7_110_l;
mov zmm4_111 zmm7_111_l;
(* vpandd 0x12e51(%rip),%zmm15,%zmm7        # 0x55555556a1c0#! EA = L0x55555556a1c0; Value = 0x0007ffffffffffed; PC = 0x555555557365 *)
and zmm7_000@int64 L0x55555556a1c0 zmm15_000;
and zmm7_001@int64 L0x55555556a1c8 zmm15_001;
and zmm7_010@int64 L0x55555556a1d0 zmm15_010;
and zmm7_011@int64 L0x55555556a1d8 zmm15_011;
and zmm7_100@int64 L0x55555556a1e0 zmm15_100;
and zmm7_101@int64 L0x55555556a1e8 zmm15_101;
and zmm7_110@int64 L0x55555556a1f0 zmm15_110;
and zmm7_111@int64 L0x55555556a1f8 zmm15_111;
(* vpandd %zmm5,%zmm15,%zmm6                       #! PC = 0x55555555736f *)
split zmm15_000_h zmm15_000_l zmm15_000 51;
split zmm15_001_h zmm15_001_l zmm15_001 51;
split zmm15_010_h zmm15_010_l zmm15_010 51;
split zmm15_011_h zmm15_011_l zmm15_011 51;
split zmm15_100_h zmm15_100_l zmm15_100 51;
split zmm15_101_h zmm15_101_l zmm15_101 51;
split zmm15_110_h zmm15_110_l zmm15_110 51;
split zmm15_111_h zmm15_111_l zmm15_111 51;
cast zmm15_000_l@int64 zmm15_000_l;
cast zmm15_001_l@int64 zmm15_001_l;
cast zmm15_010_l@int64 zmm15_010_l;
cast zmm15_011_l@int64 zmm15_011_l;
cast zmm15_100_l@int64 zmm15_100_l;
cast zmm15_101_l@int64 zmm15_101_l;
cast zmm15_110_l@int64 zmm15_110_l;
cast zmm15_111_l@int64 zmm15_111_l;
mov zmm6_000 zmm15_000_l;
mov zmm6_001 zmm15_001_l;
mov zmm6_010 zmm15_010_l;
mov zmm6_011 zmm15_011_l;
mov zmm6_100 zmm15_100_l;
mov zmm6_101 zmm15_101_l;
mov zmm6_110 zmm15_110_l;
mov zmm6_111 zmm15_111_l;
(* vpaddq %zmm7,%zmm4,%zmm0                        #! PC = 0x555555557375 *)
add zmm0_000 zmm4_000 zmm7_000;
add zmm0_001 zmm4_001 zmm7_001;
add zmm0_010 zmm4_010 zmm7_010;
add zmm0_011 zmm4_011 zmm7_011;
add zmm0_100 zmm4_100 zmm7_100;
add zmm0_101 zmm4_101 zmm7_101;
add zmm0_110 zmm4_110 zmm7_110;
add zmm0_111 zmm4_111 zmm7_111;
(* vpandd %zmm5,%zmm8,%zmm1                        #! PC = 0x55555555737b *)
split zmm8_000_h zmm8_000_l zmm8_000 51;
split zmm8_001_h zmm8_001_l zmm8_001 51;
split zmm8_010_h zmm8_010_l zmm8_010 51;
split zmm8_011_h zmm8_011_l zmm8_011 51;
split zmm8_100_h zmm8_100_l zmm8_100 51;
split zmm8_101_h zmm8_101_l zmm8_101 51;
split zmm8_110_h zmm8_110_l zmm8_110 51;
split zmm8_111_h zmm8_111_l zmm8_111 51;
cast zmm8_000_l@int64 zmm8_000_l;
cast zmm8_001_l@int64 zmm8_001_l;
cast zmm8_010_l@int64 zmm8_010_l;
cast zmm8_011_l@int64 zmm8_011_l;
cast zmm8_100_l@int64 zmm8_100_l;
cast zmm8_101_l@int64 zmm8_101_l;
cast zmm8_110_l@int64 zmm8_110_l;
cast zmm8_111_l@int64 zmm8_111_l;
mov zmm1_000 zmm8_000_l;
mov zmm1_001 zmm8_001_l;
mov zmm1_010 zmm8_010_l;
mov zmm1_011 zmm8_011_l;
mov zmm1_100 zmm8_100_l;
mov zmm1_101 zmm8_101_l;
mov zmm1_110 zmm8_110_l;
mov zmm1_111 zmm8_111_l;
(* vpaddq %zmm1,%zmm6,%zmm3                        #! PC = 0x555555557381 *)
add zmm3_000 zmm6_000 zmm1_000;
add zmm3_001 zmm6_001 zmm1_001;
add zmm3_010 zmm6_010 zmm1_010;
add zmm3_011 zmm6_011 zmm1_011;
add zmm3_100 zmm6_100 zmm1_100;
add zmm3_101 zmm6_101 zmm1_101;
add zmm3_110 zmm6_110 zmm1_110;
add zmm3_111 zmm6_111 zmm1_111;
(* vpsrlq $0x33,%zmm0,%zmm2                        #! PC = 0x555555557387 *)
split zmm0_000_h zmm0_000_l zmm0_000 51;
split zmm0_001_h zmm0_001_l zmm0_001 51;
split zmm0_010_h zmm0_010_l zmm0_010 51;
split zmm0_011_h zmm0_011_l zmm0_011 51;
split zmm0_100_h zmm0_100_l zmm0_100 51;
split zmm0_101_h zmm0_101_l zmm0_101 51;
split zmm0_110_h zmm0_110_l zmm0_110 51;
split zmm0_111_h zmm0_111_l zmm0_111 51;
mov zmm2_000 zmm0_000_h;
mov zmm2_001 zmm0_001_h;
mov zmm2_010 zmm0_010_h;
mov zmm2_011 zmm0_011_h;
mov zmm2_100 zmm0_100_h;
mov zmm2_101 zmm0_101_h;
mov zmm2_110 zmm0_110_h;
mov zmm2_111 zmm0_111_h;
(* vpaddq %zmm2,%zmm3,%zmm8                        #! PC = 0x55555555738e *)
add zmm8_000 zmm3_000 zmm2_000;
add zmm8_001 zmm3_001 zmm2_001;
add zmm8_010 zmm3_010 zmm2_010;
add zmm8_011 zmm3_011 zmm2_011;
add zmm8_100 zmm3_100 zmm2_100;
add zmm8_101 zmm3_101 zmm2_101;
add zmm8_110 zmm3_110 zmm2_110;
add zmm8_111 zmm3_111 zmm2_111;
(* vpandd %zmm5,%zmm9,%zmm9                        #! PC = 0x555555557394 *)
split zmm9_000_h zmm9_000_l zmm9_000 51;
split zmm9_001_h zmm9_001_l zmm9_001 51;
split zmm9_010_h zmm9_010_l zmm9_010 51;
split zmm9_011_h zmm9_011_l zmm9_011 51;
split zmm9_100_h zmm9_100_l zmm9_100 51;
split zmm9_101_h zmm9_101_l zmm9_101 51;
split zmm9_110_h zmm9_110_l zmm9_110 51;
split zmm9_111_h zmm9_111_l zmm9_111 51;
cast zmm9_000_l@int64 zmm9_000_l;
cast zmm9_001_l@int64 zmm9_001_l;
cast zmm9_010_l@int64 zmm9_010_l;
cast zmm9_011_l@int64 zmm9_011_l;
cast zmm9_100_l@int64 zmm9_100_l;
cast zmm9_101_l@int64 zmm9_101_l;
cast zmm9_110_l@int64 zmm9_110_l;
cast zmm9_111_l@int64 zmm9_111_l;
mov zmm9_000 zmm9_000_l;
mov zmm9_001 zmm9_001_l;
mov zmm9_010 zmm9_010_l;
mov zmm9_011 zmm9_011_l;
mov zmm9_100 zmm9_100_l;
mov zmm9_101 zmm9_101_l;
mov zmm9_110 zmm9_110_l;
mov zmm9_111 zmm9_111_l;
(* vpsrlq $0x33,%zmm8,%zmm12                       #! PC = 0x55555555739a *)
split zmm8_000_h zmm8_000_l zmm8_000 51;
split zmm8_001_h zmm8_001_l zmm8_001 51;
split zmm8_010_h zmm8_010_l zmm8_010 51;
split zmm8_011_h zmm8_011_l zmm8_011 51;
split zmm8_100_h zmm8_100_l zmm8_100 51;
split zmm8_101_h zmm8_101_l zmm8_101 51;
split zmm8_110_h zmm8_110_l zmm8_110 51;
split zmm8_111_h zmm8_111_l zmm8_111 51;
mov zmm12_000 zmm8_000_h;
mov zmm12_001 zmm8_001_h;
mov zmm12_010 zmm8_010_h;
mov zmm12_011 zmm8_011_h;
mov zmm12_100 zmm8_100_h;
mov zmm12_101 zmm8_101_h;
mov zmm12_110 zmm8_110_h;
mov zmm12_111 zmm8_111_h;
(* vpaddq %zmm9,%zmm6,%zmm13                       #! PC = 0x5555555573a1 *)
add zmm13_000 zmm6_000 zmm9_000;
add zmm13_001 zmm6_001 zmm9_001;
add zmm13_010 zmm6_010 zmm9_010;
add zmm13_011 zmm6_011 zmm9_011;
add zmm13_100 zmm6_100 zmm9_100;
add zmm13_101 zmm6_101 zmm9_101;
add zmm13_110 zmm6_110 zmm9_110;
add zmm13_111 zmm6_111 zmm9_111;
(* vpaddq %zmm12,%zmm13,%zmm15                     #! PC = 0x5555555573a7 *)
add zmm15_000 zmm13_000 zmm12_000;
add zmm15_001 zmm13_001 zmm12_001;
add zmm15_010 zmm13_010 zmm12_010;
add zmm15_011 zmm13_011 zmm12_011;
add zmm15_100 zmm13_100 zmm12_100;
add zmm15_101 zmm13_101 zmm12_101;
add zmm15_110 zmm13_110 zmm12_110;
add zmm15_111 zmm13_111 zmm12_111;
(* vpandd %zmm5,%zmm11,%zmm11                      #! PC = 0x5555555573ad *)
split zmm11_000_h zmm11_000_l zmm11_000 51;
split zmm11_001_h zmm11_001_l zmm11_001 51;
split zmm11_010_h zmm11_010_l zmm11_010 51;
split zmm11_011_h zmm11_011_l zmm11_011 51;
split zmm11_100_h zmm11_100_l zmm11_100 51;
split zmm11_101_h zmm11_101_l zmm11_101 51;
split zmm11_110_h zmm11_110_l zmm11_110 51;
split zmm11_111_h zmm11_111_l zmm11_111 51;
cast zmm11_000_l@int64 zmm11_000_l;
cast zmm11_001_l@int64 zmm11_001_l;
cast zmm11_010_l@int64 zmm11_010_l;
cast zmm11_011_l@int64 zmm11_011_l;
cast zmm11_100_l@int64 zmm11_100_l;
cast zmm11_101_l@int64 zmm11_101_l;
cast zmm11_110_l@int64 zmm11_110_l;
cast zmm11_111_l@int64 zmm11_111_l;
mov zmm11_000 zmm11_000_l;
mov zmm11_001 zmm11_001_l;
mov zmm11_010 zmm11_010_l;
mov zmm11_011 zmm11_011_l;
mov zmm11_100 zmm11_100_l;
mov zmm11_101 zmm11_101_l;
mov zmm11_110 zmm11_110_l;
mov zmm11_111 zmm11_111_l;
(* vpandd %zmm5,%zmm0,%zmm10                       #! PC = 0x5555555573b3 *)
split zmm0_000_h zmm0_000_l zmm0_000 51;
split zmm0_001_h zmm0_001_l zmm0_001 51;
split zmm0_010_h zmm0_010_l zmm0_010 51;
split zmm0_011_h zmm0_011_l zmm0_011 51;
split zmm0_100_h zmm0_100_l zmm0_100 51;
split zmm0_101_h zmm0_101_l zmm0_101 51;
split zmm0_110_h zmm0_110_l zmm0_110 51;
split zmm0_111_h zmm0_111_l zmm0_111 51;
cast zmm0_000_l@int64 zmm0_000_l;
cast zmm0_001_l@int64 zmm0_001_l;
cast zmm0_010_l@int64 zmm0_010_l;
cast zmm0_011_l@int64 zmm0_011_l;
cast zmm0_100_l@int64 zmm0_100_l;
cast zmm0_101_l@int64 zmm0_101_l;
cast zmm0_110_l@int64 zmm0_110_l;
cast zmm0_111_l@int64 zmm0_111_l;
mov zmm10_000 zmm0_000_l;
mov zmm10_001 zmm0_001_l;
mov zmm10_010 zmm0_010_l;
mov zmm10_011 zmm0_011_l;
mov zmm10_100 zmm0_100_l;
mov zmm10_101 zmm0_101_l;
mov zmm10_110 zmm0_110_l;
mov zmm10_111 zmm0_111_l;
(* vpsrlq $0x33,%zmm15,%zmm7                       #! PC = 0x5555555573b9 *)
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
(* vpaddq %zmm11,%zmm6,%zmm0                       #! PC = 0x5555555573c0 *)
add zmm0_000 zmm6_000 zmm11_000;
add zmm0_001 zmm6_001 zmm11_001;
add zmm0_010 zmm6_010 zmm11_010;
add zmm0_011 zmm6_011 zmm11_011;
add zmm0_100 zmm6_100 zmm11_100;
add zmm0_101 zmm6_101 zmm11_101;
add zmm0_110 zmm6_110 zmm11_110;
add zmm0_111 zmm6_111 zmm11_111;
(* vpaddq %zmm7,%zmm0,%zmm1                        #! PC = 0x5555555573c6 *)
add zmm1_000 zmm0_000 zmm7_000;
add zmm1_001 zmm0_001 zmm7_001;
add zmm1_010 zmm0_010 zmm7_010;
add zmm1_011 zmm0_011 zmm7_011;
add zmm1_100 zmm0_100 zmm7_100;
add zmm1_101 zmm0_101 zmm7_101;
add zmm1_110 zmm0_110 zmm7_110;
add zmm1_111 zmm0_111 zmm7_111;
(* vpsrlq $0x33,%zmm1,%zmm3                        #! PC = 0x5555555573cc *)
split zmm1_000_h zmm1_000_l zmm1_000 51;
split zmm1_001_h zmm1_001_l zmm1_001 51;
split zmm1_010_h zmm1_010_l zmm1_010 51;
split zmm1_011_h zmm1_011_l zmm1_011 51;
split zmm1_100_h zmm1_100_l zmm1_100 51;
split zmm1_101_h zmm1_101_l zmm1_101 51;
split zmm1_110_h zmm1_110_l zmm1_110 51;
split zmm1_111_h zmm1_111_l zmm1_111 51;
mov zmm3_000 zmm1_000_h;
mov zmm3_001 zmm1_001_h;
mov zmm3_010 zmm1_010_h;
mov zmm3_011 zmm1_011_h;
mov zmm3_100 zmm1_100_h;
mov zmm3_101 zmm1_101_h;
mov zmm3_110 zmm1_110_h;
mov zmm3_111 zmm1_111_h;
(* vpaddq %zmm6,%zmm14,%zmm14                      #! PC = 0x5555555573d3 *)
add zmm14_000 zmm14_000 zmm6_000;
add zmm14_001 zmm14_001 zmm6_001;
add zmm14_010 zmm14_010 zmm6_010;
add zmm14_011 zmm14_011 zmm6_011;
add zmm14_100 zmm14_100 zmm6_100;
add zmm14_101 zmm14_101 zmm6_101;
add zmm14_110 zmm14_110 zmm6_110;
add zmm14_111 zmm14_111 zmm6_111;
(* vpaddq %zmm3,%zmm14,%zmm6                       #! PC = 0x5555555573d9 *)
add zmm6_000 zmm14_000 zmm3_000;
add zmm6_001 zmm14_001 zmm3_001;
add zmm6_010 zmm14_010 zmm3_010;
add zmm6_011 zmm14_011 zmm3_011;
add zmm6_100 zmm14_100 zmm3_100;
add zmm6_101 zmm14_101 zmm3_101;
add zmm6_110 zmm14_110 zmm3_110;
add zmm6_111 zmm14_111 zmm3_111;
(* vpandd %zmm5,%zmm8,%zmm4                        #! PC = 0x5555555573df *)
split zmm8_000_h zmm8_000_l zmm8_000 51;
split zmm8_001_h zmm8_001_l zmm8_001 51;
split zmm8_010_h zmm8_010_l zmm8_010 51;
split zmm8_011_h zmm8_011_l zmm8_011 51;
split zmm8_100_h zmm8_100_l zmm8_100 51;
split zmm8_101_h zmm8_101_l zmm8_101 51;
split zmm8_110_h zmm8_110_l zmm8_110 51;
split zmm8_111_h zmm8_111_l zmm8_111 51;
cast zmm8_000_l@int64 zmm8_000_l;
cast zmm8_001_l@int64 zmm8_001_l;
cast zmm8_010_l@int64 zmm8_010_l;
cast zmm8_011_l@int64 zmm8_011_l;
cast zmm8_100_l@int64 zmm8_100_l;
cast zmm8_101_l@int64 zmm8_101_l;
cast zmm8_110_l@int64 zmm8_110_l;
cast zmm8_111_l@int64 zmm8_111_l;
mov zmm4_000 zmm8_000_l;
mov zmm4_001 zmm8_001_l;
mov zmm4_010 zmm8_010_l;
mov zmm4_011 zmm8_011_l;
mov zmm4_100 zmm8_100_l;
mov zmm4_101 zmm8_101_l;
mov zmm4_110 zmm8_110_l;
mov zmm4_111 zmm8_111_l;
(* vpandd %zmm5,%zmm15,%zmm2                       #! PC = 0x5555555573e5 *)
split zmm15_000_h zmm15_000_l zmm15_000 51;
split zmm15_001_h zmm15_001_l zmm15_001 51;
split zmm15_010_h zmm15_010_l zmm15_010 51;
split zmm15_011_h zmm15_011_l zmm15_011 51;
split zmm15_100_h zmm15_100_l zmm15_100 51;
split zmm15_101_h zmm15_101_l zmm15_101 51;
split zmm15_110_h zmm15_110_l zmm15_110 51;
split zmm15_111_h zmm15_111_l zmm15_111 51;
cast zmm15_000_l@int64 zmm15_000_l;
cast zmm15_001_l@int64 zmm15_001_l;
cast zmm15_010_l@int64 zmm15_010_l;
cast zmm15_011_l@int64 zmm15_011_l;
cast zmm15_100_l@int64 zmm15_100_l;
cast zmm15_101_l@int64 zmm15_101_l;
cast zmm15_110_l@int64 zmm15_110_l;
cast zmm15_111_l@int64 zmm15_111_l;
mov zmm2_000 zmm15_000_l;
mov zmm2_001 zmm15_001_l;
mov zmm2_010 zmm15_010_l;
mov zmm2_011 zmm15_011_l;
mov zmm2_100 zmm15_100_l;
mov zmm2_101 zmm15_101_l;
mov zmm2_110 zmm15_110_l;
mov zmm2_111 zmm15_111_l;
(* vpandd %zmm5,%zmm1,%zmm8                        #! PC = 0x5555555573eb *)
split zmm1_000_h zmm1_000_l zmm1_000 51;
split zmm1_001_h zmm1_001_l zmm1_001 51;
split zmm1_010_h zmm1_010_l zmm1_010 51;
split zmm1_011_h zmm1_011_l zmm1_011 51;
split zmm1_100_h zmm1_100_l zmm1_100 51;
split zmm1_101_h zmm1_101_l zmm1_101 51;
split zmm1_110_h zmm1_110_l zmm1_110 51;
split zmm1_111_h zmm1_111_l zmm1_111 51;
cast zmm1_000_l@int64 zmm1_000_l;
cast zmm1_001_l@int64 zmm1_001_l;
cast zmm1_010_l@int64 zmm1_010_l;
cast zmm1_011_l@int64 zmm1_011_l;
cast zmm1_100_l@int64 zmm1_100_l;
cast zmm1_101_l@int64 zmm1_101_l;
cast zmm1_110_l@int64 zmm1_110_l;
cast zmm1_111_l@int64 zmm1_111_l;
mov zmm8_000 zmm1_000_l;
mov zmm8_001 zmm1_001_l;
mov zmm8_010 zmm1_010_l;
mov zmm8_011 zmm1_011_l;
mov zmm8_100 zmm1_100_l;
mov zmm8_101 zmm1_101_l;
mov zmm8_110 zmm1_110_l;
mov zmm8_111 zmm1_111_l;
(* vpandd %zmm5,%zmm6,%zmm5                        #! PC = 0x5555555573f1 *)
split zmm6_000_h zmm6_000_l zmm6_000 51;
split zmm6_001_h zmm6_001_l zmm6_001 51;
split zmm6_010_h zmm6_010_l zmm6_010 51;
split zmm6_011_h zmm6_011_l zmm6_011 51;
split zmm6_100_h zmm6_100_l zmm6_100 51;
split zmm6_101_h zmm6_101_l zmm6_101 51;
split zmm6_110_h zmm6_110_l zmm6_110 51;
split zmm6_111_h zmm6_111_l zmm6_111 51;
cast zmm6_000_l@int64 zmm6_000_l;
cast zmm6_001_l@int64 zmm6_001_l;
cast zmm6_010_l@int64 zmm6_010_l;
cast zmm6_011_l@int64 zmm6_011_l;
cast zmm6_100_l@int64 zmm6_100_l;
cast zmm6_101_l@int64 zmm6_101_l;
cast zmm6_110_l@int64 zmm6_110_l;
cast zmm6_111_l@int64 zmm6_111_l;
mov zmm5_000 zmm6_000_l;
mov zmm5_001 zmm6_001_l;
mov zmm5_010 zmm6_010_l;
mov zmm5_011 zmm6_011_l;
mov zmm5_100 zmm6_100_l;
mov zmm5_101 zmm6_101_l;
mov zmm5_110 zmm6_110_l;
mov zmm5_111 zmm6_111_l;
(* vmovdqa32 %zmm10,(%rdi)                         #! EA = L0x7fffffffd8c0; PC = 0x5555555573f7 *)
mov L0x7fffffffd8c0 zmm10_000;
mov L0x7fffffffd8c8 zmm10_001;
mov L0x7fffffffd8d0 zmm10_010;
mov L0x7fffffffd8d8 zmm10_011;
mov L0x7fffffffd8e0 zmm10_100;
mov L0x7fffffffd8e8 zmm10_101;
mov L0x7fffffffd8f0 zmm10_110;
mov L0x7fffffffd8f8 zmm10_111;
(* vmovdqa32 %zmm4,0x40(%rdi)                      #! EA = L0x7fffffffd900; PC = 0x5555555573fd *)
mov L0x7fffffffd900 zmm4_000;
mov L0x7fffffffd908 zmm4_001;
mov L0x7fffffffd910 zmm4_010;
mov L0x7fffffffd918 zmm4_011;
mov L0x7fffffffd920 zmm4_100;
mov L0x7fffffffd928 zmm4_101;
mov L0x7fffffffd930 zmm4_110;
mov L0x7fffffffd938 zmm4_111;
(* vmovdqa32 %zmm2,0x80(%rdi)                      #! EA = L0x7fffffffd940; PC = 0x555555557404 *)
mov L0x7fffffffd940 zmm2_000;
mov L0x7fffffffd948 zmm2_001;
mov L0x7fffffffd950 zmm2_010;
mov L0x7fffffffd958 zmm2_011;
mov L0x7fffffffd960 zmm2_100;
mov L0x7fffffffd968 zmm2_101;
mov L0x7fffffffd970 zmm2_110;
mov L0x7fffffffd978 zmm2_111;
(* vmovdqa32 %zmm8,0xc0(%rdi)                      #! EA = L0x7fffffffd980; PC = 0x55555555740b *)
mov L0x7fffffffd980 zmm8_000;
mov L0x7fffffffd988 zmm8_001;
mov L0x7fffffffd990 zmm8_010;
mov L0x7fffffffd998 zmm8_011;
mov L0x7fffffffd9a0 zmm8_100;
mov L0x7fffffffd9a8 zmm8_101;
mov L0x7fffffffd9b0 zmm8_110;
mov L0x7fffffffd9b8 zmm8_111;
(* vmovdqa32 %zmm5,0x100(%rdi)                     #! EA = L0x7fffffffd9c0; PC = 0x555555557412 *)
mov L0x7fffffffd9c0 zmm5_000;
mov L0x7fffffffd9c8 zmm5_001;
mov L0x7fffffffd9d0 zmm5_010;
mov L0x7fffffffd9d8 zmm5_011;
mov L0x7fffffffd9e0 zmm5_100;
mov L0x7fffffffd9e8 zmm5_101;
mov L0x7fffffffd9f0 zmm5_110;
mov L0x7fffffffd9f8 zmm5_111;
(* #! <- SP = 0x7fffffffd5f8 *)
#! 0x7fffffffd5f8 = 0x7fffffffd5f8;
(* #ret                                            #! PC = 0x55555555741c *)
#ret                                            #! 0x55555555741c = 0x55555555741c;

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

assert true && and [
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
                  p,
      limbs 51 [c00, c01, c02, c03, c04] >=u 0@268,
      limbs 51 [c00, c01, c02, c03, c04] <u p,
      limbs 51 [c10, c11, c12, c13, c14] >=u 0@268,
      limbs 51 [c10, c11, c12, c13, c14] <u p,
      limbs 51 [c20, c21, c22, c23, c24] >=u 0@268,
      limbs 51 [c20, c21, c22, c23, c24] <u p,
      limbs 51 [c30, c31, c32, c33, c34] >=u 0@268,
      limbs 51 [c30, c31, c32, c33, c34] <u p,
      limbs 51 [c40, c41, c42, c43, c44] >=u 0@268,
      limbs 51 [c40, c41, c42, c43, c44] <u p,
      limbs 51 [c50, c51, c52, c53, c54] >=u 0@268,
      limbs 51 [c50, c51, c52, c53, c54] <u p,
      limbs 51 [c60, c61, c62, c63, c64] >=u 0@268,
      limbs 51 [c60, c61, c62, c63, c64] <u p,
      limbs 51 [c70, c71, c72, c73, c74] >=u 0@268,
      limbs 51 [c70, c71, c72, c73, c74] <u p
];

{
  true
  &&
  true
}

