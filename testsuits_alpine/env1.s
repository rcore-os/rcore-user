	.file	"env1.c"
	.text
	.comm	env,8,8
	.section	.rodata
.LC0:
	.string	"----------------------\n"
.LC1:
	.string	"USER"
.LC2:
	.string	"USER =%s\n"
.LC3:
	.string	"test"
.LC4:
	.string	"USER=%s\n"
.LC5:
	.string	"env2"
.LC6:
	.string	"./env2"
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	environ(%rip), %rax
	movq	%rax, env(%rip)
	jmp	.L2
.L3:
	movq	environ(%rip), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	environ(%rip), %rax
	addq	$8, %rax
	movq	%rax, environ(%rip)
.L2:
	movq	environ(%rip), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L3
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	leaq	.LC1(%rip), %rdi
	call	getenv@PLT
	movq	%rax, -40(%rbp)
	cmpq	$0, -40(%rbp)
	je	.L4
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC2(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L4:
	movl	$1, %edx
	leaq	.LC3(%rip), %rsi
	leaq	.LC1(%rip), %rdi
	call	setenv@PLT
	leaq	.LC1(%rip), %rdi
	call	getenv@PLT
	movq	%rax, %rsi
	leaq	.LC4(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC5(%rip), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -24(%rbp)
	movq	env(%rip), %rdx
	leaq	-32(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC6(%rip), %rdi
	call	execve@PLT
	movl	$0, %eax
	movq	-8(%rbp), %rcx
	xorq	%fs:40, %rcx
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Alpine 8.2.0) 8.2.0"
	.section	.note.GNU-stack,"",@progbits
