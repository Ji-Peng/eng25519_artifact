/*
+-----------------------------------------------------------------------------+
| This code corresponds to the Galois field F(2^255-19) from the paper        |
| "Efficient Inversion In (Pseudo-)Mersenne Prime Order Fields" authored by   |
| Kaushik Nath,  Indian Statistical Institute, Kolkata, India, and            |
| Palash Sarkar, Indian Statistical Institute, Kolkata, India.	              |
+-----------------------------------------------------------------------------+
| Copyright (c) 2018, Kaushik Nath and Palash Sarkar.                         |
|                                                                             |
| Permission to use this code is granted.                          	      |
|                                                                             |
| Redistribution and use in source and binary forms, with or without          |
| modification, are permitted provided that the following conditions are      |
| met:                                                                        |
|                                                                             |
| * Redistributions of source code must retain the above copyright notice,    |
|   this list of conditions and the following disclaimer.                     |
|                                                                             |
| * Redistributions in binary form must reproduce the above copyright         |
|   notice, this list of conditions and the following disclaimer in the       |
|   documentation and/or other materials provided with the distribution.      |
|                                                                             |
| * The names of the contributors may not be used to endorse or promote       |
|   products derived from this software without specific prior written        |
|   permission.                                                               |
+-----------------------------------------------------------------------------+
| THIS SOFTWARE IS PROVIDED BY THE AUTHORS ""AS IS"" AND ANY EXPRESS OR       |
| IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES   |
| OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.     |
| IN NO EVENT SHALL THE CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,      |
| INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT    |
| NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,   |
| DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY       |
| THEORY LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING |
| NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,| 
| EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.                          |
+-----------------------------------------------------------------------------+
*/
.section .data

.p2align 4
zero: 
.quad 0x0000000000000000

mask63: 
.quad 0x7FFFFFFFFFFFFFFF

.section .text

