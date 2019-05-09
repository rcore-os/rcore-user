	.text
	.file	"main.7rcbfp3g-cgu.0"
	.section	.text._ZN3std2rt10lang_start17hd104aeefecd8038fE,"ax",@progbits
	.hidden	_ZN3std2rt10lang_start17hd104aeefecd8038fE
	.globl	_ZN3std2rt10lang_start17hd104aeefecd8038fE
	.p2align	4, 0x90
	.type	_ZN3std2rt10lang_start17hd104aeefecd8038fE,@function
_ZN3std2rt10lang_start17hd104aeefecd8038fE:
	.cfi_startproc
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	leaq	.L__unnamed_1(%rip), %rax
	movq	%rdi, 32(%rsp)
	leaq	32(%rsp), %rdi
	movq	%rsi, 24(%rsp)
	movq	%rax, %rsi
	movq	24(%rsp), %rax
	movq	%rdx, 16(%rsp)
	movq	%rax, %rdx
	movq	16(%rsp), %rcx
	callq	*_ZN3std2rt19lang_start_internal17hb46c7d8805fecd15E@GOTPCREL(%rip)
	movq	%rax, 8(%rsp)
	movq	8(%rsp), %rax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end0:
	.size	_ZN3std2rt10lang_start17hd104aeefecd8038fE, .Lfunc_end0-_ZN3std2rt10lang_start17hd104aeefecd8038fE
	.cfi_endproc

	.section	".text._ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE,@function
