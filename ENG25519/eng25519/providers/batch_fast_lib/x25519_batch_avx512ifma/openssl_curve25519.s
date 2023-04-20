.text	

.globl	x25519_fe64_mul
.type	x25519_fe64_mul,@function
.align	32
x25519_fe64_mul:
.cfi_startproc	
	pushq	%rbp
.cfi_adjust_cfa_offset	8
.cfi_offset	%rbp,-16
	pushq	%rbx
.cfi_adjust_cfa_offset	8
.cfi_offset	%rbx,-24
	pushq	%r12
.cfi_adjust_cfa_offset	8
.cfi_offset	%r12,-32
	pushq	%r13
.cfi_adjust_cfa_offset	8
.cfi_offset	%r13,-40
	pushq	%r14
.cfi_adjust_cfa_offset	8
.cfi_offset	%r14,-48
	pushq	%r15
.cfi_adjust_cfa_offset	8
.cfi_offset	%r15,-56
	pushq	%rdi
.cfi_adjust_cfa_offset	8
.cfi_offset	%rdi,-64
	leaq	-16(%rsp),%rsp
.cfi_adjust_cfa_offset	16
.Lfe64_mul_body:

	movq	%rdx,%rax
	movq	0(%rdx),%rbp
	movq	0(%rsi),%rdx
	movq	8(%rax),%rcx
	movq	16(%rax),%r14
	movq	24(%rax),%r15

	mulxq	%rbp,%r8,%rax
	xorl	%edi,%edi
	mulxq	%rcx,%r9,%rbx
	adcxq	%rax,%r9
	mulxq	%r14,%r10,%rax
	adcxq	%rbx,%r10
	mulxq	%r15,%r11,%r12
	movq	8(%rsi),%rdx
	adcxq	%rax,%r11
	movq	%r14,(%rsp)
	adcxq	%rdi,%r12

	mulxq	%rbp,%rax,%rbx
	adoxq	%rax,%r9
	adcxq	%rbx,%r10
	mulxq	%rcx,%rax,%rbx
	adoxq	%rax,%r10
	adcxq	%rbx,%r11
	mulxq	%r14,%rax,%rbx
	adoxq	%rax,%r11
	adcxq	%rbx,%r12
	mulxq	%r15,%rax,%r13
	movq	16(%rsi),%rdx
	adoxq	%rax,%r12
	adcxq	%rdi,%r13
	adoxq	%rdi,%r13

	mulxq	%rbp,%rax,%rbx
	adcxq	%rax,%r10
	adoxq	%rbx,%r11
	mulxq	%rcx,%rax,%rbx
	adcxq	%rax,%r11
	adoxq	%rbx,%r12
	mulxq	%r14,%rax,%rbx
	adcxq	%rax,%r12
	adoxq	%rbx,%r13
	mulxq	%r15,%rax,%r14
	movq	24(%rsi),%rdx
	adcxq	%rax,%r13
	adoxq	%rdi,%r14
	adcxq	%rdi,%r14

	mulxq	%rbp,%rax,%rbx
	adoxq	%rax,%r11
	adcxq	%rbx,%r12
	mulxq	%rcx,%rax,%rbx
	adoxq	%rax,%r12
	adcxq	%rbx,%r13
	mulxq	(%rsp),%rax,%rbx
	adoxq	%rax,%r13
	adcxq	%rbx,%r14
	mulxq	%r15,%rax,%r15
	movl	$38,%edx
	adoxq	%rax,%r14
	adcxq	%rdi,%r15
	adoxq	%rdi,%r15

	jmp	.Lreduce64
.Lfe64_mul_epilogue:
.cfi_endproc	
.size	x25519_fe64_mul,.-x25519_fe64_mul

.globl	x25519_fe64_sqr
.type	x25519_fe64_sqr,@function
.align	32
x25519_fe64_sqr:
.cfi_startproc	
	pushq	%rbp
.cfi_adjust_cfa_offset	8
.cfi_offset	%rbp,-16
	pushq	%rbx
.cfi_adjust_cfa_offset	8
.cfi_offset	%rbx,-24
	pushq	%r12
.cfi_adjust_cfa_offset	8
.cfi_offset	%r12,-32
	pushq	%r13
.cfi_adjust_cfa_offset	8
.cfi_offset	%r13,-40
	pushq	%r14