.p2align 5
.globl gfp25519mul
// void gfp25519mul(gfe25519 *d, const gfe25519 *s1, const gfe25519 *s2);
gfp25519mul:
    // rdi = d, rsi = s1, rdx = s2
    push    %rbp
    push    %rbx
    push    %r12
    push    %r13
    push    %r14
    push    %r15
    
    // rbx = s2
    movq    %rdx, %rbx
    // r13 = 0
    xorq    %r13, %r13
    // rdx = s2[0]
    movq    0(%rbx), %rdx    
    // {r9,r8} = s1[0] * s2[0]
    mulx    0(%rsi), %r8, %r9
    // {r10,rcx} = s1[1] * s2[0]
    mulx    8(%rsi), %rcx, %r10
    // r9 = r9 + rcx
    adcx    %rcx, %r9
    // {r11,rcx} = s1[2] * s2[0]
    mulx    16(%rsi), %rcx, %r11
    // r10 = r10 + rcx
    adcx    %rcx, %r10    
    // {r12, rcx} = s1[3] * s2[0]
    mulx    24(%rsi), %rcx, %r12
    // r11 = r11 + rcx
    adcx    %rcx, %r11
    // r12 = r12 + r13
    adcx    %r13, %r12

    // {r12,r11,10,r9,r8} = s1[0]*s2[0] + s1[1]*s2[0] + s1[2]*s2[0] + s1[3]*s2[0]

    // r14 = 0
    xorq    %r14, %r14

    // rdx = s2[1]
    movq    8(%rbx), %rdx
    // {rbp,rcx} = s1[0] * s2[1]
    mulx    0(%rsi), %rcx, %rbp
    // r9 += rcx
    adcx    %rcx, %r9
    // r10 += rbp
    adox    %rbp, %r10
    // {rbp,rcx} = s1[1] * s2[1]
    mulx    8(%rsi), %rcx, %rbp
    // r10 += rcx
    adcx    %rcx, %r10
    // r11 += rbp
    adox    %rbp, %r11
    // {rbp,rcx} = s1[2] * s2[1]
    mulx    16(%rsi), %rcx, %rbp
    // r11 += rcx
    adcx    %rcx, %r11
    // r12 += rbp
    adox    %rbp, %r12
    // {rbp,rcx} = s1[3] * s2[1]
    mulx    24(%rsi), %rcx, %rbp
    // r12 += rcx
    adcx    %rcx, %r12
    // r13 += rbp
    adox    %rbp, %r13
    // r13 += r14
    adcx    %r14, %r13

    // r15 = 0
    xorq    %r15, %r15
    // rdx = s2[2]
    movq    16(%rbx), %rdx
    // {rbp,rcx} = s1[0] * s2[2]
    mulx    0(%rsi), %rcx, %rbp
    // r10 += rcx
    adcx    %rcx, %r10
    // r11 += rbp
    adox    %rbp, %r11
    // {rbp,rcx} = s1[1] * s2[2]
    mulx    8(%rsi), %rcx, %rbp
    // r11 += rcx
    adcx    %rcx, %r11
    // r12 += rbp
    adox    %rbp, %r12
    // {rbp,rcx} = s1[2] * s2[2]
    mulx    16(%rsi), %rcx, %rbp
    // r12 += rcx
    adcx    %rcx, %r12
    // r13 += rbp
    adox    %rbp, %r13
    // {rbp,rcx} = s1[3] * s2[2]
    mulx    24(%rsi), %rcx, %rbp
    // r13 += rcx
    adcx    %rcx, %r13
    // r14 += rbp
    adox    %rbp, %r14
    // r14 += r15
    adcx    %r15, %r14

    // rax = 0
    xorq    %rax, %rax
    // rdx = s2[3]
    movq    24(%rbx), %rdx
    // {rbp,rcx} = s1[0] * s2[3]
    mulx    0(%rsi), %rcx, %rbp
    adcx    %rcx, %r11
    adox    %rbp, %r12
    // {rbp,rcx} = s1[1] * s2[3]
    mulx    8(%rsi), %rcx, %rbp
    adcx    %rcx, %r12
    adox    %rbp, %r13
    // {rbp,rcx} = s1[2] * s2[3]
    mulx    16(%rsi), %rcx, %rbp
    adcx    %rcx, %r13
    adox    %rbp, %r14
    // {rbp,rcx} = s1[3] * s2[3]
    mulx    24(%rsi), %rcx, %rbp
    adcx    %rcx, %r14
    adox    %rbp, %r15			
    adcx    %rax, %r15

    // {r15,r14,r13,r12,r11,10,r9,r8}

    // rbp = 0
    xorq    %rbp, %rbp
    // rdx = 38
    movq    $38, %rdx
    // {r12,rax} = 38 * r12
    mulx    %r12, %rax, %r12
    // r8 += rax
    adcx    %rax, %r8
    // r9 += r12
    adox    %r12, %r9

    // r12 = 0
    // xorq    %r12, %r12

    // {r13,rcx} = 38 * r13
    mulx    %r13, %rcx, %r13
    // r9 += rcx
    adcx    %rcx, %r9
    // r10 += r13
    adox    %r13, %r10

    // r13 = 0
    // xorq    %r13, %r13

    // {r14,rcx} = 38 * r14
    mulx    %r14, %rcx, %r14
    // r10 += rcx
    adcx    %rcx, %r10
    // r11 += r14
    adox    %r14, %r11

    // {r15,rcx} = 38 * r15
    mulx    %r15, %rcx, %r15
    // r11 += rcx
    adcx    %rcx, %r11
    lea     zero(%rip), %rbp
    adox    (%rbp), %r15
    adcx    (%rbp), %r15

    lea     mask63(%rip), %r13
    shld    $1, %r11, %r15
    andq    (%r13), %r11

    imul    $19, %r15, %r15
    addq    %r15, %r8
    adcq    $0, %r9
    adcq    $0, %r10
    adcq    $0, %r11

    movq    %r8,   0(%rdi)
    movq    %r9,   8(%rdi)
    movq    %r10, 16(%rdi)
    movq    %r11, 24(%rdi)

    pop     %r15
    pop     %r14
    pop     %r13
    pop     %r12
    pop     %rbx
    pop     %rbp

    ret


