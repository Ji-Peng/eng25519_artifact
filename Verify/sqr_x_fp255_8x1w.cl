(*
cv -v -disable_safety sqr_x_fp255_8x1w.cl
Parsing CryptoLine file:                [OK]            0.011436 seconds
Checking well-formedness:               [OK]            0.003753 seconds
Transforming to SSA form:               [OK]            0.001167 seconds
Normalizing specification:              [OK]            0.001500 seconds
Rewriting assignments:                  [OK]            0.000911 seconds
Verifying range assertions:             [OK]            3039.028568 seconds
Verifying range specification:          [OK]            0.001145 seconds                                          
Rewriting value-preserved casting:      [OK]            0.002985 seconds
Verifying algebraic assertions:         [OK]            0.190341 seconds
Verifying algebraic specification:      [OK]            0.000057 seconds
Verification result:                    [OK]            3039.243364 seconds
*)

proc main (uint64 a00, uint64 a10, uint64 a20, uint64 a30, uint64 a40, uint64 a50, uint64 a60, uint64 a70,
           uint64 a01, uint64 a11, uint64 a21, uint64 a31, uint64 a41, uint64 a51, uint64 a61, uint64 a71,
           uint64 a02, uint64 a12, uint64 a22, uint64 a32, uint64 a42, uint64 a52, uint64 a62, uint64 a72,
           uint64 a03, uint64 a13, uint64 a23, uint64 a33, uint64 a43, uint64 a53, uint64 a63, uint64 a73,
           uint64 a04, uint64 a14, uint64 a24, uint64 a34, uint64 a44, uint64 a54, uint64 a64, uint64 a74,
           uint268 p, uint523 p1) =
{
  and [
    p = 0x007fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed
  ]
  &&
  and [
        p = 0x07fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed@268,
        p1 = 0x07fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffed@523,
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
mov L0x55555556a180 0x169@uint64;
mov L0x55555556a188 0x169@uint64;
mov L0x55555556a190 0x169@uint64;
mov L0x55555556a198 0x169@uint64;
mov L0x55555556a1a0 0x169@uint64;
mov L0x55555556a1a8 0x169@uint64;
mov L0x55555556a1b0 0x169@uint64;
mov L0x55555556a1b8 0x169@uint64;
mov L0x7fffffffd580 a00;
mov L0x7fffffffd588 a10;
mov L0x7fffffffd590 a20;
mov L0x7fffffffd598 a30;
mov L0x7fffffffd5a0 a40;
mov L0x7fffffffd5a8 a50;
mov L0x7fffffffd5b0 a60;
mov L0x7fffffffd5b8 a70;
mov L0x7fffffffd5c0 a01;
mov L0x7fffffffd5c8 a11;
mov L0x7fffffffd5d0 a21;
mov L0x7fffffffd5d8 a31;
mov L0x7fffffffd5e0 a41;
mov L0x7fffffffd5e8 a51;
mov L0x7fffffffd5f0 a61;
mov L0x7fffffffd5f8 a71;
mov L0x7fffffffd600 a02;
mov L0x7fffffffd608 a12;
mov L0x7fffffffd610 a22;
mov L0x7fffffffd618 a32;
mov L0x7fffffffd620 a42;
mov L0x7fffffffd628 a52;
mov L0x7fffffffd630 a62;
mov L0x7fffffffd638 a72;
mov L0x7fffffffd640 a03;
mov L0x7fffffffd648 a13;
mov L0x7fffffffd650 a23;
mov L0x7fffffffd658 a33;
mov L0x7fffffffd660 a43;
mov L0x7fffffffd668 a53;
mov L0x7fffffffd670 a63;
mov L0x7fffffffd678 a73;
mov L0x7fffffffd680 a04;
mov L0x7fffffffd688 a14;
mov L0x7fffffffd690 a24;
mov L0x7fffffffd698 a34;
mov L0x7fffffffd6a0 a44;
mov L0x7fffffffd6a8 a54;
mov L0x7fffffffd6b0 a64;
mov L0x7fffffffd6b8 a74;

(* #! -> SP = 0x7fffffffd538 *)
#! 0x7fffffffd538 = 0x7fffffffd538;
(* vpxor  %zmm0,%zmm0,%zmm0                        #! PC = 0x5555555569c4 *)
mov zmm0_000 0@uint64;
mov zmm0_001 0@uint64;
mov zmm0_010 0@uint64;
mov zmm0_011 0@uint64;
mov zmm0_100 0@uint64;
mov zmm0_101 0@uint64;
mov zmm0_110 0@uint64;
mov zmm0_111 0@uint64;
(* vmovdqa64 (%rsi),%zmm2                          #! EA = L0x7fffffffd580; Value = 0x00007ffff7fc38d8; PC = 0x5555555569c8 *)
mov zmm2_000 L0x7fffffffd580; (* zmm2_000=a00 *)
mov zmm2_001 L0x7fffffffd588;
mov zmm2_010 L0x7fffffffd590;
mov zmm2_011 L0x7fffffffd598;
mov zmm2_100 L0x7fffffffd5a0;
mov zmm2_101 L0x7fffffffd5a8;
mov zmm2_110 L0x7fffffffd5b0;
mov zmm2_111 L0x7fffffffd5b8;
(* vmovdqa64 0x40(%rsi),%zmm10                     #! EA = L0x7fffffffd5c0; Value = 0x0000000000000000; PC = 0x5555555569ce *)
mov zmm10_000 L0x7fffffffd5c0; (* zmm10_000=a01 *)
mov zmm10_001 L0x7fffffffd5c8;
mov zmm10_010 L0x7fffffffd5d0;
mov zmm10_011 L0x7fffffffd5d8;
mov zmm10_100 L0x7fffffffd5e0;
mov zmm10_101 L0x7fffffffd5e8;
mov zmm10_110 L0x7fffffffd5f0;
mov zmm10_111 L0x7fffffffd5f8;
(* vmovdqa64 %zmm0,%zmm1                           #! PC = 0x5555555569d5 *)
mov zmm1_000 zmm0_000; (* zmm1_000=0 *)
mov zmm1_001 zmm0_001;
mov zmm1_010 zmm0_010;
mov zmm1_011 zmm0_011;
mov zmm1_100 zmm0_100;
mov zmm1_101 zmm0_101;
mov zmm1_110 zmm0_110;
mov zmm1_111 zmm0_111;
(* vmovdqa64 %zmm0,%zmm12                          #! PC = 0x5555555569db *)
mov zmm12_000 zmm0_000; (* zmm12_000=0 *)
mov zmm12_001 zmm0_001;
mov zmm12_010 zmm0_010;
mov zmm12_011 zmm0_011;
mov zmm12_100 zmm0_100;
mov zmm12_101 zmm0_101;
mov zmm12_110 zmm0_110;
mov zmm12_111 zmm0_111;
(* vpmadd52luq %zmm10,%zmm2,%zmm12 t = VMACLO(t, a0, a1) #! PC = 0x5555555569e1 *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj zmm10_zmm2_000F zmm10_000 zmm2_000; spl zmm10_zmm2_000h_t zmm10_zmm2_000l_t zmm10_zmm2_000F 52;
umulj zmm10_zmm2_001F zmm10_001 zmm2_001; spl zmm10_zmm2_001h_t zmm10_zmm2_001l_t zmm10_zmm2_001F 52;
umulj zmm10_zmm2_010F zmm10_010 zmm2_010; spl zmm10_zmm2_010h_t zmm10_zmm2_010l_t zmm10_zmm2_010F 52;
umulj zmm10_zmm2_011F zmm10_011 zmm2_011; spl zmm10_zmm2_011h_t zmm10_zmm2_011l_t zmm10_zmm2_011F 52;
umulj zmm10_zmm2_100F zmm10_100 zmm2_100; spl zmm10_zmm2_100h_t zmm10_zmm2_100l_t zmm10_zmm2_100F 52;
umulj zmm10_zmm2_101F zmm10_101 zmm2_101; spl zmm10_zmm2_101h_t zmm10_zmm2_101l_t zmm10_zmm2_101F 52;
umulj zmm10_zmm2_110F zmm10_110 zmm2_110; spl zmm10_zmm2_110h_t zmm10_zmm2_110l_t zmm10_zmm2_110F 52;
umulj zmm10_zmm2_111F zmm10_111 zmm2_111; spl zmm10_zmm2_111h_t zmm10_zmm2_111l_t zmm10_zmm2_111F 52;
vpc zmm10_zmm2_000h_t@uint64 zmm10_zmm2_000h_t; vpc zmm10_zmm2_000l_t@uint64 zmm10_zmm2_000l_t;
vpc zmm10_zmm2_001h_t@uint64 zmm10_zmm2_001h_t; vpc zmm10_zmm2_001l_t@uint64 zmm10_zmm2_001l_t;
vpc zmm10_zmm2_010h_t@uint64 zmm10_zmm2_010h_t; vpc zmm10_zmm2_010l_t@uint64 zmm10_zmm2_010l_t;
vpc zmm10_zmm2_011h_t@uint64 zmm10_zmm2_011h_t; vpc zmm10_zmm2_011l_t@uint64 zmm10_zmm2_011l_t;
vpc zmm10_zmm2_100h_t@uint64 zmm10_zmm2_100h_t; vpc zmm10_zmm2_100l_t@uint64 zmm10_zmm2_100l_t;
vpc zmm10_zmm2_101h_t@uint64 zmm10_zmm2_101h_t; vpc zmm10_zmm2_101l_t@uint64 zmm10_zmm2_101l_t;
vpc zmm10_zmm2_110h_t@uint64 zmm10_zmm2_110h_t; vpc zmm10_zmm2_110l_t@uint64 zmm10_zmm2_110l_t;
vpc zmm10_zmm2_111h_t@uint64 zmm10_zmm2_111h_t; vpc zmm10_zmm2_111l_t@uint64 zmm10_zmm2_111l_t;
add zmm12_000 zmm12_000 zmm10_zmm2_000l_t; (* zmm12_000=(a00*a01)l *)
add zmm12_001 zmm12_001 zmm10_zmm2_001l_t;
add zmm12_010 zmm12_010 zmm10_zmm2_010l_t;
add zmm12_011 zmm12_011 zmm10_zmm2_011l_t;
add zmm12_100 zmm12_100 zmm10_zmm2_100l_t;
add zmm12_101 zmm12_101 zmm10_zmm2_101l_t;
add zmm12_110 zmm12_110 zmm10_zmm2_110l_t;
add zmm12_111 zmm12_111 zmm10_zmm2_111l_t;
(* vpmadd52huq %zmm2,%zmm2,%zmm1 z0 = VMACLO(z0, a0, a0) #! PC = 0x5555555569e7 *)
assert true && and [
zmm2_000 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj zmm2_zmm2_000F zmm2_000 zmm2_000; spl zmm2_zmm2_000h_t zmm2_zmm2_000l_t zmm2_zmm2_000F 52;
umulj zmm2_zmm2_001F zmm2_001 zmm2_001; spl zmm2_zmm2_001h_t zmm2_zmm2_001l_t zmm2_zmm2_001F 52;
umulj zmm2_zmm2_010F zmm2_010 zmm2_010; spl zmm2_zmm2_010h_t zmm2_zmm2_010l_t zmm2_zmm2_010F 52;
umulj zmm2_zmm2_011F zmm2_011 zmm2_011; spl zmm2_zmm2_011h_t zmm2_zmm2_011l_t zmm2_zmm2_011F 52;
umulj zmm2_zmm2_100F zmm2_100 zmm2_100; spl zmm2_zmm2_100h_t zmm2_zmm2_100l_t zmm2_zmm2_100F 52;
umulj zmm2_zmm2_101F zmm2_101 zmm2_101; spl zmm2_zmm2_101h_t zmm2_zmm2_101l_t zmm2_zmm2_101F 52;
umulj zmm2_zmm2_110F zmm2_110 zmm2_110; spl zmm2_zmm2_110h_t zmm2_zmm2_110l_t zmm2_zmm2_110F 52;
umulj zmm2_zmm2_111F zmm2_111 zmm2_111; spl zmm2_zmm2_111h_t zmm2_zmm2_111l_t zmm2_zmm2_111F 52;
vpc zmm2_zmm2_000h_t@uint64 zmm2_zmm2_000h_t; vpc zmm2_zmm2_000l_t@uint64 zmm2_zmm2_000l_t;
vpc zmm2_zmm2_001h_t@uint64 zmm2_zmm2_001h_t; vpc zmm2_zmm2_001l_t@uint64 zmm2_zmm2_001l_t;
vpc zmm2_zmm2_010h_t@uint64 zmm2_zmm2_010h_t; vpc zmm2_zmm2_010l_t@uint64 zmm2_zmm2_010l_t;
vpc zmm2_zmm2_011h_t@uint64 zmm2_zmm2_011h_t; vpc zmm2_zmm2_011l_t@uint64 zmm2_zmm2_011l_t;
vpc zmm2_zmm2_100h_t@uint64 zmm2_zmm2_100h_t; vpc zmm2_zmm2_100l_t@uint64 zmm2_zmm2_100l_t;
vpc zmm2_zmm2_101h_t@uint64 zmm2_zmm2_101h_t; vpc zmm2_zmm2_101l_t@uint64 zmm2_zmm2_101l_t;
vpc zmm2_zmm2_110h_t@uint64 zmm2_zmm2_110h_t; vpc zmm2_zmm2_110l_t@uint64 zmm2_zmm2_110l_t;
vpc zmm2_zmm2_111h_t@uint64 zmm2_zmm2_111h_t; vpc zmm2_zmm2_111l_t@uint64 zmm2_zmm2_111l_t;
add zmm1_000 zmm1_000 zmm2_zmm2_000h_t; (* zmm1_000=(a00*a00)h *)
add zmm1_001 zmm1_001 zmm2_zmm2_001h_t;
add zmm1_010 zmm1_010 zmm2_zmm2_010h_t;
add zmm1_011 zmm1_011 zmm2_zmm2_011h_t;
add zmm1_100 zmm1_100 zmm2_zmm2_100h_t;
add zmm1_101 zmm1_101 zmm2_zmm2_101h_t;
add zmm1_110 zmm1_110 zmm2_zmm2_110h_t;
add zmm1_111 zmm1_111 zmm2_zmm2_111h_t;
(* vmovdqa64 0x80(%rsi),%zmm8                      #! EA = L0x7fffffffd600; Value = 0x0000000000000000; PC = 0x5555555569ed *)
mov zmm8_000 L0x7fffffffd600; (* zmm8_000=a02 *)
mov zmm8_001 L0x7fffffffd608;
mov zmm8_010 L0x7fffffffd610;
mov zmm8_011 L0x7fffffffd618;
mov zmm8_100 L0x7fffffffd620;
mov zmm8_101 L0x7fffffffd628;
mov zmm8_110 L0x7fffffffd630;
mov zmm8_111 L0x7fffffffd638;
(* vmovdqa64 0xc0(%rsi),%zmm5                      #! EA = L0x7fffffffd640; Value = 0x0000000000000000; PC = 0x5555555569f4 *)
mov zmm5_000 L0x7fffffffd640; (* zmm5_000=a03 *)
mov zmm5_001 L0x7fffffffd648;
mov zmm5_010 L0x7fffffffd650;
mov zmm5_011 L0x7fffffffd658;
mov zmm5_100 L0x7fffffffd660;
mov zmm5_101 L0x7fffffffd668;
mov zmm5_110 L0x7fffffffd670;
mov zmm5_111 L0x7fffffffd678;
(* vmovdqa64 %zmm0,%zmm15                          #! PC = 0x5555555569fb *)
mov zmm15_000 zmm0_000; (* zmm15_000=0 *)
mov zmm15_001 zmm0_001;
mov zmm15_010 zmm0_010;
mov zmm15_011 zmm0_011;
mov zmm15_100 zmm0_100;
mov zmm15_101 zmm0_101;
mov zmm15_110 zmm0_110;
mov zmm15_111 zmm0_111;
(* vpmadd52huq %zmm8,%zmm2,%zmm15 t = VMACLO(t, a0, a2) #! PC = 0x555555556a01 *)
assert true && and [
zmm8_000 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj zmm8_zmm2_000F zmm8_000 zmm2_000; spl zmm8_zmm2_000h_t zmm8_zmm2_000l_t zmm8_zmm2_000F 52;
umulj zmm8_zmm2_001F zmm8_001 zmm2_001; spl zmm8_zmm2_001h_t zmm8_zmm2_001l_t zmm8_zmm2_001F 52;
umulj zmm8_zmm2_010F zmm8_010 zmm2_010; spl zmm8_zmm2_010h_t zmm8_zmm2_010l_t zmm8_zmm2_010F 52;
umulj zmm8_zmm2_011F zmm8_011 zmm2_011; spl zmm8_zmm2_011h_t zmm8_zmm2_011l_t zmm8_zmm2_011F 52;
umulj zmm8_zmm2_100F zmm8_100 zmm2_100; spl zmm8_zmm2_100h_t zmm8_zmm2_100l_t zmm8_zmm2_100F 52;
umulj zmm8_zmm2_101F zmm8_101 zmm2_101; spl zmm8_zmm2_101h_t zmm8_zmm2_101l_t zmm8_zmm2_101F 52;
umulj zmm8_zmm2_110F zmm8_110 zmm2_110; spl zmm8_zmm2_110h_t zmm8_zmm2_110l_t zmm8_zmm2_110F 52;
umulj zmm8_zmm2_111F zmm8_111 zmm2_111; spl zmm8_zmm2_111h_t zmm8_zmm2_111l_t zmm8_zmm2_111F 52;
vpc zmm8_zmm2_000h_t@uint64 zmm8_zmm2_000h_t; vpc zmm8_zmm2_000l_t@uint64 zmm8_zmm2_000l_t;
vpc zmm8_zmm2_001h_t@uint64 zmm8_zmm2_001h_t; vpc zmm8_zmm2_001l_t@uint64 zmm8_zmm2_001l_t;
vpc zmm8_zmm2_010h_t@uint64 zmm8_zmm2_010h_t; vpc zmm8_zmm2_010l_t@uint64 zmm8_zmm2_010l_t;
vpc zmm8_zmm2_011h_t@uint64 zmm8_zmm2_011h_t; vpc zmm8_zmm2_011l_t@uint64 zmm8_zmm2_011l_t;
vpc zmm8_zmm2_100h_t@uint64 zmm8_zmm2_100h_t; vpc zmm8_zmm2_100l_t@uint64 zmm8_zmm2_100l_t;
vpc zmm8_zmm2_101h_t@uint64 zmm8_zmm2_101h_t; vpc zmm8_zmm2_101l_t@uint64 zmm8_zmm2_101l_t;
vpc zmm8_zmm2_110h_t@uint64 zmm8_zmm2_110h_t; vpc zmm8_zmm2_110l_t@uint64 zmm8_zmm2_110l_t;
vpc zmm8_zmm2_111h_t@uint64 zmm8_zmm2_111h_t; vpc zmm8_zmm2_111l_t@uint64 zmm8_zmm2_111l_t;
add zmm15_000 zmm15_000 zmm8_zmm2_000h_t; (* zmm15_000=(a00*a02)h *)
add zmm15_001 zmm15_001 zmm8_zmm2_001h_t;
add zmm15_010 zmm15_010 zmm8_zmm2_010h_t;
add zmm15_011 zmm15_011 zmm8_zmm2_011h_t;
add zmm15_100 zmm15_100 zmm8_zmm2_100h_t;
add zmm15_101 zmm15_101 zmm8_zmm2_101h_t;
add zmm15_110 zmm15_110 zmm8_zmm2_110h_t;
add zmm15_111 zmm15_111 zmm8_zmm2_111h_t;
(* vpaddq %zmm1,%zmm12,%zmm13                      #! PC = 0x555555556a07 *)
add zmm13_000 zmm12_000 zmm1_000; (* zmm13_000=(a00*a01)l+(a00*a00)h *)
add zmm13_001 zmm12_001 zmm1_001;
add zmm13_010 zmm12_010 zmm1_010;
add zmm13_011 zmm12_011 zmm1_011;
add zmm13_100 zmm12_100 zmm1_100;
add zmm13_101 zmm12_101 zmm1_101;
add zmm13_110 zmm12_110 zmm1_110;
add zmm13_111 zmm12_111 zmm1_111;
(* vmovdqa64 %zmm0,%zmm9                           #! PC = 0x555555556a0d *)
mov zmm9_000 zmm0_000; (* zmm9_000=0 *)
mov zmm9_001 zmm0_001;
mov zmm9_010 zmm0_010;
mov zmm9_011 zmm0_011;
mov zmm9_100 zmm0_100;
mov zmm9_101 zmm0_101;
mov zmm9_110 zmm0_110;
mov zmm9_111 zmm0_111;
(* vmovdqa64 %zmm0,%zmm12                          #! PC = 0x555555556a13 *)
mov zmm12_000 zmm0_000; (* zmm12_000=0 *)
mov zmm12_001 zmm0_001;
mov zmm12_010 zmm0_010;
mov zmm12_011 zmm0_011;
mov zmm12_100 zmm0_100;
mov zmm12_101 zmm0_101;
mov zmm12_110 zmm0_110;
mov zmm12_111 zmm0_111;
(* vpmadd52huq %zmm10,%zmm2,%zmm9                  #! PC = 0x555555556a19 *)
add zmm9_000 zmm9_000 zmm10_zmm2_000h_t; (* zmm9_000=(a00*a01)h *)
add zmm9_001 zmm9_001 zmm10_zmm2_001h_t;
add zmm9_010 zmm9_010 zmm10_zmm2_010h_t;
add zmm9_011 zmm9_011 zmm10_zmm2_011h_t;
add zmm9_100 zmm9_100 zmm10_zmm2_100h_t;
add zmm9_101 zmm9_101 zmm10_zmm2_101h_t;
add zmm9_110 zmm9_110 zmm10_zmm2_110h_t;
add zmm9_111 zmm9_111 zmm10_zmm2_111h_t;
(* vpmadd52luq %zmm5,%zmm2,%zmm12                  #! PC = 0x555555556a1f *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj zmm5_zmm2_000F zmm5_000 zmm2_000; spl zmm5_zmm2_000h_t zmm5_zmm2_000l_t zmm5_zmm2_000F 52;
umulj zmm5_zmm2_001F zmm5_001 zmm2_001; spl zmm5_zmm2_001h_t zmm5_zmm2_001l_t zmm5_zmm2_001F 52;
umulj zmm5_zmm2_010F zmm5_010 zmm2_010; spl zmm5_zmm2_010h_t zmm5_zmm2_010l_t zmm5_zmm2_010F 52;
umulj zmm5_zmm2_011F zmm5_011 zmm2_011; spl zmm5_zmm2_011h_t zmm5_zmm2_011l_t zmm5_zmm2_011F 52;
umulj zmm5_zmm2_100F zmm5_100 zmm2_100; spl zmm5_zmm2_100h_t zmm5_zmm2_100l_t zmm5_zmm2_100F 52;
umulj zmm5_zmm2_101F zmm5_101 zmm2_101; spl zmm5_zmm2_101h_t zmm5_zmm2_101l_t zmm5_zmm2_101F 52;
umulj zmm5_zmm2_110F zmm5_110 zmm2_110; spl zmm5_zmm2_110h_t zmm5_zmm2_110l_t zmm5_zmm2_110F 52;
umulj zmm5_zmm2_111F zmm5_111 zmm2_111; spl zmm5_zmm2_111h_t zmm5_zmm2_111l_t zmm5_zmm2_111F 52;
vpc zmm5_zmm2_000h_t@uint64 zmm5_zmm2_000h_t; vpc zmm5_zmm2_000l_t@uint64 zmm5_zmm2_000l_t;
vpc zmm5_zmm2_001h_t@uint64 zmm5_zmm2_001h_t; vpc zmm5_zmm2_001l_t@uint64 zmm5_zmm2_001l_t;
vpc zmm5_zmm2_010h_t@uint64 zmm5_zmm2_010h_t; vpc zmm5_zmm2_010l_t@uint64 zmm5_zmm2_010l_t;
vpc zmm5_zmm2_011h_t@uint64 zmm5_zmm2_011h_t; vpc zmm5_zmm2_011l_t@uint64 zmm5_zmm2_011l_t;
vpc zmm5_zmm2_100h_t@uint64 zmm5_zmm2_100h_t; vpc zmm5_zmm2_100l_t@uint64 zmm5_zmm2_100l_t;
vpc zmm5_zmm2_101h_t@uint64 zmm5_zmm2_101h_t; vpc zmm5_zmm2_101l_t@uint64 zmm5_zmm2_101l_t;
vpc zmm5_zmm2_110h_t@uint64 zmm5_zmm2_110h_t; vpc zmm5_zmm2_110l_t@uint64 zmm5_zmm2_110l_t;
vpc zmm5_zmm2_111h_t@uint64 zmm5_zmm2_111h_t; vpc zmm5_zmm2_111l_t@uint64 zmm5_zmm2_111l_t;
add zmm12_000 zmm12_000 zmm5_zmm2_000l_t; (* zmm12_000=(a00*a03)l *)
add zmm12_001 zmm12_001 zmm5_zmm2_001l_t;
add zmm12_010 zmm12_010 zmm5_zmm2_010l_t;
add zmm12_011 zmm12_011 zmm5_zmm2_011l_t;
add zmm12_100 zmm12_100 zmm5_zmm2_100l_t;
add zmm12_101 zmm12_101 zmm5_zmm2_101l_t;
add zmm12_110 zmm12_110 zmm5_zmm2_110l_t;
add zmm12_111 zmm12_111 zmm5_zmm2_111l_t;
(* vmovdqa64 %zmm0,%zmm6                           #! PC = 0x555555556a25 *)
mov zmm6_000 zmm0_000; (* zmm6_000=0 *)
mov zmm6_001 zmm0_001;
mov zmm6_010 zmm0_010;
mov zmm6_011 zmm0_011;
mov zmm6_100 zmm0_100;
mov zmm6_101 zmm0_101;
mov zmm6_110 zmm0_110;
mov zmm6_111 zmm0_111;
(* vpmadd52luq %zmm8,%zmm2,%zmm6                   #! PC = 0x555555556a2b *)
add zmm6_000 zmm6_000 zmm8_zmm2_000l_t; (* zmm6_000=(a00*a02)l *)
add zmm6_001 zmm6_001 zmm8_zmm2_001l_t;
add zmm6_010 zmm6_010 zmm8_zmm2_010l_t;
add zmm6_011 zmm6_011 zmm8_zmm2_011l_t;
add zmm6_100 zmm6_100 zmm8_zmm2_100l_t;
add zmm6_101 zmm6_101 zmm8_zmm2_101l_t;
add zmm6_110 zmm6_110 zmm8_zmm2_110l_t;
add zmm6_111 zmm6_111 zmm8_zmm2_111l_t;
(* vpsllq $0x1,%zmm15,%zmm1                        #! PC = 0x555555556a31 *)
shl zmm1_000 zmm15_000 0x1; (* zmm1_000=(a00*a02)h<<1 *)
shl zmm1_001 zmm15_001 0x1;
shl zmm1_010 zmm15_010 0x1;
shl zmm1_011 zmm15_011 0x1;
shl zmm1_100 zmm15_100 0x1;
shl zmm1_101 zmm15_101 0x1;
shl zmm1_110 zmm15_110 0x1;
shl zmm1_111 zmm15_111 0x1;
(* vpmadd52huq %zmm10,%zmm10,%zmm1                 #! PC = 0x555555556a38 *)
assert true && and [
zmm10_000 <u 0x10000000000000@64, zmm10_000 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64
];
umulj zmm10_zmm10_000F zmm10_000 zmm10_000; spl zmm10_zmm10_000h_t zmm10_zmm10_000l_t zmm10_zmm10_000F 52;
umulj zmm10_zmm10_001F zmm10_001 zmm10_001; spl zmm10_zmm10_001h_t zmm10_zmm10_001l_t zmm10_zmm10_001F 52;
umulj zmm10_zmm10_010F zmm10_010 zmm10_010; spl zmm10_zmm10_010h_t zmm10_zmm10_010l_t zmm10_zmm10_010F 52;
umulj zmm10_zmm10_011F zmm10_011 zmm10_011; spl zmm10_zmm10_011h_t zmm10_zmm10_011l_t zmm10_zmm10_011F 52;
umulj zmm10_zmm10_100F zmm10_100 zmm10_100; spl zmm10_zmm10_100h_t zmm10_zmm10_100l_t zmm10_zmm10_100F 52;
umulj zmm10_zmm10_101F zmm10_101 zmm10_101; spl zmm10_zmm10_101h_t zmm10_zmm10_101l_t zmm10_zmm10_101F 52;
umulj zmm10_zmm10_110F zmm10_110 zmm10_110; spl zmm10_zmm10_110h_t zmm10_zmm10_110l_t zmm10_zmm10_110F 52;
umulj zmm10_zmm10_111F zmm10_111 zmm10_111; spl zmm10_zmm10_111h_t zmm10_zmm10_111l_t zmm10_zmm10_111F 52;
vpc zmm10_zmm10_000h_t@uint64 zmm10_zmm10_000h_t; vpc zmm10_zmm10_000l_t@uint64 zmm10_zmm10_000l_t;
vpc zmm10_zmm10_001h_t@uint64 zmm10_zmm10_001h_t; vpc zmm10_zmm10_001l_t@uint64 zmm10_zmm10_001l_t;
vpc zmm10_zmm10_010h_t@uint64 zmm10_zmm10_010h_t; vpc zmm10_zmm10_010l_t@uint64 zmm10_zmm10_010l_t;
vpc zmm10_zmm10_011h_t@uint64 zmm10_zmm10_011h_t; vpc zmm10_zmm10_011l_t@uint64 zmm10_zmm10_011l_t;
vpc zmm10_zmm10_100h_t@uint64 zmm10_zmm10_100h_t; vpc zmm10_zmm10_100l_t@uint64 zmm10_zmm10_100l_t;
vpc zmm10_zmm10_101h_t@uint64 zmm10_zmm10_101h_t; vpc zmm10_zmm10_101l_t@uint64 zmm10_zmm10_101l_t;
vpc zmm10_zmm10_110h_t@uint64 zmm10_zmm10_110h_t; vpc zmm10_zmm10_110l_t@uint64 zmm10_zmm10_110l_t;
vpc zmm10_zmm10_111h_t@uint64 zmm10_zmm10_111h_t; vpc zmm10_zmm10_111l_t@uint64 zmm10_zmm10_111l_t;
add zmm1_000 zmm1_000 zmm10_zmm10_000h_t; (* zmm1_000=(a00*a02)h<<1+(a01*a01)h *)
add zmm1_001 zmm1_001 zmm10_zmm10_001h_t;
add zmm1_010 zmm1_010 zmm10_zmm10_010h_t;
add zmm1_011 zmm1_011 zmm10_zmm10_011h_t;
add zmm1_100 zmm1_100 zmm10_zmm10_100h_t;
add zmm1_101 zmm1_101 zmm10_zmm10_101h_t;
add zmm1_110 zmm1_110 zmm10_zmm10_110h_t;
add zmm1_111 zmm1_111 zmm10_zmm10_111h_t;
(* vpmadd52luq %zmm8,%zmm10,%zmm12                 #! PC = 0x555555556a3e *)
assert true && and [
zmm8_000 <u 0x10000000000000@64, zmm10_000 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64
];
umulj zmm8_zmm10_000F zmm8_000 zmm10_000; spl zmm8_zmm10_000h_t zmm8_zmm10_000l_t zmm8_zmm10_000F 52;
umulj zmm8_zmm10_001F zmm8_001 zmm10_001; spl zmm8_zmm10_001h_t zmm8_zmm10_001l_t zmm8_zmm10_001F 52;
umulj zmm8_zmm10_010F zmm8_010 zmm10_010; spl zmm8_zmm10_010h_t zmm8_zmm10_010l_t zmm8_zmm10_010F 52;
umulj zmm8_zmm10_011F zmm8_011 zmm10_011; spl zmm8_zmm10_011h_t zmm8_zmm10_011l_t zmm8_zmm10_011F 52;
umulj zmm8_zmm10_100F zmm8_100 zmm10_100; spl zmm8_zmm10_100h_t zmm8_zmm10_100l_t zmm8_zmm10_100F 52;
umulj zmm8_zmm10_101F zmm8_101 zmm10_101; spl zmm8_zmm10_101h_t zmm8_zmm10_101l_t zmm8_zmm10_101F 52;
umulj zmm8_zmm10_110F zmm8_110 zmm10_110; spl zmm8_zmm10_110h_t zmm8_zmm10_110l_t zmm8_zmm10_110F 52;
umulj zmm8_zmm10_111F zmm8_111 zmm10_111; spl zmm8_zmm10_111h_t zmm8_zmm10_111l_t zmm8_zmm10_111F 52;
vpc zmm8_zmm10_000h_t@uint64 zmm8_zmm10_000h_t; vpc zmm8_zmm10_000l_t@uint64 zmm8_zmm10_000l_t;
vpc zmm8_zmm10_001h_t@uint64 zmm8_zmm10_001h_t; vpc zmm8_zmm10_001l_t@uint64 zmm8_zmm10_001l_t;
vpc zmm8_zmm10_010h_t@uint64 zmm8_zmm10_010h_t; vpc zmm8_zmm10_010l_t@uint64 zmm8_zmm10_010l_t;
vpc zmm8_zmm10_011h_t@uint64 zmm8_zmm10_011h_t; vpc zmm8_zmm10_011l_t@uint64 zmm8_zmm10_011l_t;
vpc zmm8_zmm10_100h_t@uint64 zmm8_zmm10_100h_t; vpc zmm8_zmm10_100l_t@uint64 zmm8_zmm10_100l_t;
vpc zmm8_zmm10_101h_t@uint64 zmm8_zmm10_101h_t; vpc zmm8_zmm10_101l_t@uint64 zmm8_zmm10_101l_t;
vpc zmm8_zmm10_110h_t@uint64 zmm8_zmm10_110h_t; vpc zmm8_zmm10_110l_t@uint64 zmm8_zmm10_110l_t;
vpc zmm8_zmm10_111h_t@uint64 zmm8_zmm10_111h_t; vpc zmm8_zmm10_111l_t@uint64 zmm8_zmm10_111l_t;
add zmm12_000 zmm12_000 zmm8_zmm10_000l_t; (* zmm12_000=(a00*a03)l+(a02*a01)l *)
add zmm12_001 zmm12_001 zmm8_zmm10_001l_t;
add zmm12_010 zmm12_010 zmm8_zmm10_010l_t;
add zmm12_011 zmm12_011 zmm8_zmm10_011l_t;
add zmm12_100 zmm12_100 zmm8_zmm10_100l_t;
add zmm12_101 zmm12_101 zmm8_zmm10_101l_t;
add zmm12_110 zmm12_110 zmm8_zmm10_110l_t;
add zmm12_111 zmm12_111 zmm8_zmm10_111l_t;
(* vpsllq $0x2,%zmm9,%zmm3                         #! PC = 0x555555556a44 *)
shl zmm3_000 zmm9_000 0x2; (* zmm3_000=(a00*a01)h<<2 *)
shl zmm3_001 zmm9_001 0x2;
shl zmm3_010 zmm9_010 0x2;
shl zmm3_011 zmm9_011 0x2;
shl zmm3_100 zmm9_100 0x2;
shl zmm3_101 zmm9_101 0x2;
shl zmm3_110 zmm9_110 0x2;
shl zmm3_111 zmm9_111 0x2;
(* vmovdqa64 %zmm0,%zmm9                           #! PC = 0x555555556a4b *)
mov zmm9_000 zmm0_000; (* zmm9_000=0 *)
mov zmm9_001 zmm0_001;
mov zmm9_010 zmm0_010;
mov zmm9_011 zmm0_011;
mov zmm9_100 zmm0_100;
mov zmm9_101 zmm0_101;
mov zmm9_110 zmm0_110;
mov zmm9_111 zmm0_111;
(* vpmadd52huq %zmm5,%zmm2,%zmm9                   #! PC = 0x555555556a51 *)
add zmm9_000 zmm9_000 zmm5_zmm2_000h_t; (* zmm9_000=(a00*a03)h *)
add zmm9_001 zmm9_001 zmm5_zmm2_001h_t;
add zmm9_010 zmm9_010 zmm5_zmm2_010h_t;
add zmm9_011 zmm9_011 zmm5_zmm2_011h_t;
add zmm9_100 zmm9_100 zmm5_zmm2_100h_t;
add zmm9_101 zmm9_101 zmm5_zmm2_101h_t;
add zmm9_110 zmm9_110 zmm5_zmm2_110h_t;
add zmm9_111 zmm9_111 zmm5_zmm2_111h_t;
(* vmovdqa64 0x100(%rsi),%zmm7                     #! EA = L0x7fffffffd680; Value = 0x00007ffff7caec80; PC = 0x555555556a57 *)
mov zmm7_000 L0x7fffffffd680; (* zmm7_000=a04 *)
mov zmm7_001 L0x7fffffffd688;
mov zmm7_010 L0x7fffffffd690;
mov zmm7_011 L0x7fffffffd698;
mov zmm7_100 L0x7fffffffd6a0;
mov zmm7_101 L0x7fffffffd6a8;
mov zmm7_110 L0x7fffffffd6b0;
mov zmm7_111 L0x7fffffffd6b8;
(* vpsllq $0x1,%zmm6,%zmm11                        #! PC = 0x555555556a5e *)
shl zmm11_000 zmm6_000 0x1; (* zmm11_000=(a00*a02)l<<1 *)
shl zmm11_001 zmm6_001 0x1;
shl zmm11_010 zmm6_010 0x1;
shl zmm11_011 zmm6_011 0x1;
shl zmm11_100 zmm6_100 0x1;
shl zmm11_101 zmm6_101 0x1;
shl zmm11_110 zmm6_110 0x1;
shl zmm11_111 zmm6_111 0x1;
(* vpaddq %zmm11,%zmm3,%zmm14                      #! PC = 0x555555556a65 *)
add zmm14_000 zmm3_000 zmm11_000; (* zmm14_000=(a00*a01)h<<2+(a00*a02)l<<1 *)
add zmm14_001 zmm3_001 zmm11_001;
add zmm14_010 zmm3_010 zmm11_010;
add zmm14_011 zmm3_011 zmm11_011;
add zmm14_100 zmm3_100 zmm11_100;
add zmm14_101 zmm3_101 zmm11_101;
add zmm14_110 zmm3_110 zmm11_110;
add zmm14_111 zmm3_111 zmm11_111;
(* vpaddq %zmm1,%zmm12,%zmm11                      #! PC = 0x555555556a6b *)
add zmm11_000 zmm12_000 zmm1_000; (* zmm11_000=(a00*a03)l+(a02*a01)l+(a00*a02)h<<1+(a01*a01)h *)
add zmm11_001 zmm12_001 zmm1_001;
add zmm11_010 zmm12_010 zmm1_010;
add zmm11_011 zmm12_011 zmm1_011;
add zmm11_100 zmm12_100 zmm1_100;
add zmm11_101 zmm12_101 zmm1_101;
add zmm11_110 zmm12_110 zmm1_110;
add zmm11_111 zmm12_111 zmm1_111;
(* vmovdqa64 %zmm0,%zmm12                          #! PC = 0x555555556a71 *)
mov zmm12_000 zmm0_000; (* zmm12_000=0 *)
mov zmm12_001 zmm0_001;
mov zmm12_010 zmm0_010;
mov zmm12_011 zmm0_011;
mov zmm12_100 zmm0_100;
mov zmm12_101 zmm0_101;
mov zmm12_110 zmm0_110;
mov zmm12_111 zmm0_111;
(* vpmadd52huq %zmm8,%zmm10,%zmm9                  #! PC = 0x555555556a77 *)
add zmm9_000 zmm9_000 zmm8_zmm10_000h_t; (* zmm9_000=(a00*a03)h+(a02*a01)h *)
add zmm9_001 zmm9_001 zmm8_zmm10_001h_t;
add zmm9_010 zmm9_010 zmm8_zmm10_010h_t;
add zmm9_011 zmm9_011 zmm8_zmm10_011h_t;
add zmm9_100 zmm9_100 zmm8_zmm10_100h_t;
add zmm9_101 zmm9_101 zmm8_zmm10_101h_t;
add zmm9_110 zmm9_110 zmm8_zmm10_110h_t;
add zmm9_111 zmm9_111 zmm8_zmm10_111h_t;
(* vpmadd52huq %zmm7,%zmm2,%zmm12                  #! PC = 0x555555556a7d *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj zmm7_zmm2_000F zmm7_000 zmm2_000; spl zmm7_zmm2_000h_t zmm7_zmm2_000l_t zmm7_zmm2_000F 52;
umulj zmm7_zmm2_001F zmm7_001 zmm2_001; spl zmm7_zmm2_001h_t zmm7_zmm2_001l_t zmm7_zmm2_001F 52;
umulj zmm7_zmm2_010F zmm7_010 zmm2_010; spl zmm7_zmm2_010h_t zmm7_zmm2_010l_t zmm7_zmm2_010F 52;
umulj zmm7_zmm2_011F zmm7_011 zmm2_011; spl zmm7_zmm2_011h_t zmm7_zmm2_011l_t zmm7_zmm2_011F 52;
umulj zmm7_zmm2_100F zmm7_100 zmm2_100; spl zmm7_zmm2_100h_t zmm7_zmm2_100l_t zmm7_zmm2_100F 52;
umulj zmm7_zmm2_101F zmm7_101 zmm2_101; spl zmm7_zmm2_101h_t zmm7_zmm2_101l_t zmm7_zmm2_101F 52;
umulj zmm7_zmm2_110F zmm7_110 zmm2_110; spl zmm7_zmm2_110h_t zmm7_zmm2_110l_t zmm7_zmm2_110F 52;
umulj zmm7_zmm2_111F zmm7_111 zmm2_111; spl zmm7_zmm2_111h_t zmm7_zmm2_111l_t zmm7_zmm2_111F 52;
vpc zmm7_zmm2_000h_t@uint64 zmm7_zmm2_000h_t; vpc zmm7_zmm2_000l_t@uint64 zmm7_zmm2_000l_t;
vpc zmm7_zmm2_001h_t@uint64 zmm7_zmm2_001h_t; vpc zmm7_zmm2_001l_t@uint64 zmm7_zmm2_001l_t;
vpc zmm7_zmm2_010h_t@uint64 zmm7_zmm2_010h_t; vpc zmm7_zmm2_010l_t@uint64 zmm7_zmm2_010l_t;
vpc zmm7_zmm2_011h_t@uint64 zmm7_zmm2_011h_t; vpc zmm7_zmm2_011l_t@uint64 zmm7_zmm2_011l_t;
vpc zmm7_zmm2_100h_t@uint64 zmm7_zmm2_100h_t; vpc zmm7_zmm2_100l_t@uint64 zmm7_zmm2_100l_t;
vpc zmm7_zmm2_101h_t@uint64 zmm7_zmm2_101h_t; vpc zmm7_zmm2_101l_t@uint64 zmm7_zmm2_101l_t;
vpc zmm7_zmm2_110h_t@uint64 zmm7_zmm2_110h_t; vpc zmm7_zmm2_110l_t@uint64 zmm7_zmm2_110l_t;
vpc zmm7_zmm2_111h_t@uint64 zmm7_zmm2_111h_t; vpc zmm7_zmm2_111l_t@uint64 zmm7_zmm2_111l_t;
add zmm12_000 zmm12_000 zmm7_zmm2_000h_t; (* zmm12_000=(a00*a04)h *)
add zmm12_001 zmm12_001 zmm7_zmm2_001h_t;
add zmm12_010 zmm12_010 zmm7_zmm2_010h_t;
add zmm12_011 zmm12_011 zmm7_zmm2_011h_t;
add zmm12_100 zmm12_100 zmm7_zmm2_100h_t;
add zmm12_101 zmm12_101 zmm7_zmm2_101h_t;
add zmm12_110 zmm12_110 zmm7_zmm2_110h_t;
add zmm12_111 zmm12_111 zmm7_zmm2_111h_t;
(* vmovdqa64 %zmm0,%zmm3                           #! PC = 0x555555556a83 *)
mov zmm3_000 zmm0_000; (* zmm3_000=0 *)
mov zmm3_001 zmm0_001;
mov zmm3_010 zmm0_010;
mov zmm3_011 zmm0_011;
mov zmm3_100 zmm0_100;
mov zmm3_101 zmm0_101;
mov zmm3_110 zmm0_110;
mov zmm3_111 zmm0_111;
(* vpmadd52luq %zmm7,%zmm2,%zmm3                   #! PC = 0x555555556a89 *)
add zmm3_000 zmm3_000 zmm7_zmm2_000l_t; (* zmm3_000=(a00*a04)l *)
add zmm3_001 zmm3_001 zmm7_zmm2_001l_t;
add zmm3_010 zmm3_010 zmm7_zmm2_010l_t;
add zmm3_011 zmm3_011 zmm7_zmm2_011l_t;
add zmm3_100 zmm3_100 zmm7_zmm2_100l_t;
add zmm3_101 zmm3_101 zmm7_zmm2_101l_t;
add zmm3_110 zmm3_110 zmm7_zmm2_110l_t;
add zmm3_111 zmm3_111 zmm7_zmm2_111l_t;
(* vmovdqa64 %zmm0,%zmm4                           #! PC = 0x555555556a8f *)
mov zmm4_000 zmm0_000; (* zmm4_000=0 *)
mov zmm4_001 zmm0_001;
mov zmm4_010 zmm0_010;
mov zmm4_011 zmm0_011;
mov zmm4_100 zmm0_100;
mov zmm4_101 zmm0_101;
mov zmm4_110 zmm0_110;
mov zmm4_111 zmm0_111;
(* vpsllq $0x2,%zmm9,%zmm6                         #! PC = 0x555555556a95 *)
shl zmm6_000 zmm9_000 0x2; (* zmm6_000=((a00*a03)h+(a02*a01)h)<<2 *)
shl zmm6_001 zmm9_001 0x2;
shl zmm6_010 zmm9_010 0x2;
shl zmm6_011 zmm9_011 0x2;
shl zmm6_100 zmm9_100 0x2;
shl zmm6_101 zmm9_101 0x2;
shl zmm6_110 zmm9_110 0x2;
shl zmm6_111 zmm9_111 0x2;
(* vpmadd52huq %zmm5,%zmm10,%zmm12                 #! PC = 0x555555556a9c *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm10_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64
];
umulj zmm5_zmm10_000F zmm5_000 zmm10_000; spl zmm5_zmm10_000h_t zmm5_zmm10_000l_t zmm5_zmm10_000F 52;
umulj zmm5_zmm10_001F zmm5_001 zmm10_001; spl zmm5_zmm10_001h_t zmm5_zmm10_001l_t zmm5_zmm10_001F 52;
umulj zmm5_zmm10_010F zmm5_010 zmm10_010; spl zmm5_zmm10_010h_t zmm5_zmm10_010l_t zmm5_zmm10_010F 52;
umulj zmm5_zmm10_011F zmm5_011 zmm10_011; spl zmm5_zmm10_011h_t zmm5_zmm10_011l_t zmm5_zmm10_011F 52;
umulj zmm5_zmm10_100F zmm5_100 zmm10_100; spl zmm5_zmm10_100h_t zmm5_zmm10_100l_t zmm5_zmm10_100F 52;
umulj zmm5_zmm10_101F zmm5_101 zmm10_101; spl zmm5_zmm10_101h_t zmm5_zmm10_101l_t zmm5_zmm10_101F 52;
umulj zmm5_zmm10_110F zmm5_110 zmm10_110; spl zmm5_zmm10_110h_t zmm5_zmm10_110l_t zmm5_zmm10_110F 52;
umulj zmm5_zmm10_111F zmm5_111 zmm10_111; spl zmm5_zmm10_111h_t zmm5_zmm10_111l_t zmm5_zmm10_111F 52;
vpc zmm5_zmm10_000h_t@uint64 zmm5_zmm10_000h_t; vpc zmm5_zmm10_000l_t@uint64 zmm5_zmm10_000l_t;
vpc zmm5_zmm10_001h_t@uint64 zmm5_zmm10_001h_t; vpc zmm5_zmm10_001l_t@uint64 zmm5_zmm10_001l_t;
vpc zmm5_zmm10_010h_t@uint64 zmm5_zmm10_010h_t; vpc zmm5_zmm10_010l_t@uint64 zmm5_zmm10_010l_t;
vpc zmm5_zmm10_011h_t@uint64 zmm5_zmm10_011h_t; vpc zmm5_zmm10_011l_t@uint64 zmm5_zmm10_011l_t;
vpc zmm5_zmm10_100h_t@uint64 zmm5_zmm10_100h_t; vpc zmm5_zmm10_100l_t@uint64 zmm5_zmm10_100l_t;
vpc zmm5_zmm10_101h_t@uint64 zmm5_zmm10_101h_t; vpc zmm5_zmm10_101l_t@uint64 zmm5_zmm10_101l_t;
vpc zmm5_zmm10_110h_t@uint64 zmm5_zmm10_110h_t; vpc zmm5_zmm10_110l_t@uint64 zmm5_zmm10_110l_t;
vpc zmm5_zmm10_111h_t@uint64 zmm5_zmm10_111h_t; vpc zmm5_zmm10_111l_t@uint64 zmm5_zmm10_111l_t;
add zmm12_000 zmm12_000 zmm5_zmm10_000h_t; (* zmm12_000=(a00*a04)h+(a01*a03)h *)
add zmm12_001 zmm12_001 zmm5_zmm10_001h_t;
add zmm12_010 zmm12_010 zmm5_zmm10_010h_t;
add zmm12_011 zmm12_011 zmm5_zmm10_011h_t;
add zmm12_100 zmm12_100 zmm5_zmm10_100h_t;
add zmm12_101 zmm12_101 zmm5_zmm10_101h_t;
add zmm12_110 zmm12_110 zmm5_zmm10_110h_t;
add zmm12_111 zmm12_111 zmm5_zmm10_111h_t;
(* vmovdqa64 %zmm0,%zmm9                           #! PC = 0x555555556aa2 *)
mov zmm9_000 zmm0_000; (* zmm9_000=0 *)
mov zmm9_001 zmm0_001;
mov zmm9_010 zmm0_010;
mov zmm9_011 zmm0_011;
mov zmm9_100 zmm0_100;
mov zmm9_101 zmm0_101;
mov zmm9_110 zmm0_110;
mov zmm9_111 zmm0_111;
(* vpmadd52luq %zmm5,%zmm10,%zmm3                  #! PC = 0x555555556aa8 *)
add zmm3_000 zmm3_000 zmm5_zmm10_000l_t; (* zmm3_000=(a00*a04)l+(a01*a03)l *)
add zmm3_001 zmm3_001 zmm5_zmm10_001l_t;
add zmm3_010 zmm3_010 zmm5_zmm10_010l_t;
add zmm3_011 zmm3_011 zmm5_zmm10_011l_t;
add zmm3_100 zmm3_100 zmm5_zmm10_100l_t;
add zmm3_101 zmm3_101 zmm5_zmm10_101l_t;
add zmm3_110 zmm3_110 zmm5_zmm10_110l_t;
add zmm3_111 zmm3_111 zmm5_zmm10_111l_t;
(* vpmadd52luq %zmm7,%zmm10,%zmm9                  #! PC = 0x555555556aae *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm10_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm10_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm10_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm10_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm10_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm10_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm10_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm10_111 <u 0x10000000000000@64
];
umulj zmm7_zmm10_000F zmm7_000 zmm10_000; spl zmm7_zmm10_000h_t zmm7_zmm10_000l_t zmm7_zmm10_000F 52;
umulj zmm7_zmm10_001F zmm7_001 zmm10_001; spl zmm7_zmm10_001h_t zmm7_zmm10_001l_t zmm7_zmm10_001F 52;
umulj zmm7_zmm10_010F zmm7_010 zmm10_010; spl zmm7_zmm10_010h_t zmm7_zmm10_010l_t zmm7_zmm10_010F 52;
umulj zmm7_zmm10_011F zmm7_011 zmm10_011; spl zmm7_zmm10_011h_t zmm7_zmm10_011l_t zmm7_zmm10_011F 52;
umulj zmm7_zmm10_100F zmm7_100 zmm10_100; spl zmm7_zmm10_100h_t zmm7_zmm10_100l_t zmm7_zmm10_100F 52;
umulj zmm7_zmm10_101F zmm7_101 zmm10_101; spl zmm7_zmm10_101h_t zmm7_zmm10_101l_t zmm7_zmm10_101F 52;
umulj zmm7_zmm10_110F zmm7_110 zmm10_110; spl zmm7_zmm10_110h_t zmm7_zmm10_110l_t zmm7_zmm10_110F 52;
umulj zmm7_zmm10_111F zmm7_111 zmm10_111; spl zmm7_zmm10_111h_t zmm7_zmm10_111l_t zmm7_zmm10_111F 52;
vpc zmm7_zmm10_000h_t@uint64 zmm7_zmm10_000h_t; vpc zmm7_zmm10_000l_t@uint64 zmm7_zmm10_000l_t;
vpc zmm7_zmm10_001h_t@uint64 zmm7_zmm10_001h_t; vpc zmm7_zmm10_001l_t@uint64 zmm7_zmm10_001l_t;
vpc zmm7_zmm10_010h_t@uint64 zmm7_zmm10_010h_t; vpc zmm7_zmm10_010l_t@uint64 zmm7_zmm10_010l_t;
vpc zmm7_zmm10_011h_t@uint64 zmm7_zmm10_011h_t; vpc zmm7_zmm10_011l_t@uint64 zmm7_zmm10_011l_t;
vpc zmm7_zmm10_100h_t@uint64 zmm7_zmm10_100h_t; vpc zmm7_zmm10_100l_t@uint64 zmm7_zmm10_100l_t;
vpc zmm7_zmm10_101h_t@uint64 zmm7_zmm10_101h_t; vpc zmm7_zmm10_101l_t@uint64 zmm7_zmm10_101l_t;
vpc zmm7_zmm10_110h_t@uint64 zmm7_zmm10_110h_t; vpc zmm7_zmm10_110l_t@uint64 zmm7_zmm10_110l_t;
vpc zmm7_zmm10_111h_t@uint64 zmm7_zmm10_111h_t; vpc zmm7_zmm10_111l_t@uint64 zmm7_zmm10_111l_t;
add zmm9_000 zmm9_000 zmm7_zmm10_000l_t; (* zmm9_000=(a01*a04)l *)
add zmm9_001 zmm9_001 zmm7_zmm10_001l_t;
add zmm9_010 zmm9_010 zmm7_zmm10_010l_t;
add zmm9_011 zmm9_011 zmm7_zmm10_011l_t;
add zmm9_100 zmm9_100 zmm7_zmm10_100l_t;
add zmm9_101 zmm9_101 zmm7_zmm10_101l_t;
add zmm9_110 zmm9_110 zmm7_zmm10_110l_t;
add zmm9_111 zmm9_111 zmm7_zmm10_111l_t;
(* vpmadd52luq %zmm2,%zmm2,%zmm4                   #! PC = 0x555555556ab4 *)
add zmm4_000 zmm4_000 zmm2_zmm2_000l_t; (* zmm4_000=(a00*a00)l *)
add zmm4_001 zmm4_001 zmm2_zmm2_001l_t;
add zmm4_010 zmm4_010 zmm2_zmm2_010l_t;
add zmm4_011 zmm4_011 zmm2_zmm2_011l_t;
add zmm4_100 zmm4_100 zmm2_zmm2_100l_t;
add zmm4_101 zmm4_101 zmm2_zmm2_101l_t;
add zmm4_110 zmm4_110 zmm2_zmm2_110l_t;
add zmm4_111 zmm4_111 zmm2_zmm2_111l_t;
(* vpsllq $0x1,%zmm12,%zmm2                        #! PC = 0x555555556aba *)
shl zmm2_000 zmm12_000 0x1; (* zmm2_000=((a00*a04)h+(a01*a03)h)<<1 *)
shl zmm2_001 zmm12_001 0x1;
shl zmm2_010 zmm12_010 0x1;
shl zmm2_011 zmm12_011 0x1;
shl zmm2_100 zmm12_100 0x1;
shl zmm2_101 zmm12_101 0x1;
shl zmm2_110 zmm12_110 0x1;
shl zmm2_111 zmm12_111 0x1;
(* vpmadd52huq %zmm8,%zmm8,%zmm2                   #! PC = 0x555555556ac1 *)
assert true && and [
zmm8_000 <u 0x10000000000000@64, zmm8_000 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm8_001 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm8_010 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm8_011 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm8_100 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm8_101 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm8_110 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64, zmm8_111 <u 0x10000000000000@64
];
umulj zmm8_zmm8_000F zmm8_000 zmm8_000; spl zmm8_zmm8_000h_t zmm8_zmm8_000l_t zmm8_zmm8_000F 52;
umulj zmm8_zmm8_001F zmm8_001 zmm8_001; spl zmm8_zmm8_001h_t zmm8_zmm8_001l_t zmm8_zmm8_001F 52;
umulj zmm8_zmm8_010F zmm8_010 zmm8_010; spl zmm8_zmm8_010h_t zmm8_zmm8_010l_t zmm8_zmm8_010F 52;
umulj zmm8_zmm8_011F zmm8_011 zmm8_011; spl zmm8_zmm8_011h_t zmm8_zmm8_011l_t zmm8_zmm8_011F 52;
umulj zmm8_zmm8_100F zmm8_100 zmm8_100; spl zmm8_zmm8_100h_t zmm8_zmm8_100l_t zmm8_zmm8_100F 52;
umulj zmm8_zmm8_101F zmm8_101 zmm8_101; spl zmm8_zmm8_101h_t zmm8_zmm8_101l_t zmm8_zmm8_101F 52;
umulj zmm8_zmm8_110F zmm8_110 zmm8_110; spl zmm8_zmm8_110h_t zmm8_zmm8_110l_t zmm8_zmm8_110F 52;
umulj zmm8_zmm8_111F zmm8_111 zmm8_111; spl zmm8_zmm8_111h_t zmm8_zmm8_111l_t zmm8_zmm8_111F 52;
vpc zmm8_zmm8_000h_t@uint64 zmm8_zmm8_000h_t; vpc zmm8_zmm8_000l_t@uint64 zmm8_zmm8_000l_t;
vpc zmm8_zmm8_001h_t@uint64 zmm8_zmm8_001h_t; vpc zmm8_zmm8_001l_t@uint64 zmm8_zmm8_001l_t;
vpc zmm8_zmm8_010h_t@uint64 zmm8_zmm8_010h_t; vpc zmm8_zmm8_010l_t@uint64 zmm8_zmm8_010l_t;
vpc zmm8_zmm8_011h_t@uint64 zmm8_zmm8_011h_t; vpc zmm8_zmm8_011l_t@uint64 zmm8_zmm8_011l_t;
vpc zmm8_zmm8_100h_t@uint64 zmm8_zmm8_100h_t; vpc zmm8_zmm8_100l_t@uint64 zmm8_zmm8_100l_t;
vpc zmm8_zmm8_101h_t@uint64 zmm8_zmm8_101h_t; vpc zmm8_zmm8_101l_t@uint64 zmm8_zmm8_101l_t;
vpc zmm8_zmm8_110h_t@uint64 zmm8_zmm8_110h_t; vpc zmm8_zmm8_110l_t@uint64 zmm8_zmm8_110l_t;
vpc zmm8_zmm8_111h_t@uint64 zmm8_zmm8_111h_t; vpc zmm8_zmm8_111l_t@uint64 zmm8_zmm8_111l_t;
add zmm2_000 zmm2_000 zmm8_zmm8_000h_t; (* zmm2_000=((a00*a04)h+(a01*a03)h)<<1+(a02*a02)h *)
add zmm2_001 zmm2_001 zmm8_zmm8_001h_t;
add zmm2_010 zmm2_010 zmm8_zmm8_010h_t;
add zmm2_011 zmm2_011 zmm8_zmm8_011h_t;
add zmm2_100 zmm2_100 zmm8_zmm8_100h_t;
add zmm2_101 zmm2_101 zmm8_zmm8_101h_t;
add zmm2_110 zmm2_110 zmm8_zmm8_110h_t;
add zmm2_111 zmm2_111 zmm8_zmm8_111h_t;
(* vpsllq $0x1,%zmm3,%zmm15                        #! PC = 0x555555556ac7 *)
shl zmm15_000 zmm3_000 0x1; (* zmm15_000=((a00*a04)l+(a01*a03)l)<<1 *)
shl zmm15_001 zmm3_001 0x1;
shl zmm15_010 zmm3_010 0x1;
shl zmm15_011 zmm3_011 0x1;
shl zmm15_100 zmm3_100 0x1;
shl zmm15_101 zmm3_101 0x1;
shl zmm15_110 zmm3_110 0x1;
shl zmm15_111 zmm3_111 0x1;
(* vpmadd52luq %zmm5,%zmm8,%zmm9                   #! PC = 0x555555556ace *)
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
add zmm9_000 zmm9_000 zmm5_zmm8_000l_t; (* zmm9_000=(a01*a04)l+(a02*a03)l *)
add zmm9_001 zmm9_001 zmm5_zmm8_001l_t;
add zmm9_010 zmm9_010 zmm5_zmm8_010l_t;
add zmm9_011 zmm9_011 zmm5_zmm8_011l_t;
add zmm9_100 zmm9_100 zmm5_zmm8_100l_t;
add zmm9_101 zmm9_101 zmm5_zmm8_101l_t;
add zmm9_110 zmm9_110 zmm5_zmm8_110l_t;
add zmm9_111 zmm9_111 zmm5_zmm8_111l_t;
(* vmovdqa64 %zmm0,%zmm3                           #! PC = 0x555555556ad4 *)
mov zmm3_000 zmm0_000; (* zmm3_000=0 *)
mov zmm3_001 zmm0_001;
mov zmm3_010 zmm0_010;
mov zmm3_011 zmm0_011;
mov zmm3_100 zmm0_100;
mov zmm3_101 zmm0_101;
mov zmm3_110 zmm0_110;
mov zmm3_111 zmm0_111;
(* vpmadd52huq %zmm7,%zmm10,%zmm3                  #! PC = 0x555555556ada *)
add zmm3_000 zmm3_000 zmm7_zmm10_000h_t; (* zmm3_000=(a01*a04)h *)
add zmm3_001 zmm3_001 zmm7_zmm10_001h_t;
add zmm3_010 zmm3_010 zmm7_zmm10_010h_t;
add zmm3_011 zmm3_011 zmm7_zmm10_011h_t;
add zmm3_100 zmm3_100 zmm7_zmm10_100h_t;
add zmm3_101 zmm3_101 zmm7_zmm10_101h_t;
add zmm3_110 zmm3_110 zmm7_zmm10_110h_t;
add zmm3_111 zmm3_111 zmm7_zmm10_111h_t;
(* vpaddq %zmm15,%zmm6,%zmm1                       #! PC = 0x555555556ae0 *)
add zmm1_000 zmm6_000 zmm15_000; (* zmm1_000=((a00*a03)h+(a02*a01)h)<<2+((a00*a04)l+(a01*a03)l)<<1 *)
add zmm1_001 zmm6_001 zmm15_001;
add zmm1_010 zmm6_010 zmm15_010;
add zmm1_011 zmm6_011 zmm15_011;
add zmm1_100 zmm6_100 zmm15_100;
add zmm1_101 zmm6_101 zmm15_101;
add zmm1_110 zmm6_110 zmm15_110;
add zmm1_111 zmm6_111 zmm15_111;
(* vmovdqa64 %zmm0,%zmm15                          #! PC = 0x555555556ae6 *)
mov zmm15_000 zmm0_000; (* zmm15_000=0 *)
mov zmm15_001 zmm0_001;
mov zmm15_010 zmm0_010;
mov zmm15_011 zmm0_011;
mov zmm15_100 zmm0_100;
mov zmm15_101 zmm0_101;
mov zmm15_110 zmm0_110;
mov zmm15_111 zmm0_111;
(* vpaddq %zmm2,%zmm9,%zmm6                        #! PC = 0x555555556aec *)
add zmm6_000 zmm9_000 zmm2_000; (* zmm6_000=(a01*a04)l+(a02*a03)l+((a00*a04)h+(a01*a03)h)<<1+(a02*a02)h *)
add zmm6_001 zmm9_001 zmm2_001;
add zmm6_010 zmm9_010 zmm2_010;
add zmm6_011 zmm9_011 zmm2_011;
add zmm6_100 zmm9_100 zmm2_100;
add zmm6_101 zmm9_101 zmm2_101;
add zmm6_110 zmm9_110 zmm2_110;
add zmm6_111 zmm9_111 zmm2_111;
(* vmovdqa64 %zmm0,%zmm9                           #! PC = 0x555555556af2 *)
mov zmm9_000 zmm0_000; (* zmm9_000=0 *)
mov zmm9_001 zmm0_001;
mov zmm9_010 zmm0_010;
mov zmm9_011 zmm0_011;
mov zmm9_100 zmm0_100;
mov zmm9_101 zmm0_101;
mov zmm9_110 zmm0_110;
mov zmm9_111 zmm0_111;
(* vpmadd52huq %zmm5,%zmm8,%zmm3                   #! PC = 0x555555556af8 *)
add zmm3_000 zmm3_000 zmm5_zmm8_000h_t; (* zmm3_000=(a01*a04)h+(a02*a03)h *)
add zmm3_001 zmm3_001 zmm5_zmm8_001h_t;
add zmm3_010 zmm3_010 zmm5_zmm8_010h_t;
add zmm3_011 zmm3_011 zmm5_zmm8_011h_t;
add zmm3_100 zmm3_100 zmm5_zmm8_100h_t;
add zmm3_101 zmm3_101 zmm5_zmm8_101h_t;
add zmm3_110 zmm3_110 zmm5_zmm8_110h_t;
add zmm3_111 zmm3_111 zmm5_zmm8_111h_t;
(* vpmadd52luq %zmm7,%zmm8,%zmm15                  #! PC = 0x555555556afe *)
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
add zmm15_000 zmm15_000 zmm7_zmm8_000l_t; (* zmm15_000=(a02*a04)l *)
add zmm15_001 zmm15_001 zmm7_zmm8_001l_t;
add zmm15_010 zmm15_010 zmm7_zmm8_010l_t;
add zmm15_011 zmm15_011 zmm7_zmm8_011l_t;
add zmm15_100 zmm15_100 zmm7_zmm8_100l_t;
add zmm15_101 zmm15_101 zmm7_zmm8_101l_t;
add zmm15_110 zmm15_110 zmm7_zmm8_110l_t;
add zmm15_111 zmm15_111 zmm7_zmm8_111l_t;
(* vpmadd52huq %zmm7,%zmm8,%zmm9                   #! PC = 0x555555556b04 *)
add zmm9_000 zmm9_000 zmm7_zmm8_000h_t; (* zmm9_000=(a02*a04)h *)
add zmm9_001 zmm9_001 zmm7_zmm8_001h_t;
add zmm9_010 zmm9_010 zmm7_zmm8_010h_t;
add zmm9_011 zmm9_011 zmm7_zmm8_011h_t;
add zmm9_100 zmm9_100 zmm7_zmm8_100h_t;
add zmm9_101 zmm9_101 zmm7_zmm8_101h_t;
add zmm9_110 zmm9_110 zmm7_zmm8_110h_t;
add zmm9_111 zmm9_111 zmm7_zmm8_111h_t;
(* vpmadd52luq %zmm10,%zmm10,%zmm14                #! PC = 0x555555556b0a *)
add zmm14_000 zmm14_000 zmm10_zmm10_000l_t; (* zmm14_000=(a00*a01)h<<2+(a00*a02)l<<1+(a01*a01)l *)
add zmm14_001 zmm14_001 zmm10_zmm10_001l_t;
add zmm14_010 zmm14_010 zmm10_zmm10_010l_t;
add zmm14_011 zmm14_011 zmm10_zmm10_011l_t;
add zmm14_100 zmm14_100 zmm10_zmm10_100l_t;
add zmm14_101 zmm14_101 zmm10_zmm10_101l_t;
add zmm14_110 zmm14_110 zmm10_zmm10_110l_t;
add zmm14_111 zmm14_111 zmm10_zmm10_111l_t;
(* vpmadd52luq %zmm8,%zmm8,%zmm1                   #! PC = 0x555555556b10 *)
add zmm1_000 zmm1_000 zmm8_zmm8_000l_t; (* zmm1_000=((a00*a03)h+(a02*a01)h)<<2+((a00*a04)l+(a01*a03)l)<<1+(a02*a02)l *)
add zmm1_001 zmm1_001 zmm8_zmm8_001l_t;
add zmm1_010 zmm1_010 zmm8_zmm8_010l_t;
add zmm1_011 zmm1_011 zmm8_zmm8_011l_t;
add zmm1_100 zmm1_100 zmm8_zmm8_100l_t;
add zmm1_101 zmm1_101 zmm8_zmm8_101l_t;
add zmm1_110 zmm1_110 zmm8_zmm8_110l_t;
add zmm1_111 zmm1_111 zmm8_zmm8_111l_t;
(* vpsllq $0x2,%zmm3,%zmm10                        #! PC = 0x555555556b16 *)
shl zmm10_000 zmm3_000 0x2; (* zmm10_000=((a01*a04)h+(a02*a03)h)<<2 *)
shl zmm10_001 zmm3_001 0x2;
shl zmm10_010 zmm3_010 0x2;
shl zmm10_011 zmm3_011 0x2;
shl zmm10_100 zmm3_100 0x2;
shl zmm10_101 zmm3_101 0x2;
shl zmm10_110 zmm3_110 0x2;
shl zmm10_111 zmm3_111 0x2;
(* vpsllq $0x1,%zmm15,%zmm12                       #! PC = 0x555555556b1d *)
shl zmm12_000 zmm15_000 0x1; (* zmm12_000=(a02*a04)l<<1 *)
shl zmm12_001 zmm15_001 0x1;
shl zmm12_010 zmm15_010 0x1;
shl zmm12_011 zmm15_011 0x1;
shl zmm12_100 zmm15_100 0x1;
shl zmm12_101 zmm15_101 0x1;
shl zmm12_110 zmm15_110 0x1;
shl zmm12_111 zmm15_111 0x1;
(* vpsllq $0x1,%zmm9,%zmm8                         #! PC = 0x555555556b24 *)
shl zmm8_000 zmm9_000 0x1; (* zmm8_000=(a02*a04)h<<1 *)
shl zmm8_001 zmm9_001 0x1;
shl zmm8_010 zmm9_010 0x1;
shl zmm8_011 zmm9_011 0x1;
shl zmm8_100 zmm9_100 0x1;
shl zmm8_101 zmm9_101 0x1;
shl zmm8_110 zmm9_110 0x1;
shl zmm8_111 zmm9_111 0x1;
(* vmovdqa64 %zmm0,%zmm3                           #! PC = 0x555555556b2b *)
mov zmm3_000 zmm0_000; (* zmm3_000=0 *)
mov zmm3_001 zmm0_001;
mov zmm3_010 zmm0_010;
mov zmm3_011 zmm0_011;
mov zmm3_100 zmm0_100;
mov zmm3_101 zmm0_101;
mov zmm3_110 zmm0_110;
mov zmm3_111 zmm0_111;
(* vmovdqa64 %zmm0,%zmm15                          #! PC = 0x555555556b31 *)
mov zmm15_000 zmm0_000; (* zmm15_000=0 *)
mov zmm15_001 zmm0_001;
mov zmm15_010 zmm0_010;
mov zmm15_011 zmm0_011;
mov zmm15_100 zmm0_100;
mov zmm15_101 zmm0_101;
mov zmm15_110 zmm0_110;
mov zmm15_111 zmm0_111;
(* vpmadd52luq %zmm7,%zmm5,%zmm3                   #! PC = 0x555555556b37 *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm5_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64
];
umulj zmm7_zmm5_000F zmm7_000 zmm5_000; spl zmm7_zmm5_000h_t zmm7_zmm5_000l_t zmm7_zmm5_000F 52;
umulj zmm7_zmm5_001F zmm7_001 zmm5_001; spl zmm7_zmm5_001h_t zmm7_zmm5_001l_t zmm7_zmm5_001F 52;
umulj zmm7_zmm5_010F zmm7_010 zmm5_010; spl zmm7_zmm5_010h_t zmm7_zmm5_010l_t zmm7_zmm5_010F 52;
umulj zmm7_zmm5_011F zmm7_011 zmm5_011; spl zmm7_zmm5_011h_t zmm7_zmm5_011l_t zmm7_zmm5_011F 52;
umulj zmm7_zmm5_100F zmm7_100 zmm5_100; spl zmm7_zmm5_100h_t zmm7_zmm5_100l_t zmm7_zmm5_100F 52;
umulj zmm7_zmm5_101F zmm7_101 zmm5_101; spl zmm7_zmm5_101h_t zmm7_zmm5_101l_t zmm7_zmm5_101F 52;
umulj zmm7_zmm5_110F zmm7_110 zmm5_110; spl zmm7_zmm5_110h_t zmm7_zmm5_110l_t zmm7_zmm5_110F 52;
umulj zmm7_zmm5_111F zmm7_111 zmm5_111; spl zmm7_zmm5_111h_t zmm7_zmm5_111l_t zmm7_zmm5_111F 52;
vpc zmm7_zmm5_000h_t@uint64 zmm7_zmm5_000h_t; vpc zmm7_zmm5_000l_t@uint64 zmm7_zmm5_000l_t;
vpc zmm7_zmm5_001h_t@uint64 zmm7_zmm5_001h_t; vpc zmm7_zmm5_001l_t@uint64 zmm7_zmm5_001l_t;
vpc zmm7_zmm5_010h_t@uint64 zmm7_zmm5_010h_t; vpc zmm7_zmm5_010l_t@uint64 zmm7_zmm5_010l_t;
vpc zmm7_zmm5_011h_t@uint64 zmm7_zmm5_011h_t; vpc zmm7_zmm5_011l_t@uint64 zmm7_zmm5_011l_t;
vpc zmm7_zmm5_100h_t@uint64 zmm7_zmm5_100h_t; vpc zmm7_zmm5_100l_t@uint64 zmm7_zmm5_100l_t;
vpc zmm7_zmm5_101h_t@uint64 zmm7_zmm5_101h_t; vpc zmm7_zmm5_101l_t@uint64 zmm7_zmm5_101l_t;
vpc zmm7_zmm5_110h_t@uint64 zmm7_zmm5_110h_t; vpc zmm7_zmm5_110l_t@uint64 zmm7_zmm5_110l_t;
vpc zmm7_zmm5_111h_t@uint64 zmm7_zmm5_111h_t; vpc zmm7_zmm5_111l_t@uint64 zmm7_zmm5_111l_t;
add zmm3_000 zmm3_000 zmm7_zmm5_000l_t; (* zmm3_000=(a03*a04)l *)
add zmm3_001 zmm3_001 zmm7_zmm5_001l_t;
add zmm3_010 zmm3_010 zmm7_zmm5_010l_t;
add zmm3_011 zmm3_011 zmm7_zmm5_011l_t;
add zmm3_100 zmm3_100 zmm7_zmm5_100l_t;
add zmm3_101 zmm3_101 zmm7_zmm5_101l_t;
add zmm3_110 zmm3_110 zmm7_zmm5_110l_t;
add zmm3_111 zmm3_111 zmm7_zmm5_111l_t;
(* vpmadd52huq %zmm7,%zmm5,%zmm15                  #! PC = 0x555555556b3d *)
add zmm15_000 zmm15_000 zmm7_zmm5_000h_t; (* zmm15_000=(a03*a04)h *)
add zmm15_001 zmm15_001 zmm7_zmm5_001h_t;
add zmm15_010 zmm15_010 zmm7_zmm5_010h_t;
add zmm15_011 zmm15_011 zmm7_zmm5_011h_t;
add zmm15_100 zmm15_100 zmm7_zmm5_100h_t;
add zmm15_101 zmm15_101 zmm7_zmm5_101h_t;
add zmm15_110 zmm15_110 zmm7_zmm5_110h_t;
add zmm15_111 zmm15_111 zmm7_zmm5_111h_t;
(* vpmadd52huq %zmm5,%zmm5,%zmm8                   #! PC = 0x555555556b43 *)
assert true && and [
zmm5_000 <u 0x10000000000000@64, zmm5_000 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm5_001 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm5_010 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm5_011 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm5_100 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm5_101 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm5_110 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64, zmm5_111 <u 0x10000000000000@64
];
umulj zmm5_zmm5_000F zmm5_000 zmm5_000; spl zmm5_zmm5_000h_t zmm5_zmm5_000l_t zmm5_zmm5_000F 52;
umulj zmm5_zmm5_001F zmm5_001 zmm5_001; spl zmm5_zmm5_001h_t zmm5_zmm5_001l_t zmm5_zmm5_001F 52;
umulj zmm5_zmm5_010F zmm5_010 zmm5_010; spl zmm5_zmm5_010h_t zmm5_zmm5_010l_t zmm5_zmm5_010F 52;
umulj zmm5_zmm5_011F zmm5_011 zmm5_011; spl zmm5_zmm5_011h_t zmm5_zmm5_011l_t zmm5_zmm5_011F 52;
umulj zmm5_zmm5_100F zmm5_100 zmm5_100; spl zmm5_zmm5_100h_t zmm5_zmm5_100l_t zmm5_zmm5_100F 52;
umulj zmm5_zmm5_101F zmm5_101 zmm5_101; spl zmm5_zmm5_101h_t zmm5_zmm5_101l_t zmm5_zmm5_101F 52;
umulj zmm5_zmm5_110F zmm5_110 zmm5_110; spl zmm5_zmm5_110h_t zmm5_zmm5_110l_t zmm5_zmm5_110F 52;
umulj zmm5_zmm5_111F zmm5_111 zmm5_111; spl zmm5_zmm5_111h_t zmm5_zmm5_111l_t zmm5_zmm5_111F 52;
vpc zmm5_zmm5_000h_t@uint64 zmm5_zmm5_000h_t; vpc zmm5_zmm5_000l_t@uint64 zmm5_zmm5_000l_t;
vpc zmm5_zmm5_001h_t@uint64 zmm5_zmm5_001h_t; vpc zmm5_zmm5_001l_t@uint64 zmm5_zmm5_001l_t;
vpc zmm5_zmm5_010h_t@uint64 zmm5_zmm5_010h_t; vpc zmm5_zmm5_010l_t@uint64 zmm5_zmm5_010l_t;
vpc zmm5_zmm5_011h_t@uint64 zmm5_zmm5_011h_t; vpc zmm5_zmm5_011l_t@uint64 zmm5_zmm5_011l_t;
vpc zmm5_zmm5_100h_t@uint64 zmm5_zmm5_100h_t; vpc zmm5_zmm5_100l_t@uint64 zmm5_zmm5_100l_t;
vpc zmm5_zmm5_101h_t@uint64 zmm5_zmm5_101h_t; vpc zmm5_zmm5_101l_t@uint64 zmm5_zmm5_101l_t;
vpc zmm5_zmm5_110h_t@uint64 zmm5_zmm5_110h_t; vpc zmm5_zmm5_110l_t@uint64 zmm5_zmm5_110l_t;
vpc zmm5_zmm5_111h_t@uint64 zmm5_zmm5_111h_t; vpc zmm5_zmm5_111l_t@uint64 zmm5_zmm5_111l_t;
add zmm8_000 zmm8_000 zmm5_zmm5_000h_t; (* zmm8_000=(a02*a04)h<<1+(a03*a03)h *)
add zmm8_001 zmm8_001 zmm5_zmm5_001h_t;
add zmm8_010 zmm8_010 zmm5_zmm5_010h_t;
add zmm8_011 zmm8_011 zmm5_zmm5_011h_t;
add zmm8_100 zmm8_100 zmm5_zmm5_100h_t;
add zmm8_101 zmm8_101 zmm5_zmm5_101h_t;
add zmm8_110 zmm8_110 zmm5_zmm5_110h_t;
add zmm8_111 zmm8_111 zmm5_zmm5_111h_t;
(* vpaddq %zmm12,%zmm10,%zmm2                      #! PC = 0x555555556b49 *)
add zmm2_000 zmm10_000 zmm12_000; (* zmm2_000=((a01*a04)h+(a02*a03)h)<<2+(a02*a04)l<<1 *)
add zmm2_001 zmm10_001 zmm12_001;
add zmm2_010 zmm10_010 zmm12_010;
add zmm2_011 zmm10_011 zmm12_011;
add zmm2_100 zmm10_100 zmm12_100;
add zmm2_101 zmm10_101 zmm12_101;
add zmm2_110 zmm10_110 zmm12_110;
add zmm2_111 zmm10_111 zmm12_111;
(* vpmadd52luq %zmm5,%zmm5,%zmm2                   #! PC = 0x555555556b4f *)
add zmm2_000 zmm2_000 zmm5_zmm5_000l_t; (* zmm2_000=((a01*a04)h+(a02*a03)h)<<2+(a02*a04)l<<1+(a03*a03)l *)
add zmm2_001 zmm2_001 zmm5_zmm5_001l_t;
add zmm2_010 zmm2_010 zmm5_zmm5_010l_t;
add zmm2_011 zmm2_011 zmm5_zmm5_011l_t;
add zmm2_100 zmm2_100 zmm5_zmm5_100l_t;
add zmm2_101 zmm2_101 zmm5_zmm5_101l_t;
add zmm2_110 zmm2_110 zmm5_zmm5_110l_t;
add zmm2_111 zmm2_111 zmm5_zmm5_111l_t;
(* vmovdqa64 %zmm0,%zmm5                           #! PC = 0x555555556b55 *)
mov zmm5_000 zmm0_000; (* zmm5_000=0 *)
mov zmm5_001 zmm0_001;
mov zmm5_010 zmm0_010;
mov zmm5_011 zmm0_011;
mov zmm5_100 zmm0_100;
mov zmm5_101 zmm0_101;
mov zmm5_110 zmm0_110;
mov zmm5_111 zmm0_111;
(* vpmadd52huq %zmm7,%zmm7,%zmm5                   #! PC = 0x555555556b5b *)
assert true && and [
zmm7_000 <u 0x10000000000000@64, zmm7_000 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64
];
umulj zmm7_zmm7_000F zmm7_000 zmm7_000; spl zmm7_zmm7_000h_t zmm7_zmm7_000l_t zmm7_zmm7_000F 52;
umulj zmm7_zmm7_001F zmm7_001 zmm7_001; spl zmm7_zmm7_001h_t zmm7_zmm7_001l_t zmm7_zmm7_001F 52;
umulj zmm7_zmm7_010F zmm7_010 zmm7_010; spl zmm7_zmm7_010h_t zmm7_zmm7_010l_t zmm7_zmm7_010F 52;
umulj zmm7_zmm7_011F zmm7_011 zmm7_011; spl zmm7_zmm7_011h_t zmm7_zmm7_011l_t zmm7_zmm7_011F 52;
umulj zmm7_zmm7_100F zmm7_100 zmm7_100; spl zmm7_zmm7_100h_t zmm7_zmm7_100l_t zmm7_zmm7_100F 52;
umulj zmm7_zmm7_101F zmm7_101 zmm7_101; spl zmm7_zmm7_101h_t zmm7_zmm7_101l_t zmm7_zmm7_101F 52;
umulj zmm7_zmm7_110F zmm7_110 zmm7_110; spl zmm7_zmm7_110h_t zmm7_zmm7_110l_t zmm7_zmm7_110F 52;
umulj zmm7_zmm7_111F zmm7_111 zmm7_111; spl zmm7_zmm7_111h_t zmm7_zmm7_111l_t zmm7_zmm7_111F 52;
vpc zmm7_zmm7_000h_t@uint64 zmm7_zmm7_000h_t; vpc zmm7_zmm7_000l_t@uint64 zmm7_zmm7_000l_t;
vpc zmm7_zmm7_001h_t@uint64 zmm7_zmm7_001h_t; vpc zmm7_zmm7_001l_t@uint64 zmm7_zmm7_001l_t;
vpc zmm7_zmm7_010h_t@uint64 zmm7_zmm7_010h_t; vpc zmm7_zmm7_010l_t@uint64 zmm7_zmm7_010l_t;
vpc zmm7_zmm7_011h_t@uint64 zmm7_zmm7_011h_t; vpc zmm7_zmm7_011l_t@uint64 zmm7_zmm7_011l_t;
vpc zmm7_zmm7_100h_t@uint64 zmm7_zmm7_100h_t; vpc zmm7_zmm7_100l_t@uint64 zmm7_zmm7_100l_t;
vpc zmm7_zmm7_101h_t@uint64 zmm7_zmm7_101h_t; vpc zmm7_zmm7_101l_t@uint64 zmm7_zmm7_101l_t;
vpc zmm7_zmm7_110h_t@uint64 zmm7_zmm7_110h_t; vpc zmm7_zmm7_110l_t@uint64 zmm7_zmm7_110l_t;
vpc zmm7_zmm7_111h_t@uint64 zmm7_zmm7_111h_t; vpc zmm7_zmm7_111l_t@uint64 zmm7_zmm7_111l_t;
add zmm5_000 zmm5_000 zmm7_zmm7_000h_t; (* zmm5_000=(a04*a04)h *)
add zmm5_001 zmm5_001 zmm7_zmm7_001h_t;
add zmm5_010 zmm5_010 zmm7_zmm7_010h_t;
add zmm5_011 zmm5_011 zmm7_zmm7_011h_t;
add zmm5_100 zmm5_100 zmm7_zmm7_100h_t;
add zmm5_101 zmm5_101 zmm7_zmm7_101h_t;
add zmm5_110 zmm5_110 zmm7_zmm7_110h_t;
add zmm5_111 zmm5_111 zmm7_zmm7_111h_t;
(* vpaddq %zmm8,%zmm3,%zmm10                       #! PC = 0x555555556b61 *)
add zmm10_000 zmm3_000 zmm8_000; (* zmm10_000=(a03*a04)l+(a02*a04)h<<1+(a03*a03)h *)
add zmm10_001 zmm3_001 zmm8_001;
add zmm10_010 zmm3_010 zmm8_010;
add zmm10_011 zmm3_011 zmm8_011;
add zmm10_100 zmm3_100 zmm8_100;
add zmm10_101 zmm3_101 zmm8_101;
add zmm10_110 zmm3_110 zmm8_110;
add zmm10_111 zmm3_111 zmm8_111;
(* # movzbl %dl,%edx                                 #! PC = 0x555555556b67 *)
# movzbl %dl,%edx                                 #! 0x555555556b67 = 0x555555556b67;
(* vpsllq $0x2,%zmm15,%zmm8                        #! PC = 0x555555556b6a *)
shl zmm8_000 zmm15_000 0x2; (* zmm8_000=(a03*a04)h<<2 *)
shl zmm8_001 zmm15_001 0x2;
shl zmm8_010 zmm15_010 0x2;
shl zmm8_011 zmm15_011 0x2;
shl zmm8_100 zmm15_100 0x2;
shl zmm8_101 zmm15_101 0x2;
shl zmm8_110 zmm15_110 0x2;
shl zmm8_111 zmm15_111 0x2;
(* vpmadd52luq %zmm7,%zmm7,%zmm8                   #! PC = 0x555555556b71 *)
add zmm8_000 zmm8_000 zmm7_zmm7_000l_t; (* zmm8_000=(a03*a04)h<<2+(a04*a04)l *)
add zmm8_001 zmm8_001 zmm7_zmm7_001l_t;
add zmm8_010 zmm8_010 zmm7_zmm7_010l_t;
add zmm8_011 zmm8_011 zmm7_zmm7_011l_t;
add zmm8_100 zmm8_100 zmm7_zmm7_100l_t;
add zmm8_101 zmm8_101 zmm7_zmm7_101l_t;
add zmm8_110 zmm8_110 zmm7_zmm7_110l_t;
add zmm8_111 zmm8_111 zmm7_zmm7_111l_t;
(* # lea    -0x1(%rdx),%eax                          #! PC = 0x555555556b77 *)
# lea    %%EA,%eax                          #! 0x555555556b77 = 0x555555556b77;
(* # vmovq  %rax,%xmm15                              #! PC = 0x555555556b7a *)
# vmovq  %rax,%xmm15                              #! 0x555555556b7a = 0x555555556b7a;
(* vpsllq $0x1,%zmm13,%zmm13                       #! PC = 0x555555556b7f *)
shl zmm13_000 zmm13_000 0x1; (* zmm13_000=((a00*a01)l+(a00*a00)h)<<1 *)
shl zmm13_001 zmm13_001 0x1;
shl zmm13_010 zmm13_010 0x1;
shl zmm13_011 zmm13_011 0x1;
shl zmm13_100 zmm13_100 0x1;
shl zmm13_101 zmm13_101 0x1;
shl zmm13_110 zmm13_110 0x1;
shl zmm13_111 zmm13_111 0x1;
(* vpsllq $0x1,%zmm6,%zmm6                         #! PC = 0x555555556b86 *)
shl zmm6_000 zmm6_000 0x1; (* zmm6_000=((a01*a04)l+(a02*a03)l+((a00*a04)h+(a01*a03)h)<<1+(a02*a02)h)<<1 *)
shl zmm6_001 zmm6_001 0x1;
shl zmm6_010 zmm6_010 0x1;
shl zmm6_011 zmm6_011 0x1;
shl zmm6_100 zmm6_100 0x1;
shl zmm6_101 zmm6_101 0x1;
shl zmm6_110 zmm6_110 0x1;
shl zmm6_111 zmm6_111 0x1;
(* vpsllq %xmm15,%zmm13,%zmm12                     #! PC = 0x555555556b8d *)
shl zmm12_000 zmm13_000 1; (* zmm12_000=((a00*a01)l+(a00*a00)h)<<2 *)
shl zmm12_001 zmm13_001 1;
shl zmm12_010 zmm13_010 1;
shl zmm12_011 zmm13_011 1;
shl zmm12_100 zmm13_100 1;
shl zmm12_101 zmm13_101 1;
shl zmm12_110 zmm13_110 1;
shl zmm12_111 zmm13_111 1;
ghost
  z01@uint64,
  z11@uint64,
  z21@uint64,
  z31@uint64,
  z41@uint64,
  z51@uint64,
  z61@uint64,
  z71@uint64 :
  and [
  z01=zmm12_000,
  z11=zmm12_001,
  z21=zmm12_010,
  z31=zmm12_011,
  z41=zmm12_100,
  z51=zmm12_101,
  z61=zmm12_110,
  z71=zmm12_111
  ] &&
  and [
  z01=zmm12_000,
  z11=zmm12_001,
  z21=zmm12_010,
  z31=zmm12_011,
  z41=zmm12_100,
  z51=zmm12_101,
  z61=zmm12_110,
  z71=zmm12_111
  ];
(* vpsllq $0x1,%zmm5,%zmm7                         #! PC = 0x555555556b93 *)
shl zmm7_000 zmm5_000 0x1; (* zmm7_000=(a04*a04)h<<1 *)
shl zmm7_001 zmm5_001 0x1;
shl zmm7_010 zmm5_010 0x1;
shl zmm7_011 zmm5_011 0x1;
shl zmm7_100 zmm5_100 0x1;
shl zmm7_101 zmm5_101 0x1;
shl zmm7_110 zmm5_110 0x1;
shl zmm7_111 zmm5_111 0x1;
(* vpsllq %xmm15,%zmm6,%zmm13                      #! PC = 0x555555556b9a *)
shl zmm13_000 zmm6_000 1; (* zmm13_000=((a01*a04)l+(a02*a03)l+((a00*a04)h+(a01*a03)h)<<1+(a02*a02)h)<<2 *)
shl zmm13_001 zmm6_001 1;
shl zmm13_010 zmm6_010 1;
shl zmm13_011 zmm6_011 1;
shl zmm13_100 zmm6_100 1;
shl zmm13_101 zmm6_101 1;
shl zmm13_110 zmm6_110 1;
shl zmm13_111 zmm6_111 1;
ghost
  z05@uint64,
  z15@uint64,
  z25@uint64,
  z35@uint64,
  z45@uint64,
  z55@uint64,
  z65@uint64,
  z75@uint64 :
  and [
  z05=zmm13_000,
  z15=zmm13_001,
  z25=zmm13_010,
  z35=zmm13_011,
  z45=zmm13_100,
  z55=zmm13_101,
  z65=zmm13_110,
  z75=zmm13_111
  ] &&
  and [
  z05=zmm13_000,
  z15=zmm13_001,
  z25=zmm13_010,
  z35=zmm13_011,
  z45=zmm13_100,
  z55=zmm13_101,
  z65=zmm13_110,
  z75=zmm13_111
  ];
(* vpsllq %xmm15,%zmm7,%zmm5                       #! PC = 0x555555556ba0 *)
shl zmm5_000 zmm7_000 1; (* zmm5_000=(a04*a04)h<<2 *)
shl zmm5_001 zmm7_001 1;
shl zmm5_010 zmm7_010 1;
shl zmm5_011 zmm7_011 1;
shl zmm5_100 zmm7_100 1;
shl zmm5_101 zmm7_101 1;
shl zmm5_110 zmm7_110 1;
shl zmm5_111 zmm7_111 1;
ghost
  z09@uint64,
  z19@uint64,
  z29@uint64,
  z39@uint64,
  z49@uint64,
  z59@uint64,
  z69@uint64,
  z79@uint64 :
  and [
  z09=zmm5_000,
  z19=zmm5_001,
  z29=zmm5_010,
  z39=zmm5_011,
  z49=zmm5_100,
  z59=zmm5_101,
  z69=zmm5_110,
  z79=zmm5_111
  ] &&
  and [
  z09=zmm5_000,
  z19=zmm5_001,
  z29=zmm5_010,
  z39=zmm5_011,
  z49=zmm5_100,
  z59=zmm5_101,
  z69=zmm5_110,
  z79=zmm5_111
  ];
(* vpsllq %xmm15,%zmm14,%zmm9                      #! PC = 0x555555556ba6 *)
shl zmm9_000 zmm14_000 1; (* zmm9_000=((a00*a01)h<<2+(a00*a02)l<<1+(a01*a01)l)<<1 *)
shl zmm9_001 zmm14_001 1;
shl zmm9_010 zmm14_010 1;
shl zmm9_011 zmm14_011 1;
shl zmm9_100 zmm14_100 1;
shl zmm9_101 zmm14_101 1;
shl zmm9_110 zmm14_110 1;
shl zmm9_111 zmm14_111 1;
ghost
  z02@uint64,
  z12@uint64,
  z22@uint64,
  z32@uint64,
  z42@uint64,
  z52@uint64,
  z62@uint64,
  z72@uint64 :
  and [
  z02=zmm9_000,
  z12=zmm9_001,
  z22=zmm9_010,
  z32=zmm9_011,
  z42=zmm9_100,
  z52=zmm9_101,
  z62=zmm9_110,
  z72=zmm9_111
  ] &&
  and [
  z02=zmm9_000,
  z12=zmm9_001,
  z22=zmm9_010,
  z32=zmm9_011,
  z42=zmm9_100,
  z52=zmm9_101,
  z62=zmm9_110,
  z72=zmm9_111
  ];
(* vpsllq %xmm15,%zmm2,%zmm2                       #! PC = 0x555555556bac *)
shl zmm2_000 zmm2_000 1; (* zmm2_000=(((a01*a04)h+(a02*a03)h)<<2+(a02*a04)l<<1+(a03*a03)l)<<1 *)
shl zmm2_001 zmm2_001 1;
shl zmm2_010 zmm2_010 1;
shl zmm2_011 zmm2_011 1;
shl zmm2_100 zmm2_100 1;
shl zmm2_101 zmm2_101 1;
shl zmm2_110 zmm2_110 1;
shl zmm2_111 zmm2_111 1;
ghost
  z06@uint64,
  z16@uint64,
  z26@uint64,
  z36@uint64,
  z46@uint64,
  z56@uint64,
  z66@uint64,
  z76@uint64 :
  and [
  z06=zmm2_000,
  z16=zmm2_001,
  z26=zmm2_010,
  z36=zmm2_011,
  z46=zmm2_100,
  z56=zmm2_101,
  z66=zmm2_110,
  z76=zmm2_111
  ] &&
  and [
  z06=zmm2_000,
  z16=zmm2_001,
  z26=zmm2_010,
  z36=zmm2_011,
  z46=zmm2_100,
  z56=zmm2_101,
  z66=zmm2_110,
  z76=zmm2_111
  ];
(* vpsllq $0x1,%zmm10,%zmm3                        #! PC = 0x555555556bb2 *)
shl zmm3_000 zmm10_000 0x1; (* zmm3_000=((a03*a04)l+(a02*a04)h<<1+(a03*a03)h)<<1 *)
shl zmm3_001 zmm10_001 0x1;
shl zmm3_010 zmm10_010 0x1;
shl zmm3_011 zmm10_011 0x1;
shl zmm3_100 zmm10_100 0x1;
shl zmm3_101 zmm10_101 0x1;
shl zmm3_110 zmm10_110 0x1;
shl zmm3_111 zmm10_111 0x1;
(* vpsllq $0x1,%zmm11,%zmm14                       #! PC = 0x555555556bb9 *)
shl zmm14_000 zmm11_000 0x1; (* zmm14_000=((a00*a03)l+(a02*a01)l+(a00*a02)h<<1+(a01*a01)h)<<1 *)
shl zmm14_001 zmm11_001 0x1;
shl zmm14_010 zmm11_010 0x1;
shl zmm14_011 zmm11_011 0x1;
shl zmm14_100 zmm11_100 0x1;
shl zmm14_101 zmm11_101 0x1;
shl zmm14_110 zmm11_110 0x1;
shl zmm14_111 zmm11_111 0x1;
(* vpsllq %xmm15,%zmm14,%zmm11                     #! PC = 0x555555556bc0 *)
shl zmm11_000 zmm14_000 1; (* zmm11_000=((a00*a03)l+(a02*a01)l+(a00*a02)h<<1+(a01*a01)h)<<2 *)
shl zmm11_001 zmm14_001 1;
shl zmm11_010 zmm14_010 1;
shl zmm11_011 zmm14_011 1;
shl zmm11_100 zmm14_100 1;
shl zmm11_101 zmm14_101 1;
shl zmm11_110 zmm14_110 1;
shl zmm11_111 zmm14_111 1;
ghost
  z03@uint64,
  z13@uint64,
  z23@uint64,
  z33@uint64,
  z43@uint64,
  z53@uint64,
  z63@uint64,
  z73@uint64 :
  and [
  z03=zmm11_000,
  z13=zmm11_001,
  z23=zmm11_010,
  z33=zmm11_011,
  z43=zmm11_100,
  z53=zmm11_101,
  z63=zmm11_110,
  z73=zmm11_111
  ] &&
  and [
  z03=zmm11_000,
  z13=zmm11_001,
  z23=zmm11_010,
  z33=zmm11_011,
  z43=zmm11_100,
  z53=zmm11_101,
  z63=zmm11_110,
  z73=zmm11_111
  ];
(* vpsrlq $0x33,%zmm13,%zmm10                      #! PC = 0x555555556bc6 *)
split zmm13_000_h zmm13_000_l zmm13_000 51;
split zmm13_001_h zmm13_001_l zmm13_001 51;
split zmm13_010_h zmm13_010_l zmm13_010 51;
split zmm13_011_h zmm13_011_l zmm13_011 51;
split zmm13_100_h zmm13_100_l zmm13_100 51;
split zmm13_101_h zmm13_101_l zmm13_101 51;
split zmm13_110_h zmm13_110_l zmm13_110 51;
split zmm13_111_h zmm13_111_l zmm13_111 51;
mov zmm10_000 zmm13_000_h; (* zmm10_000=z05>>51 *)
mov zmm10_001 zmm13_001_h;
mov zmm10_010 zmm13_010_h;
mov zmm10_011 zmm13_011_h;
mov zmm10_100 zmm13_100_h;
mov zmm10_101 zmm13_101_h;
mov zmm10_110 zmm13_110_h;
mov zmm10_111 zmm13_111_h;
assert true && and [
zmm10_000 <u 56@64,
zmm10_001 <u 56@64,
zmm10_010 <u 56@64,
zmm10_011 <u 56@64,
zmm10_100 <u 56@64,
zmm10_101 <u 56@64,
zmm10_110 <u 56@64,
zmm10_111 <u 56@64
];
(* vpsllq %xmm15,%zmm3,%zmm14                      #! PC = 0x555555556bcd *)
shl zmm14_000 zmm3_000 1; (* zmm14_000=((a03*a04)l+(a02*a04)h<<1+(a03*a03)h)<<2 *)
shl zmm14_001 zmm3_001 1;
shl zmm14_010 zmm3_010 1;
shl zmm14_011 zmm3_011 1;
shl zmm14_100 zmm3_100 1;
shl zmm14_101 zmm3_101 1;
shl zmm14_110 zmm3_110 1;
shl zmm14_111 zmm3_111 1;
ghost
  z07@uint64,
  z17@uint64,
  z27@uint64,
  z37@uint64,
  z47@uint64,
  z57@uint64,
  z67@uint64,
  z77@uint64 :
  and [
  z07=zmm14_000,
  z17=zmm14_001,
  z27=zmm14_010,
  z37=zmm14_011,
  z47=zmm14_100,
  z57=zmm14_101,
  z67=zmm14_110,
  z77=zmm14_111
  ] &&
  and [
  z07=zmm14_000,
  z17=zmm14_001,
  z27=zmm14_010,
  z37=zmm14_011,
  z47=zmm14_100,
  z57=zmm14_101,
  z67=zmm14_110,
  z77=zmm14_111
  ];
(* vpsllq %xmm15,%zmm4,%zmm4                       #! PC = 0x555555556bd3 *)
shl zmm4_000 zmm4_000 1; (* zmm4_000=(a00*a00)l<<1 *)
shl zmm4_001 zmm4_001 1;
shl zmm4_010 zmm4_010 1;
shl zmm4_011 zmm4_011 1;
shl zmm4_100 zmm4_100 1;
shl zmm4_101 zmm4_101 1;
shl zmm4_110 zmm4_110 1;
shl zmm4_111 zmm4_111 1;
ghost
  z00@uint64,
  z10@uint64,
  z20@uint64,
  z30@uint64,
  z40@uint64,
  z50@uint64,
  z60@uint64,
  z70@uint64 :
  and [
  z00=zmm4_000,
  z10=zmm4_001,
  z20=zmm4_010,
  z30=zmm4_011,
  z40=zmm4_100,
  z50=zmm4_101,
  z60=zmm4_110,
  z70=zmm4_111
  ] &&
  and [
  z00=zmm4_000,
  z10=zmm4_001,
  z20=zmm4_010,
  z30=zmm4_011,
  z40=zmm4_100,
  z50=zmm4_101,
  z60=zmm4_110,
  z70=zmm4_111
  ];
(* vpaddq %zmm2,%zmm10,%zmm7                       #! PC = 0x555555556bd9 *)
add zmm7_000 zmm10_000 zmm2_000; (* zmm7_000=z05>>51+z06 *)
add zmm7_001 zmm10_001 zmm2_001;
add zmm7_010 zmm10_010 zmm2_010;
add zmm7_011 zmm10_011 zmm2_011;
add zmm7_100 zmm10_100 zmm2_100;
add zmm7_101 zmm10_101 zmm2_101;
add zmm7_110 zmm10_110 zmm2_110;
add zmm7_111 zmm10_111 zmm2_111;
assert true && and [
zmm7_000 <u 0x160000000000038@64,
zmm7_001 <u 0x160000000000038@64,
zmm7_010 <u 0x160000000000038@64,
zmm7_011 <u 0x160000000000038@64,
zmm7_100 <u 0x160000000000038@64,
zmm7_101 <u 0x160000000000038@64,
zmm7_110 <u 0x160000000000038@64,
zmm7_111 <u 0x160000000000038@64
];
(* vpsllq %xmm15,%zmm8,%zmm8                       #! PC = 0x555555556bdf *)
shl zmm8_000 zmm8_000 1; (* zmm8_000=((a03*a04)h<<2+(a04*a04)l)<<1 *)
shl zmm8_001 zmm8_001 1;
shl zmm8_010 zmm8_010 1;
shl zmm8_011 zmm8_011 1;
shl zmm8_100 zmm8_100 1;
shl zmm8_101 zmm8_101 1;
shl zmm8_110 zmm8_110 1;
shl zmm8_111 zmm8_111 1;
ghost
  z08@uint64,
  z18@uint64,
  z28@uint64,
  z38@uint64,
  z48@uint64,
  z58@uint64,
  z68@uint64,
  z78@uint64 :
  and [
  z08=zmm8_000,
  z18=zmm8_001,
  z28=zmm8_010,
  z38=zmm8_011,
  z48=zmm8_100,
  z58=zmm8_101,
  z68=zmm8_110,
  z78=zmm8_111
  ] &&
  and [
  z08=zmm8_000,
  z18=zmm8_001,
  z28=zmm8_010,
  z38=zmm8_011,
  z48=zmm8_100,
  z58=zmm8_101,
  z68=zmm8_110,
  z78=zmm8_111
  ];
(* vmovdqa32 0x13551(%rip),%zmm10        # 0x55555556a140#! EA = L0x55555556a140; Value = 0x0007ffffffffffff; PC = 0x555555556be5 *)
mov zmm10_000 L0x55555556a140; (* zmm10_000=mask51b *)
mov zmm10_001 L0x55555556a148;
mov zmm10_010 L0x55555556a150;
mov zmm10_011 L0x55555556a158;
mov zmm10_100 L0x55555556a160;
mov zmm10_101 L0x55555556a168;
mov zmm10_110 L0x55555556a170;
mov zmm10_111 L0x55555556a178;
(* vpsrlq $0x33,%zmm5,%zmm2                        #! PC = 0x555555556bef *)
split zmm5_000_h zmm5_000_l zmm5_000 51;
split zmm5_001_h zmm5_001_l zmm5_001 51;
split zmm5_010_h zmm5_010_l zmm5_010 51;
split zmm5_011_h zmm5_011_l zmm5_011 51;
split zmm5_100_h zmm5_100_l zmm5_100 51;
split zmm5_101_h zmm5_101_l zmm5_101 51;
split zmm5_110_h zmm5_110_l zmm5_110 51;
split zmm5_111_h zmm5_111_l zmm5_111 51;
mov zmm2_000 zmm5_000_h; (* zmm2_000=z09>>51 *)
mov zmm2_001 zmm5_001_h;
mov zmm2_010 zmm5_010_h;
mov zmm2_011 zmm5_011_h;
mov zmm2_100 zmm5_100_h;
mov zmm2_101 zmm5_101_h;
mov zmm2_110 zmm5_110_h;
mov zmm2_111 zmm5_111_h;
assert true && and [
zmm2_000 <u 8@64,
zmm2_001 <u 8@64,
zmm2_010 <u 8@64,
zmm2_011 <u 8@64,
zmm2_100 <u 8@64,
zmm2_101 <u 8@64,
zmm2_110 <u 8@64,
zmm2_111 <u 8@64
];
(* vpmadd52luq 0x13580(%rip),%zmm2,%zmm4        # 0x55555556a180#! EA = L0x55555556a180; Value = 0x0000000000000169; PC = 0x555555556bf6 *)
assert true && and [
L0x55555556a180 <u 0x10000000000000@64, zmm2_000 <u 0x10000000000000@64, L0x55555556a188 <u 0x10000000000000@64, zmm2_001 <u 0x10000000000000@64, L0x55555556a190 <u 0x10000000000000@64, zmm2_010 <u 0x10000000000000@64, L0x55555556a198 <u 0x10000000000000@64, zmm2_011 <u 0x10000000000000@64, L0x55555556a1a0 <u 0x10000000000000@64, zmm2_100 <u 0x10000000000000@64, L0x55555556a1a8 <u 0x10000000000000@64, zmm2_101 <u 0x10000000000000@64, L0x55555556a1b0 <u 0x10000000000000@64, zmm2_110 <u 0x10000000000000@64, L0x55555556a1b8 <u 0x10000000000000@64, zmm2_111 <u 0x10000000000000@64
];
umulj L0x55555556a180_zmm2_000F L0x55555556a180 zmm2_000; spl L0x55555556a180_zmm2_000h_t L0x55555556a180_zmm2_000l_t L0x55555556a180_zmm2_000F 52;
umulj L0x55555556a180_zmm2_001F L0x55555556a188 zmm2_001; spl L0x55555556a180_zmm2_001h_t L0x55555556a180_zmm2_001l_t L0x55555556a180_zmm2_001F 52;
umulj L0x55555556a180_zmm2_010F L0x55555556a190 zmm2_010; spl L0x55555556a180_zmm2_010h_t L0x55555556a180_zmm2_010l_t L0x55555556a180_zmm2_010F 52;
umulj L0x55555556a180_zmm2_011F L0x55555556a198 zmm2_011; spl L0x55555556a180_zmm2_011h_t L0x55555556a180_zmm2_011l_t L0x55555556a180_zmm2_011F 52;
umulj L0x55555556a180_zmm2_100F L0x55555556a1a0 zmm2_100; spl L0x55555556a180_zmm2_100h_t L0x55555556a180_zmm2_100l_t L0x55555556a180_zmm2_100F 52;
umulj L0x55555556a180_zmm2_101F L0x55555556a1a8 zmm2_101; spl L0x55555556a180_zmm2_101h_t L0x55555556a180_zmm2_101l_t L0x55555556a180_zmm2_101F 52;
umulj L0x55555556a180_zmm2_110F L0x55555556a1b0 zmm2_110; spl L0x55555556a180_zmm2_110h_t L0x55555556a180_zmm2_110l_t L0x55555556a180_zmm2_110F 52;
umulj L0x55555556a180_zmm2_111F L0x55555556a1b8 zmm2_111; spl L0x55555556a180_zmm2_111h_t L0x55555556a180_zmm2_111l_t L0x55555556a180_zmm2_111F 52;
vpc L0x55555556a180_zmm2_000h_t@uint64 L0x55555556a180_zmm2_000h_t; vpc L0x55555556a180_zmm2_000l_t@uint64 L0x55555556a180_zmm2_000l_t;
vpc L0x55555556a180_zmm2_001h_t@uint64 L0x55555556a180_zmm2_001h_t; vpc L0x55555556a180_zmm2_001l_t@uint64 L0x55555556a180_zmm2_001l_t;
vpc L0x55555556a180_zmm2_010h_t@uint64 L0x55555556a180_zmm2_010h_t; vpc L0x55555556a180_zmm2_010l_t@uint64 L0x55555556a180_zmm2_010l_t;
vpc L0x55555556a180_zmm2_011h_t@uint64 L0x55555556a180_zmm2_011h_t; vpc L0x55555556a180_zmm2_011l_t@uint64 L0x55555556a180_zmm2_011l_t;
vpc L0x55555556a180_zmm2_100h_t@uint64 L0x55555556a180_zmm2_100h_t; vpc L0x55555556a180_zmm2_100l_t@uint64 L0x55555556a180_zmm2_100l_t;
vpc L0x55555556a180_zmm2_101h_t@uint64 L0x55555556a180_zmm2_101h_t; vpc L0x55555556a180_zmm2_101l_t@uint64 L0x55555556a180_zmm2_101l_t;
vpc L0x55555556a180_zmm2_110h_t@uint64 L0x55555556a180_zmm2_110h_t; vpc L0x55555556a180_zmm2_110l_t@uint64 L0x55555556a180_zmm2_110l_t;
vpc L0x55555556a180_zmm2_111h_t@uint64 L0x55555556a180_zmm2_111h_t; vpc L0x55555556a180_zmm2_111l_t@uint64 L0x55555556a180_zmm2_111l_t;
add zmm4_000 zmm4_000 L0x55555556a180_zmm2_000l_t; (* zmm4_000=z00+0x169*(z09>>51) *)
add zmm4_001 zmm4_001 L0x55555556a180_zmm2_001l_t;
add zmm4_010 zmm4_010 L0x55555556a180_zmm2_010l_t;
add zmm4_011 zmm4_011 L0x55555556a180_zmm2_011l_t;
add zmm4_100 zmm4_100 L0x55555556a180_zmm2_100l_t;
add zmm4_101 zmm4_101 L0x55555556a180_zmm2_101l_t;
add zmm4_110 zmm4_110 L0x55555556a180_zmm2_110l_t;
add zmm4_111 zmm4_111 L0x55555556a180_zmm2_111l_t;
assert true && and [
L0x55555556a180_zmm2_000h_t = 0@64,
L0x55555556a180_zmm2_001h_t = 0@64,
L0x55555556a180_zmm2_010h_t = 0@64,
L0x55555556a180_zmm2_011h_t = 0@64,
L0x55555556a180_zmm2_100h_t = 0@64,
L0x55555556a180_zmm2_101h_t = 0@64,
L0x55555556a180_zmm2_110h_t = 0@64,
L0x55555556a180_zmm2_111h_t = 0@64
];
assume and [
L0x55555556a180_zmm2_000h_t = 0,
L0x55555556a180_zmm2_001h_t = 0,
L0x55555556a180_zmm2_010h_t = 0,
L0x55555556a180_zmm2_011h_t = 0,
L0x55555556a180_zmm2_100h_t = 0,
L0x55555556a180_zmm2_101h_t = 0,
L0x55555556a180_zmm2_110h_t = 0,
L0x55555556a180_zmm2_111h_t = 0
] && true;
assert true && and [
zmm4_000 <u 0x20000000000b48@64,
zmm4_001 <u 0x20000000000b48@64,
zmm4_010 <u 0x20000000000b48@64,
zmm4_011 <u 0x20000000000b48@64,
zmm4_100 <u 0x20000000000b48@64,
zmm4_101 <u 0x20000000000b48@64,
zmm4_110 <u 0x20000000000b48@64,
zmm4_111 <u 0x20000000000b48@64
];
(* vpsrlq $0x33,%zmm14,%zmm6                       #! PC = 0x555555556c00 *)
split zmm14_000_h zmm14_000_l zmm14_000 51;
split zmm14_001_h zmm14_001_l zmm14_001 51;
split zmm14_010_h zmm14_010_l zmm14_010 51;
split zmm14_011_h zmm14_011_l zmm14_011 51;
split zmm14_100_h zmm14_100_l zmm14_100 51;
split zmm14_101_h zmm14_101_l zmm14_101 51;
split zmm14_110_h zmm14_110_l zmm14_110 51;
split zmm14_111_h zmm14_111_l zmm14_111 51;
mov zmm6_000 zmm14_000_h; (* zmm6_000=z07>>51 *)
mov zmm6_001 zmm14_001_h;
mov zmm6_010 zmm14_010_h;
mov zmm6_011 zmm14_011_h;
mov zmm6_100 zmm14_100_h;
mov zmm6_101 zmm14_101_h;
mov zmm6_110 zmm14_110_h;
mov zmm6_111 zmm14_111_h;
assert true && and [
zmm6_000 <u 32@64,
zmm6_001 <u 32@64,
zmm6_010 <u 32@64,
zmm6_011 <u 32@64,
zmm6_100 <u 32@64,
zmm6_101 <u 32@64,
zmm6_110 <u 32@64,
zmm6_111 <u 32@64
];
(* vpsllq %xmm15,%zmm1,%zmm1                       #! PC = 0x555555556c07 *)
shl zmm1_000 zmm1_000 1; (* zmm1_000=(((a00*a03)h+(a02*a01)h)<<2+((a00*a04)l+(a01*a03)l)<<1+(a02*a02)l)<<1 *)
shl zmm1_001 zmm1_001 1;
shl zmm1_010 zmm1_010 1;
shl zmm1_011 zmm1_011 1;
shl zmm1_100 zmm1_100 1;
shl zmm1_101 zmm1_101 1;
shl zmm1_110 zmm1_110 1;
shl zmm1_111 zmm1_111 1;
ghost
  z04@uint64,
  z14@uint64,
  z24@uint64,
  z34@uint64,
  z44@uint64,
  z54@uint64,
  z64@uint64,
  z74@uint64 :
  and [
  z04=zmm1_000,
  z14=zmm1_001,
  z24=zmm1_010,
  z34=zmm1_011,
  z44=zmm1_100,
  z54=zmm1_101,
  z64=zmm1_110,
  z74=zmm1_111
  ] &&
  and [
  z04=zmm1_000,
  z14=zmm1_001,
  z24=zmm1_010,
  z34=zmm1_011,
  z44=zmm1_100,
  z54=zmm1_101,
  z64=zmm1_110,
  z74=zmm1_111
  ];
assert and [
  eqmod
  limbs 51 [z00,z01,z02,z03,z04,z05,z06,z07,z08,z09]
  limbs 51 [a00,a01,a02,a03,a04]*limbs 51 [a00,a01,a02,a03,a04]*2
  p,
  eqmod
  limbs 51 [z10,z11,z12,z13,z14,z15,z16,z17,z18,z19]
  limbs 51 [a10,a11,a12,a13,a14]*limbs 51 [a10,a11,a12,a13,a14]*2
  p,
  eqmod
  limbs 51 [z20,z21,z22,z23,z24,z25,z26,z27,z28,z29]
  limbs 51 [a20,a21,a22,a23,a24]*limbs 51 [a20,a21,a22,a23,a24]*2
  p,
  eqmod
  limbs 51 [z30,z31,z32,z33,z34,z35,z36,z37,z38,z39]
  limbs 51 [a30,a31,a32,a33,a34]*limbs 51 [a30,a31,a32,a33,a34]*2
  p,
  eqmod
  limbs 51 [z40,z41,z42,z43,z44,z45,z46,z47,z48,z49]
  limbs 51 [a40,a41,a42,a43,a44]*limbs 51 [a40,a41,a42,a43,a44]*2
  p,
  eqmod
  limbs 51 [z50,z51,z52,z53,z54,z55,z56,z57,z58,z59]
  limbs 51 [a50,a51,a52,a53,a54]*limbs 51 [a50,a51,a52,a53,a54]*2
  p,
  eqmod
  limbs 51 [z60,z61,z62,z63,z64,z65,z66,z67,z68,z69]
  limbs 51 [a60,a61,a62,a63,a64]*limbs 51 [a60,a61,a62,a63,a64]*2
  p,
  eqmod
  limbs 51 [z70,z71,z72,z73,z74,z75,z76,z77,z78,z79]
  limbs 51 [a70,a71,a72,a73,a74]*limbs 51 [a70,a71,a72,a73,a74]*2
  p
] && true;
assume and [
  eqmod
  limbs 51 [z00,z01,z02,z03,z04,z05,z06,z07,z08,z09]
  limbs 51 [a00,a01,a02,a03,a04]*limbs 51 [a00,a01,a02,a03,a04]*2
  p,
  eqmod
  limbs 51 [z10,z11,z12,z13,z14,z15,z16,z17,z18,z19]
  limbs 51 [a10,a11,a12,a13,a14]*limbs 51 [a10,a11,a12,a13,a14]*2
  p,
  eqmod
  limbs 51 [z20,z21,z22,z23,z24,z25,z26,z27,z28,z29]
  limbs 51 [a20,a21,a22,a23,a24]*limbs 51 [a20,a21,a22,a23,a24]*2
  p,
  eqmod
  limbs 51 [z30,z31,z32,z33,z34,z35,z36,z37,z38,z39]
  limbs 51 [a30,a31,a32,a33,a34]*limbs 51 [a30,a31,a32,a33,a34]*2
  p,
  eqmod
  limbs 51 [z40,z41,z42,z43,z44,z45,z46,z47,z48,z49]
  limbs 51 [a40,a41,a42,a43,a44]*limbs 51 [a40,a41,a42,a43,a44]*2
  p,
  eqmod
  limbs 51 [z50,z51,z52,z53,z54,z55,z56,z57,z58,z59]
  limbs 51 [a50,a51,a52,a53,a54]*limbs 51 [a50,a51,a52,a53,a54]*2
  p,
  eqmod
  limbs 51 [z60,z61,z62,z63,z64,z65,z66,z67,z68,z69]
  limbs 51 [a60,a61,a62,a63,a64]*limbs 51 [a60,a61,a62,a63,a64]*2
  p,
  eqmod
  limbs 51 [z70,z71,z72,z73,z74,z75,z76,z77,z78,z79]
  limbs 51 [a70,a71,a72,a73,a74]*limbs 51 [a70,a71,a72,a73,a74]*2
  p
] &&
and [
  eqmod
  limbs 51 [z00,z01,z02,z03,z04,z05,z06,z07,z08,z09]
  limbs 51 [a00,a01,a02,a03,a04,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a00,a01,a02,a03,a04,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z10,z11,z12,z13,z14,z15,z16,z17,z18,z19]
  limbs 51 [a10,a11,a12,a13,a14,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a10,a11,a12,a13,a14,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z20,z21,z22,z23,z24,z25,z26,z27,z28,z29]
  limbs 51 [a20,a21,a22,a23,a24,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a20,a21,a22,a23,a24,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z30,z31,z32,z33,z34,z35,z36,z37,z38,z39]
  limbs 51 [a30,a31,a32,a33,a34,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a30,a31,a32,a33,a34,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z40,z41,z42,z43,z44,z45,z46,z47,z48,z49]
  limbs 51 [a40,a41,a42,a43,a44,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a40,a41,a42,a43,a44,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z50,z51,z52,z53,z54,z55,z56,z57,z58,z59]
  limbs 51 [a50,a51,a52,a53,a54,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a50,a51,a52,a53,a54,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z60,z61,z62,z63,z64,z65,z66,z67,z68,z69]
  limbs 51 [a60,a61,a62,a63,a64,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a60,a61,a62,a63,a64,0@64,0@64,0@64,0@64,0@64]*2@523
  p1,
  eqmod
  limbs 51 [z70,z71,z72,z73,z74,z75,z76,z77,z78,z79]
  limbs 51 [a70,a71,a72,a73,a74,0@64,0@64,0@64,0@64,0@64]*limbs 51 [a70,a71,a72,a73,a74,0@64,0@64,0@64,0@64,0@64]*2@523
  p1
];

(* vpandd %zmm10,%zmm13,%zmm15                     #! PC = 0x555555556c0d *)
mov zmm15_000 zmm13_000_l; (* zmm15_000=z05&mask51b *)
mov zmm15_001 zmm13_001_l;
mov zmm15_010 zmm13_010_l;
mov zmm15_011 zmm13_011_l;
mov zmm15_100 zmm13_100_l;
mov zmm15_101 zmm13_101_l;
mov zmm15_110 zmm13_110_l;
mov zmm15_111 zmm13_111_l;
(* vpaddq %zmm8,%zmm6,%zmm13                       #! PC = 0x555555556c13 *)
add zmm13_000 zmm6_000 zmm8_000; (* zmm13_000=z07>>51+z08 *)
add zmm13_001 zmm6_001 zmm8_001;
add zmm13_010 zmm6_010 zmm8_010;
add zmm13_011 zmm6_011 zmm8_011;
add zmm13_100 zmm6_100 zmm8_100;
add zmm13_101 zmm6_101 zmm8_101;
add zmm13_110 zmm6_110 zmm8_110;
add zmm13_111 zmm6_111 zmm8_111;
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
(* vpsrlq $0x33,%zmm13,%zmm6                       #! PC = 0x555555556c19 *)
split zmm13_000_h zmm13_000_l zmm13_000 51;
split zmm13_001_h zmm13_001_l zmm13_001 51;
split zmm13_010_h zmm13_010_l zmm13_010 51;
split zmm13_011_h zmm13_011_l zmm13_011 51;
split zmm13_100_h zmm13_100_l zmm13_100 51;
split zmm13_101_h zmm13_101_l zmm13_101 51;
split zmm13_110_h zmm13_110_l zmm13_110 51;
split zmm13_111_h zmm13_111_l zmm13_111 51;
mov zmm6_000 zmm13_000_h; (* zmm6_000=(z07>>51+z08)>>51 *)
mov zmm6_001 zmm13_001_h;
mov zmm6_010 zmm13_010_h;
mov zmm6_011 zmm13_011_h;
mov zmm6_100 zmm13_100_h;
mov zmm6_101 zmm13_101_h;
mov zmm6_110 zmm13_110_h;
mov zmm6_111 zmm13_111_h;
assert true && and [
zmm6_000 <u 21@64,
zmm6_001 <u 21@64,
zmm6_010 <u 21@64,
zmm6_011 <u 21@64,
zmm6_100 <u 21@64,
zmm6_101 <u 21@64,
zmm6_110 <u 21@64,
zmm6_111 <u 21@64
];
(* vpandd %zmm10,%zmm5,%zmm5                       #! PC = 0x555555556c20 *)
mov zmm5_000 zmm5_000_l; (* zmm5_000=z09&mask51b *)
mov zmm5_001 zmm5_001_l;
mov zmm5_010 zmm5_010_l;
mov zmm5_011 zmm5_011_l;
mov zmm5_100 zmm5_100_l;
mov zmm5_101 zmm5_101_l;
mov zmm5_110 zmm5_110_l;
mov zmm5_111 zmm5_111_l;
(* vpaddq %zmm5,%zmm6,%zmm5                        #! PC = 0x555555556c26 *)
add zmm5_000 zmm6_000 zmm5_000; (* zmm5_000=(z07>>51+z08)>>51+z09&mask51b *)
add zmm5_001 zmm6_001 zmm5_001;
add zmm5_010 zmm6_010 zmm5_010;
add zmm5_011 zmm6_011 zmm5_011;
add zmm5_100 zmm6_100 zmm5_100;
add zmm5_101 zmm6_101 zmm5_101;
add zmm5_110 zmm6_110 zmm5_110;
add zmm5_111 zmm6_111 zmm5_111;
assert true && and [
zmm5_000 <u 0x8000000000015@64,
zmm5_001 <u 0x8000000000015@64,
zmm5_010 <u 0x8000000000015@64,
zmm5_011 <u 0x8000000000015@64,
zmm5_100 <u 0x8000000000015@64,
zmm5_101 <u 0x8000000000015@64,
zmm5_110 <u 0x8000000000015@64,
zmm5_111 <u 0x8000000000015@64
];
(* vpandd %zmm10,%zmm13,%zmm6                      #! PC = 0x555555556c2c *)
mov zmm6_000 zmm13_000_l; (* zmm6_000=(z07>>51+z08)&mask51b *)
mov zmm6_001 zmm13_001_l;
mov zmm6_010 zmm13_010_l;
mov zmm6_011 zmm13_011_l;
mov zmm6_100 zmm13_100_l;
mov zmm6_101 zmm13_101_l;
mov zmm6_110 zmm13_110_l;
mov zmm6_111 zmm13_111_l;
(* vpbroadcastq 0x134c4(%rip),%zmm13        # 0x55555556a100#! EA = L0x55555556a100; Value = 0x0000000000000013; PC = 0x555555556c32 *)
mov zmm13_000 L0x55555556a100;
mov zmm13_001 L0x55555556a100;
mov zmm13_010 L0x55555556a100;
mov zmm13_011 L0x55555556a100;
mov zmm13_100 L0x55555556a100;
mov zmm13_101 L0x55555556a100;
mov zmm13_110 L0x55555556a100;
mov zmm13_111 L0x55555556a100;
(* vpsrlq $0x33,%zmm7,%zmm8                        #! PC = 0x555555556c3c *)
split zmm7_000_h zmm7_000_l zmm7_000 51;
split zmm7_001_h zmm7_001_l zmm7_001 51;
split zmm7_010_h zmm7_010_l zmm7_010 51;
split zmm7_011_h zmm7_011_l zmm7_011 51;
split zmm7_100_h zmm7_100_l zmm7_100 51;
split zmm7_101_h zmm7_101_l zmm7_101 51;
split zmm7_110_h zmm7_110_l zmm7_110 51;
split zmm7_111_h zmm7_111_l zmm7_111 51;
mov zmm8_000 zmm7_000_h; (* zmm8_000=(z05>>51+z06)>>51 *)
mov zmm8_001 zmm7_001_h;
mov zmm8_010 zmm7_010_h;
mov zmm8_011 zmm7_011_h;
mov zmm8_100 zmm7_100_h;
mov zmm8_101 zmm7_101_h;
mov zmm8_110 zmm7_110_h;
mov zmm8_111 zmm7_111_h;
assert true && and [
zmm8_000 <u 45@64,
zmm8_001 <u 45@64,
zmm8_010 <u 45@64,
zmm8_011 <u 45@64,
zmm8_100 <u 45@64,
zmm8_101 <u 45@64,
zmm8_110 <u 45@64,
zmm8_111 <u 45@64
];
(* vpandd %zmm10,%zmm14,%zmm3                      #! PC = 0x555555556c43 *)
mov zmm3_000 zmm14_000_l; (* zmm3_000=z07&mask51b *)
mov zmm3_001 zmm14_001_l;
mov zmm3_010 zmm14_010_l;
mov zmm3_011 zmm14_011_l;
mov zmm3_100 zmm14_100_l;
mov zmm3_101 zmm14_101_l;
mov zmm3_110 zmm14_110_l;
mov zmm3_111 zmm14_111_l;
(* vmovdqa64 %zmm0,%zmm2                           #! PC = 0x555555556c49 *)
mov zmm2_000 zmm0_000; (* zmm2_000=0 *)
mov zmm2_001 zmm0_001;
mov zmm2_010 zmm0_010;
mov zmm2_011 zmm0_011;
mov zmm2_100 zmm0_100;
mov zmm2_101 zmm0_101;
mov zmm2_110 zmm0_110;
mov zmm2_111 zmm0_111;
(* vpaddq %zmm3,%zmm8,%zmm14                       #! PC = 0x555555556c4f *)
add zmm14_000 zmm8_000 zmm3_000; (* zmm14_000=(z05>>51+z06)>>51+z07&mask51b *)
add zmm14_001 zmm8_001 zmm3_001;
add zmm14_010 zmm8_010 zmm3_010;
add zmm14_011 zmm8_011 zmm3_011;
add zmm14_100 zmm8_100 zmm3_100;
add zmm14_101 zmm8_101 zmm3_101;
add zmm14_110 zmm8_110 zmm3_110;
add zmm14_111 zmm8_111 zmm3_111;
assert true && and [
zmm14_000 <u 0x800000000002d@64,
zmm14_001 <u 0x800000000002d@64,
zmm14_010 <u 0x800000000002d@64,
zmm14_011 <u 0x800000000002d@64,
zmm14_100 <u 0x800000000002d@64,
zmm14_101 <u 0x800000000002d@64,
zmm14_110 <u 0x800000000002d@64,
zmm14_111 <u 0x800000000002d@64
];
(* vpmadd52luq %zmm13,%zmm15,%zmm4                 #! PC = 0x555555556c55 *)
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
add zmm4_000 zmm4_000 zmm13_zmm15_000l_t; (* zmm4_000=z00+0x169*(z09>>51)+(z05&mask51b * 19)l *)
add zmm4_001 zmm4_001 zmm13_zmm15_001l_t;
add zmm4_010 zmm4_010 zmm13_zmm15_010l_t;
add zmm4_011 zmm4_011 zmm13_zmm15_011l_t;
add zmm4_100 zmm4_100 zmm13_zmm15_100l_t;
add zmm4_101 zmm4_101 zmm13_zmm15_101l_t;
add zmm4_110 zmm4_110 zmm13_zmm15_110l_t;
add zmm4_111 zmm4_111 zmm13_zmm15_111l_t;
assert true && and [
zmm4_000 <u 0x30000000000b48@64,
zmm4_001 <u 0x30000000000b48@64,
zmm4_010 <u 0x30000000000b48@64,
zmm4_011 <u 0x30000000000b48@64,
zmm4_100 <u 0x30000000000b48@64,
zmm4_101 <u 0x30000000000b48@64,
zmm4_110 <u 0x30000000000b48@64,
zmm4_111 <u 0x30000000000b48@64
];
(* vpmadd52huq %zmm13,%zmm15,%zmm2                 #! PC = 0x555555556c5b *)
add zmm2_000 zmm2_000 zmm13_zmm15_000h_t; (* zmm2_000=(z05&mask51b * 19)h *)
add zmm2_001 zmm2_001 zmm13_zmm15_001h_t;
add zmm2_010 zmm2_010 zmm13_zmm15_010h_t;
add zmm2_011 zmm2_011 zmm13_zmm15_011h_t;
add zmm2_100 zmm2_100 zmm13_zmm15_100h_t;
add zmm2_101 zmm2_101 zmm13_zmm15_101h_t;
add zmm2_110 zmm2_110 zmm13_zmm15_110h_t;
add zmm2_111 zmm2_111 zmm13_zmm15_111h_t;
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
(* vmovdqa64 %zmm0,%zmm15                          #! PC = 0x555555556c61 *)
mov zmm15_000 zmm0_000; (* zmm15_000=0 *)
mov zmm15_001 zmm0_001;
mov zmm15_010 zmm0_010;
mov zmm15_011 zmm0_011;
mov zmm15_100 zmm0_100;
mov zmm15_101 zmm0_101;
mov zmm15_110 zmm0_110;
mov zmm15_111 zmm0_111;
(* vpmadd52huq %zmm13,%zmm14,%zmm15                #! PC = 0x555555556c67 *)
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
add zmm15_000 zmm15_000 zmm13_zmm14_000h_t; (* zmm15_000=((z05>>51+z06)>>51+z07&mask51b * 19)h *)
add zmm15_001 zmm15_001 zmm13_zmm14_001h_t;
add zmm15_010 zmm15_010 zmm13_zmm14_010h_t;
add zmm15_011 zmm15_011 zmm13_zmm14_011h_t;
add zmm15_100 zmm15_100 zmm13_zmm14_100h_t;
add zmm15_101 zmm15_101 zmm13_zmm14_101h_t;
add zmm15_110 zmm15_110 zmm13_zmm14_110h_t;
add zmm15_111 zmm15_111 zmm13_zmm14_111h_t;
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
(* vpmadd52luq %zmm13,%zmm14,%zmm9                 #! PC = 0x555555556c6d *)
add zmm9_000 zmm9_000 zmm13_zmm14_000l_t; (* zmm9_000=z02+((z05>>51+z06)>>51+z07&mask51b * 19)l *)
add zmm9_001 zmm9_001 zmm13_zmm14_001l_t;
add zmm9_010 zmm9_010 zmm13_zmm14_010l_t;
add zmm9_011 zmm9_011 zmm13_zmm14_011l_t;
add zmm9_100 zmm9_100 zmm13_zmm14_100l_t;
add zmm9_101 zmm9_101 zmm13_zmm14_101l_t;
add zmm9_110 zmm9_110 zmm13_zmm14_110l_t;
add zmm9_111 zmm9_111 zmm13_zmm14_111l_t;
assert true && and [
zmm9_000 <u 0xf0000000000000@64,
zmm9_001 <u 0xf0000000000000@64,
zmm9_010 <u 0xf0000000000000@64,
zmm9_011 <u 0xf0000000000000@64,
zmm9_100 <u 0xf0000000000000@64,
zmm9_101 <u 0xf0000000000000@64,
zmm9_110 <u 0xf0000000000000@64,
zmm9_111 <u 0xf0000000000000@64
];
(* vmovdqa64 %zmm0,%zmm8                           #! PC = 0x555555556c73 *)
mov zmm8_000 zmm0_000; (* zmm8_000=0 *)
mov zmm8_001 zmm0_001;
mov zmm8_010 zmm0_010;
mov zmm8_011 zmm0_011;
mov zmm8_100 zmm0_100;
mov zmm8_101 zmm0_101;
mov zmm8_110 zmm0_110;
mov zmm8_111 zmm0_111;
(* vpmadd52luq %zmm13,%zmm5,%zmm1                  #! PC = 0x555555556c79 *)
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
add zmm1_000 zmm1_000 zmm13_zmm5_000l_t; (* zmm1_000=z04+((z07>>51+z08)>>51+z09&mask51b * 19)l *)
add zmm1_001 zmm1_001 zmm13_zmm5_001l_t;
add zmm1_010 zmm1_010 zmm13_zmm5_010l_t;
add zmm1_011 zmm1_011 zmm13_zmm5_011l_t;
add zmm1_100 zmm1_100 zmm13_zmm5_100l_t;
add zmm1_101 zmm1_101 zmm13_zmm5_101l_t;
add zmm1_110 zmm1_110 zmm13_zmm5_110l_t;
add zmm1_111 zmm1_111 zmm13_zmm5_111l_t;
assert true && and [
zmm1_000 <u 0x1b0000000000000@64,
zmm1_001 <u 0x1b0000000000000@64,
zmm1_010 <u 0x1b0000000000000@64,
zmm1_011 <u 0x1b0000000000000@64,
zmm1_100 <u 0x1b0000000000000@64,
zmm1_101 <u 0x1b0000000000000@64,
zmm1_110 <u 0x1b0000000000000@64,
zmm1_111 <u 0x1b0000000000000@64
];
(* vpmadd52huq %zmm13,%zmm5,%zmm8                  #! PC = 0x555555556c7f *)
add zmm8_000 zmm8_000 zmm13_zmm5_000h_t; (* zmm8_000=((z07>>51+z08)>>51+z09&mask51b * 19)h *)
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
(* vpsllq $0x1,%zmm2,%zmm3                         #! PC = 0x555555556c85 *)
shl zmm3_000 zmm2_000 0x1; (* zmm3_000=(z05&mask51b * 19)h<<1 *)
shl zmm3_001 zmm2_001 0x1;
shl zmm3_010 zmm2_010 0x1;
shl zmm3_011 zmm2_011 0x1;
shl zmm3_100 zmm2_100 0x1;
shl zmm3_101 zmm2_101 0x1;
shl zmm3_110 zmm2_110 0x1;
shl zmm3_111 zmm2_111 0x1;
assert true && and [
zmm3_000 <u 32@64,
zmm3_001 <u 32@64,
zmm3_010 <u 32@64,
zmm3_011 <u 32@64,
zmm3_100 <u 32@64,
zmm3_101 <u 32@64,
zmm3_110 <u 32@64,
zmm3_111 <u 32@64
];
(* vpsllq $0x1,%zmm15,%zmm2                        #! PC = 0x555555556c8c *)
shl zmm2_000 zmm15_000 0x1; (* zmm2_000=((z05>>51+z06)>>51+z07&mask51b * 19)h<<1 *)
shl zmm2_001 zmm15_001 0x1;
shl zmm2_010 zmm15_010 0x1;
shl zmm2_011 zmm15_011 0x1;
shl zmm2_100 zmm15_100 0x1;
shl zmm2_101 zmm15_101 0x1;
shl zmm2_110 zmm15_110 0x1;
shl zmm2_111 zmm15_111 0x1;
assert true && and [
zmm2_000 <u 32@64,
zmm2_001 <u 32@64,
zmm2_010 <u 32@64,
zmm2_011 <u 32@64,
zmm2_100 <u 32@64,
zmm2_101 <u 32@64,
zmm2_110 <u 32@64,
zmm2_111 <u 32@64
];
(* vpsrlq $0x33,%zmm4,%zmm16                       #! PC = 0x555555556c93 *)
split zmm4_000_h zmm4_000_l zmm4_000 51;
split zmm4_001_h zmm4_001_l zmm4_001 51;
split zmm4_010_h zmm4_010_l zmm4_010 51;
split zmm4_011_h zmm4_011_l zmm4_011 51;
split zmm4_100_h zmm4_100_l zmm4_100 51;
split zmm4_101_h zmm4_101_l zmm4_101 51;
split zmm4_110_h zmm4_110_l zmm4_110 51;
split zmm4_111_h zmm4_111_l zmm4_111 51;
mov zmm16_000 zmm4_000_h; (* zmm16_000=(z00+0x169*(z09>>51)+(z05&mask51b * 19)l)>>51 *)
mov zmm16_001 zmm4_001_h;
mov zmm16_010 zmm4_010_h;
mov zmm16_011 zmm4_011_h;
mov zmm16_100 zmm4_100_h;
mov zmm16_101 zmm4_101_h;
mov zmm16_110 zmm4_110_h;
mov zmm16_111 zmm4_111_h;
assert true && and [
zmm16_000 <u 7@64,
zmm16_001 <u 7@64,
zmm16_010 <u 7@64,
zmm16_011 <u 7@64,
zmm16_100 <u 7@64,
zmm16_101 <u 7@64,
zmm16_110 <u 7@64,
zmm16_111 <u 7@64
];
(* vpsrlq $0x33,%zmm9,%zmm15                       #! PC = 0x555555556c9a *)
split zmm9_000_h zmm9_000_l zmm9_000 51;
split zmm9_001_h zmm9_001_l zmm9_001 51;
split zmm9_010_h zmm9_010_l zmm9_010 51;
split zmm9_011_h zmm9_011_l zmm9_011 51;
split zmm9_100_h zmm9_100_l zmm9_100 51;
split zmm9_101_h zmm9_101_l zmm9_101 51;
split zmm9_110_h zmm9_110_l zmm9_110 51;
split zmm9_111_h zmm9_111_l zmm9_111 51;
mov zmm15_000 zmm9_000_h; (* zmm15_000=(z02+((z05>>51+z06)>>51+z07&mask51b * 19)l)>>51 *)
mov zmm15_001 zmm9_001_h;
mov zmm15_010 zmm9_010_h;
mov zmm15_011 zmm9_011_h;
mov zmm15_100 zmm9_100_h;
mov zmm15_101 zmm9_101_h;
mov zmm15_110 zmm9_110_h;
mov zmm15_111 zmm9_111_h;
assert true && and [
zmm15_000 <u 30@64,
zmm15_001 <u 30@64,
zmm15_010 <u 30@64,
zmm15_011 <u 30@64,
zmm15_100 <u 30@64,
zmm15_101 <u 30@64,
zmm15_110 <u 30@64,
zmm15_111 <u 30@64
];
(* vpaddq %zmm12,%zmm3,%zmm12                      #! PC = 0x555555556ca1 *)
add zmm12_000 zmm3_000 zmm12_000; (* zmm12_000=(z05&mask51b * 19)h<<1+z01 *)
add zmm12_001 zmm3_001 zmm12_001;
add zmm12_010 zmm3_010 zmm12_010;
add zmm12_011 zmm3_011 zmm12_011;
add zmm12_100 zmm3_100 zmm12_100;
add zmm12_101 zmm3_101 zmm12_101;
add zmm12_110 zmm3_110 zmm12_110;
add zmm12_111 zmm3_111 zmm12_111;
assert true && and [
zmm12_000 <u 0x80000000000020@64,
zmm12_001 <u 0x80000000000020@64,
zmm12_010 <u 0x80000000000020@64,
zmm12_011 <u 0x80000000000020@64,
zmm12_100 <u 0x80000000000020@64,
zmm12_101 <u 0x80000000000020@64,
zmm12_110 <u 0x80000000000020@64,
zmm12_111 <u 0x80000000000020@64
];
(* vpaddq %zmm11,%zmm2,%zmm11                      #! PC = 0x555555556ca7 *)
add zmm11_000 zmm2_000 zmm11_000; (* zmm11_000=((z05>>51+z06)>>51+z07&mask51b * 19)h<<1+z03 *)
add zmm11_001 zmm2_001 zmm11_001;
add zmm11_010 zmm2_010 zmm11_010;
add zmm11_011 zmm2_011 zmm11_011;
add zmm11_100 zmm2_100 zmm11_100;
add zmm11_101 zmm2_101 zmm11_101;
add zmm11_110 zmm2_110 zmm11_110;
add zmm11_111 zmm2_111 zmm11_111;
assert true && and [
zmm11_000 <u 0x140000000000020@64,
zmm11_001 <u 0x140000000000020@64,
zmm11_010 <u 0x140000000000020@64,
zmm11_011 <u 0x140000000000020@64,
zmm11_100 <u 0x140000000000020@64,
zmm11_101 <u 0x140000000000020@64,
zmm11_110 <u 0x140000000000020@64,
zmm11_111 <u 0x140000000000020@64
];
(* vpandd %zmm10,%zmm7,%zmm7                       #! PC = 0x555555556cad *)
mov zmm7_000 zmm7_000_l; (* zmm7_000=(z05>>51+z06)&mask51b *)
mov zmm7_001 zmm7_001_l;
mov zmm7_010 zmm7_010_l;
mov zmm7_011 zmm7_011_l;
mov zmm7_100 zmm7_100_l;
mov zmm7_101 zmm7_101_l;
mov zmm7_110 zmm7_110_l;
mov zmm7_111 zmm7_111_l;
(* vpaddq %zmm16,%zmm12,%zmm3                      #! PC = 0x555555556cb3 *)
add zmm3_000 zmm12_000 zmm16_000; (* zmm3_000=(z05&mask51b * 19)h<<1+z01+(z00+0x169*(z09>>51)+(z05&mask51b * 19)l)>>51 *)
add zmm3_001 zmm12_001 zmm16_001;
add zmm3_010 zmm12_010 zmm16_010;
add zmm3_011 zmm12_011 zmm16_011;
add zmm3_100 zmm12_100 zmm16_100;
add zmm3_101 zmm12_101 zmm16_101;
add zmm3_110 zmm12_110 zmm16_110;
add zmm3_111 zmm12_111 zmm16_111;
assert true && and [
zmm3_000 <u 0x80000000000027@64,
zmm3_001 <u 0x80000000000027@64,
zmm3_010 <u 0x80000000000027@64,
zmm3_011 <u 0x80000000000027@64,
zmm3_100 <u 0x80000000000027@64,
zmm3_101 <u 0x80000000000027@64,
zmm3_110 <u 0x80000000000027@64,
zmm3_111 <u 0x80000000000027@64
];
(* vpaddq %zmm15,%zmm11,%zmm2                      #! PC = 0x555555556cb9 *)
add zmm2_000 zmm11_000 zmm15_000;
add zmm2_001 zmm11_001 zmm15_001;
add zmm2_010 zmm11_010 zmm15_010;
add zmm2_011 zmm11_011 zmm15_011;
add zmm2_100 zmm11_100 zmm15_100;
add zmm2_101 zmm11_101 zmm15_101;
add zmm2_110 zmm11_110 zmm15_110;
add zmm2_111 zmm11_111 zmm15_111;
(* vmovdqa64 %zmm0,%zmm5                           #! PC = 0x555555556cbf *)
mov zmm5_000 zmm0_000;
mov zmm5_001 zmm0_001;
mov zmm5_010 zmm0_010;
mov zmm5_011 zmm0_011;
mov zmm5_100 zmm0_100;
mov zmm5_101 zmm0_101;
mov zmm5_110 zmm0_110;
mov zmm5_111 zmm0_111;
(* vpmadd52luq %zmm13,%zmm6,%zmm2                  #! PC = 0x555555556cc5 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm6_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm6_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm6_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm6_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm6_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm6_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm6_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm6_111 <u 0x10000000000000@64
];
umulj zmm13_zmm6_000F zmm13_000 zmm6_000; spl zmm13_zmm6_000h_t zmm13_zmm6_000l_t zmm13_zmm6_000F 52;
umulj zmm13_zmm6_001F zmm13_001 zmm6_001; spl zmm13_zmm6_001h_t zmm13_zmm6_001l_t zmm13_zmm6_001F 52;
umulj zmm13_zmm6_010F zmm13_010 zmm6_010; spl zmm13_zmm6_010h_t zmm13_zmm6_010l_t zmm13_zmm6_010F 52;
umulj zmm13_zmm6_011F zmm13_011 zmm6_011; spl zmm13_zmm6_011h_t zmm13_zmm6_011l_t zmm13_zmm6_011F 52;
umulj zmm13_zmm6_100F zmm13_100 zmm6_100; spl zmm13_zmm6_100h_t zmm13_zmm6_100l_t zmm13_zmm6_100F 52;
umulj zmm13_zmm6_101F zmm13_101 zmm6_101; spl zmm13_zmm6_101h_t zmm13_zmm6_101l_t zmm13_zmm6_101F 52;
umulj zmm13_zmm6_110F zmm13_110 zmm6_110; spl zmm13_zmm6_110h_t zmm13_zmm6_110l_t zmm13_zmm6_110F 52;
umulj zmm13_zmm6_111F zmm13_111 zmm6_111; spl zmm13_zmm6_111h_t zmm13_zmm6_111l_t zmm13_zmm6_111F 52;
vpc zmm13_zmm6_000h_t@uint64 zmm13_zmm6_000h_t; vpc zmm13_zmm6_000l_t@uint64 zmm13_zmm6_000l_t;
vpc zmm13_zmm6_001h_t@uint64 zmm13_zmm6_001h_t; vpc zmm13_zmm6_001l_t@uint64 zmm13_zmm6_001l_t;
vpc zmm13_zmm6_010h_t@uint64 zmm13_zmm6_010h_t; vpc zmm13_zmm6_010l_t@uint64 zmm13_zmm6_010l_t;
vpc zmm13_zmm6_011h_t@uint64 zmm13_zmm6_011h_t; vpc zmm13_zmm6_011l_t@uint64 zmm13_zmm6_011l_t;
vpc zmm13_zmm6_100h_t@uint64 zmm13_zmm6_100h_t; vpc zmm13_zmm6_100l_t@uint64 zmm13_zmm6_100l_t;
vpc zmm13_zmm6_101h_t@uint64 zmm13_zmm6_101h_t; vpc zmm13_zmm6_101l_t@uint64 zmm13_zmm6_101l_t;
vpc zmm13_zmm6_110h_t@uint64 zmm13_zmm6_110h_t; vpc zmm13_zmm6_110l_t@uint64 zmm13_zmm6_110l_t;
vpc zmm13_zmm6_111h_t@uint64 zmm13_zmm6_111h_t; vpc zmm13_zmm6_111l_t@uint64 zmm13_zmm6_111l_t;
add zmm2_000 zmm2_000 zmm13_zmm6_000l_t;
add zmm2_001 zmm2_001 zmm13_zmm6_001l_t;
add zmm2_010 zmm2_010 zmm13_zmm6_010l_t;
add zmm2_011 zmm2_011 zmm13_zmm6_011l_t;
add zmm2_100 zmm2_100 zmm13_zmm6_100l_t;
add zmm2_101 zmm2_101 zmm13_zmm6_101l_t;
add zmm2_110 zmm2_110 zmm13_zmm6_110l_t;
add zmm2_111 zmm2_111 zmm13_zmm6_111l_t;
(* vpmadd52luq %zmm13,%zmm7,%zmm3                  #! PC = 0x555555556ccb *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm7_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm7_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm7_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm7_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm7_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm7_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm7_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm7_111 <u 0x10000000000000@64
];
umulj zmm13_zmm7_000F zmm13_000 zmm7_000; spl zmm13_zmm7_000h_t zmm13_zmm7_000l_t zmm13_zmm7_000F 52;
umulj zmm13_zmm7_001F zmm13_001 zmm7_001; spl zmm13_zmm7_001h_t zmm13_zmm7_001l_t zmm13_zmm7_001F 52;
umulj zmm13_zmm7_010F zmm13_010 zmm7_010; spl zmm13_zmm7_010h_t zmm13_zmm7_010l_t zmm13_zmm7_010F 52;
umulj zmm13_zmm7_011F zmm13_011 zmm7_011; spl zmm13_zmm7_011h_t zmm13_zmm7_011l_t zmm13_zmm7_011F 52;
umulj zmm13_zmm7_100F zmm13_100 zmm7_100; spl zmm13_zmm7_100h_t zmm13_zmm7_100l_t zmm13_zmm7_100F 52;
umulj zmm13_zmm7_101F zmm13_101 zmm7_101; spl zmm13_zmm7_101h_t zmm13_zmm7_101l_t zmm13_zmm7_101F 52;
umulj zmm13_zmm7_110F zmm13_110 zmm7_110; spl zmm13_zmm7_110h_t zmm13_zmm7_110l_t zmm13_zmm7_110F 52;
umulj zmm13_zmm7_111F zmm13_111 zmm7_111; spl zmm13_zmm7_111h_t zmm13_zmm7_111l_t zmm13_zmm7_111F 52;
vpc zmm13_zmm7_000h_t@uint64 zmm13_zmm7_000h_t; vpc zmm13_zmm7_000l_t@uint64 zmm13_zmm7_000l_t;
vpc zmm13_zmm7_001h_t@uint64 zmm13_zmm7_001h_t; vpc zmm13_zmm7_001l_t@uint64 zmm13_zmm7_001l_t;
vpc zmm13_zmm7_010h_t@uint64 zmm13_zmm7_010h_t; vpc zmm13_zmm7_010l_t@uint64 zmm13_zmm7_010l_t;
vpc zmm13_zmm7_011h_t@uint64 zmm13_zmm7_011h_t; vpc zmm13_zmm7_011l_t@uint64 zmm13_zmm7_011l_t;
vpc zmm13_zmm7_100h_t@uint64 zmm13_zmm7_100h_t; vpc zmm13_zmm7_100l_t@uint64 zmm13_zmm7_100l_t;
vpc zmm13_zmm7_101h_t@uint64 zmm13_zmm7_101h_t; vpc zmm13_zmm7_101l_t@uint64 zmm13_zmm7_101l_t;
vpc zmm13_zmm7_110h_t@uint64 zmm13_zmm7_110h_t; vpc zmm13_zmm7_110l_t@uint64 zmm13_zmm7_110l_t;
vpc zmm13_zmm7_111h_t@uint64 zmm13_zmm7_111h_t; vpc zmm13_zmm7_111l_t@uint64 zmm13_zmm7_111l_t;
add zmm3_000 zmm3_000 zmm13_zmm7_000l_t;
add zmm3_001 zmm3_001 zmm13_zmm7_001l_t;
add zmm3_010 zmm3_010 zmm13_zmm7_010l_t;
add zmm3_011 zmm3_011 zmm13_zmm7_011l_t;
add zmm3_100 zmm3_100 zmm13_zmm7_100l_t;
add zmm3_101 zmm3_101 zmm13_zmm7_101l_t;
add zmm3_110 zmm3_110 zmm13_zmm7_110l_t;
add zmm3_111 zmm3_111 zmm13_zmm7_111l_t;
(* vpmadd52huq %zmm13,%zmm7,%zmm5                  #! PC = 0x555555556cd1 *)
add zmm5_000 zmm5_000 zmm13_zmm7_000h_t;
add zmm5_001 zmm5_001 zmm13_zmm7_001h_t;
add zmm5_010 zmm5_010 zmm13_zmm7_010h_t;
add zmm5_011 zmm5_011 zmm13_zmm7_011h_t;
add zmm5_100 zmm5_100 zmm13_zmm7_100h_t;
add zmm5_101 zmm5_101 zmm13_zmm7_101h_t;
add zmm5_110 zmm5_110 zmm13_zmm7_110h_t;
add zmm5_111 zmm5_111 zmm13_zmm7_111h_t;
(* vpmadd52huq %zmm13,%zmm6,%zmm0                  #! PC = 0x555555556cd7 *)
add zmm0_000 zmm0_000 zmm13_zmm6_000h_t;
add zmm0_001 zmm0_001 zmm13_zmm6_001h_t;
add zmm0_010 zmm0_010 zmm13_zmm6_010h_t;
add zmm0_011 zmm0_011 zmm13_zmm6_011h_t;
add zmm0_100 zmm0_100 zmm13_zmm6_100h_t;
add zmm0_101 zmm0_101 zmm13_zmm6_101h_t;
add zmm0_110 zmm0_110 zmm13_zmm6_110h_t;
add zmm0_111 zmm0_111 zmm13_zmm6_111h_t;
(* vpsrlq $0x33,%zmm1,%zmm14                       #! PC = 0x555555556cdd *)
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
(* vpsllq $0x1,%zmm8,%zmm8                         #! PC = 0x555555556ce4 *)
shl zmm8_000 zmm8_000 0x1;
shl zmm8_001 zmm8_001 0x1;
shl zmm8_010 zmm8_010 0x1;
shl zmm8_011 zmm8_011 0x1;
shl zmm8_100 zmm8_100 0x1;
shl zmm8_101 zmm8_101 0x1;
shl zmm8_110 zmm8_110 0x1;
shl zmm8_111 zmm8_111 0x1;
(* vpaddq %zmm14,%zmm8,%zmm6                       #! PC = 0x555555556ceb *)
add zmm6_000 zmm8_000 zmm14_000;
add zmm6_001 zmm8_001 zmm14_001;
add zmm6_010 zmm8_010 zmm14_010;
add zmm6_011 zmm8_011 zmm14_011;
add zmm6_100 zmm8_100 zmm14_100;
add zmm6_101 zmm8_101 zmm14_101;
add zmm6_110 zmm8_110 zmm14_110;
add zmm6_111 zmm8_111 zmm14_111;
(* vpandd %zmm10,%zmm4,%zmm4                       #! PC = 0x555555556cf1 *)
mov zmm4_000 zmm4_000_l;
mov zmm4_001 zmm4_001_l;
mov zmm4_010 zmm4_010_l;
mov zmm4_011 zmm4_011_l;
mov zmm4_100 zmm4_100_l;
mov zmm4_101 zmm4_101_l;
mov zmm4_110 zmm4_110_l;
mov zmm4_111 zmm4_111_l;
(* vpmadd52luq %zmm13,%zmm6,%zmm4                  #! PC = 0x555555556cf7 *)
assert true && and [
zmm13_000 <u 0x10000000000000@64, zmm6_000 <u 0x10000000000000@64, zmm13_001 <u 0x10000000000000@64, zmm6_001 <u 0x10000000000000@64, zmm13_010 <u 0x10000000000000@64, zmm6_010 <u 0x10000000000000@64, zmm13_011 <u 0x10000000000000@64, zmm6_011 <u 0x10000000000000@64, zmm13_100 <u 0x10000000000000@64, zmm6_100 <u 0x10000000000000@64, zmm13_101 <u 0x10000000000000@64, zmm6_101 <u 0x10000000000000@64, zmm13_110 <u 0x10000000000000@64, zmm6_110 <u 0x10000000000000@64, zmm13_111 <u 0x10000000000000@64, zmm6_111 <u 0x10000000000000@64
];
umulj zmm13_zmm6_000F zmm13_000 zmm6_000; spl zmm13_zmm6_000h_t zmm13_zmm6_000l_t zmm13_zmm6_000F 52;
umulj zmm13_zmm6_001F zmm13_001 zmm6_001; spl zmm13_zmm6_001h_t zmm13_zmm6_001l_t zmm13_zmm6_001F 52;
umulj zmm13_zmm6_010F zmm13_010 zmm6_010; spl zmm13_zmm6_010h_t zmm13_zmm6_010l_t zmm13_zmm6_010F 52;
umulj zmm13_zmm6_011F zmm13_011 zmm6_011; spl zmm13_zmm6_011h_t zmm13_zmm6_011l_t zmm13_zmm6_011F 52;
umulj zmm13_zmm6_100F zmm13_100 zmm6_100; spl zmm13_zmm6_100h_t zmm13_zmm6_100l_t zmm13_zmm6_100F 52;
umulj zmm13_zmm6_101F zmm13_101 zmm6_101; spl zmm13_zmm6_101h_t zmm13_zmm6_101l_t zmm13_zmm6_101F 52;
umulj zmm13_zmm6_110F zmm13_110 zmm6_110; spl zmm13_zmm6_110h_t zmm13_zmm6_110l_t zmm13_zmm6_110F 52;
umulj zmm13_zmm6_111F zmm13_111 zmm6_111; spl zmm13_zmm6_111h_t zmm13_zmm6_111l_t zmm13_zmm6_111F 52;
vpc zmm13_zmm6_000h_t@uint64 zmm13_zmm6_000h_t; vpc zmm13_zmm6_000l_t@uint64 zmm13_zmm6_000l_t;
vpc zmm13_zmm6_001h_t@uint64 zmm13_zmm6_001h_t; vpc zmm13_zmm6_001l_t@uint64 zmm13_zmm6_001l_t;
vpc zmm13_zmm6_010h_t@uint64 zmm13_zmm6_010h_t; vpc zmm13_zmm6_010l_t@uint64 zmm13_zmm6_010l_t;
vpc zmm13_zmm6_011h_t@uint64 zmm13_zmm6_011h_t; vpc zmm13_zmm6_011l_t@uint64 zmm13_zmm6_011l_t;
vpc zmm13_zmm6_100h_t@uint64 zmm13_zmm6_100h_t; vpc zmm13_zmm6_100l_t@uint64 zmm13_zmm6_100l_t;
vpc zmm13_zmm6_101h_t@uint64 zmm13_zmm6_101h_t; vpc zmm13_zmm6_101l_t@uint64 zmm13_zmm6_101l_t;
vpc zmm13_zmm6_110h_t@uint64 zmm13_zmm6_110h_t; vpc zmm13_zmm6_110l_t@uint64 zmm13_zmm6_110l_t;
vpc zmm13_zmm6_111h_t@uint64 zmm13_zmm6_111h_t; vpc zmm13_zmm6_111l_t@uint64 zmm13_zmm6_111l_t;
add zmm4_000 zmm4_000 zmm13_zmm6_000l_t;
add zmm4_001 zmm4_001 zmm13_zmm6_001l_t;
add zmm4_010 zmm4_010 zmm13_zmm6_010l_t;
add zmm4_011 zmm4_011 zmm13_zmm6_011l_t;
add zmm4_100 zmm4_100 zmm13_zmm6_100l_t;
add zmm4_101 zmm4_101 zmm13_zmm6_101l_t;
add zmm4_110 zmm4_110 zmm13_zmm6_110l_t;
add zmm4_111 zmm4_111 zmm13_zmm6_111l_t;
assert true && and [
zmm13_zmm6_000h_t = 0@64,
zmm13_zmm6_001h_t = 0@64,
zmm13_zmm6_010h_t = 0@64,
zmm13_zmm6_011h_t = 0@64,
zmm13_zmm6_100h_t = 0@64,
zmm13_zmm6_101h_t = 0@64,
zmm13_zmm6_110h_t = 0@64,
zmm13_zmm6_111h_t = 0@64
];
assume and [
zmm13_zmm6_000h_t = 0,
zmm13_zmm6_001h_t = 0,
zmm13_zmm6_010h_t = 0,
zmm13_zmm6_011h_t = 0,
zmm13_zmm6_100h_t = 0,
zmm13_zmm6_101h_t = 0,
zmm13_zmm6_110h_t = 0,
zmm13_zmm6_111h_t = 0
] && true;
(* vpsrlq $0x33,%zmm3,%zmm12                       #! PC = 0x555555556cfd *)
split zmm3_000_h zmm3_000_l zmm3_000 51;
split zmm3_001_h zmm3_001_l zmm3_001 51;
split zmm3_010_h zmm3_010_l zmm3_010 51;
split zmm3_011_h zmm3_011_l zmm3_011 51;
split zmm3_100_h zmm3_100_l zmm3_100 51;
split zmm3_101_h zmm3_101_l zmm3_101 51;
split zmm3_110_h zmm3_110_l zmm3_110 51;
split zmm3_111_h zmm3_111_l zmm3_111 51;
mov zmm12_000 zmm3_000_h;
mov zmm12_001 zmm3_001_h;
mov zmm12_010 zmm3_010_h;
mov zmm12_011 zmm3_011_h;
mov zmm12_100 zmm3_100_h;
mov zmm12_101 zmm3_101_h;
mov zmm12_110 zmm3_110_h;
mov zmm12_111 zmm3_111_h;
(* vpsllq $0x1,%zmm5,%zmm5                         #! PC = 0x555555556d04 *)
shl zmm5_000 zmm5_000 0x1;
shl zmm5_001 zmm5_001 0x1;
shl zmm5_010 zmm5_010 0x1;
shl zmm5_011 zmm5_011 0x1;
shl zmm5_100 zmm5_100 0x1;
shl zmm5_101 zmm5_101 0x1;
shl zmm5_110 zmm5_110 0x1;
shl zmm5_111 zmm5_111 0x1;
(* vpsllq $0x1,%zmm0,%zmm0                         #! PC = 0x555555556d0b *)
shl zmm0_000 zmm0_000 0x1;
shl zmm0_001 zmm0_001 0x1;
shl zmm0_010 zmm0_010 0x1;
shl zmm0_011 zmm0_011 0x1;
shl zmm0_100 zmm0_100 0x1;
shl zmm0_101 zmm0_101 0x1;
shl zmm0_110 zmm0_110 0x1;
shl zmm0_111 zmm0_111 0x1;
(* vpsrlq $0x33,%zmm2,%zmm7                        #! PC = 0x555555556d12 *)
split zmm2_000_h zmm2_000_l zmm2_000 51;
split zmm2_001_h zmm2_001_l zmm2_001 51;
split zmm2_010_h zmm2_010_l zmm2_010 51;
split zmm2_011_h zmm2_011_l zmm2_011 51;
split zmm2_100_h zmm2_100_l zmm2_100 51;
split zmm2_101_h zmm2_101_l zmm2_101 51;
split zmm2_110_h zmm2_110_l zmm2_110 51;
split zmm2_111_h zmm2_111_l zmm2_111 51;
mov zmm7_000 zmm2_000_h;
mov zmm7_001 zmm2_001_h;
mov zmm7_010 zmm2_010_h;
mov zmm7_011 zmm2_011_h;
mov zmm7_100 zmm2_100_h;
mov zmm7_101 zmm2_101_h;
mov zmm7_110 zmm2_110_h;
mov zmm7_111 zmm2_111_h;
(* vpandd %zmm10,%zmm3,%zmm13                      #! PC = 0x555555556d19 *)
mov zmm13_000 zmm3_000_l;
mov zmm13_001 zmm3_001_l;
mov zmm13_010 zmm3_010_l;
mov zmm13_011 zmm3_011_l;
mov zmm13_100 zmm3_100_l;
mov zmm13_101 zmm3_101_l;
mov zmm13_110 zmm3_110_l;
mov zmm13_111 zmm3_111_l;
(* vpandd %zmm10,%zmm9,%zmm9                       #! PC = 0x555555556d1f *)
mov zmm9_000 zmm9_000_l;
mov zmm9_001 zmm9_001_l;
mov zmm9_010 zmm9_010_l;
mov zmm9_011 zmm9_011_l;
mov zmm9_100 zmm9_100_l;
mov zmm9_101 zmm9_101_l;
mov zmm9_110 zmm9_110_l;
mov zmm9_111 zmm9_111_l;
(* vpandd %zmm10,%zmm2,%zmm14                      #! PC = 0x555555556d25 *)
mov zmm14_000 zmm2_000_l;
mov zmm14_001 zmm2_001_l;
mov zmm14_010 zmm2_010_l;
mov zmm14_011 zmm2_011_l;
mov zmm14_100 zmm2_100_l;
mov zmm14_101 zmm2_101_l;
mov zmm14_110 zmm2_110_l;
mov zmm14_111 zmm2_111_l;
(* vpandd %zmm10,%zmm1,%zmm1                       #! PC = 0x555555556d2b *)
mov zmm1_000 zmm1_000_l;
mov zmm1_001 zmm1_001_l;
mov zmm1_010 zmm1_010_l;
mov zmm1_011 zmm1_011_l;
mov zmm1_100 zmm1_100_l;
mov zmm1_101 zmm1_101_l;
mov zmm1_110 zmm1_110_l;
mov zmm1_111 zmm1_111_l;
(* vpaddq %zmm12,%zmm5,%zmm15                      #! PC = 0x555555556d31 *)
add zmm15_000 zmm5_000 zmm12_000;
add zmm15_001 zmm5_001 zmm12_001;
add zmm15_010 zmm5_010 zmm12_010;
add zmm15_011 zmm5_011 zmm12_011;
add zmm15_100 zmm5_100 zmm12_100;
add zmm15_101 zmm5_101 zmm12_101;
add zmm15_110 zmm5_110 zmm12_110;
add zmm15_111 zmm5_111 zmm12_111;
(* vpaddq %zmm7,%zmm0,%zmm10                       #! PC = 0x555555556d37 *)
add zmm10_000 zmm0_000 zmm7_000;
add zmm10_001 zmm0_001 zmm7_001;
add zmm10_010 zmm0_010 zmm7_010;
add zmm10_011 zmm0_011 zmm7_011;
add zmm10_100 zmm0_100 zmm7_100;
add zmm10_101 zmm0_101 zmm7_101;
add zmm10_110 zmm0_110 zmm7_110;
add zmm10_111 zmm0_111 zmm7_111;
(* vpaddq %zmm9,%zmm15,%zmm8                       #! PC = 0x555555556d3d *)
add zmm8_000 zmm15_000 zmm9_000;
add zmm8_001 zmm15_001 zmm9_001;
add zmm8_010 zmm15_010 zmm9_010;
add zmm8_011 zmm15_011 zmm9_011;
add zmm8_100 zmm15_100 zmm9_100;
add zmm8_101 zmm15_101 zmm9_101;
add zmm8_110 zmm15_110 zmm9_110;
add zmm8_111 zmm15_111 zmm9_111;
(* vpaddq %zmm1,%zmm10,%zmm3                       #! PC = 0x555555556d43 *)
add zmm3_000 zmm10_000 zmm1_000;
add zmm3_001 zmm10_001 zmm1_001;
add zmm3_010 zmm10_010 zmm1_010;
add zmm3_011 zmm10_011 zmm1_011;
add zmm3_100 zmm10_100 zmm1_100;
add zmm3_101 zmm10_101 zmm1_101;
add zmm3_110 zmm10_110 zmm1_110;
add zmm3_111 zmm10_111 zmm1_111;
(* vmovdqa64 %zmm4,(%rdi)                          #! EA = L0x7fffffffd800; PC = 0x555555556d49 *)
mov L0x7fffffffd800 zmm4_000;
mov L0x7fffffffd808 zmm4_001;
mov L0x7fffffffd810 zmm4_010;
mov L0x7fffffffd818 zmm4_011;
mov L0x7fffffffd820 zmm4_100;
mov L0x7fffffffd828 zmm4_101;
mov L0x7fffffffd830 zmm4_110;
mov L0x7fffffffd838 zmm4_111;
(* vmovdqa32 %zmm13,0x40(%rdi)                     #! EA = L0x7fffffffd840; PC = 0x555555556d4f *)
mov L0x7fffffffd840 zmm13_000;
mov L0x7fffffffd848 zmm13_001;
mov L0x7fffffffd850 zmm13_010;
mov L0x7fffffffd858 zmm13_011;
mov L0x7fffffffd860 zmm13_100;
mov L0x7fffffffd868 zmm13_101;
mov L0x7fffffffd870 zmm13_110;
mov L0x7fffffffd878 zmm13_111;
(* vmovdqa64 %zmm8,0x80(%rdi)                      #! EA = L0x7fffffffd880; PC = 0x555555556d56 *)
mov L0x7fffffffd880 zmm8_000;
mov L0x7fffffffd888 zmm8_001;
mov L0x7fffffffd890 zmm8_010;
mov L0x7fffffffd898 zmm8_011;
mov L0x7fffffffd8a0 zmm8_100;
mov L0x7fffffffd8a8 zmm8_101;
mov L0x7fffffffd8b0 zmm8_110;
mov L0x7fffffffd8b8 zmm8_111;
(* vmovdqa32 %zmm14,0xc0(%rdi)                     #! EA = L0x7fffffffd8c0; PC = 0x555555556d5d *)
mov L0x7fffffffd8c0 zmm14_000;
mov L0x7fffffffd8c8 zmm14_001;
mov L0x7fffffffd8d0 zmm14_010;
mov L0x7fffffffd8d8 zmm14_011;
mov L0x7fffffffd8e0 zmm14_100;
mov L0x7fffffffd8e8 zmm14_101;
mov L0x7fffffffd8f0 zmm14_110;
mov L0x7fffffffd8f8 zmm14_111;
(* vmovdqa64 %zmm3,0x100(%rdi)                     #! EA = L0x7fffffffd900; PC = 0x555555556d64 *)
mov L0x7fffffffd900 zmm3_000;
mov L0x7fffffffd908 zmm3_001;
mov L0x7fffffffd910 zmm3_010;
mov L0x7fffffffd918 zmm3_011;
mov L0x7fffffffd920 zmm3_100;
mov L0x7fffffffd928 zmm3_101;
mov L0x7fffffffd930 zmm3_110;
mov L0x7fffffffd938 zmm3_111;
(* #! <- SP = 0x7fffffffd538 *)
#! 0x7fffffffd538 = 0x7fffffffd538;
(* #ret                                            #! PC = 0x555555556d6e *)
#ret                                            #! 0x555555556d6e = 0x555555556d6e;

mov c00 L0x7fffffffd800;
mov c10 L0x7fffffffd808;
mov c20 L0x7fffffffd810;
mov c30 L0x7fffffffd818;
mov c40 L0x7fffffffd820;
mov c50 L0x7fffffffd828;
mov c60 L0x7fffffffd830;
mov c70 L0x7fffffffd838;
mov c01 L0x7fffffffd840;
mov c11 L0x7fffffffd848;
mov c21 L0x7fffffffd850;
mov c31 L0x7fffffffd858;
mov c41 L0x7fffffffd860;
mov c51 L0x7fffffffd868;
mov c61 L0x7fffffffd870;
mov c71 L0x7fffffffd878;
mov c02 L0x7fffffffd880;
mov c12 L0x7fffffffd888;
mov c22 L0x7fffffffd890;
mov c32 L0x7fffffffd898;
mov c42 L0x7fffffffd8a0;
mov c52 L0x7fffffffd8a8;
mov c62 L0x7fffffffd8b0;
mov c72 L0x7fffffffd8b8;
mov c03 L0x7fffffffd8c0;
mov c13 L0x7fffffffd8c8;
mov c23 L0x7fffffffd8d0;
mov c33 L0x7fffffffd8d8;
mov c43 L0x7fffffffd8e0;
mov c53 L0x7fffffffd8e8;
mov c63 L0x7fffffffd8f0;
mov c73 L0x7fffffffd8f8;
mov c04 L0x7fffffffd900;
mov c14 L0x7fffffffd908;
mov c24 L0x7fffffffd910;
mov c34 L0x7fffffffd918;
mov c44 L0x7fffffffd920;
mov c54 L0x7fffffffd928;
mov c64 L0x7fffffffd930;
mov c74 L0x7fffffffd938;

assert and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
                  limbs 51 [a00, a01, a02, a03, a04] * limbs 51 [a00, a01, a02, a03, a04] * 2
                  p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
                  limbs 51 [a10, a11, a12, a13, a14] * limbs 51 [a10, a11, a12, a13, a14] * 2
                  p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
                  limbs 51 [a20, a21, a22, a23, a24] * limbs 51 [a20, a21, a22, a23, a24] * 2
                  p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
                  limbs 51 [a30, a31, a32, a33, a34] * limbs 51 [a30, a31, a32, a33, a34] * 2
                  p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
                  limbs 51 [a40, a41, a42, a43, a44] * limbs 51 [a40, a41, a42, a43, a44] * 2
                  p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
                  limbs 51 [a50, a51, a52, a53, a54] * limbs 51 [a50, a51, a52, a53, a54] * 2
                  p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
                  limbs 51 [a60, a61, a62, a63, a64] * limbs 51 [a60, a61, a62, a63, a64] * 2
                  p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
                  limbs 51 [a70, a71, a72, a73, a74] * limbs 51 [a70, a71, a72, a73, a74] * 2
                  p
  ] && true;

assume true &&
  and [
      eqmod limbs 51 [c00, c01, c02, c03, c04]
                  limbs 51 [a00, a01, a02, a03, a04] * limbs 51 [a00, a01, a02, a03, a04] * 2@268
                  p,
      eqmod limbs 51 [c10, c11, c12, c13, c14]
                  limbs 51 [a10, a11, a12, a13, a14] * limbs 51 [a10, a11, a12, a13, a14] * 2@268
                  p,
      eqmod limbs 51 [c20, c21, c22, c23, c24]
                  limbs 51 [a20, a21, a22, a23, a24] * limbs 51 [a20, a21, a22, a23, a24] * 2@268
                  p,
      eqmod limbs 51 [c30, c31, c32, c33, c34]
                  limbs 51 [a30, a31, a32, a33, a34] * limbs 51 [a30, a31, a32, a33, a34] * 2@268
                  p,
      eqmod limbs 51 [c40, c41, c42, c43, c44]
                  limbs 51 [a40, a41, a42, a43, a44] * limbs 51 [a40, a41, a42, a43, a44] * 2@268
                  p,
      eqmod limbs 51 [c50, c51, c52, c53, c54]
                  limbs 51 [a50, a51, a52, a53, a54] * limbs 51 [a50, a51, a52, a53, a54] * 2@268
                  p,
      eqmod limbs 51 [c60, c61, c62, c63, c64]
                  limbs 51 [a60, a61, a62, a63, a64] * limbs 51 [a60, a61, a62, a63, a64] * 2@268
                  p,
      eqmod limbs 51 [c70, c71, c72, c73, c74]
                  limbs 51 [a70, a71, a72, a73, a74] * limbs 51 [a70, a71, a72, a73, a74] * 2@268
                  p
  ];

assert true && and [
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

