	.file	"env2.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"child, evn2----------------------\n"
.LC1:
	.string	"----------------------\n"
.LC2:
	.string	"USER"
.LC3:
	.string	"USER =%s\n"
.LC4:
	.string	"TEST"
.LC5:
	.string	"USER=%s\n"
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
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	leaq	.LC0(%rip), %rdi
	call	puts@PLT
	jmp	.L2
.L3:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	puts@PLT
	addq	$8, -40(%rbp)
.L2:
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	jne	.L3
	leaq	.LC1(%rip), %rdi
	call	puts@PLT
	leaq	.LC2(%rip), %rdi
	call	getenv@PLT
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L4
	movq	-8(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
.L4:
	movl	$1, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	setenv@PLT
	leaq	.LC2(%rip), %rdi
	call	getenv@PLT
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	.LC2(%rip), %rdi
	call	unsetenv@PLT
	leaq	.LC2(%rip), %rdi
	call	getenv@PLT
	movq	%rax, %rsi
	leaq	.LC5(%rip), %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %edx
	leaq	.LC4(%rip), %rsi
	leaq	.LC2(%rip), %rdi
	call	setenv@PLT
	movl	$0, %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.ident	"GCC: (Alpine 8.3.0) 8.3.0"
	.section	.note.GNU-stack,"",@progbits