.p2align 5
.globl gfp25519reduce
// void gfp25519reduce(gfe25519 *s);
gfp25519reduce:

    movq    0(%rdi),   %r8
    movq    8(%rdi),   %r9
    movq    24(%rdi), %r10

    movq    %r10, %r11
    shrq    $63, %r11
    lea     mask63(%rip), %rsi
    andq    (%rsi), %r10

    imul    $19, %r11, %r11
    addq    %r11, %r8
    adcq    $0, %r9

    movq    %r8,   0(%rdi)
    movq    %r9,   8(%rdi)
    movq    %r10, 24(%rdi)

    ret

.globl gfp25519nsqr
gfp25519nsqr:

    push    %rbp
    push    %rbx
    push    %r12
    push    %r13
    push    %r14
    push    %r15
    push    %rdi

    movq    0(%rsi),  %rbx  
    movq    8(%rsi),  %rbp  
    movq    16(%rsi), %rax
    movq    24(%rsi), %rsi

    movq    %rdx, %rdi

    .START:

    decq    %rdi

    xorq    %r13, %r13
    movq    %rbx, %rdx
    
    mulx    %rbp, %r9, %r10

    mulx    %rax, %rcx, %r11
    adcx    %rcx, %r10
    
    mulx    %rsi, %rcx, %r12
    adcx    %rcx, %r11
    adcx    %r13, %r12

    movq    %rbp, %rdx
    xorq    %r14, %r14
    
    mulx    %rax, %rcx, %rdx
    adcx    %rcx, %r11
    adox    %rdx, %r12
    
    movq    %rbp, %rdx
    mulx    %rsi, %rcx, %rdx
    adcx    %rcx, %r12
    adox    %rdx, %r13
    adcx    %r14, %r13

    xorq    %r15, %r15
    movq    %rax, %rdx
    
    mulx    %rsi, %rcx, %r14
    adcx    %rcx, %r13
    adcx    %r15, %r14

    shld    $1, %r14, %r15
    shld    $1, %r13, %r14
    shld    $1, %r12, %r13
    shld    $1, %r11, %r12
    shld    $1, %r10, %r11
    shld    $1, %r9, %r10
    shlq    $1, %r9
     
    xorq    %rdx, %rdx
    movq    %rbx, %rdx
    mulx    %rdx, %r8, %rdx
    adcx    %rdx, %r9

    movq    %rbp, %rdx
    mulx    %rdx, %rcx, %rdx
    adcx    %rcx, %r10
    adcx    %rdx, %r11

    movq    %rax, %rdx
    mulx    %rdx, %rcx, %rdx
    adcx    %rcx, %r12
    adcx    %rdx, %r13

    movq    %rsi, %rdx
    mulx    %rdx, %rcx, %rdx
    adcx    %rcx, %r14
    adcx    %rdx, %r15

    xorq    %rbp, %rbp
    movq    $38, %rdx    		

    mulx    %r12, %rbx, %rbp
    adcx    %r8, %rbx
    adox    %r9, %rbp

    mulx    %r13, %rcx, %rax
    adcx    %rcx, %rbp
    adox    %r10, %rax

    mulx    %r14, %rcx, %rsi
    adcx    %rcx, %rax
    adox    %r11, %rsi

    mulx    %r15, %rcx, %r15
    adcx    %rcx, %rsi
    lea     zero(%rip), %r8
    adox    (%r8), %r15
    adcx    (%r8), %r15

    shld    $1, %rsi, %r15
    lea     mask63(%rip), %r9
    andq    (%r9), %rsi

    imul   $19, %r15, %r15
    addq   %r15, %rbx
    adcq   $0, %rbp
    adcq   $0, %rax
    adcq   $0, %rsi

    cmpq   $0, %rdi

    jne    .START

    pop     %rdi

    movq    %rbx,  0(%rdi)
    movq    %rbp,  8(%rdi)
    movq    %rax, 16(%rdi)
    movq    %rsi, 24(%rdi)

    pop     %r15
    pop     %r14
    pop     %r13
    pop     %r12
    pop     %rbx
    pop     %rbp

    ret