.cfi_adjust_cfa_offset	8
.cfi_offset	%r14,-48
	pushq	%r15
.cfi_adjust_cfa_offset	8
.cfi_offset	%r15,-56
	pushq	%rdi
.cfi_adjust_cfa_offset	8
.cfi_offset	%rdi,-64
	leaq	-16(%rsp),%rsp
.cfi_adjust_cfa_offset	16
.Lfe64_sqr_body:

	movq	0(%rsi),%rdx
	movq	8(%rsi),%rcx
	movq	16(%rsi),%rbp
	movq	24(%rsi),%rsi


	mulxq	%rdx,%r8,%r15
	mulxq	%rcx,%r9,%rax
	xorl	%edi,%edi
	mulxq	%rbp,%r10,%rbx
	adcxq	%rax,%r10
	mulxq	%rsi,%r11,%r12
	movq	%rcx,%rdx
	adcxq	%rbx,%r11
	adcxq	%rdi,%r12


	mulxq	%rbp,%rax,%rbx
	adoxq	%rax,%r11
	adcxq	%rbx,%r12
	mulxq	%rsi,%rax,%r13
	movq	%rbp,%rdx
	adoxq	%rax,%r12
	adcxq	%rdi,%r13


	mulxq	%rsi,%rax,%r14
	movq	%rcx,%rdx
	adoxq	%rax,%r13
	adcxq	%rdi,%r14
	adoxq	%rdi,%r14

	adcxq	%r9,%r9
	adoxq	%r15,%r9
	adcxq	%r10,%r10
	mulxq	%rdx,%rax,%rbx
	movq	%rbp,%rdx
	adcxq	%r11,%r11
	adoxq	%rax,%r10
	adcxq	%r12,%r12
	adoxq	%rbx,%r11
	mulxq	%rdx,%rax,%rbx
	movq	%rsi,%rdx
	adcxq	%r13,%r13
	adoxq	%rax,%r12
	adcxq	%r14,%r14
	adoxq	%rbx,%r13
	mulxq	%rdx,%rax,%r15
	movl	$38,%edx
	adoxq	%rax,%r14
	adcxq	%rdi,%r15
	adoxq	%rdi,%r15
	jmp	.Lreduce64

.align	32
.Lreduce64:
	mulxq	%r12,%rax,%rbx
	adcxq	%rax,%r8
	adoxq	%rbx,%r9
	mulxq	%r13,%rax,%rbx
	adcxq	%rax,%r9
	adoxq	%rbx,%r10
	mulxq	%r14,%rax,%rbx
	adcxq	%rax,%r10
	adoxq	%rbx,%r11
	mulxq	%r15,%rax,%r12
	adcxq	%rax,%r11
	adoxq	%rdi,%r12
	adcxq	%rdi,%r12

	movq	16(%rsp),%rdi
	imulq	%rdx,%r12

	addq	%r12,%r8
	adcq	$0,%r9
	adcq	$0,%r10
	adcq	$0,%r11

	sbbq	%rax,%rax
	andq	$38,%rax

	addq	%rax,%r8
	movq	%r9,8(%rdi)
	movq	%r10,16(%rdi)
	movq	%r11,24(%rdi)
	movq	%r8,0(%rdi)

	movq	24(%rsp),%r15
.cfi_restore	%r15
	movq	32(%rsp),%r14
.cfi_restore	%r14
	movq	40(%rsp),%r13
.cfi_restore	%r13
	movq	48(%rsp),%r12
.cfi_restore	%r12
	movq	56(%rsp),%rbx
.cfi_restore	%rbx
	movq	64(%rsp),%rbp
.cfi_restore	%rbp
	leaq	72(%rsp),%rsp
.cfi_adjust_cfa_offset	88
.Lfe64_sqr_epilogue:
	.byte	0xf3,0xc3
.cfi_endproc	
.size	x25519_fe64_sqr,.-x25519_fe64_sqr