_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	callq	*(%rdi)
	callq	_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17ha9ecefda7a6b1407E
	movl	%eax, 4(%rsp)
	movl	4(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end1:
	.size	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE, .Lfunc_end1-_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE
	.cfi_endproc

	.section	.text._ZN3std3sys4unix7process14process_common8ExitCode6as_i3217hf011959b166ac557E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN3std3sys4unix7process14process_common8ExitCode6as_i3217hf011959b166ac557E,@function
_ZN3std3sys4unix7process14process_common8ExitCode6as_i3217hf011959b166ac557E:
	.cfi_startproc
	movzbl	(%rdi), %eax
	retq
.Lfunc_end2:
	.size	_ZN3std3sys4unix7process14process_common8ExitCode6as_i3217hf011959b166ac557E, .Lfunc_end2-_ZN3std3sys4unix7process14process_common8ExitCode6as_i3217hf011959b166ac557E
	.cfi_endproc

	.section	.text._ZN4core3fmt9Arguments6new_v117haedbbf16e2943668E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3fmt9Arguments6new_v117haedbbf16e2943668E,@function
_ZN4core3fmt9Arguments6new_v117haedbbf16e2943668E:
	.cfi_startproc
	subq	$16, %rsp
	.cfi_def_cfa_offset 24
	movq	%rdi, %rax
	movq	$0, (%rsp)
	movq	%rsi, (%rdi)
	movq	%rdx, 8(%rdi)
	movq	(%rsp), %rdx
	movq	8(%rsp), %rsi
	movq	%rdx, 16(%rdi)
	movq	%rsi, 24(%rdi)
	movq	%rcx, 32(%rdi)
	movq	%r8, 40(%rdi)
	addq	$16, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end3:
	.size	_ZN4core3fmt9Arguments6new_v117haedbbf16e2943668E, .Lfunc_end3-_ZN4core3fmt9Arguments6new_v117haedbbf16e2943668E
	.cfi_endproc

	.section	.text._ZN4core3ops8function6FnOnce9call_once17hd0afc3450211ae73E,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ops8function6FnOnce9call_once17hd0afc3450211ae73E,@function
_ZN4core3ops8function6FnOnce9call_once17hd0afc3450211ae73E:
.Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, DW.ref.rust_eh_personality
	.cfi_lsda 27, .Lexception0
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movq	%rdi, 8(%rsp)
.Ltmp0:
	leaq	8(%rsp), %rdi
	callq	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE
.Ltmp1:
	movl	%eax, 4(%rsp)
	jmp	.LBB4_1
.LBB4_1:
	jmp	.LBB4_2
.LBB4_2:
	movl	4(%rsp), %eax
	addq	$40, %rsp
	.cfi_def_cfa_offset 8
	retq
.LBB4_3:
	.cfi_def_cfa_offset 48
	jmp	.LBB4_4
.LBB4_4:
	movq	24(%rsp), %rdi
	callq	_Unwind_Resume@PLT
	ud2
.LBB4_5:
.Ltmp2:
	movl	%edx, %ecx
	movq	%rax, 24(%rsp)
	movl	%ecx, 32(%rsp)
	jmp	.LBB4_3
.Lfunc_end4:
	.size	_ZN4core3ops8function6FnOnce9call_once17hd0afc3450211ae73E, .Lfunc_end4-_ZN4core3ops8function6FnOnce9call_once17hd0afc3450211ae73E
	.cfi_endproc
	.section	.gcc_except_table,"a",@progbits
	.p2align	2
GCC_except_table4:
.Lexception0:
	.byte	255
	.byte	255
	.byte	1
	.uleb128 .Lcst_end0-.Lcst_begin0
.Lcst_begin0:
	.uleb128 .Ltmp0-.Lfunc_begin0
	.uleb128 .Ltmp1-.Ltmp0
	.uleb128 .Ltmp2-.Lfunc_begin0
	.byte	0
	.uleb128 .Ltmp1-.Lfunc_begin0
	.uleb128 .Lfunc_end4-.Ltmp1
	.byte	0
	.byte	0
.Lcst_end0:
	.p2align	2

	.section	".text._ZN4core3ops8function6FnOnce9call_once32_$u7b$$u7b$vtable.shim$u7d$$u7d$17hcc32d95715f82f6aE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ops8function6FnOnce9call_once32_$u7b$$u7b$vtable.shim$u7d$$u7d$17hcc32d95715f82f6aE,@function
_ZN4core3ops8function6FnOnce9call_once32_$u7b$$u7b$vtable.shim$u7d$$u7d$17hcc32d95715f82f6aE:
	.cfi_startproc
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	(%rdi), %rdi
	callq	_ZN4core3ops8function6FnOnce9call_once17hd0afc3450211ae73E
	movl	%eax, 12(%rsp)
	movl	12(%rsp), %eax
	addq	$24, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end5:
	.size	_ZN4core3ops8function6FnOnce9call_once32_$u7b$$u7b$vtable.shim$u7d$$u7d$17hcc32d95715f82f6aE, .Lfunc_end5-_ZN4core3ops8function6FnOnce9call_once32_$u7b$$u7b$vtable.shim$u7d$$u7d$17hcc32d95715f82f6aE
	.cfi_endproc

	.section	.text._ZN4core3ptr18real_drop_in_place17hea7fc73262c2fe7fE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4core3ptr18real_drop_in_place17hea7fc73262c2fe7fE,@function
_ZN4core3ptr18real_drop_in_place17hea7fc73262c2fe7fE:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movq	%rdi, (%rsp)
	popq	%rax
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end6:
	.size	_ZN4core3ptr18real_drop_in_place17hea7fc73262c2fe7fE, .Lfunc_end6-_ZN4core3ptr18real_drop_in_place17hea7fc73262c2fe7fE
	.cfi_endproc

	.section	".text._ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17ha9ecefda7a6b1407E","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17ha9ecefda7a6b1407E,@function
_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17ha9ecefda7a6b1407E:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	xorl	%edi, %edi
	callq	_ZN68_$LT$std..process..ExitCode$u20$as$u20$std..process..Termination$GT$6report17h81bedb91af02c45eE
	movl	%eax, 4(%rsp)
	movl	4(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end7:
	.size	_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17ha9ecefda7a6b1407E, .Lfunc_end7-_ZN54_$LT$$LP$$RP$$u20$as$u20$std..process..Termination$GT$6report17ha9ecefda7a6b1407E
	.cfi_endproc

	.section	".text._ZN68_$LT$std..process..ExitCode$u20$as$u20$std..process..Termination$GT$6report17h81bedb91af02c45eE","ax",@progbits
	.p2align	4, 0x90
	.type	_ZN68_$LT$std..process..ExitCode$u20$as$u20$std..process..Termination$GT$6report17h81bedb91af02c45eE,@function
_ZN68_$LT$std..process..ExitCode$u20$as$u20$std..process..Termination$GT$6report17h81bedb91af02c45eE:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movb	%dil, %al
	movb	%al, 7(%rsp)
	leaq	7(%rsp), %rdi
	callq	_ZN3std3sys4unix7process14process_common8ExitCode6as_i3217hf011959b166ac557E
	movl	%eax, (%rsp)
	movl	(%rsp), %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end8:
	.size	_ZN68_$LT$std..process..ExitCode$u20$as$u20$std..process..Termination$GT$6report17h81bedb91af02c45eE, .Lfunc_end8-_ZN68_$LT$std..process..ExitCode$u20$as$u20$std..process..Termination$GT$6report17h81bedb91af02c45eE
	.cfi_endproc

	.section	.text._ZN4main4main17hfe98083a4c87500fE,"ax",@progbits
	.p2align	4, 0x90
	.type	_ZN4main4main17hfe98083a4c87500fE,@function
_ZN4main4main17hfe98083a4c87500fE:
	.cfi_startproc
	subq	$56, %rsp
	.cfi_def_cfa_offset 64
	leaq	.L__unnamed_2(%rip), %rax
	leaq	.L__unnamed_3(%rip), %rcx
	xorl	%edx, %edx
	movl	%edx, %r8d
	leaq	8(%rsp), %rdi
	movq	%rax, %rsi
	movl	$1, %edx
	callq	_ZN4core3fmt9Arguments6new_v117haedbbf16e2943668E
	leaq	8(%rsp), %rdi
	callq	*_ZN3std2io5stdio6_print17hb337e3f21004a87fE@GOTPCREL(%rip)
	addq	$56, %rsp
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end9:
	.size	_ZN4main4main17hfe98083a4c87500fE, .Lfunc_end9-_ZN4main4main17hfe98083a4c87500fE
	.cfi_endproc

	.section	.text.main,"ax",@progbits
	.globl	main
	.p2align	4, 0x90
	.type	main,@function
main:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	movslq	%edi, %rax
	leaq	_ZN4main4main17hfe98083a4c87500fE(%rip), %rdi
	movq	%rsi, (%rsp)
	movq	%rax, %rsi
	movq	(%rsp), %rdx
	callq	_ZN3std2rt10lang_start17hd104aeefecd8038fE
	movl	%eax, %ecx
	movl	%ecx, %eax
	popq	%rcx
	.cfi_def_cfa_offset 8
	retq
.Lfunc_end10:
	.size	main, .Lfunc_end10-main
	.cfi_endproc

	.type	.L__unnamed_1,@object
	.section	.data.rel.ro..L__unnamed_1,"aw",@progbits
	.p2align	3
.L__unnamed_1:
	.quad	_ZN4core3ptr18real_drop_in_place17hea7fc73262c2fe7fE
	.quad	8
	.quad	8
	.quad	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE
	.quad	_ZN3std2rt10lang_start28_$u7b$$u7b$closure$u7d$$u7d$17h8f8384c3a63fbb7bE
	.quad	_ZN4core3ops8function6FnOnce9call_once32_$u7b$$u7b$vtable.shim$u7d$$u7d$17hcc32d95715f82f6aE
	.size	.L__unnamed_1, 48

	.type	.L__unnamed_4,@object
	.section	.rodata..L__unnamed_4,"a",@progbits
.L__unnamed_4:
	.ascii	"Hello, world!\n"
	.size	.L__unnamed_4, 14

	.type	.L__unnamed_2,@object
	.section	.data.rel.ro..L__unnamed_2,"aw",@progbits
	.p2align	3
.L__unnamed_2:
	.quad	.L__unnamed_4
	.asciz	"\016\000\000\000\000\000\000"
	.size	.L__unnamed_2, 16

	.type	.L__unnamed_3,@object
	.section	.rodata..L__unnamed_3,"a",@progbits
	.p2align	3
.L__unnamed_3:
	.size	.L__unnamed_3, 0

	.hidden	DW.ref.rust_eh_personality
	.weak	DW.ref.rust_eh_personality
	.section	.data.DW.ref.rust_eh_personality,"aGw",@progbits,DW.ref.rust_eh_personality,comdat
	.p2align	3
	.type	DW.ref.rust_eh_personality,@object
	.size	DW.ref.rust_eh_personality, 8
DW.ref.rust_eh_personality:
	.quad	rust_eh_personality

	.section	".note.GNU-stack","",@progbits