.globl	x25519_fe64_mul121666
.type	x25519_fe64_mul121666,@function
.align	32
x25519_fe64_mul121666:
.Lfe64_mul121666_body:
.cfi_startproc	
	movl	$121666,%edx
	mulxq	0(%rsi),%r8,%rcx
	mulxq	8(%rsi),%r9,%rax
	addq	%rcx,%r9
	mulxq	16(%rsi),%r10,%rcx
	adcq	%rax,%r10
	mulxq	24(%rsi),%r11,%rax
	adcq	%rcx,%r11
	adcq	$0,%rax

	imulq	$38,%rax,%rax

	addq	%rax,%r8
	adcq	$0,%r9
	adcq	$0,%r10
	adcq	$0,%r11

	sbbq	%rax,%rax
	andq	$38,%rax

	addq	%rax,%r8
	movq	%r9,8(%rdi)
	movq	%r10,16(%rdi)
	movq	%r11,24(%rdi)
	movq	%r8,0(%rdi)

.Lfe64_mul121666_epilogue:
	.byte	0xf3,0xc3
.cfi_endproc	
.size	x25519_fe64_mul121666,.-x25519_fe64_mul121666

.globl	x25519_fe64_add
.type	x25519_fe64_add,@function
.align	32
x25519_fe64_add:
.Lfe64_add_body:
.cfi_startproc	
	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
	movq	16(%rsi),%r10
	movq	24(%rsi),%r11

	addq	0(%rdx),%r8
	adcq	8(%rdx),%r9
	adcq	16(%rdx),%r10
	adcq	24(%rdx),%r11

	sbbq	%rax,%rax
	andq	$38,%rax

	addq	%rax,%r8
	adcq	$0,%r9
	adcq	$0,%r10
	movq	%r9,8(%rdi)
	adcq	$0,%r11
	movq	%r10,16(%rdi)
	sbbq	%rax,%rax
	movq	%r11,24(%rdi)
	andq	$38,%rax

	addq	%rax,%r8
	movq	%r8,0(%rdi)

.Lfe64_add_epilogue:
	.byte	0xf3,0xc3
.cfi_endproc	
.size	x25519_fe64_add,.-x25519_fe64_add

.globl	x25519_fe64_sub
.type	x25519_fe64_sub,@function
.align	32
x25519_fe64_sub:
.Lfe64_sub_body:
.cfi_startproc	
	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
	movq	16(%rsi),%r10
	movq	24(%rsi),%r11

	subq	0(%rdx),%r8
	sbbq	8(%rdx),%r9
	sbbq	16(%rdx),%r10
	sbbq	24(%rdx),%r11

	sbbq	%rax,%rax
	andq	$38,%rax

	subq	%rax,%r8
	sbbq	$0,%r9
	sbbq	$0,%r10
	movq	%r9,8(%rdi)
	sbbq	$0,%r11
	movq	%r10,16(%rdi)
	sbbq	%rax,%rax
	movq	%r11,24(%rdi)
	andq	$38,%rax

	subq	%rax,%r8
	movq	%r8,0(%rdi)

.Lfe64_sub_epilogue:
	.byte	0xf3,0xc3
.cfi_endproc	
.size	x25519_fe64_sub,.-x25519_fe64_sub

.globl	x25519_fe64_tobytes
.type	x25519_fe64_tobytes,@function
.align	32
x25519_fe64_tobytes:
.Lfe64_to_body:
.cfi_startproc	
	movq	0(%rsi),%r8
	movq	8(%rsi),%r9
	movq	16(%rsi),%r10
	movq	24(%rsi),%r11


	leaq	(%r11,%r11,1),%rax
	sarq	$63,%r11
	shrq	$1,%rax
	andq	$19,%r11
	addq	$19,%r11

	addq	%r11,%r8
	adcq	$0,%r9
	adcq	$0,%r10
	adcq	$0,%rax

	leaq	(%rax,%rax,1),%r11
	sarq	$63,%rax
	shrq	$1,%r11
	notq	%rax
	andq	$19,%rax

	subq	%rax,%r8
	sbbq	$0,%r9
	sbbq	$0,%r10
	sbbq	$0,%r11

	movq	%r8,0(%rdi)
	movq	%r9,8(%rdi)
	movq	%r10,16(%rdi)
	movq	%r11,24(%rdi)

.Lfe64_to_epilogue:
	.byte	0xf3,0xc3
.cfi_endproc	
.size	x25519_fe64_tobytes,.-x25519_fe64_tobytes
.byte	88,50,53,53,49,57,32,112,114,105,109,105,116,105,118,101,115,32,102,111,114,32,120,56,54,95,54,52,44,32,67,82,89,80,84,79,71,65,77,83,32,98,121,32,60,97,112,112,114,111,64,111,112,101,110,115,115,108,46,111,114,103,62,0
