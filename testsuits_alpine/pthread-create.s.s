
pthread-create.s：     文件格式 elf64-x86-64


Disassembly of section .init:

0000000000400120 <_init>:
  400120:	50                   	push   %rax
  400121:	e8 7a 01 00 00       	callq  4002a0 <frame_dummy>
  400126:	e8 25 3b 00 00       	callq  403c50 <__do_global_ctors_aux>
  40012b:	58                   	pop    %rax
  40012c:	c3                   	retq   

Disassembly of section .text:

0000000000400130 <exit>:
  400130:	48 83 ec 18          	sub    $0x18,%rsp
  400134:	89 7c 24 0c          	mov    %edi,0xc(%rsp)
  400138:	e8 cb 04 00 00       	callq  400608 <__funcs_on_exit>
  40013d:	e8 c7 04 00 00       	callq  400609 <__libc_exit_fini>
  400142:	31 c0                	xor    %eax,%eax
  400144:	e8 63 3a 00 00       	callq  403bac <__stdio_exit>
  400149:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  40014d:	e8 e6 2a 00 00       	callq  402c38 <_Exit>

0000000000400152 <_start>:
  400152:	48 31 ed             	xor    %rbp,%rbp
  400155:	48 89 e7             	mov    %rsp,%rdi
  400158:	48 8d 35 a1 fe bf ff 	lea    -0x40015f(%rip),%rsi        # 0 <_init-0x400120>
  40015f:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  400163:	e8 00 00 00 00       	callq  400168 <_start_c>

0000000000400168 <_start_c>:
  400168:	48 83 ec 08          	sub    $0x8,%rsp
  40016c:	48 8b 37             	mov    (%rdi),%rsi
  40016f:	48 8d 57 08          	lea    0x8(%rdi),%rdx
  400173:	45 31 c9             	xor    %r9d,%r9d
  400176:	41 b8 87 3c 40 00    	mov    $0x403c87,%r8d
  40017c:	b9 20 01 40 00       	mov    $0x400120,%ecx
  400181:	bf de 02 40 00       	mov    $0x4002de,%edi
  400186:	e8 45 04 00 00       	callq  4005d0 <__libc_start_main>
  40018b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000400190 <deregister_tm_clones>:
  400190:	b8 1f 52 60 00       	mov    $0x60521f,%eax
  400195:	55                   	push   %rbp
  400196:	48 2d 18 52 60 00    	sub    $0x605218,%rax
  40019c:	48 83 f8 0e          	cmp    $0xe,%rax
  4001a0:	48 89 e5             	mov    %rsp,%rbp
  4001a3:	76 1b                	jbe    4001c0 <deregister_tm_clones+0x30>
  4001a5:	b8 00 00 00 00       	mov    $0x0,%eax
  4001aa:	48 85 c0             	test   %rax,%rax
  4001ad:	74 11                	je     4001c0 <deregister_tm_clones+0x30>
  4001af:	5d                   	pop    %rbp
  4001b0:	bf 18 52 60 00       	mov    $0x605218,%edi
  4001b5:	ff e0                	jmpq   *%rax
  4001b7:	66 0f 1f 84 00 00 00 	nopw   0x0(%rax,%rax,1)
  4001be:	00 00 
  4001c0:	5d                   	pop    %rbp
  4001c1:	c3                   	retq   
  4001c2:	0f 1f 40 00          	nopl   0x0(%rax)
  4001c6:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4001cd:	00 00 00 

00000000004001d0 <register_tm_clones>:
  4001d0:	be 18 52 60 00       	mov    $0x605218,%esi
  4001d5:	55                   	push   %rbp
  4001d6:	48 81 ee 18 52 60 00 	sub    $0x605218,%rsi
  4001dd:	48 c1 fe 03          	sar    $0x3,%rsi
  4001e1:	48 89 e5             	mov    %rsp,%rbp
  4001e4:	48 89 f0             	mov    %rsi,%rax
  4001e7:	48 c1 e8 3f          	shr    $0x3f,%rax
  4001eb:	48 01 c6             	add    %rax,%rsi
  4001ee:	48 d1 fe             	sar    %rsi
  4001f1:	74 15                	je     400208 <register_tm_clones+0x38>
  4001f3:	b8 00 00 00 00       	mov    $0x0,%eax
  4001f8:	48 85 c0             	test   %rax,%rax
  4001fb:	74 0b                	je     400208 <register_tm_clones+0x38>
  4001fd:	5d                   	pop    %rbp
  4001fe:	bf 18 52 60 00       	mov    $0x605218,%edi
  400203:	ff e0                	jmpq   *%rax
  400205:	0f 1f 00             	nopl   (%rax)
  400208:	5d                   	pop    %rbp
  400209:	c3                   	retq   
  40020a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000400210 <__do_global_dtors_aux>:
  400210:	80 3d 09 50 20 00 00 	cmpb   $0x0,0x205009(%rip)        # 605220 <completed.5536>
  400217:	75 76                	jne    40028f <__do_global_dtors_aux+0x7f>
  400219:	55                   	push   %rbp
  40021a:	48 8b 05 07 50 20 00 	mov    0x205007(%rip),%rax        # 605228 <dtor_idx.5538>
  400221:	48 89 e5             	mov    %rsp,%rbp
  400224:	41 54                	push   %r12
  400226:	53                   	push   %rbx
  400227:	bb f0 4f 60 00       	mov    $0x604ff0,%ebx
  40022c:	41 bc e8 4f 60 00    	mov    $0x604fe8,%r12d
  400232:	48 81 eb e8 4f 60 00 	sub    $0x604fe8,%rbx
  400239:	48 c1 fb 03          	sar    $0x3,%rbx
  40023d:	48 83 eb 01          	sub    $0x1,%rbx
  400241:	48 39 d8             	cmp    %rbx,%rax
  400244:	73 25                	jae    40026b <__do_global_dtors_aux+0x5b>
  400246:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40024d:	00 00 00 
  400250:	48 83 c0 01          	add    $0x1,%rax
  400254:	48 89 05 cd 4f 20 00 	mov    %rax,0x204fcd(%rip)        # 605228 <dtor_idx.5538>
  40025b:	41 ff 14 c4          	callq  *(%r12,%rax,8)
  40025f:	48 8b 05 c2 4f 20 00 	mov    0x204fc2(%rip),%rax        # 605228 <dtor_idx.5538>
  400266:	48 39 c3             	cmp    %rax,%rbx
  400269:	77 e5                	ja     400250 <__do_global_dtors_aux+0x40>
  40026b:	e8 20 ff ff ff       	callq  400190 <deregister_tm_clones>
  400270:	b8 00 00 00 00       	mov    $0x0,%eax
  400275:	48 85 c0             	test   %rax,%rax
  400278:	74 0a                	je     400284 <__do_global_dtors_aux+0x74>
  40027a:	bf f0 49 40 00       	mov    $0x4049f0,%edi
  40027f:	e8 7c fd bf ff       	callq  0 <_init-0x400120>
  400284:	5b                   	pop    %rbx
  400285:	41 5c                	pop    %r12
  400287:	5d                   	pop    %rbp
  400288:	c6 05 91 4f 20 00 01 	movb   $0x1,0x204f91(%rip)        # 605220 <completed.5536>
  40028f:	f3 c3                	repz retq 
  400291:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  400296:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40029d:	00 00 00 

00000000004002a0 <frame_dummy>:
  4002a0:	55                   	push   %rbp
  4002a1:	b8 00 00 00 00       	mov    $0x0,%eax
  4002a6:	48 85 c0             	test   %rax,%rax
  4002a9:	48 89 e5             	mov    %rsp,%rbp
  4002ac:	74 0f                	je     4002bd <frame_dummy+0x1d>
  4002ae:	be 40 52 60 00       	mov    $0x605240,%esi
  4002b3:	bf f0 49 40 00       	mov    $0x4049f0,%edi
  4002b8:	e8 43 fd bf ff       	callq  0 <_init-0x400120>
  4002bd:	bf f8 4f 60 00       	mov    $0x604ff8,%edi
  4002c2:	48 83 3f 00          	cmpq   $0x0,(%rdi)
  4002c6:	75 08                	jne    4002d0 <frame_dummy+0x30>
  4002c8:	5d                   	pop    %rbp
  4002c9:	e9 02 ff ff ff       	jmpq   4001d0 <register_tm_clones>
  4002ce:	66 90                	xchg   %ax,%ax
  4002d0:	b8 00 00 00 00       	mov    $0x0,%eax
  4002d5:	48 85 c0             	test   %rax,%rax
  4002d8:	74 ee                	je     4002c8 <frame_dummy+0x28>
  4002da:	ff d0                	callq  *%rax
  4002dc:	eb ea                	jmp    4002c8 <frame_dummy+0x28>

00000000004002de <main>:
  4002de:	55                   	push   %rbp
  4002df:	48 89 e5             	mov    %rsp,%rbp
  4002e2:	48 83 ec 30          	sub    $0x30,%rsp
  4002e6:	48 c7 45 f8 a0 3c 40 	movq   $0x403ca0,-0x8(%rbp)
  4002ed:	00 
  4002ee:	48 c7 45 f0 a9 3c 40 	movq   $0x403ca9,-0x10(%rbp)
  4002f5:	00 
  4002f6:	48 8b 55 f8          	mov    -0x8(%rbp),%rdx
  4002fa:	48 8d 45 e0          	lea    -0x20(%rbp),%rax
  4002fe:	48 89 d1             	mov    %rdx,%rcx
  400301:	ba e2 03 40 00       	mov    $0x4003e2,%edx
  400306:	be 00 00 00 00       	mov    $0x0,%esi
  40030b:	48 89 c7             	mov    %rax,%rdi
  40030e:	e8 17 20 00 00       	callq  40232a <__pthread_create>
  400313:	89 45 ec             	mov    %eax,-0x14(%rbp)
  400316:	83 7d ec 00          	cmpl   $0x0,-0x14(%rbp)
  40031a:	74 26                	je     400342 <main+0x64>
  40031c:	48 8b 05 35 3a 00 00 	mov    0x3a35(%rip),%rax        # 403d58 <stderr>
  400323:	8b 55 ec             	mov    -0x14(%rbp),%edx
  400326:	be b8 3c 40 00       	mov    $0x403cb8,%esi
  40032b:	48 89 c7             	mov    %rax,%rdi
  40032e:	b8 00 00 00 00       	mov    $0x0,%eax
  400333:	e8 f2 02 00 00       	callq  40062a <fprintf>
  400338:	bf 01 00 00 00       	mov    $0x1,%edi
  40033d:	e8 ee fd ff ff       	callq  400130 <exit>
  400342:	48 8b 55 f0          	mov    -0x10(%rbp),%rdx
  400346:	48 8d 45 d8          	lea    -0x28(%rbp),%rax
  40034a:	48 89 d1             	mov    %rdx,%rcx
  40034d:	ba e2 03 40 00       	mov    $0x4003e2,%edx
  400352:	be 00 00 00 00       	mov    $0x0,%esi
  400357:	48 89 c7             	mov    %rax,%rdi
  40035a:	e8 cb 1f 00 00       	callq  40232a <__pthread_create>
  40035f:	89 45 e8             	mov    %eax,-0x18(%rbp)
  400362:	83 7d e8 00          	cmpl   $0x0,-0x18(%rbp)
  400366:	74 26                	je     40038e <main+0xb0>
  400368:	48 8b 05 e9 39 00 00 	mov    0x39e9(%rip),%rax        # 403d58 <stderr>
  40036f:	8b 55 e8             	mov    -0x18(%rbp),%edx
  400372:	be b8 3c 40 00       	mov    $0x403cb8,%esi
  400377:	48 89 c7             	mov    %rax,%rdi
  40037a:	b8 00 00 00 00       	mov    $0x0,%eax
  40037f:	e8 a6 02 00 00       	callq  40062a <fprintf>
  400384:	bf 01 00 00 00       	mov    $0x1,%edi
  400389:	e8 a2 fd ff ff       	callq  400130 <exit>
  40038e:	8b 45 ec             	mov    -0x14(%rbp),%eax
  400391:	89 c6                	mov    %eax,%esi
  400393:	bf e8 3c 40 00       	mov    $0x403ce8,%edi
  400398:	b8 00 00 00 00       	mov    $0x0,%eax
  40039d:	e8 17 03 00 00       	callq  4006b9 <printf>
  4003a2:	8b 45 e8             	mov    -0x18(%rbp),%eax
  4003a5:	89 c6                	mov    %eax,%esi
  4003a7:	bf 18 3d 40 00       	mov    $0x403d18,%edi
  4003ac:	b8 00 00 00 00       	mov    $0x0,%eax
  4003b1:	e8 03 03 00 00       	callq  4006b9 <printf>
  4003b6:	48 8b 45 e0          	mov    -0x20(%rbp),%rax
  4003ba:	be 00 00 00 00       	mov    $0x0,%esi
  4003bf:	48 89 c7             	mov    %rax,%rdi
  4003c2:	e8 b7 24 00 00       	callq  40287e <__pthread_join>
  4003c7:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
  4003cb:	be 00 00 00 00       	mov    $0x0,%esi
  4003d0:	48 89 c7             	mov    %rax,%rdi
  4003d3:	e8 a6 24 00 00       	callq  40287e <__pthread_join>
  4003d8:	bf 00 00 00 00       	mov    $0x0,%edi
  4003dd:	e8 4e fd ff ff       	callq  400130 <exit>

00000000004003e2 <print_message_function>:
  4003e2:	55                   	push   %rbp
  4003e3:	48 89 e5             	mov    %rsp,%rbp
  4003e6:	48 83 ec 20          	sub    $0x20,%rsp
  4003ea:	48 89 7d e8          	mov    %rdi,-0x18(%rbp)
  4003ee:	48 8b 45 e8          	mov    -0x18(%rbp),%rax
  4003f2:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
  4003f6:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
  4003fa:	48 89 c6             	mov    %rax,%rsi
  4003fd:	bf 43 3d 40 00       	mov    $0x403d43,%edi
  400402:	b8 00 00 00 00       	mov    $0x0,%eax
  400407:	e8 ad 02 00 00       	callq  4006b9 <printf>
  40040c:	90                   	nop
  40040d:	c9                   	leaveq 
  40040e:	c3                   	retq   

000000000040040f <dummy>:
  40040f:	c3                   	retq   

0000000000400410 <__init_ssp>:
  400410:	c3                   	retq   

0000000000400411 <__init_libc>:
  400411:	53                   	push   %rbx
  400412:	48 89 fa             	mov    %rdi,%rdx
  400415:	31 c0                	xor    %eax,%eax
  400417:	b9 4c 00 00 00       	mov    $0x4c,%ecx
  40041c:	48 81 ec 50 01 00 00 	sub    $0x150,%rsp
  400423:	48 89 15 a6 52 20 00 	mov    %rdx,0x2052a6(%rip)        # 6056d0 <__environ>
  40042a:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
  40042f:	f3 ab                	rep stos %eax,%es:(%rdi)
  400431:	31 c0                	xor    %eax,%eax
  400433:	48 83 3c c2 00       	cmpq   $0x0,(%rdx,%rax,8)
  400438:	48 8d 40 01          	lea    0x1(%rax),%rax
  40043c:	75 f5                	jne    400433 <__init_libc+0x22>
  40043e:	48 8d 04 c2          	lea    (%rdx,%rax,8),%rax
  400442:	48 89 05 a7 54 20 00 	mov    %rax,0x2054a7(%rip)        # 6058f0 <__libc+0x10>
  400449:	48 8b 18             	mov    (%rax),%rbx
  40044c:	48 85 db             	test   %rbx,%rbx
  40044f:	74 15                	je     400466 <__init_libc+0x55>
  400451:	48 83 fb 25          	cmp    $0x25,%rbx
  400455:	77 09                	ja     400460 <__init_libc+0x4f>
  400457:	48 8b 50 08          	mov    0x8(%rax),%rdx
  40045b:	48 89 54 dc 20       	mov    %rdx,0x20(%rsp,%rbx,8)
  400460:	48 83 c0 10          	add    $0x10,%rax
  400464:	eb e3                	jmp    400449 <__init_libc+0x38>
  400466:	48 8b 84 24 a0 00 00 	mov    0xa0(%rsp),%rax
  40046d:	00 
  40046e:	48 85 f6             	test   %rsi,%rsi
  400471:	48 89 05 48 54 20 00 	mov    %rax,0x205448(%rip)        # 6058c0 <__hwcap>
  400478:	48 8b 84 24 20 01 00 	mov    0x120(%rsp),%rax
  40047f:	00 
  400480:	48 89 05 c9 54 20 00 	mov    %rax,0x2054c9(%rip)        # 605950 <__sysinfo>
  400487:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  40048c:	48 89 05 85 54 20 00 	mov    %rax,0x205485(%rip)        # 605918 <__libc+0x38>
  400493:	75 14                	jne    4004a9 <__init_libc+0x98>
  400495:	48 8b b4 24 18 01 00 	mov    0x118(%rsp),%rsi
  40049c:	00 
  40049d:	b8 2d 3e 40 00       	mov    $0x403e2d,%eax
  4004a2:	48 85 f6             	test   %rsi,%rsi
  4004a5:	48 0f 44 f0          	cmove  %rax,%rsi
  4004a9:	48 89 35 c0 4d 20 00 	mov    %rsi,0x204dc0(%rip)        # 605270 <__progname_full>
  4004b0:	48 89 35 c1 4d 20 00 	mov    %rsi,0x204dc1(%rip)        # 605278 <__progname>
  4004b7:	48 ff c6             	inc    %rsi
  4004ba:	8a 46 ff             	mov    -0x1(%rsi),%al
  4004bd:	84 c0                	test   %al,%al
  4004bf:	74 06                	je     4004c7 <__init_libc+0xb6>
  4004c1:	3c 2f                	cmp    $0x2f,%al
  4004c3:	75 f2                	jne    4004b7 <__init_libc+0xa6>
  4004c5:	eb e9                	jmp    4004b0 <__init_libc+0x9f>
  4004c7:	48 8d 7c 24 20       	lea    0x20(%rsp),%rdi
  4004cc:	e8 8f 25 00 00       	callq  402a60 <__init_tls>
  4004d1:	48 8b bc 24 e8 00 00 	mov    0xe8(%rsp),%rdi
  4004d8:	00 
  4004d9:	e8 32 ff ff ff       	callq  400410 <__init_ssp>
  4004de:	48 8b 84 24 80 00 00 	mov    0x80(%rsp),%rax
  4004e5:	00 
  4004e6:	48 39 44 24 78       	cmp    %rax,0x78(%rsp)
  4004eb:	75 1d                	jne    40050a <__init_libc+0xf9>
  4004ed:	48 8b 84 24 90 00 00 	mov    0x90(%rsp),%rax
  4004f4:	00 
  4004f5:	48 39 84 24 88 00 00 	cmp    %rax,0x88(%rsp)
  4004fc:	00 
  4004fd:	75 0b                	jne    40050a <__init_libc+0xf9>
  4004ff:	48 83 bc 24 d8 00 00 	cmpq   $0x0,0xd8(%rsp)
  400506:	00 00 
  400508:	74 6d                	je     400577 <__init_libc+0x166>
  40050a:	48 8d 7c 24 08       	lea    0x8(%rsp),%rdi
  40050f:	ba 06 00 00 00       	mov    $0x6,%edx
  400514:	31 c0                	xor    %eax,%eax
  400516:	48 89 d1             	mov    %rdx,%rcx
  400519:	4c 8d 44 24 08       	lea    0x8(%rsp),%r8
  40051e:	be 03 00 00 00       	mov    $0x3,%esi
  400523:	f3 ab                	rep stos %eax,%es:(%rdi)
  400525:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%rsp)
  40052c:	00 
  40052d:	c7 44 24 18 02 00 00 	movl   $0x2,0x18(%rsp)
  400534:	00 
  400535:	b8 07 00 00 00       	mov    $0x7,%eax
  40053a:	4c 89 c7             	mov    %r8,%rdi
  40053d:	48 89 ca             	mov    %rcx,%rdx
  400540:	0f 05                	syscall 
  400542:	85 c0                	test   %eax,%eax
  400544:	79 01                	jns    400547 <__init_libc+0x136>
  400546:	f4                   	hlt    
  400547:	be 02 00 00 00       	mov    $0x2,%esi
  40054c:	bf 48 3d 40 00       	mov    $0x403d48,%edi
  400551:	41 f6 44 d8 06 20    	testb  $0x20,0x6(%r8,%rbx,8)
  400557:	74 0b                	je     400564 <__init_libc+0x153>
  400559:	48 89 f0             	mov    %rsi,%rax
  40055c:	0f 05                	syscall 
  40055e:	48 85 c0             	test   %rax,%rax
  400561:	79 01                	jns    400564 <__init_libc+0x153>
  400563:	f4                   	hlt    
  400564:	48 ff c3             	inc    %rbx
  400567:	48 83 fb 03          	cmp    $0x3,%rbx
  40056b:	75 e4                	jne    400551 <__init_libc+0x140>
  40056d:	c7 05 71 53 20 00 01 	movl   $0x1,0x205371(%rip)        # 6058e8 <__libc+0x8>
  400574:	00 00 00 
  400577:	48 81 c4 50 01 00 00 	add    $0x150,%rsp
  40057e:	5b                   	pop    %rbx
  40057f:	c3                   	retq   

0000000000400580 <__libc_start_init>:
  400580:	53                   	push   %rbx
  400581:	bb d8 4f 60 00       	mov    $0x604fd8,%ebx
  400586:	e8 95 fb ff ff       	callq  400120 <_init>
  40058b:	48 81 fb d8 4f 60 00 	cmp    $0x604fd8,%rbx
  400592:	73 08                	jae    40059c <__libc_start_init+0x1c>
  400594:	ff 13                	callq  *(%rbx)
  400596:	48 83 c3 08          	add    $0x8,%rbx
  40059a:	eb ef                	jmp    40058b <__libc_start_init+0xb>
  40059c:	5b                   	pop    %rbx
  40059d:	c3                   	retq   

000000000040059e <libc_start_main_stage2>:
  40059e:	41 55                	push   %r13
  4005a0:	48 63 c6             	movslq %esi,%rax
  4005a3:	41 54                	push   %r12
  4005a5:	55                   	push   %rbp
  4005a6:	53                   	push   %rbx
  4005a7:	4c 8d 6c c2 08       	lea    0x8(%rdx,%rax,8),%r13
  4005ac:	48 89 c3             	mov    %rax,%rbx
  4005af:	48 89 d5             	mov    %rdx,%rbp
  4005b2:	49 89 fc             	mov    %rdi,%r12
  4005b5:	48 83 ec 08          	sub    $0x8,%rsp
  4005b9:	e8 c2 ff ff ff       	callq  400580 <__libc_start_init>
  4005be:	89 df                	mov    %ebx,%edi
  4005c0:	4c 89 ea             	mov    %r13,%rdx
  4005c3:	48 89 ee             	mov    %rbp,%rsi
  4005c6:	41 ff d4             	callq  *%r12
  4005c9:	89 c7                	mov    %eax,%edi
  4005cb:	e8 60 fb ff ff       	callq  400130 <exit>

00000000004005d0 <__libc_start_main>:
  4005d0:	55                   	push   %rbp
  4005d1:	53                   	push   %rbx
  4005d2:	48 63 c6             	movslq %esi,%rax
  4005d5:	48 89 fd             	mov    %rdi,%rbp
  4005d8:	48 8d 7c c2 08       	lea    0x8(%rdx,%rax,8),%rdi
  4005dd:	48 89 c3             	mov    %rax,%rbx
  4005e0:	48 83 ec 18          	sub    $0x18,%rsp
  4005e4:	48 8b 32             	mov    (%rdx),%rsi
  4005e7:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  4005ec:	e8 20 fe ff ff       	callq  400411 <__init_libc>
  4005f1:	b8 9e 05 40 00       	mov    $0x40059e,%eax
  4005f6:	89 de                	mov    %ebx,%esi
  4005f8:	48 89 ef             	mov    %rbp,%rdi
  4005fb:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  400600:	48 83 c4 18          	add    $0x18,%rsp
  400604:	5b                   	pop    %rbx
  400605:	5d                   	pop    %rbp
  400606:	ff e0                	jmpq   *%rax

0000000000400608 <__funcs_on_exit>:
  400608:	c3                   	retq   

0000000000400609 <__libc_exit_fini>:
  400609:	53                   	push   %rbx
  40060a:	bb d8 4f 60 00       	mov    $0x604fd8,%ebx
  40060f:	48 81 fb d8 4f 60 00 	cmp    $0x604fd8,%rbx
  400616:	76 0a                	jbe    400622 <__libc_exit_fini+0x19>
  400618:	48 83 eb 08          	sub    $0x8,%rbx
  40061c:	31 c0                	xor    %eax,%eax
  40061e:	ff 13                	callq  *(%rbx)
  400620:	eb ed                	jmp    40060f <__libc_exit_fini+0x6>
  400622:	5b                   	pop    %rbx
  400623:	31 c0                	xor    %eax,%eax
  400625:	e9 5d 36 00 00       	jmpq   403c87 <_fini>

000000000040062a <fprintf>:
  40062a:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
  400631:	84 c0                	test   %al,%al
  400633:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
  400638:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
  40063d:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
  400642:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
  400647:	74 37                	je     400680 <fprintf+0x56>
  400649:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
  40064e:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
  400653:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
  400658:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
  40065f:	00 
  400660:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
  400667:	00 
  400668:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
  40066f:	00 
  400670:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
  400677:	00 
  400678:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
  40067f:	00 
  400680:	48 8d 84 24 e0 00 00 	lea    0xe0(%rsp),%rax
  400687:	00 
  400688:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  40068d:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  400692:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  400697:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%rsp)
  40069e:	00 
  40069f:	c7 44 24 0c 30 00 00 	movl   $0x30,0xc(%rsp)
  4006a6:	00 
  4006a7:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  4006ac:	e8 b5 17 00 00       	callq  401e66 <vfprintf>
  4006b1:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
  4006b8:	c3                   	retq   

00000000004006b9 <printf>:
  4006b9:	48 81 ec d8 00 00 00 	sub    $0xd8,%rsp
  4006c0:	84 c0                	test   %al,%al
  4006c2:	48 89 74 24 28       	mov    %rsi,0x28(%rsp)
  4006c7:	48 89 54 24 30       	mov    %rdx,0x30(%rsp)
  4006cc:	48 89 4c 24 38       	mov    %rcx,0x38(%rsp)
  4006d1:	4c 89 44 24 40       	mov    %r8,0x40(%rsp)
  4006d6:	4c 89 4c 24 48       	mov    %r9,0x48(%rsp)
  4006db:	74 37                	je     400714 <printf+0x5b>
  4006dd:	0f 29 44 24 50       	movaps %xmm0,0x50(%rsp)
  4006e2:	0f 29 4c 24 60       	movaps %xmm1,0x60(%rsp)
  4006e7:	0f 29 54 24 70       	movaps %xmm2,0x70(%rsp)
  4006ec:	0f 29 9c 24 80 00 00 	movaps %xmm3,0x80(%rsp)
  4006f3:	00 
  4006f4:	0f 29 a4 24 90 00 00 	movaps %xmm4,0x90(%rsp)
  4006fb:	00 
  4006fc:	0f 29 ac 24 a0 00 00 	movaps %xmm5,0xa0(%rsp)
  400703:	00 
  400704:	0f 29 b4 24 b0 00 00 	movaps %xmm6,0xb0(%rsp)
  40070b:	00 
  40070c:	0f 29 bc 24 c0 00 00 	movaps %xmm7,0xc0(%rsp)
  400713:	00 
  400714:	48 8d 84 24 e0 00 00 	lea    0xe0(%rsp),%rax
  40071b:	00 
  40071c:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  400721:	48 89 fe             	mov    %rdi,%rsi
  400724:	bf 20 51 60 00       	mov    $0x605120,%edi
  400729:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  40072e:	48 8d 44 24 20       	lea    0x20(%rsp),%rax
  400733:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%rsp)
  40073a:	00 
  40073b:	c7 44 24 0c 30 00 00 	movl   $0x30,0xc(%rsp)
  400742:	00 
  400743:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  400748:	e8 19 17 00 00       	callq  401e66 <vfprintf>
  40074d:	48 81 c4 d8 00 00 00 	add    $0xd8,%rsp
  400754:	c3                   	retq   

0000000000400755 <pop_arg>:
  400755:	83 ee 09             	sub    $0x9,%esi
  400758:	83 fe 11             	cmp    $0x11,%esi
  40075b:	0f 87 58 01 00 00    	ja     4008b9 <pop_arg+0x164>
  400761:	ff 24 f5 68 3d 40 00 	jmpq   *0x403d68(,%rsi,8)
  400768:	8b 0a                	mov    (%rdx),%ecx
  40076a:	83 f9 2f             	cmp    $0x2f,%ecx
  40076d:	77 0d                	ja     40077c <pop_arg+0x27>
  40076f:	89 c8                	mov    %ecx,%eax
  400771:	83 c1 08             	add    $0x8,%ecx
  400774:	48 03 42 10          	add    0x10(%rdx),%rax
  400778:	89 0a                	mov    %ecx,(%rdx)
  40077a:	eb 0c                	jmp    400788 <pop_arg+0x33>
  40077c:	48 8b 42 08          	mov    0x8(%rdx),%rax
  400780:	48 8d 48 08          	lea    0x8(%rax),%rcx
  400784:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  400788:	48 63 00             	movslq (%rax),%rax
  40078b:	e9 e3 00 00 00       	jmpq   400873 <pop_arg+0x11e>
  400790:	8b 0a                	mov    (%rdx),%ecx
  400792:	83 f9 2f             	cmp    $0x2f,%ecx
  400795:	77 0d                	ja     4007a4 <pop_arg+0x4f>
  400797:	89 c8                	mov    %ecx,%eax
  400799:	83 c1 08             	add    $0x8,%ecx
  40079c:	48 03 42 10          	add    0x10(%rdx),%rax
  4007a0:	89 0a                	mov    %ecx,(%rdx)
  4007a2:	eb 0c                	jmp    4007b0 <pop_arg+0x5b>
  4007a4:	48 8b 42 08          	mov    0x8(%rdx),%rax
  4007a8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  4007ac:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  4007b0:	8b 00                	mov    (%rax),%eax
  4007b2:	e9 bc 00 00 00       	jmpq   400873 <pop_arg+0x11e>
  4007b7:	8b 0a                	mov    (%rdx),%ecx
  4007b9:	83 f9 2f             	cmp    $0x2f,%ecx
  4007bc:	77 0d                	ja     4007cb <pop_arg+0x76>
  4007be:	89 c8                	mov    %ecx,%eax
  4007c0:	83 c1 08             	add    $0x8,%ecx
  4007c3:	48 03 42 10          	add    0x10(%rdx),%rax
  4007c7:	89 0a                	mov    %ecx,(%rdx)
  4007c9:	eb 0c                	jmp    4007d7 <pop_arg+0x82>
  4007cb:	48 8b 42 08          	mov    0x8(%rdx),%rax
  4007cf:	48 8d 48 08          	lea    0x8(%rax),%rcx
  4007d3:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  4007d7:	48 0f bf 00          	movswq (%rax),%rax
  4007db:	e9 93 00 00 00       	jmpq   400873 <pop_arg+0x11e>
  4007e0:	8b 0a                	mov    (%rdx),%ecx
  4007e2:	83 f9 2f             	cmp    $0x2f,%ecx
  4007e5:	77 0d                	ja     4007f4 <pop_arg+0x9f>
  4007e7:	89 c8                	mov    %ecx,%eax
  4007e9:	83 c1 08             	add    $0x8,%ecx
  4007ec:	48 03 42 10          	add    0x10(%rdx),%rax
  4007f0:	89 0a                	mov    %ecx,(%rdx)
  4007f2:	eb 0c                	jmp    400800 <pop_arg+0xab>
  4007f4:	48 8b 42 08          	mov    0x8(%rdx),%rax
  4007f8:	48 8d 48 08          	lea    0x8(%rax),%rcx
  4007fc:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  400800:	0f b7 00             	movzwl (%rax),%eax
  400803:	eb 6e                	jmp    400873 <pop_arg+0x11e>
  400805:	8b 0a                	mov    (%rdx),%ecx
  400807:	83 f9 2f             	cmp    $0x2f,%ecx
  40080a:	77 0d                	ja     400819 <pop_arg+0xc4>
  40080c:	89 c8                	mov    %ecx,%eax
  40080e:	83 c1 08             	add    $0x8,%ecx
  400811:	48 03 42 10          	add    0x10(%rdx),%rax
  400815:	89 0a                	mov    %ecx,(%rdx)
  400817:	eb 0c                	jmp    400825 <pop_arg+0xd0>
  400819:	48 8b 42 08          	mov    0x8(%rdx),%rax
  40081d:	48 8d 48 08          	lea    0x8(%rax),%rcx
  400821:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  400825:	48 0f be 00          	movsbq (%rax),%rax
  400829:	eb 48                	jmp    400873 <pop_arg+0x11e>
  40082b:	8b 0a                	mov    (%rdx),%ecx
  40082d:	83 f9 2f             	cmp    $0x2f,%ecx
  400830:	77 0d                	ja     40083f <pop_arg+0xea>
  400832:	89 c8                	mov    %ecx,%eax
  400834:	83 c1 08             	add    $0x8,%ecx
  400837:	48 03 42 10          	add    0x10(%rdx),%rax
  40083b:	89 0a                	mov    %ecx,(%rdx)
  40083d:	eb 0c                	jmp    40084b <pop_arg+0xf6>
  40083f:	48 8b 42 08          	mov    0x8(%rdx),%rax
  400843:	48 8d 48 08          	lea    0x8(%rax),%rcx
  400847:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  40084b:	0f b6 00             	movzbl (%rax),%eax
  40084e:	eb 23                	jmp    400873 <pop_arg+0x11e>
  400850:	8b 0a                	mov    (%rdx),%ecx
  400852:	83 f9 2f             	cmp    $0x2f,%ecx
  400855:	77 0d                	ja     400864 <pop_arg+0x10f>
  400857:	89 c8                	mov    %ecx,%eax
  400859:	83 c1 08             	add    $0x8,%ecx
  40085c:	48 03 42 10          	add    0x10(%rdx),%rax
  400860:	89 0a                	mov    %ecx,(%rdx)
  400862:	eb 0c                	jmp    400870 <pop_arg+0x11b>
  400864:	48 8b 42 08          	mov    0x8(%rdx),%rax
  400868:	48 8d 48 08          	lea    0x8(%rax),%rcx
  40086c:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  400870:	48 8b 00             	mov    (%rax),%rax
  400873:	48 89 07             	mov    %rax,(%rdi)
  400876:	c3                   	retq   
  400877:	8b 4a 04             	mov    0x4(%rdx),%ecx
  40087a:	81 f9 af 00 00 00    	cmp    $0xaf,%ecx
  400880:	77 0e                	ja     400890 <pop_arg+0x13b>
  400882:	89 c8                	mov    %ecx,%eax
  400884:	83 c1 10             	add    $0x10,%ecx
  400887:	48 03 42 10          	add    0x10(%rdx),%rax
  40088b:	89 4a 04             	mov    %ecx,0x4(%rdx)
  40088e:	eb 0c                	jmp    40089c <pop_arg+0x147>
  400890:	48 8b 42 08          	mov    0x8(%rdx),%rax
  400894:	48 8d 48 08          	lea    0x8(%rax),%rcx
  400898:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  40089c:	dd 00                	fldl   (%rax)
  40089e:	db 3f                	fstpt  (%rdi)
  4008a0:	c3                   	retq   
  4008a1:	48 8b 42 08          	mov    0x8(%rdx),%rax
  4008a5:	48 83 c0 0f          	add    $0xf,%rax
  4008a9:	48 83 e0 f0          	and    $0xfffffffffffffff0,%rax
  4008ad:	48 8d 48 10          	lea    0x10(%rax),%rcx
  4008b1:	48 89 4a 08          	mov    %rcx,0x8(%rdx)
  4008b5:	db 28                	fldt   (%rax)
  4008b7:	db 3f                	fstpt  (%rdi)
  4008b9:	c3                   	retq   

00000000004008ba <fmt_u>:
  4008ba:	48 89 f8             	mov    %rdi,%rax
  4008bd:	b9 0a 00 00 00       	mov    $0xa,%ecx
  4008c2:	48 85 c0             	test   %rax,%rax
  4008c5:	74 0f                	je     4008d6 <fmt_u+0x1c>
  4008c7:	31 d2                	xor    %edx,%edx
  4008c9:	48 ff ce             	dec    %rsi
  4008cc:	48 f7 f1             	div    %rcx
  4008cf:	83 c2 30             	add    $0x30,%edx
  4008d2:	88 16                	mov    %dl,(%rsi)
  4008d4:	eb ec                	jmp    4008c2 <fmt_u+0x8>
  4008d6:	48 89 f0             	mov    %rsi,%rax
  4008d9:	c3                   	retq   

00000000004008da <getint>:
  4008da:	31 c0                	xor    %eax,%eax
  4008dc:	41 83 c8 ff          	or     $0xffffffff,%r8d
  4008e0:	48 8b 0f             	mov    (%rdi),%rcx
  4008e3:	0f be 11             	movsbl (%rcx),%edx
  4008e6:	83 ea 30             	sub    $0x30,%edx
  4008e9:	83 fa 09             	cmp    $0x9,%edx
  4008ec:	77 26                	ja     400914 <getint+0x3a>
  4008ee:	3d cc cc cc 0c       	cmp    $0xccccccc,%eax
  4008f3:	77 14                	ja     400909 <getint+0x2f>
  4008f5:	6b f0 f6             	imul   $0xfffffff6,%eax,%esi
  4008f8:	81 c6 ff ff ff 7f    	add    $0x7fffffff,%esi
  4008fe:	39 f2                	cmp    %esi,%edx
  400900:	7f 07                	jg     400909 <getint+0x2f>
  400902:	6b c0 0a             	imul   $0xa,%eax,%eax
  400905:	01 d0                	add    %edx,%eax
  400907:	eb 03                	jmp    40090c <getint+0x32>
  400909:	44 89 c0             	mov    %r8d,%eax
  40090c:	48 ff c1             	inc    %rcx
  40090f:	48 89 0f             	mov    %rcx,(%rdi)
  400912:	eb cc                	jmp    4008e0 <getint+0x6>
  400914:	c3                   	retq   

0000000000400915 <out>:
  400915:	f6 07 20             	testb  $0x20,(%rdi)
  400918:	48 89 f0             	mov    %rsi,%rax
  40091b:	48 89 d6             	mov    %rdx,%rsi
  40091e:	75 0b                	jne    40092b <out+0x16>
  400920:	48 89 fa             	mov    %rdi,%rdx
  400923:	48 89 c7             	mov    %rax,%rdi
  400926:	e9 36 28 00 00       	jmpq   403161 <__fwritex>
  40092b:	c3                   	retq   

000000000040092c <pad>:
  40092c:	41 81 e0 00 20 01 00 	and    $0x12000,%r8d
  400933:	75 6e                	jne    4009a3 <pad+0x77>
  400935:	39 d1                	cmp    %edx,%ecx
  400937:	7d 6a                	jge    4009a3 <pad+0x77>
  400939:	41 54                	push   %r12
  40093b:	55                   	push   %rbp
  40093c:	40 0f be f6          	movsbl %sil,%esi
  400940:	53                   	push   %rbx
  400941:	89 d3                	mov    %edx,%ebx
  400943:	ba 00 01 00 00       	mov    $0x100,%edx
  400948:	29 cb                	sub    %ecx,%ebx
  40094a:	48 89 fd             	mov    %rdi,%rbp
  40094d:	48 81 ec 00 01 00 00 	sub    $0x100,%rsp
  400954:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
  40095a:	41 89 dc             	mov    %ebx,%r12d
  40095d:	48 0f 46 d3          	cmovbe %rbx,%rdx
  400961:	48 89 e7             	mov    %rsp,%rdi
  400964:	e8 94 16 00 00       	callq  401ffd <memset>
  400969:	81 fb ff 00 00 00    	cmp    $0xff,%ebx
  40096f:	76 18                	jbe    400989 <pad+0x5d>
  400971:	ba 00 01 00 00       	mov    $0x100,%edx
  400976:	48 89 e6             	mov    %rsp,%rsi
  400979:	48 89 ef             	mov    %rbp,%rdi
  40097c:	e8 94 ff ff ff       	callq  400915 <out>
  400981:	81 eb 00 01 00 00    	sub    $0x100,%ebx
  400987:	eb e0                	jmp    400969 <pad+0x3d>
  400989:	41 0f b6 d4          	movzbl %r12b,%edx
  40098d:	48 89 e6             	mov    %rsp,%rsi
  400990:	48 89 ef             	mov    %rbp,%rdi
  400993:	e8 7d ff ff ff       	callq  400915 <out>
  400998:	48 81 c4 00 01 00 00 	add    $0x100,%rsp
  40099f:	5b                   	pop    %rbx
  4009a0:	5d                   	pop    %rbp
  4009a1:	41 5c                	pop    %r12
  4009a3:	c3                   	retq   

00000000004009a4 <fmt_fp>:
  4009a4:	41 57                	push   %r15
  4009a6:	41 56                	push   %r14
  4009a8:	45 89 c6             	mov    %r8d,%r14d
  4009ab:	41 55                	push   %r13
  4009ad:	41 54                	push   %r12
  4009af:	55                   	push   %rbp
  4009b0:	53                   	push   %rbx
  4009b1:	48 89 fd             	mov    %rdi,%rbp
  4009b4:	89 d3                	mov    %edx,%ebx
  4009b6:	48 81 ec 58 1d 00 00 	sub    $0x1d58,%rsp
  4009bd:	db ac 24 90 1d 00 00 	fldt   0x1d90(%rsp)
  4009c4:	89 74 24 58          	mov    %esi,0x58(%rsp)
  4009c8:	89 4c 24 1c          	mov    %ecx,0x1c(%rsp)
  4009cc:	c7 44 24 78 00 00 00 	movl   $0x0,0x78(%rsp)
  4009d3:	00 
  4009d4:	d9 c0                	fld    %st(0)
  4009d6:	db 3c 24             	fstpt  (%rsp)
  4009d9:	db 7c 24 20          	fstpt  0x20(%rsp)
  4009dd:	e8 dc 22 00 00       	callq  402cbe <__signbitl>
  4009e2:	85 c0                	test   %eax,%eax
  4009e4:	5f                   	pop    %rdi
  4009e5:	41 58                	pop    %r8
  4009e7:	db 6c 24 10          	fldt   0x10(%rsp)
  4009eb:	74 13                	je     400a00 <fmt_fp+0x5c>
  4009ed:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  4009f3:	48 c7 44 24 40 f8 3d 	movq   $0x403df8,0x40(%rsp)
  4009fa:	40 00 
  4009fc:	d9 e0                	fchs   
  4009fe:	eb 38                	jmp    400a38 <fmt_fp+0x94>
  400a00:	8b 44 24 0c          	mov    0xc(%rsp),%eax
  400a04:	0f ba e0 0b          	bt     $0xb,%eax
  400a08:	72 1f                	jb     400a29 <fmt_fp+0x85>
  400a0a:	45 31 e4             	xor    %r12d,%r12d
  400a0d:	ba f9 3d 40 00       	mov    $0x403df9,%edx
  400a12:	83 e0 01             	and    $0x1,%eax
  400a15:	b8 fe 3d 40 00       	mov    $0x403dfe,%eax
  400a1a:	41 0f 95 c4          	setne  %r12b
  400a1e:	48 0f 44 c2          	cmove  %rdx,%rax
  400a22:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  400a27:	eb 0f                	jmp    400a38 <fmt_fp+0x94>
  400a29:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  400a2f:	48 c7 44 24 40 fb 3d 	movq   $0x403dfb,0x40(%rsp)
  400a36:	40 00 
  400a38:	48 83 ec 10          	sub    $0x10,%rsp
  400a3c:	d9 c0                	fld    %st(0)
  400a3e:	db 3c 24             	fstpt  (%rsp)
  400a41:	db 7c 24 20          	fstpt  0x20(%rsp)
  400a45:	e8 26 22 00 00       	callq  402c70 <__fpclassifyl>
  400a4a:	ff c8                	dec    %eax
  400a4c:	59                   	pop    %rcx
  400a4d:	5e                   	pop    %rsi
  400a4e:	db 6c 24 10          	fldt   0x10(%rsp)
  400a52:	0f 8f 9e 00 00 00    	jg     400af6 <fmt_fp+0x152>
  400a58:	41 83 e6 20          	and    $0x20,%r14d
  400a5c:	b8 0b 3e 40 00       	mov    $0x403e0b,%eax
  400a61:	bb 0f 3e 40 00       	mov    $0x403e0f,%ebx
  400a66:	48 0f 45 d8          	cmovne %rax,%rbx
  400a6a:	df e8                	fucomip %st(0),%st
  400a6c:	7b 11                	jnp    400a7f <fmt_fp+0xdb>
  400a6e:	45 85 f6             	test   %r14d,%r14d
  400a71:	b8 17 3e 40 00       	mov    $0x403e17,%eax
  400a76:	bb 13 3e 40 00       	mov    $0x403e13,%ebx
  400a7b:	48 0f 45 d8          	cmovne %rax,%rbx
  400a7f:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  400a84:	45 8d 74 24 03       	lea    0x3(%r12),%r14d
  400a89:	8b 54 24 48          	mov    0x48(%rsp),%edx
  400a8d:	be 20 00 00 00       	mov    $0x20,%esi
  400a92:	48 89 ef             	mov    %rbp,%rdi
  400a95:	44 89 f1             	mov    %r14d,%ecx
  400a98:	41 81 e0 ff ff fe ff 	and    $0xfffeffff,%r8d
  400a9f:	e8 88 fe ff ff       	callq  40092c <pad>
  400aa4:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  400aa9:	49 63 d4             	movslq %r12d,%rdx
  400aac:	48 89 ef             	mov    %rbp,%rdi
  400aaf:	e8 61 fe ff ff       	callq  400915 <out>
  400ab4:	ba 03 00 00 00       	mov    $0x3,%edx
  400ab9:	48 89 de             	mov    %rbx,%rsi
  400abc:	48 89 ef             	mov    %rbp,%rdi
  400abf:	e8 51 fe ff ff       	callq  400915 <out>
  400ac4:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  400ac9:	8b 54 24 48          	mov    0x48(%rsp),%edx
  400acd:	44 89 f1             	mov    %r14d,%ecx
  400ad0:	be 20 00 00 00       	mov    $0x20,%esi
  400ad5:	48 89 ef             	mov    %rbp,%rdi
  400ad8:	41 81 f0 00 20 00 00 	xor    $0x2000,%r8d
  400adf:	e8 48 fe ff ff       	callq  40092c <pad>
  400ae4:	44 3b 74 24 48       	cmp    0x48(%rsp),%r14d
  400ae9:	8b 44 24 48          	mov    0x48(%rsp),%eax
  400aed:	41 0f 4d c6          	cmovge %r14d,%eax
  400af1:	e9 0e 0a 00 00       	jmpq   401504 <fmt_fp+0xb60>
  400af6:	48 83 ec 10          	sub    $0x10,%rsp
  400afa:	db 3c 24             	fstpt  (%rsp)
  400afd:	48 8d 7c 24 78       	lea    0x78(%rsp),%rdi
  400b02:	e8 cb 21 00 00       	callq  402cd2 <frexpl>
  400b07:	d8 c0                	fadd   %st(0),%st
  400b09:	58                   	pop    %rax
  400b0a:	5a                   	pop    %rdx
  400b0b:	d9 ee                	fldz   
  400b0d:	d9 c9                	fxch   %st(1)
  400b0f:	db e9                	fucomi %st(1),%st
  400b11:	7a 02                	jp     400b15 <fmt_fp+0x171>
  400b13:	74 04                	je     400b19 <fmt_fp+0x175>
  400b15:	ff 4c 24 68          	decl   0x68(%rsp)
  400b19:	45 89 f1             	mov    %r14d,%r9d
  400b1c:	41 83 c9 20          	or     $0x20,%r9d
  400b20:	41 83 f9 61          	cmp    $0x61,%r9d
  400b24:	0f 85 5f 02 00 00    	jne    400d89 <fmt_fp+0x3e5>
  400b2a:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  400b2f:	d9 05 eb 36 00 00    	flds   0x36eb(%rip)        # 404220 <states+0x1e0>
  400b35:	48 83 c0 09          	add    $0x9,%rax
  400b39:	41 f6 c6 20          	test   $0x20,%r14b
  400b3d:	48 0f 44 44 24 40    	cmove  0x40(%rsp),%rax
  400b43:	41 83 c4 02          	add    $0x2,%r12d
  400b47:	83 fb 0e             	cmp    $0xe,%ebx
  400b4a:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  400b4f:	77 36                	ja     400b87 <fmt_fp+0x1e3>
  400b51:	b8 0f 00 00 00       	mov    $0xf,%eax
  400b56:	d9 05 b4 36 00 00    	flds   0x36b4(%rip)        # 404210 <states+0x1d0>
  400b5c:	29 d8                	sub    %ebx,%eax
  400b5e:	ff c8                	dec    %eax
  400b60:	83 f8 ff             	cmp    $0xffffffff,%eax
  400b63:	74 04                	je     400b69 <fmt_fp+0x1c5>
  400b65:	d8 c9                	fmul   %st(1),%st
  400b67:	eb f5                	jmp    400b5e <fmt_fp+0x1ba>
  400b69:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  400b6e:	80 38 2d             	cmpb   $0x2d,(%rax)
  400b71:	75 10                	jne    400b83 <fmt_fp+0x1df>
  400b73:	d9 ca                	fxch   %st(2)
  400b75:	d9 e0                	fchs   
  400b77:	d8 e2                	fsub   %st(2),%st
  400b79:	de c2                	faddp  %st,%st(2)
  400b7b:	d9 c9                	fxch   %st(1)
  400b7d:	d9 e0                	fchs   
  400b7f:	d9 c9                	fxch   %st(1)
  400b81:	eb 04                	jmp    400b87 <fmt_fp+0x1e3>
  400b83:	dc c2                	fadd   %st,%st(2)
  400b85:	de ea                	fsubrp %st,%st(2)
  400b87:	db 7c 24 30          	fstpt  0x30(%rsp)
  400b8b:	d9 c9                	fxch   %st(1)
  400b8d:	8b 44 24 68          	mov    0x68(%rsp),%eax
  400b91:	8b 7c 24 68          	mov    0x68(%rsp),%edi
  400b95:	4c 8d 44 24 7b       	lea    0x7b(%rsp),%r8
  400b9a:	4c 89 c6             	mov    %r8,%rsi
  400b9d:	c1 f8 1f             	sar    $0x1f,%eax
  400ba0:	31 c7                	xor    %eax,%edi
  400ba2:	29 c7                	sub    %eax,%edi
  400ba4:	48 63 ff             	movslq %edi,%rdi
  400ba7:	db 7c 24 20          	fstpt  0x20(%rsp)
  400bab:	db 7c 24 10          	fstpt  0x10(%rsp)
  400baf:	e8 06 fd ff ff       	callq  4008ba <fmt_u>
  400bb4:	4c 39 c0             	cmp    %r8,%rax
  400bb7:	db 6c 24 10          	fldt   0x10(%rsp)
  400bbb:	db 6c 24 20          	fldt   0x20(%rsp)
  400bbf:	db 6c 24 30          	fldt   0x30(%rsp)
  400bc3:	75 0a                	jne    400bcf <fmt_fp+0x22b>
  400bc5:	48 8d 44 24 7a       	lea    0x7a(%rsp),%rax
  400bca:	c6 44 24 7a 30       	movb   $0x30,0x7a(%rsp)
  400bcf:	d9 ca                	fxch   %st(2)
  400bd1:	8b 54 24 68          	mov    0x68(%rsp),%edx
  400bd5:	8b 74 24 0c          	mov    0xc(%rsp),%esi
  400bd9:	4c 8d 68 fe          	lea    -0x2(%rax),%r13
  400bdd:	45 88 f0             	mov    %r14b,%r8b
  400be0:	b1 01                	mov    $0x1,%cl
  400be2:	41 83 e0 20          	and    $0x20,%r8d
  400be6:	c1 fa 1f             	sar    $0x1f,%edx
  400be9:	83 e6 08             	and    $0x8,%esi
  400bec:	83 e2 02             	and    $0x2,%edx
  400bef:	83 c2 2b             	add    $0x2b,%edx
  400bf2:	88 50 ff             	mov    %dl,-0x1(%rax)
  400bf5:	41 8d 56 0f          	lea    0xf(%r14),%edx
  400bf9:	88 50 fe             	mov    %dl,-0x2(%rax)
  400bfc:	d9 7c 24 5e          	fnstcw 0x5e(%rsp)
  400c00:	66 8b 54 24 5e       	mov    0x5e(%rsp),%dx
  400c05:	48 8d 44 24 7b       	lea    0x7b(%rsp),%rax
  400c0a:	80 ce 0c             	or     $0xc,%dh
  400c0d:	49 89 c2             	mov    %rax,%r10
  400c10:	66 89 54 24 5c       	mov    %dx,0x5c(%rsp)
  400c15:	d9 c0                	fld    %st(0)
  400c17:	d9 6c 24 5c          	fldcw  0x5c(%rsp)
  400c1b:	db 5c 24 10          	fistpl 0x10(%rsp)
  400c1f:	d9 6c 24 5e          	fldcw  0x5e(%rsp)
  400c23:	44 88 c7             	mov    %r8b,%dil
  400c26:	4c 8d 58 01          	lea    0x1(%rax),%r11
  400c2a:	48 63 54 24 10       	movslq 0x10(%rsp),%rdx
  400c2f:	da 64 24 10          	fisubl 0x10(%rsp)
  400c33:	40 0a ba 30 40 40 00 	or     0x404030(%rdx),%dil
  400c3a:	4c 39 d0             	cmp    %r10,%rax
  400c3d:	40 88 38             	mov    %dil,(%rax)
  400c40:	d8 ca                	fmul   %st(2),%st
  400c42:	75 1c                	jne    400c60 <fmt_fp+0x2bc>
  400c44:	db e9                	fucomi %st(1),%st
  400c46:	0f 9a c2             	setp   %dl
  400c49:	0f 45 d1             	cmovne %ecx,%edx
  400c4c:	84 d2                	test   %dl,%dl
  400c4e:	75 08                	jne    400c58 <fmt_fp+0x2b4>
  400c50:	85 db                	test   %ebx,%ebx
  400c52:	7f 04                	jg     400c58 <fmt_fp+0x2b4>
  400c54:	85 f6                	test   %esi,%esi
  400c56:	74 08                	je     400c60 <fmt_fp+0x2bc>
  400c58:	4c 8d 58 02          	lea    0x2(%rax),%r11
  400c5c:	c6 40 01 2e          	movb   $0x2e,0x1(%rax)
  400c60:	db e9                	fucomi %st(1),%st
  400c62:	7b 05                	jnp    400c69 <fmt_fp+0x2c5>
  400c64:	4c 89 d8             	mov    %r11,%rax
  400c67:	eb ac                	jmp    400c15 <fmt_fp+0x271>
  400c69:	75 f9                	jne    400c64 <fmt_fp+0x2c0>
  400c6b:	dd d8                	fstp   %st(0)
  400c6d:	dd d8                	fstp   %st(0)
  400c6f:	dd d8                	fstp   %st(0)
  400c71:	4c 8d 7c 24 7b       	lea    0x7b(%rsp),%r15
  400c76:	b8 fd ff ff 7f       	mov    $0x7ffffffd,%eax
  400c7b:	49 63 cc             	movslq %r12d,%rcx
  400c7e:	48 63 d3             	movslq %ebx,%rdx
  400c81:	4d 29 ef             	sub    %r13,%r15
  400c84:	4c 29 f8             	sub    %r15,%rax
  400c87:	48 29 c8             	sub    %rcx,%rax
  400c8a:	48 39 c2             	cmp    %rax,%rdx
  400c8d:	7e 08                	jle    400c97 <fmt_fp+0x2f3>
  400c8f:	83 c8 ff             	or     $0xffffffff,%eax
  400c92:	e9 6d 08 00 00       	jmpq   401504 <fmt_fp+0xb60>
  400c97:	85 db                	test   %ebx,%ebx
  400c99:	74 13                	je     400cae <fmt_fp+0x30a>
  400c9b:	4c 89 d8             	mov    %r11,%rax
  400c9e:	42 8d 5c 3b 02       	lea    0x2(%rbx,%r15,1),%ebx
  400ca3:	4c 29 d0             	sub    %r10,%rax
  400ca6:	48 ff c8             	dec    %rax
  400ca9:	48 39 c2             	cmp    %rax,%rdx
  400cac:	7d 0a                	jge    400cb8 <fmt_fp+0x314>
  400cae:	4c 89 d8             	mov    %r11,%rax
  400cb1:	4c 29 d0             	sub    %r10,%rax
  400cb4:	42 8d 1c 38          	lea    (%rax,%r15,1),%ebx
  400cb8:	46 8d 34 23          	lea    (%rbx,%r12,1),%r14d
  400cbc:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  400cc1:	8b 54 24 48          	mov    0x48(%rsp),%edx
  400cc5:	be 20 00 00 00       	mov    $0x20,%esi
  400cca:	48 89 ef             	mov    %rbp,%rdi
  400ccd:	4c 89 54 24 20       	mov    %r10,0x20(%rsp)
  400cd2:	44 89 f1             	mov    %r14d,%ecx
  400cd5:	4c 89 5c 24 10       	mov    %r11,0x10(%rsp)
  400cda:	44 29 fb             	sub    %r15d,%ebx
  400cdd:	e8 4a fc ff ff       	callq  40092c <pad>
  400ce2:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  400ce7:	49 63 d4             	movslq %r12d,%rdx
  400cea:	48 89 ef             	mov    %rbp,%rdi
  400ced:	e8 23 fc ff ff       	callq  400915 <out>
  400cf2:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  400cf7:	8b 54 24 48          	mov    0x48(%rsp),%edx
  400cfb:	44 89 f1             	mov    %r14d,%ecx
  400cfe:	be 30 00 00 00       	mov    $0x30,%esi
  400d03:	48 89 ef             	mov    %rbp,%rdi
  400d06:	41 81 f0 00 00 01 00 	xor    $0x10000,%r8d
  400d0d:	e8 1a fc ff ff       	callq  40092c <pad>
  400d12:	4c 8b 54 24 20       	mov    0x20(%rsp),%r10
  400d17:	4c 8b 5c 24 10       	mov    0x10(%rsp),%r11
  400d1c:	48 8d 74 24 7b       	lea    0x7b(%rsp),%rsi
  400d21:	48 89 ef             	mov    %rbp,%rdi
  400d24:	4d 29 d3             	sub    %r10,%r11
  400d27:	4c 89 da             	mov    %r11,%rdx
  400d2a:	4d 89 dc             	mov    %r11,%r12
  400d2d:	e8 e3 fb ff ff       	callq  400915 <out>
  400d32:	89 da                	mov    %ebx,%edx
  400d34:	45 31 c0             	xor    %r8d,%r8d
  400d37:	31 c9                	xor    %ecx,%ecx
  400d39:	44 29 e2             	sub    %r12d,%edx
  400d3c:	be 30 00 00 00       	mov    $0x30,%esi
  400d41:	48 89 ef             	mov    %rbp,%rdi
  400d44:	e8 e3 fb ff ff       	callq  40092c <pad>
  400d49:	4c 89 fa             	mov    %r15,%rdx
  400d4c:	4c 89 ee             	mov    %r13,%rsi
  400d4f:	48 89 ef             	mov    %rbp,%rdi
  400d52:	e8 be fb ff ff       	callq  400915 <out>
  400d57:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  400d5c:	8b 54 24 48          	mov    0x48(%rsp),%edx
  400d60:	44 89 f1             	mov    %r14d,%ecx
  400d63:	be 20 00 00 00       	mov    $0x20,%esi
  400d68:	48 89 ef             	mov    %rbp,%rdi
  400d6b:	41 81 f0 00 20 00 00 	xor    $0x2000,%r8d
  400d72:	e8 b5 fb ff ff       	callq  40092c <pad>
  400d77:	44 39 74 24 48       	cmp    %r14d,0x48(%rsp)
  400d7c:	8b 44 24 48          	mov    0x48(%rsp),%eax
  400d80:	41 0f 4c c6          	cmovl  %r14d,%eax
  400d84:	e9 7b 07 00 00       	jmpq   401504 <fmt_fp+0xb60>
  400d89:	85 db                	test   %ebx,%ebx
  400d8b:	b8 06 00 00 00       	mov    $0x6,%eax
  400d90:	0f 48 d8             	cmovs  %eax,%ebx
  400d93:	db e9                	fucomi %st(1),%st
  400d95:	7a 02                	jp     400d99 <fmt_fp+0x3f5>
  400d97:	74 0b                	je     400da4 <fmt_fp+0x400>
  400d99:	d8 0d 85 34 00 00    	fmuls  0x3485(%rip)        # 404224 <states+0x1e4>
  400d9f:	83 6c 24 68 1c       	subl   $0x1c,0x68(%rsp)
  400da4:	8b 74 24 68          	mov    0x68(%rsp),%esi
  400da8:	48 8d 84 24 94 00 00 	lea    0x94(%rsp),%rax
  400daf:	00 
  400db0:	48 8d 94 24 3c 1c 00 	lea    0x1c3c(%rsp),%rdx
  400db7:	00 
  400db8:	d9 7c 24 5e          	fnstcw 0x5e(%rsp)
  400dbc:	d9 05 66 34 00 00    	flds   0x3466(%rip)        # 404228 <states+0x1e8>
  400dc2:	d9 c9                	fxch   %st(1)
  400dc4:	85 f6                	test   %esi,%esi
  400dc6:	48 0f 49 c2          	cmovns %rdx,%rax
  400dca:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  400dcf:	49 89 c5             	mov    %rax,%r13
  400dd2:	66 8b 44 24 5e       	mov    0x5e(%rsp),%ax
  400dd7:	80 cc 0c             	or     $0xc,%ah
  400dda:	66 89 44 24 5c       	mov    %ax,0x5c(%rsp)
  400ddf:	d9 c0                	fld    %st(0)
  400de1:	d9 6c 24 5c          	fldcw  0x5c(%rsp)
  400de5:	df 7c 24 50          	fistpll 0x50(%rsp)
  400de9:	d9 6c 24 5e          	fldcw  0x5e(%rsp)
  400ded:	49 83 c5 04          	add    $0x4,%r13
  400df1:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  400df6:	41 89 45 fc          	mov    %eax,-0x4(%r13)
  400dfa:	89 c0                	mov    %eax,%eax
  400dfc:	48 89 44 24 20       	mov    %rax,0x20(%rsp)
  400e01:	df 6c 24 20          	fildll 0x20(%rsp)
  400e05:	de e9                	fsubrp %st,%st(1)
  400e07:	d8 c9                	fmul   %st(1),%st
  400e09:	db ea                	fucomi %st(2),%st
  400e0b:	7a d2                	jp     400ddf <fmt_fp+0x43b>
  400e0d:	75 d0                	jne    400ddf <fmt_fp+0x43b>
  400e0f:	dd d8                	fstp   %st(0)
  400e11:	dd d8                	fstp   %st(0)
  400e13:	dd d8                	fstp   %st(0)
  400e15:	4c 8b 7c 24 10       	mov    0x10(%rsp),%r15
  400e1a:	31 c0                	xor    %eax,%eax
  400e1c:	41 b8 1d 00 00 00    	mov    $0x1d,%r8d
  400e22:	41 bb 00 ca 9a 3b    	mov    $0x3b9aca00,%r11d
  400e28:	85 f6                	test   %esi,%esi
  400e2a:	7e 50                	jle    400e7c <fmt_fp+0x4d8>
  400e2c:	83 fe 1d             	cmp    $0x1d,%esi
  400e2f:	44 89 c1             	mov    %r8d,%ecx
  400e32:	49 8d 7d fc          	lea    -0x4(%r13),%rdi
  400e36:	0f 4e ce             	cmovle %esi,%ecx
  400e39:	31 c0                	xor    %eax,%eax
  400e3b:	49 39 ff             	cmp    %rdi,%r15
  400e3e:	77 18                	ja     400e58 <fmt_fp+0x4b4>
  400e40:	8b 17                	mov    (%rdi),%edx
  400e42:	89 c0                	mov    %eax,%eax
  400e44:	48 83 ef 04          	sub    $0x4,%rdi
  400e48:	48 d3 e2             	shl    %cl,%rdx
  400e4b:	48 01 d0             	add    %rdx,%rax
  400e4e:	31 d2                	xor    %edx,%edx
  400e50:	49 f7 f3             	div    %r11
  400e53:	89 57 04             	mov    %edx,0x4(%rdi)
  400e56:	eb e3                	jmp    400e3b <fmt_fp+0x497>
  400e58:	85 c0                	test   %eax,%eax
  400e5a:	74 15                	je     400e71 <fmt_fp+0x4cd>
  400e5c:	41 89 47 fc          	mov    %eax,-0x4(%r15)
  400e60:	49 83 ef 04          	sub    $0x4,%r15
  400e64:	eb 0b                	jmp    400e71 <fmt_fp+0x4cd>
  400e66:	41 83 7d fc 00       	cmpl   $0x0,-0x4(%r13)
  400e6b:	75 09                	jne    400e76 <fmt_fp+0x4d2>
  400e6d:	49 83 ed 04          	sub    $0x4,%r13
  400e71:	4d 39 fd             	cmp    %r15,%r13
  400e74:	77 f0                	ja     400e66 <fmt_fp+0x4c2>
  400e76:	29 ce                	sub    %ecx,%esi
  400e78:	b0 01                	mov    $0x1,%al
  400e7a:	eb ac                	jmp    400e28 <fmt_fp+0x484>
  400e7c:	84 c0                	test   %al,%al
  400e7e:	74 04                	je     400e84 <fmt_fp+0x4e0>
  400e80:	89 74 24 68          	mov    %esi,0x68(%rsp)
  400e84:	8d 43 1d             	lea    0x1d(%rbx),%eax
  400e87:	b9 09 00 00 00       	mov    $0x9,%ecx
  400e8c:	31 d2                	xor    %edx,%edx
  400e8e:	f7 f1                	div    %ecx
  400e90:	31 d2                	xor    %edx,%edx
  400e92:	44 8d 50 01          	lea    0x1(%rax),%r10d
  400e96:	8b 44 24 68          	mov    0x68(%rsp),%eax
  400e9a:	4e 8d 1c 95 00 00 00 	lea    0x0(,%r10,4),%r11
  400ea1:	00 
  400ea2:	85 c0                	test   %eax,%eax
  400ea4:	0f 89 96 00 00 00    	jns    400f40 <fmt_fp+0x59c>
  400eaa:	89 c1                	mov    %eax,%ecx
  400eac:	be 09 00 00 00       	mov    $0x9,%esi
  400eb1:	41 b8 01 00 00 00    	mov    $0x1,%r8d
  400eb7:	f7 d9                	neg    %ecx
  400eb9:	83 f8 f7             	cmp    $0xfffffff7,%eax
  400ebc:	4c 89 fa             	mov    %r15,%rdx
  400ebf:	0f 4c ce             	cmovl  %esi,%ecx
  400ec2:	41 d3 e0             	shl    %cl,%r8d
  400ec5:	41 8d 70 ff          	lea    -0x1(%r8),%esi
  400ec9:	89 74 24 4c          	mov    %esi,0x4c(%rsp)
  400ecd:	be 00 ca 9a 3b       	mov    $0x3b9aca00,%esi
  400ed2:	d3 fe                	sar    %cl,%esi
  400ed4:	89 74 24 20          	mov    %esi,0x20(%rsp)
  400ed8:	31 f6                	xor    %esi,%esi
  400eda:	4c 39 ea             	cmp    %r13,%rdx
  400edd:	73 1f                	jae    400efe <fmt_fp+0x55a>
  400edf:	8b 3a                	mov    (%rdx),%edi
  400ee1:	48 83 c2 04          	add    $0x4,%rdx
  400ee5:	41 89 f8             	mov    %edi,%r8d
  400ee8:	41 d3 e8             	shr    %cl,%r8d
  400eeb:	44 01 c6             	add    %r8d,%esi
  400eee:	89 72 fc             	mov    %esi,-0x4(%rdx)
  400ef1:	8b 74 24 4c          	mov    0x4c(%rsp),%esi
  400ef5:	21 fe                	and    %edi,%esi
  400ef7:	0f af 74 24 20       	imul   0x20(%rsp),%esi
  400efc:	eb dc                	jmp    400eda <fmt_fp+0x536>
  400efe:	41 83 3f 00          	cmpl   $0x0,(%r15)
  400f02:	49 8d 57 04          	lea    0x4(%r15),%rdx
  400f06:	4c 0f 44 fa          	cmove  %rdx,%r15
  400f0a:	85 f6                	test   %esi,%esi
  400f0c:	74 08                	je     400f16 <fmt_fp+0x572>
  400f0e:	41 89 75 00          	mov    %esi,0x0(%r13)
  400f12:	49 83 c5 04          	add    $0x4,%r13
  400f16:	48 8b 54 24 10       	mov    0x10(%rsp),%rdx
  400f1b:	41 83 f9 66          	cmp    $0x66,%r9d
  400f1f:	4c 89 ee             	mov    %r13,%rsi
  400f22:	49 0f 45 d7          	cmovne %r15,%rdx
  400f26:	48 29 d6             	sub    %rdx,%rsi
  400f29:	4c 01 da             	add    %r11,%rdx
  400f2c:	48 c1 fe 02          	sar    $0x2,%rsi
  400f30:	4c 39 d6             	cmp    %r10,%rsi
  400f33:	4c 0f 4f ea          	cmovg  %rdx,%r13
  400f37:	01 c8                	add    %ecx,%eax
  400f39:	b2 01                	mov    $0x1,%dl
  400f3b:	e9 62 ff ff ff       	jmpq   400ea2 <fmt_fp+0x4fe>
  400f40:	84 d2                	test   %dl,%dl
  400f42:	74 04                	je     400f48 <fmt_fp+0x5a4>
  400f44:	89 44 24 68          	mov    %eax,0x68(%rsp)
  400f48:	45 31 c0             	xor    %r8d,%r8d
  400f4b:	4d 39 ef             	cmp    %r13,%r15
  400f4e:	73 24                	jae    400f74 <fmt_fp+0x5d0>
  400f50:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
  400f55:	41 8b 17             	mov    (%r15),%edx
  400f58:	b8 0a 00 00 00       	mov    $0xa,%eax
  400f5d:	4d 29 f8             	sub    %r15,%r8
  400f60:	49 c1 f8 02          	sar    $0x2,%r8
  400f64:	47 8d 04 c0          	lea    (%r8,%r8,8),%r8d
  400f68:	39 c2                	cmp    %eax,%edx
  400f6a:	72 08                	jb     400f74 <fmt_fp+0x5d0>
  400f6c:	6b c0 0a             	imul   $0xa,%eax,%eax
  400f6f:	41 ff c0             	inc    %r8d
  400f72:	eb f4                	jmp    400f68 <fmt_fp+0x5c4>
  400f74:	31 c0                	xor    %eax,%eax
  400f76:	41 83 f9 66          	cmp    $0x66,%r9d
  400f7a:	89 df                	mov    %ebx,%edi
  400f7c:	0f 95 c0             	setne  %al
  400f7f:	41 0f af c0          	imul   %r8d,%eax
  400f83:	29 c7                	sub    %eax,%edi
  400f85:	41 83 f9 67          	cmp    $0x67,%r9d
  400f89:	0f 94 c2             	sete   %dl
  400f8c:	31 c9                	xor    %ecx,%ecx
  400f8e:	85 db                	test   %ebx,%ebx
  400f90:	0f 95 c1             	setne  %cl
  400f93:	89 f8                	mov    %edi,%eax
  400f95:	21 d1                	and    %edx,%ecx
  400f97:	4c 89 ea             	mov    %r13,%rdx
  400f9a:	48 2b 54 24 10       	sub    0x10(%rsp),%rdx
  400f9f:	29 c8                	sub    %ecx,%eax
  400fa1:	48 63 c8             	movslq %eax,%rcx
  400fa4:	48 c1 fa 02          	sar    $0x2,%rdx
  400fa8:	48 ff ca             	dec    %rdx
  400fab:	48 8d 14 d2          	lea    (%rdx,%rdx,8),%rdx
  400faf:	48 39 d1             	cmp    %rdx,%rcx
  400fb2:	0f 8d 31 01 00 00    	jge    4010e9 <fmt_fp+0x745>
  400fb8:	05 00 40 02 00       	add    $0x24000,%eax
  400fbd:	b9 09 00 00 00       	mov    $0x9,%ecx
  400fc2:	be 0a 00 00 00       	mov    $0xa,%esi
  400fc7:	99                   	cltd   
  400fc8:	f7 f9                	idiv   %ecx
  400fca:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  400fcf:	48 98                	cltq   
  400fd1:	48 8d 8c 81 04 00 ff 	lea    -0xfffc(%rcx,%rax,4),%rcx
  400fd8:	ff 
  400fd9:	8d 42 01             	lea    0x1(%rdx),%eax
  400fdc:	83 f8 09             	cmp    $0x9,%eax
  400fdf:	74 07                	je     400fe8 <fmt_fp+0x644>
  400fe1:	6b f6 0a             	imul   $0xa,%esi,%esi
  400fe4:	ff c0                	inc    %eax
  400fe6:	eb f4                	jmp    400fdc <fmt_fp+0x638>
  400fe8:	8b 39                	mov    (%rcx),%edi
  400fea:	31 d2                	xor    %edx,%edx
  400fec:	89 f8                	mov    %edi,%eax
  400fee:	f7 f6                	div    %esi
  400ff0:	85 d2                	test   %edx,%edx
  400ff2:	41 89 d3             	mov    %edx,%r11d
  400ff5:	75 0d                	jne    401004 <fmt_fp+0x660>
  400ff7:	48 8d 41 04          	lea    0x4(%rcx),%rax
  400ffb:	49 39 c5             	cmp    %rax,%r13
  400ffe:	0f 84 cd 00 00 00    	je     4010d1 <fmt_fp+0x72d>
  401004:	31 d2                	xor    %edx,%edx
  401006:	89 f8                	mov    %edi,%eax
  401008:	f7 f6                	div    %esi
  40100a:	a8 01                	test   $0x1,%al
  40100c:	75 13                	jne    401021 <fmt_fp+0x67d>
  40100e:	81 fe 00 ca 9a 3b    	cmp    $0x3b9aca00,%esi
  401014:	75 13                	jne    401029 <fmt_fp+0x685>
  401016:	49 39 cf             	cmp    %rcx,%r15
  401019:	73 0e                	jae    401029 <fmt_fp+0x685>
  40101b:	f6 41 fc 01          	testb  $0x1,-0x4(%rcx)
  40101f:	74 08                	je     401029 <fmt_fp+0x685>
  401021:	db 2d 09 32 00 00    	fldt   0x3209(%rip)        # 404230 <states+0x1f0>
  401027:	eb 06                	jmp    40102f <fmt_fp+0x68b>
  401029:	d9 05 e5 31 00 00    	flds   0x31e5(%rip)        # 404214 <states+0x1d4>
  40102f:	89 f0                	mov    %esi,%eax
  401031:	d1 f8                	sar    %eax
  401033:	41 39 c3             	cmp    %eax,%r11d
  401036:	72 0f                	jb     401047 <fmt_fp+0x6a3>
  401038:	75 17                	jne    401051 <fmt_fp+0x6ad>
  40103a:	48 8d 41 04          	lea    0x4(%rcx),%rax
  40103e:	d9 e8                	fld1   
  401040:	49 39 c5             	cmp    %rax,%r13
  401043:	75 0a                	jne    40104f <fmt_fp+0x6ab>
  401045:	eb 10                	jmp    401057 <fmt_fp+0x6b3>
  401047:	d9 05 cb 31 00 00    	flds   0x31cb(%rip)        # 404218 <states+0x1d8>
  40104d:	eb 08                	jmp    401057 <fmt_fp+0x6b3>
  40104f:	dd d8                	fstp   %st(0)
  401051:	d9 05 c5 31 00 00    	flds   0x31c5(%rip)        # 40421c <states+0x1dc>
  401057:	45 85 e4             	test   %r12d,%r12d
  40105a:	74 12                	je     40106e <fmt_fp+0x6ca>
  40105c:	48 8b 44 24 40       	mov    0x40(%rsp),%rax
  401061:	80 38 2d             	cmpb   $0x2d,(%rax)
  401064:	75 08                	jne    40106e <fmt_fp+0x6ca>
  401066:	d9 c9                	fxch   %st(1)
  401068:	d9 e0                	fchs   
  40106a:	d9 c9                	fxch   %st(1)
  40106c:	d9 e0                	fchs   
  40106e:	d8 c1                	fadd   %st(1),%st
  401070:	d9 c9                	fxch   %st(1)
  401072:	44 29 df             	sub    %r11d,%edi
  401075:	df e9                	fucomip %st(1),%st
  401077:	dd d8                	fstp   %st(0)
  401079:	7a 06                	jp     401081 <fmt_fp+0x6dd>
  40107b:	75 04                	jne    401081 <fmt_fp+0x6dd>
  40107d:	89 39                	mov    %edi,(%rcx)
  40107f:	eb 50                	jmp    4010d1 <fmt_fp+0x72d>
  401081:	01 fe                	add    %edi,%esi
  401083:	89 31                	mov    %esi,(%rcx)
  401085:	81 39 ff c9 9a 3b    	cmpl   $0x3b9ac9ff,(%rcx)
  40108b:	76 20                	jbe    4010ad <fmt_fp+0x709>
  40108d:	48 83 e9 04          	sub    $0x4,%rcx
  401091:	c7 41 04 00 00 00 00 	movl   $0x0,0x4(%rcx)
  401098:	49 39 cf             	cmp    %rcx,%r15
  40109b:	76 0c                	jbe    4010a9 <fmt_fp+0x705>
  40109d:	41 c7 47 fc 00 00 00 	movl   $0x0,-0x4(%r15)
  4010a4:	00 
  4010a5:	49 83 ef 04          	sub    $0x4,%r15
  4010a9:	ff 01                	incl   (%rcx)
  4010ab:	eb d8                	jmp    401085 <fmt_fp+0x6e1>
  4010ad:	4c 8b 44 24 10       	mov    0x10(%rsp),%r8
  4010b2:	41 8b 17             	mov    (%r15),%edx
  4010b5:	b8 0a 00 00 00       	mov    $0xa,%eax
  4010ba:	4d 29 f8             	sub    %r15,%r8
  4010bd:	49 c1 f8 02          	sar    $0x2,%r8
  4010c1:	47 8d 04 c0          	lea    (%r8,%r8,8),%r8d
  4010c5:	39 c2                	cmp    %eax,%edx
  4010c7:	72 08                	jb     4010d1 <fmt_fp+0x72d>
  4010c9:	6b c0 0a             	imul   $0xa,%eax,%eax
  4010cc:	41 ff c0             	inc    %r8d
  4010cf:	eb f4                	jmp    4010c5 <fmt_fp+0x721>
  4010d1:	48 83 c1 04          	add    $0x4,%rcx
  4010d5:	49 39 cd             	cmp    %rcx,%r13
  4010d8:	4c 0f 47 e9          	cmova  %rcx,%r13
  4010dc:	eb 0b                	jmp    4010e9 <fmt_fp+0x745>
  4010de:	41 83 7d fc 00       	cmpl   $0x0,-0x4(%r13)
  4010e3:	75 09                	jne    4010ee <fmt_fp+0x74a>
  4010e5:	49 83 ed 04          	sub    $0x4,%r13
  4010e9:	4d 39 fd             	cmp    %r15,%r13
  4010ec:	77 f0                	ja     4010de <fmt_fp+0x73a>
  4010ee:	41 83 f9 67          	cmp    $0x67,%r9d
  4010f2:	0f 85 c3 00 00 00    	jne    4011bb <fmt_fp+0x817>
  4010f8:	85 db                	test   %ebx,%ebx
  4010fa:	b8 01 00 00 00       	mov    $0x1,%eax
  4010ff:	0f 44 d8             	cmove  %eax,%ebx
  401102:	44 39 c3             	cmp    %r8d,%ebx
  401105:	7e 11                	jle    401118 <fmt_fp+0x774>
  401107:	41 83 f8 fc          	cmp    $0xfffffffc,%r8d
  40110b:	7c 0b                	jl     401118 <fmt_fp+0x774>
  40110d:	41 8d 40 01          	lea    0x1(%r8),%eax
  401111:	41 ff ce             	dec    %r14d
  401114:	29 c3                	sub    %eax,%ebx
  401116:	eb 06                	jmp    40111e <fmt_fp+0x77a>
  401118:	41 83 ee 02          	sub    $0x2,%r14d
  40111c:	ff cb                	dec    %ebx
  40111e:	f6 44 24 0c 08       	testb  $0x8,0xc(%rsp)
  401123:	0f 85 92 00 00 00    	jne    4011bb <fmt_fp+0x817>
  401129:	4d 39 fd             	cmp    %r15,%r13
  40112c:	b9 09 00 00 00       	mov    $0x9,%ecx
  401131:	76 20                	jbe    401153 <fmt_fp+0x7af>
  401133:	41 8b 7d fc          	mov    -0x4(%r13),%edi
  401137:	85 ff                	test   %edi,%edi
  401139:	74 18                	je     401153 <fmt_fp+0x7af>
  40113b:	31 c9                	xor    %ecx,%ecx
  40113d:	be 0a 00 00 00       	mov    $0xa,%esi
  401142:	31 d2                	xor    %edx,%edx
  401144:	89 f8                	mov    %edi,%eax
  401146:	f7 f6                	div    %esi
  401148:	85 d2                	test   %edx,%edx
  40114a:	75 07                	jne    401153 <fmt_fp+0x7af>
  40114c:	6b f6 0a             	imul   $0xa,%esi,%esi
  40114f:	ff c1                	inc    %ecx
  401151:	eb ef                	jmp    401142 <fmt_fp+0x79e>
  401153:	44 89 f0             	mov    %r14d,%eax
  401156:	48 63 d3             	movslq %ebx,%rdx
  401159:	48 63 c9             	movslq %ecx,%rcx
  40115c:	83 c8 20             	or     $0x20,%eax
  40115f:	83 f8 66             	cmp    $0x66,%eax
  401162:	75 28                	jne    40118c <fmt_fp+0x7e8>
  401164:	4c 89 eb             	mov    %r13,%rbx
  401167:	48 2b 5c 24 10       	sub    0x10(%rsp),%rbx
  40116c:	b8 00 00 00 00       	mov    $0x0,%eax
  401171:	48 c1 fb 02          	sar    $0x2,%rbx
  401175:	48 ff cb             	dec    %rbx
  401178:	48 8d 1c db          	lea    (%rbx,%rbx,8),%rbx
  40117c:	48 29 cb             	sub    %rcx,%rbx
  40117f:	48 0f 48 d8          	cmovs  %rax,%rbx
  401183:	48 39 d3             	cmp    %rdx,%rbx
  401186:	48 0f 4f da          	cmovg  %rdx,%rbx
  40118a:	eb 2f                	jmp    4011bb <fmt_fp+0x817>
  40118c:	4c 89 e8             	mov    %r13,%rax
  40118f:	48 2b 44 24 10       	sub    0x10(%rsp),%rax
  401194:	49 63 d8             	movslq %r8d,%rbx
  401197:	48 c1 f8 02          	sar    $0x2,%rax
  40119b:	48 ff c8             	dec    %rax
  40119e:	48 8d 04 c0          	lea    (%rax,%rax,8),%rax
  4011a2:	48 01 d8             	add    %rbx,%rax
  4011a5:	48 29 c8             	sub    %rcx,%rax
  4011a8:	b9 00 00 00 00       	mov    $0x0,%ecx
  4011ad:	48 0f 48 c1          	cmovs  %rcx,%rax
  4011b1:	48 39 d0             	cmp    %rdx,%rax
  4011b4:	48 0f 4e d0          	cmovle %rax,%rdx
  4011b8:	48 89 d3             	mov    %rdx,%rbx
  4011bb:	85 db                	test   %ebx,%ebx
  4011bd:	b0 01                	mov    $0x1,%al
  4011bf:	75 0a                	jne    4011cb <fmt_fp+0x827>
  4011c1:	8b 44 24 0c          	mov    0xc(%rsp),%eax
  4011c5:	c1 e8 03             	shr    $0x3,%eax
  4011c8:	83 e0 01             	and    $0x1,%eax
  4011cb:	0f b6 c0             	movzbl %al,%eax
  4011ce:	ba fe ff ff 7f       	mov    $0x7ffffffe,%edx
  4011d3:	29 c2                	sub    %eax,%edx
  4011d5:	39 d3                	cmp    %edx,%ebx
  4011d7:	0f 8f b2 fa ff ff    	jg     400c8f <fmt_fp+0x2eb>
  4011dd:	44 8d 4c 18 01       	lea    0x1(%rax,%rbx,1),%r9d
  4011e2:	44 89 f0             	mov    %r14d,%eax
  4011e5:	83 c8 20             	or     $0x20,%eax
  4011e8:	83 f8 66             	cmp    $0x66,%eax
  4011eb:	89 44 24 4c          	mov    %eax,0x4c(%rsp)
  4011ef:	75 1e                	jne    40120f <fmt_fp+0x86b>
  4011f1:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  4011f6:	44 29 c8             	sub    %r9d,%eax
  4011f9:	41 39 c0             	cmp    %eax,%r8d
  4011fc:	0f 8f 8d fa ff ff    	jg     400c8f <fmt_fp+0x2eb>
  401202:	43 8d 04 01          	lea    (%r9,%r8,1),%eax
  401206:	45 85 c0             	test   %r8d,%r8d
  401209:	44 0f 4f c8          	cmovg  %eax,%r9d
  40120d:	eb 6c                	jmp    40127b <fmt_fp+0x8d7>
  40120f:	44 89 c0             	mov    %r8d,%eax
  401212:	48 8d 74 24 7b       	lea    0x7b(%rsp),%rsi
  401217:	c1 f8 1f             	sar    $0x1f,%eax
  40121a:	89 c7                	mov    %eax,%edi
  40121c:	44 31 c7             	xor    %r8d,%edi
  40121f:	29 c7                	sub    %eax,%edi
  401221:	48 63 ff             	movslq %edi,%rdi
  401224:	e8 91 f6 ff ff       	callq  4008ba <fmt_u>
  401229:	48 8d 54 24 7b       	lea    0x7b(%rsp),%rdx
  40122e:	48 89 d1             	mov    %rdx,%rcx
  401231:	48 29 c1             	sub    %rax,%rcx
  401234:	48 ff c9             	dec    %rcx
  401237:	7f 08                	jg     401241 <fmt_fp+0x89d>
  401239:	48 ff c8             	dec    %rax
  40123c:	c6 00 30             	movb   $0x30,(%rax)
  40123f:	eb ed                	jmp    40122e <fmt_fp+0x88a>
  401241:	41 c1 f8 1f          	sar    $0x1f,%r8d
  401245:	48 8d 78 fe          	lea    -0x2(%rax),%rdi
  401249:	44 88 70 fe          	mov    %r14b,-0x2(%rax)
  40124d:	41 83 e0 02          	and    $0x2,%r8d
  401251:	41 83 c0 2b          	add    $0x2b,%r8d
  401255:	48 89 7c 24 30       	mov    %rdi,0x30(%rsp)
  40125a:	44 88 40 ff          	mov    %r8b,-0x1(%rax)
  40125e:	48 89 d0             	mov    %rdx,%rax
  401261:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
  401266:	44 29 ca             	sub    %r9d,%edx
  401269:	48 29 f8             	sub    %rdi,%rax
  40126c:	48 63 d2             	movslq %edx,%rdx
  40126f:	48 39 d0             	cmp    %rdx,%rax
  401272:	0f 8f 17 fa ff ff    	jg     400c8f <fmt_fp+0x2eb>
  401278:	41 01 c1             	add    %eax,%r9d
  40127b:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  401280:	44 29 e0             	sub    %r12d,%eax
  401283:	41 39 c1             	cmp    %eax,%r9d
  401286:	0f 8f 03 fa ff ff    	jg     400c8f <fmt_fp+0x2eb>
  40128c:	43 8d 04 21          	lea    (%r9,%r12,1),%eax
  401290:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  401295:	8b 54 24 48          	mov    0x48(%rsp),%edx
  401299:	be 20 00 00 00       	mov    $0x20,%esi
  40129e:	48 89 ef             	mov    %rbp,%rdi
  4012a1:	89 c1                	mov    %eax,%ecx
  4012a3:	89 44 24 20          	mov    %eax,0x20(%rsp)
  4012a7:	e8 80 f6 ff ff       	callq  40092c <pad>
  4012ac:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  4012b1:	49 63 d4             	movslq %r12d,%rdx
  4012b4:	48 89 ef             	mov    %rbp,%rdi
  4012b7:	e8 59 f6 ff ff       	callq  400915 <out>
  4012bc:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  4012c1:	8b 4c 24 20          	mov    0x20(%rsp),%ecx
  4012c5:	be 30 00 00 00       	mov    $0x30,%esi
  4012ca:	8b 54 24 48          	mov    0x48(%rsp),%edx
  4012ce:	48 89 ef             	mov    %rbp,%rdi
  4012d1:	41 81 f0 00 00 01 00 	xor    $0x10000,%r8d
  4012d8:	e8 4f f6 ff ff       	callq  40092c <pad>
  4012dd:	83 7c 24 4c 66       	cmpl   $0x66,0x4c(%rsp)
  4012e2:	0f 85 e8 00 00 00    	jne    4013d0 <fmt_fp+0xa2c>
  4012e8:	4c 3b 7c 24 10       	cmp    0x10(%rsp),%r15
  4012ed:	4c 8d 74 24 7b       	lea    0x7b(%rsp),%r14
  4012f2:	4c 0f 47 7c 24 10    	cmova  0x10(%rsp),%r15
  4012f8:	4d 89 fc             	mov    %r15,%r12
  4012fb:	4c 3b 7c 24 10       	cmp    0x10(%rsp),%r15
  401300:	77 4a                	ja     40134c <fmt_fp+0x9a8>
  401302:	41 8b 3f             	mov    (%r15),%edi
  401305:	4d 8d 46 09          	lea    0x9(%r14),%r8
  401309:	4c 89 c6             	mov    %r8,%rsi
  40130c:	e8 a9 f5 ff ff       	callq  4008ba <fmt_u>
  401311:	4d 39 e7             	cmp    %r12,%r15
  401314:	74 0d                	je     401323 <fmt_fp+0x97f>
  401316:	4c 39 f0             	cmp    %r14,%rax
  401319:	76 19                	jbe    401334 <fmt_fp+0x990>
  40131b:	48 ff c8             	dec    %rax
  40131e:	c6 00 30             	movb   $0x30,(%rax)
  401321:	eb f3                	jmp    401316 <fmt_fp+0x972>
  401323:	4c 39 c0             	cmp    %r8,%rax
  401326:	75 0c                	jne    401334 <fmt_fp+0x990>
  401328:	49 8d 46 08          	lea    0x8(%r14),%rax
  40132c:	c6 84 24 83 00 00 00 	movb   $0x30,0x83(%rsp)
  401333:	30 
  401334:	49 8d 56 09          	lea    0x9(%r14),%rdx
  401338:	48 89 c6             	mov    %rax,%rsi
  40133b:	48 89 ef             	mov    %rbp,%rdi
  40133e:	49 83 c7 04          	add    $0x4,%r15
  401342:	48 29 c2             	sub    %rax,%rdx
  401345:	e8 cb f5 ff ff       	callq  400915 <out>
  40134a:	eb af                	jmp    4012fb <fmt_fp+0x957>
  40134c:	85 db                	test   %ebx,%ebx
  40134e:	75 07                	jne    401357 <fmt_fp+0x9b3>
  401350:	f6 44 24 0c 08       	testb  $0x8,0xc(%rsp)
  401355:	74 5c                	je     4013b3 <fmt_fp+0xa0f>
  401357:	4c 8d 64 24 7b       	lea    0x7b(%rsp),%r12
  40135c:	ba 01 00 00 00       	mov    $0x1,%edx
  401361:	be 1b 3e 40 00       	mov    $0x403e1b,%esi
  401366:	48 89 ef             	mov    %rbp,%rdi
  401369:	e8 a7 f5 ff ff       	callq  400915 <out>
  40136e:	4d 39 ef             	cmp    %r13,%r15
  401371:	73 40                	jae    4013b3 <fmt_fp+0xa0f>
  401373:	85 db                	test   %ebx,%ebx
  401375:	7e 3c                	jle    4013b3 <fmt_fp+0xa0f>
  401377:	41 8b 3f             	mov    (%r15),%edi
  40137a:	49 8d 74 24 09       	lea    0x9(%r12),%rsi
  40137f:	e8 36 f5 ff ff       	callq  4008ba <fmt_u>
  401384:	4c 39 e0             	cmp    %r12,%rax
  401387:	76 08                	jbe    401391 <fmt_fp+0x9ed>
  401389:	48 ff c8             	dec    %rax
  40138c:	c6 00 30             	movb   $0x30,(%rax)
  40138f:	eb f3                	jmp    401384 <fmt_fp+0x9e0>
  401391:	83 fb 09             	cmp    $0x9,%ebx
  401394:	ba 09 00 00 00       	mov    $0x9,%edx
  401399:	48 89 c6             	mov    %rax,%rsi
  40139c:	0f 4e d3             	cmovle %ebx,%edx
  40139f:	48 89 ef             	mov    %rbp,%rdi
  4013a2:	49 83 c7 04          	add    $0x4,%r15
  4013a6:	48 63 d2             	movslq %edx,%rdx
  4013a9:	83 eb 09             	sub    $0x9,%ebx
  4013ac:	e8 64 f5 ff ff       	callq  400915 <out>
  4013b1:	eb bb                	jmp    40136e <fmt_fp+0x9ca>
  4013b3:	8d 53 09             	lea    0x9(%rbx),%edx
  4013b6:	45 31 c0             	xor    %r8d,%r8d
  4013b9:	b9 09 00 00 00       	mov    $0x9,%ecx
  4013be:	be 30 00 00 00       	mov    $0x30,%esi
  4013c3:	48 89 ef             	mov    %rbp,%rdi
  4013c6:	e8 61 f5 ff ff       	callq  40092c <pad>
  4013cb:	e9 04 01 00 00       	jmpq   4014d4 <fmt_fp+0xb30>
  4013d0:	49 8d 47 04          	lea    0x4(%r15),%rax
  4013d4:	4d 39 fd             	cmp    %r15,%r13
  4013d7:	4c 8d 64 24 7b       	lea    0x7b(%rsp),%r12
  4013dc:	4d 89 fe             	mov    %r15,%r14
  4013df:	4c 0f 46 e8          	cmovbe %rax,%r13
  4013e3:	4d 39 ee             	cmp    %r13,%r14
  4013e6:	0f 83 b9 00 00 00    	jae    4014a5 <fmt_fp+0xb01>
  4013ec:	89 d8                	mov    %ebx,%eax
  4013ee:	83 e8 00             	sub    $0x0,%eax
  4013f1:	0f 88 ae 00 00 00    	js     4014a5 <fmt_fp+0xb01>
  4013f7:	41 8b 3e             	mov    (%r14),%edi
  4013fa:	4d 8d 44 24 09       	lea    0x9(%r12),%r8
  4013ff:	4c 89 c6             	mov    %r8,%rsi
  401402:	e8 b3 f4 ff ff       	callq  4008ba <fmt_u>
  401407:	4c 39 c0             	cmp    %r8,%rax
  40140a:	75 0d                	jne    401419 <fmt_fp+0xa75>
  40140c:	49 8d 44 24 08       	lea    0x8(%r12),%rax
  401411:	c6 84 24 83 00 00 00 	movb   $0x30,0x83(%rsp)
  401418:	30 
  401419:	4d 39 fe             	cmp    %r15,%r14
  40141c:	48 89 c1             	mov    %rax,%rcx
  40141f:	74 0d                	je     40142e <fmt_fp+0xa8a>
  401421:	4c 39 e1             	cmp    %r12,%rcx
  401424:	76 4d                	jbe    401473 <fmt_fp+0xacf>
  401426:	48 ff c9             	dec    %rcx
  401429:	c6 01 30             	movb   $0x30,(%rcx)
  40142c:	eb f3                	jmp    401421 <fmt_fp+0xa7d>
  40142e:	48 8d 48 01          	lea    0x1(%rax),%rcx
  401432:	ba 01 00 00 00       	mov    $0x1,%edx
  401437:	48 89 c6             	mov    %rax,%rsi
  40143a:	48 89 ef             	mov    %rbp,%rdi
  40143d:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  401442:	e8 ce f4 ff ff       	callq  400915 <out>
  401447:	85 db                	test   %ebx,%ebx
  401449:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  40144e:	75 07                	jne    401457 <fmt_fp+0xab3>
  401450:	f6 44 24 0c 08       	testb  $0x8,0xc(%rsp)
  401455:	74 1c                	je     401473 <fmt_fp+0xacf>
  401457:	ba 01 00 00 00       	mov    $0x1,%edx
  40145c:	be 1b 3e 40 00       	mov    $0x403e1b,%esi
  401461:	48 89 ef             	mov    %rbp,%rdi
  401464:	48 89 4c 24 10       	mov    %rcx,0x10(%rsp)
  401469:	e8 a7 f4 ff ff       	callq  400915 <out>
  40146e:	48 8b 4c 24 10       	mov    0x10(%rsp),%rcx
  401473:	49 8d 44 24 09       	lea    0x9(%r12),%rax
  401478:	48 63 d3             	movslq %ebx,%rdx
  40147b:	48 89 ce             	mov    %rcx,%rsi
  40147e:	48 89 ef             	mov    %rbp,%rdi
  401481:	48 29 c8             	sub    %rcx,%rax
  401484:	48 39 c2             	cmp    %rax,%rdx
  401487:	48 89 44 24 10       	mov    %rax,0x10(%rsp)
  40148c:	48 0f 4f d0          	cmovg  %rax,%rdx
  401490:	49 83 c6 04          	add    $0x4,%r14
  401494:	e8 7c f4 ff ff       	callq  400915 <out>
  401499:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  40149e:	29 c3                	sub    %eax,%ebx
  4014a0:	e9 3e ff ff ff       	jmpq   4013e3 <fmt_fp+0xa3f>
  4014a5:	8d 53 12             	lea    0x12(%rbx),%edx
  4014a8:	be 30 00 00 00       	mov    $0x30,%esi
  4014ad:	48 89 ef             	mov    %rbp,%rdi
  4014b0:	45 31 c0             	xor    %r8d,%r8d
  4014b3:	b9 12 00 00 00       	mov    $0x12,%ecx
  4014b8:	e8 6f f4 ff ff       	callq  40092c <pad>
  4014bd:	48 8d 54 24 7b       	lea    0x7b(%rsp),%rdx
  4014c2:	48 2b 54 24 30       	sub    0x30(%rsp),%rdx
  4014c7:	48 8b 74 24 30       	mov    0x30(%rsp),%rsi
  4014cc:	48 89 ef             	mov    %rbp,%rdi
  4014cf:	e8 41 f4 ff ff       	callq  400915 <out>
  4014d4:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  4014d9:	8b 4c 24 20          	mov    0x20(%rsp),%ecx
  4014dd:	be 20 00 00 00       	mov    $0x20,%esi
  4014e2:	8b 54 24 48          	mov    0x48(%rsp),%edx
  4014e6:	48 89 ef             	mov    %rbp,%rdi
  4014e9:	41 81 f0 00 20 00 00 	xor    $0x2000,%r8d
  4014f0:	e8 37 f4 ff ff       	callq  40092c <pad>
  4014f5:	8b 5c 24 20          	mov    0x20(%rsp),%ebx
  4014f9:	39 5c 24 48          	cmp    %ebx,0x48(%rsp)
  4014fd:	89 d8                	mov    %ebx,%eax
  4014ff:	0f 4d 44 24 48       	cmovge 0x48(%rsp),%eax
  401504:	48 81 c4 48 1d 00 00 	add    $0x1d48,%rsp
  40150b:	5b                   	pop    %rbx
  40150c:	5d                   	pop    %rbp
  40150d:	41 5c                	pop    %r12
  40150f:	41 5d                	pop    %r13
  401511:	41 5e                	pop    %r14
  401513:	41 5f                	pop    %r15
  401515:	c3                   	retq   

0000000000401516 <printf_core>:
  401516:	41 57                	push   %r15
  401518:	41 56                	push   %r14
  40151a:	41 55                	push   %r13
  40151c:	41 54                	push   %r12
  40151e:	45 31 e4             	xor    %r12d,%r12d
  401521:	55                   	push   %rbp
  401522:	53                   	push   %rbx
  401523:	31 db                	xor    %ebx,%ebx
  401525:	48 81 ec a8 00 00 00 	sub    $0xa8,%rsp
  40152c:	48 89 3c 24          	mov    %rdi,(%rsp)
  401530:	48 89 54 24 08       	mov    %rdx,0x8(%rsp)
  401535:	48 89 4c 24 20       	mov    %rcx,0x20(%rsp)
  40153a:	4c 89 44 24 18       	mov    %r8,0x18(%rsp)
  40153f:	48 89 74 24 50       	mov    %rsi,0x50(%rsp)
  401544:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%rsp)
  40154b:	00 
  40154c:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  401551:	44 29 e0             	sub    %r12d,%eax
  401554:	39 c3                	cmp    %eax,%ebx
  401556:	0f 8f 4f 08 00 00    	jg     401dab <printf_core+0x895>
  40155c:	4c 8b 74 24 50       	mov    0x50(%rsp),%r14
  401561:	41 01 dc             	add    %ebx,%r12d
  401564:	41 80 3e 00          	cmpb   $0x0,(%r14)
  401568:	0f 84 cc 07 00 00    	je     401d3a <printf_core+0x824>
  40156e:	4c 8b 6c 24 50       	mov    0x50(%rsp),%r13
  401573:	41 8a 45 00          	mov    0x0(%r13),%al
  401577:	84 c0                	test   %al,%al
  401579:	74 20                	je     40159b <printf_core+0x85>
  40157b:	3c 25                	cmp    $0x25,%al
  40157d:	74 1c                	je     40159b <printf_core+0x85>
  40157f:	49 ff c5             	inc    %r13
  401582:	4c 89 6c 24 50       	mov    %r13,0x50(%rsp)
  401587:	eb e5                	jmp    40156e <printf_core+0x58>
  401589:	80 78 01 25          	cmpb   $0x25,0x1(%rax)
  40158d:	75 16                	jne    4015a5 <printf_core+0x8f>
  40158f:	48 83 c0 02          	add    $0x2,%rax
  401593:	49 ff c5             	inc    %r13
  401596:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  40159b:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  4015a0:	80 38 25             	cmpb   $0x25,(%rax)
  4015a3:	74 e4                	je     401589 <printf_core+0x73>
  4015a5:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  4015aa:	4d 29 f5             	sub    %r14,%r13
  4015ad:	44 29 e0             	sub    %r12d,%eax
  4015b0:	89 44 24 2c          	mov    %eax,0x2c(%rsp)
  4015b4:	48 98                	cltq   
  4015b6:	49 39 c5             	cmp    %rax,%r13
  4015b9:	0f 8f ec 07 00 00    	jg     401dab <printf_core+0x895>
  4015bf:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  4015c4:	44 89 eb             	mov    %r13d,%ebx
  4015c7:	74 0f                	je     4015d8 <printf_core+0xc2>
  4015c9:	48 8b 3c 24          	mov    (%rsp),%rdi
  4015cd:	49 63 d5             	movslq %r13d,%rdx
  4015d0:	4c 89 f6             	mov    %r14,%rsi
  4015d3:	e8 3d f3 ff ff       	callq  400915 <out>
  4015d8:	45 85 ed             	test   %r13d,%r13d
  4015db:	0f 85 6b ff ff ff    	jne    40154c <printf_core+0x36>
  4015e1:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  4015e6:	44 0f be 50 01       	movsbl 0x1(%rax),%r10d
  4015eb:	41 83 ea 30          	sub    $0x30,%r10d
  4015ef:	41 83 fa 09          	cmp    $0x9,%r10d
  4015f3:	77 19                	ja     40160e <printf_core+0xf8>
  4015f5:	80 78 02 24          	cmpb   $0x24,0x2(%rax)
  4015f9:	75 13                	jne    40160e <printf_core+0xf8>
  4015fb:	48 83 c0 03          	add    $0x3,%rax
  4015ff:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
  401606:	00 
  401607:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  40160c:	eb 0c                	jmp    40161a <printf_core+0x104>
  40160e:	48 ff c0             	inc    %rax
  401611:	41 83 ca ff          	or     $0xffffffff,%r10d
  401615:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  40161a:	31 ed                	xor    %ebp,%ebp
  40161c:	be 89 28 01 00       	mov    $0x12889,%esi
  401621:	bf 01 00 00 00       	mov    $0x1,%edi
  401626:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  40162b:	0f be 08             	movsbl (%rax),%ecx
  40162e:	89 ca                	mov    %ecx,%edx
  401630:	83 e9 20             	sub    $0x20,%ecx
  401633:	83 f9 1f             	cmp    $0x1f,%ecx
  401636:	76 0b                	jbe    401643 <printf_core+0x12d>
  401638:	80 fa 2a             	cmp    $0x2a,%dl
  40163b:	0f 85 cc 00 00 00    	jne    40170d <printf_core+0x1f7>
  401641:	eb 15                	jmp    401658 <printf_core+0x142>
  401643:	0f a3 ce             	bt     %ecx,%esi
  401646:	73 f0                	jae    401638 <printf_core+0x122>
  401648:	89 fa                	mov    %edi,%edx
  40164a:	48 ff c0             	inc    %rax
  40164d:	d3 e2                	shl    %cl,%edx
  40164f:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  401654:	09 d5                	or     %edx,%ebp
  401656:	eb ce                	jmp    401626 <printf_core+0x110>
  401658:	48 0f be 48 01       	movsbq 0x1(%rax),%rcx
  40165d:	48 89 ca             	mov    %rcx,%rdx
  401660:	83 e9 30             	sub    $0x30,%ecx
  401663:	83 f9 09             	cmp    $0x9,%ecx
  401666:	77 3f                	ja     4016a7 <printf_core+0x191>
  401668:	80 78 02 24          	cmpb   $0x24,0x2(%rax)
  40166c:	75 39                	jne    4016a7 <printf_core+0x191>
  40166e:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  401673:	48 83 c0 03          	add    $0x3,%rax
  401677:	c7 44 24 14 01 00 00 	movl   $0x1,0x14(%rsp)
  40167e:	00 
  40167f:	c7 84 97 40 ff ff ff 	movl   $0xa,-0xc0(%rdi,%rdx,4)
  401686:	0a 00 00 00 
  40168a:	48 0f be 50 fe       	movsbq -0x2(%rax),%rdx
  40168f:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  401694:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  401699:	48 c1 e2 04          	shl    $0x4,%rdx
  40169d:	44 8b bc 17 00 fd ff 	mov    -0x300(%rdi,%rdx,1),%r15d
  4016a4:	ff 
  4016a5:	eb 56                	jmp    4016fd <printf_core+0x1e7>
  4016a7:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
  4016ac:	74 10                	je     4016be <printf_core+0x1a8>
  4016ae:	e8 2d 15 00 00       	callq  402be0 <__errno_location>
  4016b3:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
  4016b9:	e9 f8 06 00 00       	jmpq   401db6 <printf_core+0x8a0>
  4016be:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  4016c3:	45 89 ef             	mov    %r13d,%r15d
  4016c6:	74 2d                	je     4016f5 <printf_core+0x1df>
  4016c8:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  4016cd:	8b 0f                	mov    (%rdi),%ecx
  4016cf:	83 f9 2f             	cmp    $0x2f,%ecx
  4016d2:	77 0d                	ja     4016e1 <printf_core+0x1cb>
  4016d4:	89 ca                	mov    %ecx,%edx
  4016d6:	83 c1 08             	add    $0x8,%ecx
  4016d9:	48 03 57 10          	add    0x10(%rdi),%rdx
  4016dd:	89 0f                	mov    %ecx,(%rdi)
  4016df:	eb 11                	jmp    4016f2 <printf_core+0x1dc>
  4016e1:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  4016e6:	48 8b 57 08          	mov    0x8(%rdi),%rdx
  4016ea:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  4016ee:	48 89 4f 08          	mov    %rcx,0x8(%rdi)
  4016f2:	44 8b 3a             	mov    (%rdx),%r15d
  4016f5:	48 ff c0             	inc    %rax
  4016f8:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  4016fd:	45 85 ff             	test   %r15d,%r15d
  401700:	79 20                	jns    401722 <printf_core+0x20c>
  401702:	81 cd 00 20 00 00    	or     $0x2000,%ebp
  401708:	41 f7 df             	neg    %r15d
  40170b:	eb 15                	jmp    401722 <printf_core+0x20c>
  40170d:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
  401712:	e8 c3 f1 ff ff       	callq  4008da <getint>
  401717:	85 c0                	test   %eax,%eax
  401719:	41 89 c7             	mov    %eax,%r15d
  40171c:	0f 88 89 06 00 00    	js     401dab <printf_core+0x895>
  401722:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  401727:	49 83 c9 ff          	or     $0xffffffffffffffff,%r9
  40172b:	45 89 eb             	mov    %r13d,%r11d
  40172e:	80 38 2e             	cmpb   $0x2e,(%rax)
  401731:	0f 85 c4 00 00 00    	jne    4017fb <printf_core+0x2e5>
  401737:	80 78 01 2a          	cmpb   $0x2a,0x1(%rax)
  40173b:	0f 85 9f 00 00 00    	jne    4017e0 <printf_core+0x2ca>
  401741:	48 0f be 48 02       	movsbq 0x2(%rax),%rcx
  401746:	48 89 ca             	mov    %rcx,%rdx
  401749:	83 e9 30             	sub    $0x30,%ecx
  40174c:	83 f9 09             	cmp    $0x9,%ecx
  40174f:	77 32                	ja     401783 <printf_core+0x26d>
  401751:	80 78 03 24          	cmpb   $0x24,0x3(%rax)
  401755:	75 2c                	jne    401783 <printf_core+0x26d>
  401757:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  40175c:	48 83 c0 04          	add    $0x4,%rax
  401760:	c7 84 97 40 ff ff ff 	movl   $0xa,-0xc0(%rdi,%rdx,4)
  401767:	0a 00 00 00 
  40176b:	48 0f be 50 fe       	movsbq -0x2(%rax),%rdx
  401770:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  401775:	48 c1 e2 04          	shl    $0x4,%rdx
  401779:	4c 63 8c 17 00 fd ff 	movslq -0x300(%rdi,%rdx,1),%r9
  401780:	ff 
  401781:	eb 4b                	jmp    4017ce <printf_core+0x2b8>
  401783:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
  401788:	0f 85 20 ff ff ff    	jne    4016ae <printf_core+0x198>
  40178e:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  401793:	4d 63 cd             	movslq %r13d,%r9
  401796:	74 32                	je     4017ca <printf_core+0x2b4>
  401798:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  40179d:	8b 0e                	mov    (%rsi),%ecx
  40179f:	83 f9 2f             	cmp    $0x2f,%ecx
  4017a2:	77 0d                	ja     4017b1 <printf_core+0x29b>
  4017a4:	89 ca                	mov    %ecx,%edx
  4017a6:	83 c1 08             	add    $0x8,%ecx
  4017a9:	48 03 56 10          	add    0x10(%rsi),%rdx
  4017ad:	89 0e                	mov    %ecx,(%rsi)
  4017af:	eb 16                	jmp    4017c7 <printf_core+0x2b1>
  4017b1:	48 8b 4c 24 08       	mov    0x8(%rsp),%rcx
  4017b6:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  4017bb:	48 8b 51 08          	mov    0x8(%rcx),%rdx
  4017bf:	48 8d 4a 08          	lea    0x8(%rdx),%rcx
  4017c3:	48 89 4f 08          	mov    %rcx,0x8(%rdi)
  4017c7:	4c 63 0a             	movslq (%rdx),%r9
  4017ca:	48 83 c0 02          	add    $0x2,%rax
  4017ce:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  4017d3:	44 89 c8             	mov    %r9d,%eax
  4017d6:	f7 d0                	not    %eax
  4017d8:	c1 e8 1f             	shr    $0x1f,%eax
  4017db:	41 89 c3             	mov    %eax,%r11d
  4017de:	eb 1b                	jmp    4017fb <printf_core+0x2e5>
  4017e0:	48 8d 7c 24 50       	lea    0x50(%rsp),%rdi
  4017e5:	48 ff c0             	inc    %rax
  4017e8:	48 89 44 24 50       	mov    %rax,0x50(%rsp)
  4017ed:	e8 e8 f0 ff ff       	callq  4008da <getint>
  4017f2:	41 bb 01 00 00 00    	mov    $0x1,%r11d
  4017f8:	4c 63 c8             	movslq %eax,%r9
  4017fb:	31 c9                	xor    %ecx,%ecx
  4017fd:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  401802:	0f be 10             	movsbl (%rax),%edx
  401805:	83 ea 41             	sub    $0x41,%edx
  401808:	83 fa 39             	cmp    $0x39,%edx
  40180b:	0f 87 9d fe ff ff    	ja     4016ae <printf_core+0x198>
  401811:	48 8d 50 01          	lea    0x1(%rax),%rdx
  401815:	48 89 54 24 50       	mov    %rdx,0x50(%rsp)
  40181a:	0f be 00             	movsbl (%rax),%eax
  40181d:	89 ca                	mov    %ecx,%edx
  40181f:	48 6b d2 3a          	imul   $0x3a,%rdx,%rdx
  401823:	83 e8 41             	sub    $0x41,%eax
  401826:	48 98                	cltq   
  401828:	0f b6 b4 10 40 40 40 	movzbl 0x404040(%rax,%rdx,1),%esi
  40182f:	00 
  401830:	8d 46 ff             	lea    -0x1(%rsi),%eax
  401833:	83 f8 07             	cmp    $0x7,%eax
  401836:	77 04                	ja     40183c <printf_core+0x326>
  401838:	89 f1                	mov    %esi,%ecx
  40183a:	eb c1                	jmp    4017fd <printf_core+0x2e7>
  40183c:	85 f6                	test   %esi,%esi
  40183e:	0f 84 6a fe ff ff    	je     4016ae <printf_core+0x198>
  401844:	83 fe 1b             	cmp    $0x1b,%esi
  401847:	75 0a                	jne    401853 <printf_core+0x33d>
  401849:	45 85 d2             	test   %r10d,%r10d
  40184c:	78 64                	js     4018b2 <printf_core+0x39c>
  40184e:	e9 5b fe ff ff       	jmpq   4016ae <printf_core+0x198>
  401853:	45 85 d2             	test   %r10d,%r10d
  401856:	78 28                	js     401880 <printf_core+0x36a>
  401858:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  40185d:	4d 63 d2             	movslq %r10d,%r10
  401860:	42 89 34 90          	mov    %esi,(%rax,%r10,4)
  401864:	49 c1 e2 04          	shl    $0x4,%r10
  401868:	4c 03 54 24 20       	add    0x20(%rsp),%r10
  40186d:	49 8b 02             	mov    (%r10),%rax
  401870:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  401875:	49 8b 42 08          	mov    0x8(%r10),%rax
  401879:	48 89 44 24 68       	mov    %rax,0x68(%rsp)
  40187e:	eb 32                	jmp    4018b2 <printf_core+0x39c>
  401880:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  401885:	75 08                	jne    40188f <printf_core+0x379>
  401887:	45 31 e4             	xor    %r12d,%r12d
  40188a:	e9 c2 05 00 00       	jmpq   401e51 <printf_core+0x93b>
  40188f:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  401894:	48 8d 7c 24 60       	lea    0x60(%rsp),%rdi
  401899:	89 4c 24 30          	mov    %ecx,0x30(%rsp)
  40189d:	44 89 4c 24 28       	mov    %r9d,0x28(%rsp)
  4018a2:	e8 ae ee ff ff       	callq  400755 <pop_arg>
  4018a7:	4c 63 4c 24 28       	movslq 0x28(%rsp),%r9
  4018ac:	8b 4c 24 30          	mov    0x30(%rsp),%ecx
  4018b0:	eb 0b                	jmp    4018bd <printf_core+0x3a7>
  4018b2:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  4018b7:	0f 84 8f fc ff ff    	je     40154c <printf_core+0x36>
  4018bd:	48 8b 44 24 50       	mov    0x50(%rsp),%rax
  4018c2:	85 c9                	test   %ecx,%ecx
  4018c4:	44 0f be 40 ff       	movsbl -0x1(%rax),%r8d
  4018c9:	45 89 c2             	mov    %r8d,%r10d
  4018cc:	74 12                	je     4018e0 <printf_core+0x3ca>
  4018ce:	44 88 c0             	mov    %r8b,%al
  4018d1:	83 e0 0f             	and    $0xf,%eax
  4018d4:	3c 03                	cmp    $0x3,%al
  4018d6:	75 08                	jne    4018e0 <printf_core+0x3ca>
  4018d8:	41 83 e2 df          	and    $0xffffffdf,%r10d
  4018dc:	45 0f be c2          	movsbl %r10b,%r8d
  4018e0:	89 e8                	mov    %ebp,%eax
  4018e2:	25 ff ff fe ff       	and    $0xfffeffff,%eax
  4018e7:	f7 c5 00 20 00 00    	test   $0x2000,%ebp
  4018ed:	0f 45 e8             	cmovne %eax,%ebp
  4018f0:	41 8d 40 bf          	lea    -0x41(%r8),%eax
  4018f4:	83 f8 37             	cmp    $0x37,%eax
  4018f7:	0f 87 43 03 00 00    	ja     401c40 <printf_core+0x72a>
  4018fd:	ff 24 c5 30 3e 40 00 	jmpq   *0x403e30(,%rax,8)
  401904:	83 f9 07             	cmp    $0x7,%ecx
  401907:	0f 87 3f fc ff ff    	ja     40154c <printf_core+0x36>
  40190d:	41 89 cf             	mov    %ecx,%r15d
  401910:	42 ff 24 fd f0 3f 40 	jmpq   *0x403ff0(,%r15,8)
  401917:	00 
  401918:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  40191d:	44 89 20             	mov    %r12d,(%rax)
  401920:	e9 27 fc ff ff       	jmpq   40154c <printf_core+0x36>
  401925:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  40192a:	66 44 89 20          	mov    %r12w,(%rax)
  40192e:	e9 19 fc ff ff       	jmpq   40154c <printf_core+0x36>
  401933:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  401938:	44 88 20             	mov    %r12b,(%rax)
  40193b:	e9 0c fc ff ff       	jmpq   40154c <printf_core+0x36>
  401940:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
  401945:	49 63 c4             	movslq %r12d,%rax
  401948:	48 89 02             	mov    %rax,(%rdx)
  40194b:	e9 fc fb ff ff       	jmpq   40154c <printf_core+0x36>
  401950:	41 83 f9 10          	cmp    $0x10,%r9d
  401954:	b8 10 00 00 00       	mov    $0x10,%eax
  401959:	41 b8 78 00 00 00    	mov    $0x78,%r8d
  40195f:	44 0f 42 c8          	cmovb  %eax,%r9d
  401963:	83 cd 08             	or     $0x8,%ebp
  401966:	48 8b 54 24 60       	mov    0x60(%rsp),%rdx
  40196b:	44 89 c1             	mov    %r8d,%ecx
  40196e:	4c 8d b4 24 a0 00 00 	lea    0xa0(%rsp),%r14
  401975:	00 
  401976:	83 e1 20             	and    $0x20,%ecx
  401979:	48 89 d0             	mov    %rdx,%rax
  40197c:	48 85 c0             	test   %rax,%rax
  40197f:	74 1c                	je     40199d <printf_core+0x487>
  401981:	48 89 c6             	mov    %rax,%rsi
  401984:	40 88 cf             	mov    %cl,%dil
  401987:	49 ff ce             	dec    %r14
  40198a:	83 e6 0f             	and    $0xf,%esi
  40198d:	48 c1 e8 04          	shr    $0x4,%rax
  401991:	40 0a be 30 40 40 00 	or     0x404030(%rsi),%dil
  401998:	41 88 3e             	mov    %dil,(%r14)
  40199b:	eb df                	jmp    40197c <printf_core+0x466>
  40199d:	48 85 d2             	test   %rdx,%rdx
  4019a0:	0f 84 ee 00 00 00    	je     401a94 <printf_core+0x57e>
  4019a6:	40 f6 c5 08          	test   $0x8,%bpl
  4019aa:	0f 84 e4 00 00 00    	je     401a94 <printf_core+0x57e>
  4019b0:	41 c1 f8 04          	sar    $0x4,%r8d
  4019b4:	bb 02 00 00 00       	mov    $0x2,%ebx
  4019b9:	4d 63 d0             	movslq %r8d,%r10
  4019bc:	49 81 c2 1d 3e 40 00 	add    $0x403e1d,%r10
  4019c3:	e9 d5 00 00 00       	jmpq   401a9d <printf_core+0x587>
  4019c8:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  4019cd:	4c 8d b4 24 a0 00 00 	lea    0xa0(%rsp),%r14
  4019d4:	00 
  4019d5:	48 85 c0             	test   %rax,%rax
  4019d8:	74 14                	je     4019ee <printf_core+0x4d8>
  4019da:	88 c2                	mov    %al,%dl
  4019dc:	49 ff ce             	dec    %r14
  4019df:	48 c1 e8 03          	shr    $0x3,%rax
  4019e3:	83 e2 07             	and    $0x7,%edx
  4019e6:	83 c2 30             	add    $0x30,%edx
  4019e9:	41 88 16             	mov    %dl,(%r14)
  4019ec:	eb e7                	jmp    4019d5 <printf_core+0x4bf>
  4019ee:	40 f6 c5 08          	test   $0x8,%bpl
  4019f2:	0f 84 9c 00 00 00    	je     401a94 <printf_core+0x57e>
  4019f8:	48 8d 84 24 a0 00 00 	lea    0xa0(%rsp),%rax
  4019ff:	00 
  401a00:	49 63 d1             	movslq %r9d,%rdx
  401a03:	4c 29 f0             	sub    %r14,%rax
  401a06:	48 39 d0             	cmp    %rdx,%rax
  401a09:	0f 8c 85 00 00 00    	jl     401a94 <printf_core+0x57e>
  401a0f:	44 8d 48 01          	lea    0x1(%rax),%r9d
  401a13:	eb 7f                	jmp    401a94 <printf_core+0x57e>
  401a15:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  401a1a:	48 85 c0             	test   %rax,%rax
  401a1d:	79 0f                	jns    401a2e <printf_core+0x518>
  401a1f:	48 f7 d8             	neg    %rax
  401a22:	bb 01 00 00 00       	mov    $0x1,%ebx
  401a27:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  401a2c:	eb 28                	jmp    401a56 <printf_core+0x540>
  401a2e:	0f ba e5 0b          	bt     $0xb,%ebp
  401a32:	72 2a                	jb     401a5e <printf_core+0x548>
  401a34:	89 e8                	mov    %ebp,%eax
  401a36:	bb 01 00 00 00       	mov    $0x1,%ebx
  401a3b:	41 ba 1f 3e 40 00    	mov    $0x403e1f,%r10d
  401a41:	83 e0 01             	and    $0x1,%eax
  401a44:	b8 1d 3e 40 00       	mov    $0x403e1d,%eax
  401a49:	41 0f 44 dd          	cmove  %r13d,%ebx
  401a4d:	4c 0f 44 d0          	cmove  %rax,%r10
  401a51:	eb 16                	jmp    401a69 <printf_core+0x553>
  401a53:	44 89 eb             	mov    %r13d,%ebx
  401a56:	41 ba 1d 3e 40 00    	mov    $0x403e1d,%r10d
  401a5c:	eb 0b                	jmp    401a69 <printf_core+0x553>
  401a5e:	bb 01 00 00 00       	mov    $0x1,%ebx
  401a63:	41 ba 1e 3e 40 00    	mov    $0x403e1e,%r10d
  401a69:	48 8b 7c 24 60       	mov    0x60(%rsp),%rdi
  401a6e:	48 8d b4 24 a0 00 00 	lea    0xa0(%rsp),%rsi
  401a75:	00 
  401a76:	4c 89 54 24 30       	mov    %r10,0x30(%rsp)
  401a7b:	44 89 4c 24 28       	mov    %r9d,0x28(%rsp)
  401a80:	e8 35 ee ff ff       	callq  4008ba <fmt_u>
  401a85:	44 8b 4c 24 28       	mov    0x28(%rsp),%r9d
  401a8a:	49 89 c6             	mov    %rax,%r14
  401a8d:	4c 8b 54 24 30       	mov    0x30(%rsp),%r10
  401a92:	eb 09                	jmp    401a9d <printf_core+0x587>
  401a94:	44 89 eb             	mov    %r13d,%ebx
  401a97:	41 ba 1d 3e 40 00    	mov    $0x403e1d,%r10d
  401a9d:	44 89 c8             	mov    %r9d,%eax
  401aa0:	c1 e8 1f             	shr    $0x1f,%eax
  401aa3:	74 0a                	je     401aaf <printf_core+0x599>
  401aa5:	41 f6 c3 01          	test   $0x1,%r11b
  401aa9:	0f 85 fc 02 00 00    	jne    401dab <printf_core+0x895>
  401aaf:	89 e8                	mov    %ebp,%eax
  401ab1:	25 ff ff fe ff       	and    $0xfffeffff,%eax
  401ab6:	45 85 db             	test   %r11d,%r11d
  401ab9:	0f 45 e8             	cmovne %eax,%ebp
  401abc:	48 83 7c 24 60 00    	cmpq   $0x0,0x60(%rsp)
  401ac2:	0f 94 c2             	sete   %dl
  401ac5:	45 85 c9             	test   %r9d,%r9d
  401ac8:	75 08                	jne    401ad2 <printf_core+0x5bc>
  401aca:	84 d2                	test   %dl,%dl
  401acc:	0f 85 7e 01 00 00    	jne    401c50 <printf_core+0x73a>
  401ad2:	48 8d 84 24 a0 00 00 	lea    0xa0(%rsp),%rax
  401ad9:	00 
  401ada:	0f b6 d2             	movzbl %dl,%edx
  401add:	4d 63 c9             	movslq %r9d,%r9
  401ae0:	4c 29 f0             	sub    %r14,%rax
  401ae3:	48 01 d0             	add    %rdx,%rax
  401ae6:	4c 39 c8             	cmp    %r9,%rax
  401ae9:	4c 0f 4d c8          	cmovge %rax,%r9
  401aed:	e9 54 01 00 00       	jmpq   401c46 <printf_core+0x730>
  401af2:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  401af7:	81 e5 ff ff fe ff    	and    $0xfffeffff,%ebp
  401afd:	41 ba 1d 3e 40 00    	mov    $0x403e1d,%r10d
  401b03:	41 b9 01 00 00 00    	mov    $0x1,%r9d
  401b09:	4c 8d ac 24 a0 00 00 	lea    0xa0(%rsp),%r13
  401b10:	00 
  401b11:	4c 8d b4 24 9f 00 00 	lea    0x9f(%rsp),%r14
  401b18:	00 
  401b19:	88 84 24 9f 00 00 00 	mov    %al,0x9f(%rsp)
  401b20:	e9 39 01 00 00       	jmpq   401c5e <printf_core+0x748>
  401b25:	44 89 4c 24 28       	mov    %r9d,0x28(%rsp)
  401b2a:	e8 b1 10 00 00       	callq  402be0 <__errno_location>
  401b2f:	8b 38                	mov    (%rax),%edi
  401b31:	e8 ed 10 00 00       	callq  402c23 <strerror>
  401b36:	4c 63 4c 24 28       	movslq 0x28(%rsp),%r9
  401b3b:	49 89 c6             	mov    %rax,%r14
  401b3e:	eb 14                	jmp    401b54 <printf_core+0x63e>
  401b40:	4c 8b 5c 24 60       	mov    0x60(%rsp),%r11
  401b45:	b8 27 3e 40 00       	mov    $0x403e27,%eax
  401b4a:	4d 85 db             	test   %r11,%r11
  401b4d:	49 0f 45 c3          	cmovne %r11,%rax
  401b51:	49 89 c6             	mov    %rax,%r14
  401b54:	45 85 c9             	test   %r9d,%r9d
  401b57:	be ff ff ff 7f       	mov    $0x7fffffff,%esi
  401b5c:	4c 89 f7             	mov    %r14,%rdi
  401b5f:	49 0f 49 f1          	cmovns %r9,%rsi
  401b63:	44 89 4c 24 28       	mov    %r9d,0x28(%rsp)
  401b68:	e8 63 04 00 00       	callq  401fd0 <strnlen>
  401b6d:	44 8b 4c 24 28       	mov    0x28(%rsp),%r9d
  401b72:	4d 8d 2c 06          	lea    (%r14,%rax,1),%r13
  401b76:	45 85 c9             	test   %r9d,%r9d
  401b79:	79 0b                	jns    401b86 <printf_core+0x670>
  401b7b:	41 80 7d 00 00       	cmpb   $0x0,0x0(%r13)
  401b80:	0f 85 25 02 00 00    	jne    401dab <printf_core+0x895>
  401b86:	41 89 c1             	mov    %eax,%r9d
  401b89:	81 e5 ff ff fe ff    	and    $0xfffeffff,%ebp
  401b8f:	41 ba 1d 3e 40 00    	mov    $0x403e1d,%r10d
  401b95:	e9 c4 00 00 00       	jmpq   401c5e <printf_core+0x748>
  401b9a:	48 8b 44 24 60       	mov    0x60(%rsp),%rax
  401b9f:	c7 44 24 5c 00 00 00 	movl   $0x0,0x5c(%rsp)
  401ba6:	00 
  401ba7:	41 83 c9 ff          	or     $0xffffffff,%r9d
  401bab:	89 44 24 58          	mov    %eax,0x58(%rsp)
  401baf:	48 8d 44 24 58       	lea    0x58(%rsp),%rax
  401bb4:	48 89 44 24 60       	mov    %rax,0x60(%rsp)
  401bb9:	48 8b 5c 24 60       	mov    0x60(%rsp),%rbx
  401bbe:	45 31 ed             	xor    %r13d,%r13d
  401bc1:	4d 63 f1             	movslq %r9d,%r14
  401bc4:	4d 39 f5             	cmp    %r14,%r13
  401bc7:	0f 83 f2 01 00 00    	jae    401dbf <printf_core+0x8a9>
  401bcd:	8b 33                	mov    (%rbx),%esi
  401bcf:	85 f6                	test   %esi,%esi
  401bd1:	0f 84 e8 01 00 00    	je     401dbf <printf_core+0x8a9>
  401bd7:	48 8d 7c 24 4c       	lea    0x4c(%rsp),%rdi
  401bdc:	48 83 c3 04          	add    $0x4,%rbx
  401be0:	e8 7a 12 00 00       	callq  402e5f <wctomb>
  401be5:	85 c0                	test   %eax,%eax
  401be7:	0f 88 c9 01 00 00    	js     401db6 <printf_core+0x8a0>
  401bed:	4c 89 f2             	mov    %r14,%rdx
  401bf0:	48 98                	cltq   
  401bf2:	4c 29 ea             	sub    %r13,%rdx
  401bf5:	48 39 d0             	cmp    %rdx,%rax
  401bf8:	0f 87 c1 01 00 00    	ja     401dbf <printf_core+0x8a9>
  401bfe:	49 01 c5             	add    %rax,%r13
  401c01:	eb c1                	jmp    401bc4 <printf_core+0x6ae>
  401c03:	44 89 c8             	mov    %r9d,%eax
  401c06:	c1 e8 1f             	shr    $0x1f,%eax
  401c09:	74 0a                	je     401c15 <printf_core+0x6ff>
  401c0b:	41 80 e3 01          	and    $0x1,%r11b
  401c0f:	0f 85 96 01 00 00    	jne    401dab <printf_core+0x895>
  401c15:	ff 74 24 68          	pushq  0x68(%rsp)
  401c19:	ff 74 24 68          	pushq  0x68(%rsp)
  401c1d:	44 89 ca             	mov    %r9d,%edx
  401c20:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  401c25:	89 e9                	mov    %ebp,%ecx
  401c27:	44 89 fe             	mov    %r15d,%esi
  401c2a:	e8 75 ed ff ff       	callq  4009a4 <fmt_fp>
  401c2f:	89 c3                	mov    %eax,%ebx
  401c31:	85 db                	test   %ebx,%ebx
  401c33:	58                   	pop    %rax
  401c34:	5a                   	pop    %rdx
  401c35:	0f 89 11 f9 ff ff    	jns    40154c <printf_core+0x36>
  401c3b:	e9 6b 01 00 00       	jmpq   401dab <printf_core+0x895>
  401c40:	41 ba 1d 3e 40 00    	mov    $0x403e1d,%r10d
  401c46:	4c 8d ac 24 a0 00 00 	lea    0xa0(%rsp),%r13
  401c4d:	00 
  401c4e:	eb 0e                	jmp    401c5e <printf_core+0x748>
  401c50:	45 89 e9             	mov    %r13d,%r9d
  401c53:	4c 8d ac 24 a0 00 00 	lea    0xa0(%rsp),%r13
  401c5a:	00 
  401c5b:	4d 89 ee             	mov    %r13,%r14
  401c5e:	49 63 c1             	movslq %r9d,%rax
  401c61:	4d 29 f5             	sub    %r14,%r13
  401c64:	4c 89 54 24 38       	mov    %r10,0x38(%rsp)
  401c69:	4c 39 e8             	cmp    %r13,%rax
  401c6c:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  401c71:	45 0f 4c cd          	cmovl  %r13d,%r9d
  401c75:	29 d8                	sub    %ebx,%eax
  401c77:	41 39 c1             	cmp    %eax,%r9d
  401c7a:	0f 8f 2b 01 00 00    	jg     401dab <printf_core+0x895>
  401c80:	41 8d 04 19          	lea    (%r9,%rbx,1),%eax
  401c84:	44 89 4c 24 30       	mov    %r9d,0x30(%rsp)
  401c89:	41 39 c7             	cmp    %eax,%r15d
  401c8c:	89 44 24 28          	mov    %eax,0x28(%rsp)
  401c90:	44 0f 4c f8          	cmovl  %eax,%r15d
  401c94:	44 3b 7c 24 2c       	cmp    0x2c(%rsp),%r15d
  401c99:	0f 8f 0c 01 00 00    	jg     401dab <printf_core+0x895>
  401c9f:	48 8b 3c 24          	mov    (%rsp),%rdi
  401ca3:	89 c1                	mov    %eax,%ecx
  401ca5:	41 89 e8             	mov    %ebp,%r8d
  401ca8:	44 89 fa             	mov    %r15d,%edx
  401cab:	be 20 00 00 00       	mov    $0x20,%esi
  401cb0:	e8 77 ec ff ff       	callq  40092c <pad>
  401cb5:	4c 8b 54 24 38       	mov    0x38(%rsp),%r10
  401cba:	48 8b 3c 24          	mov    (%rsp),%rdi
  401cbe:	48 63 d3             	movslq %ebx,%rdx
  401cc1:	44 89 fb             	mov    %r15d,%ebx
  401cc4:	4c 89 d6             	mov    %r10,%rsi
  401cc7:	e8 49 ec ff ff       	callq  400915 <out>
  401ccc:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  401cd0:	48 8b 3c 24          	mov    (%rsp),%rdi
  401cd4:	41 89 e8             	mov    %ebp,%r8d
  401cd7:	41 81 f0 00 00 01 00 	xor    $0x10000,%r8d
  401cde:	44 89 fa             	mov    %r15d,%edx
  401ce1:	be 30 00 00 00       	mov    $0x30,%esi
  401ce6:	e8 41 ec ff ff       	callq  40092c <pad>
  401ceb:	44 8b 4c 24 30       	mov    0x30(%rsp),%r9d
  401cf0:	48 8b 3c 24          	mov    (%rsp),%rdi
  401cf4:	45 31 c0             	xor    %r8d,%r8d
  401cf7:	44 89 e9             	mov    %r13d,%ecx
  401cfa:	be 30 00 00 00       	mov    $0x30,%esi
  401cff:	44 89 ca             	mov    %r9d,%edx
  401d02:	e8 25 ec ff ff       	callq  40092c <pad>
  401d07:	48 8b 3c 24          	mov    (%rsp),%rdi
  401d0b:	4c 89 ea             	mov    %r13,%rdx
  401d0e:	4c 89 f6             	mov    %r14,%rsi
  401d11:	e8 ff eb ff ff       	callq  400915 <out>
  401d16:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  401d1a:	48 8b 3c 24          	mov    (%rsp),%rdi
  401d1e:	41 89 e8             	mov    %ebp,%r8d
  401d21:	41 81 f0 00 20 00 00 	xor    $0x2000,%r8d
  401d28:	44 89 fa             	mov    %r15d,%edx
  401d2b:	be 20 00 00 00       	mov    $0x20,%esi
  401d30:	e8 f7 eb ff ff       	callq  40092c <pad>
  401d35:	e9 12 f8 ff ff       	jmpq   40154c <printf_core+0x36>
  401d3a:	48 83 3c 24 00       	cmpq   $0x0,(%rsp)
  401d3f:	0f 85 0c 01 00 00    	jne    401e51 <printf_core+0x93b>
  401d45:	83 7c 24 14 00       	cmpl   $0x0,0x14(%rsp)
  401d4a:	0f 84 37 fb ff ff    	je     401887 <printf_core+0x371>
  401d50:	4c 8b 4c 24 20       	mov    0x20(%rsp),%r9
  401d55:	41 b8 01 00 00 00    	mov    $0x1,%r8d
  401d5b:	49 83 c1 10          	add    $0x10,%r9
  401d5f:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  401d64:	42 8b 34 80          	mov    (%rax,%r8,4),%esi
  401d68:	85 f6                	test   %esi,%esi
  401d6a:	74 2e                	je     401d9a <printf_core+0x884>
  401d6c:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
  401d71:	4c 89 cf             	mov    %r9,%rdi
  401d74:	e8 dc e9 ff ff       	callq  400755 <pop_arg>
  401d79:	49 ff c0             	inc    %r8
  401d7c:	49 83 c1 10          	add    $0x10,%r9
  401d80:	49 83 f8 0a          	cmp    $0xa,%r8
  401d84:	75 d9                	jne    401d5f <printf_core+0x849>
  401d86:	41 bc 01 00 00 00    	mov    $0x1,%r12d
  401d8c:	e9 c0 00 00 00       	jmpq   401e51 <printf_core+0x93b>
  401d91:	49 ff c0             	inc    %r8
  401d94:	49 83 f8 0a          	cmp    $0xa,%r8
  401d98:	74 ec                	je     401d86 <printf_core+0x870>
  401d9a:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  401d9f:	42 83 3c 80 00       	cmpl   $0x0,(%rax,%r8,4)
  401da4:	74 eb                	je     401d91 <printf_core+0x87b>
  401da6:	e9 03 f9 ff ff       	jmpq   4016ae <printf_core+0x198>
  401dab:	e8 30 0e 00 00       	callq  402be0 <__errno_location>
  401db0:	c7 00 4b 00 00 00    	movl   $0x4b,(%rax)
  401db6:	41 83 cc ff          	or     $0xffffffff,%r12d
  401dba:	e9 92 00 00 00       	jmpq   401e51 <printf_core+0x93b>
  401dbf:	49 81 fd ff ff ff 7f 	cmp    $0x7fffffff,%r13
  401dc6:	77 e3                	ja     401dab <printf_core+0x895>
  401dc8:	48 8b 3c 24          	mov    (%rsp),%rdi
  401dcc:	41 89 e8             	mov    %ebp,%r8d
  401dcf:	44 89 e9             	mov    %r13d,%ecx
  401dd2:	44 89 fa             	mov    %r15d,%edx
  401dd5:	be 20 00 00 00       	mov    $0x20,%esi
  401dda:	44 89 6c 24 28       	mov    %r13d,0x28(%rsp)
  401ddf:	45 31 f6             	xor    %r14d,%r14d
  401de2:	e8 45 eb ff ff       	callq  40092c <pad>
  401de7:	48 8b 5c 24 60       	mov    0x60(%rsp),%rbx
  401dec:	4d 39 f5             	cmp    %r14,%r13
  401def:	77 31                	ja     401e22 <printf_core+0x90c>
  401df1:	8b 4c 24 28          	mov    0x28(%rsp),%ecx
  401df5:	48 8b 3c 24          	mov    (%rsp),%rdi
  401df9:	41 89 e8             	mov    %ebp,%r8d
  401dfc:	41 81 f0 00 20 00 00 	xor    $0x2000,%r8d
  401e03:	44 89 fa             	mov    %r15d,%edx
  401e06:	be 20 00 00 00       	mov    $0x20,%esi
  401e0b:	e8 1c eb ff ff       	callq  40092c <pad>
  401e10:	44 3b 7c 24 28       	cmp    0x28(%rsp),%r15d
  401e15:	8b 5c 24 28          	mov    0x28(%rsp),%ebx
  401e19:	41 0f 4d df          	cmovge %r15d,%ebx
  401e1d:	e9 2a f7 ff ff       	jmpq   40154c <printf_core+0x36>
  401e22:	8b 33                	mov    (%rbx),%esi
  401e24:	85 f6                	test   %esi,%esi
  401e26:	74 c9                	je     401df1 <printf_core+0x8db>
  401e28:	48 8d 7c 24 4c       	lea    0x4c(%rsp),%rdi
  401e2d:	48 83 c3 04          	add    $0x4,%rbx
  401e31:	e8 29 10 00 00       	callq  402e5f <wctomb>
  401e36:	48 63 d0             	movslq %eax,%rdx
  401e39:	49 01 d6             	add    %rdx,%r14
  401e3c:	4d 39 f5             	cmp    %r14,%r13
  401e3f:	72 b0                	jb     401df1 <printf_core+0x8db>
  401e41:	48 8b 3c 24          	mov    (%rsp),%rdi
  401e45:	48 8d 74 24 4c       	lea    0x4c(%rsp),%rsi
  401e4a:	e8 c6 ea ff ff       	callq  400915 <out>
  401e4f:	eb 9b                	jmp    401dec <printf_core+0x8d6>
  401e51:	48 81 c4 a8 00 00 00 	add    $0xa8,%rsp
  401e58:	44 89 e0             	mov    %r12d,%eax
  401e5b:	5b                   	pop    %rbx
  401e5c:	5d                   	pop    %rbp
  401e5d:	41 5c                	pop    %r12
  401e5f:	41 5d                	pop    %r13
  401e61:	41 5e                	pop    %r14
  401e63:	41 5f                	pop    %r15
  401e65:	c3                   	retq   

0000000000401e66 <vfprintf>:
  401e66:	41 57                	push   %r15
  401e68:	41 56                	push   %r14
  401e6a:	31 c0                	xor    %eax,%eax
  401e6c:	41 55                	push   %r13
  401e6e:	41 54                	push   %r12
  401e70:	b9 0a 00 00 00       	mov    $0xa,%ecx
  401e75:	55                   	push   %rbp
  401e76:	53                   	push   %rbx
  401e77:	48 89 fb             	mov    %rdi,%rbx
  401e7a:	49 89 f7             	mov    %rsi,%r15
  401e7d:	48 89 d6             	mov    %rdx,%rsi
  401e80:	83 cd ff             	or     $0xffffffff,%ebp
  401e83:	48 81 ec 38 01 00 00 	sub    $0x138,%rsp
  401e8a:	48 8d 7c 24 18       	lea    0x18(%rsp),%rdi
  401e8f:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
  401e94:	48 89 e2             	mov    %rsp,%rdx
  401e97:	f3 ab                	rep stos %eax,%es:(%rdi)
  401e99:	b9 06 00 00 00       	mov    $0x6,%ecx
  401e9e:	48 89 e7             	mov    %rsp,%rdi
  401ea1:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  401ea3:	48 8d 8c 24 90 00 00 	lea    0x90(%rsp),%rcx
  401eaa:	00 
  401eab:	31 ff                	xor    %edi,%edi
  401ead:	4c 89 fe             	mov    %r15,%rsi
  401eb0:	e8 61 f6 ff ff       	callq  401516 <printf_core>
  401eb5:	85 c0                	test   %eax,%eax
  401eb7:	0f 88 fa 00 00 00    	js     401fb7 <vfprintf+0x151>
  401ebd:	8b 83 8c 00 00 00    	mov    0x8c(%rbx),%eax
  401ec3:	45 31 f6             	xor    %r14d,%r14d
  401ec6:	85 c0                	test   %eax,%eax
  401ec8:	78 0b                	js     401ed5 <vfprintf+0x6f>
  401eca:	48 89 df             	mov    %rbx,%rdi
  401ecd:	e8 ea 0f 00 00       	callq  402ebc <__lockfile>
  401ed2:	41 89 c6             	mov    %eax,%r14d
  401ed5:	8b 03                	mov    (%rbx),%eax
  401ed7:	41 89 c4             	mov    %eax,%r12d
  401eda:	41 83 e4 20          	and    $0x20,%r12d
  401ede:	83 bb 88 00 00 00 00 	cmpl   $0x0,0x88(%rbx)
  401ee5:	7f 05                	jg     401eec <vfprintf+0x86>
  401ee7:	83 e0 df             	and    $0xffffffdf,%eax
  401eea:	89 03                	mov    %eax,(%rbx)
  401eec:	45 31 ed             	xor    %r13d,%r13d
  401eef:	48 83 7b 60 00       	cmpq   $0x0,0x60(%rbx)
  401ef4:	75 2d                	jne    401f23 <vfprintf+0xbd>
  401ef6:	48 8d 44 24 40       	lea    0x40(%rsp),%rax
  401efb:	4c 8b 6b 58          	mov    0x58(%rbx),%r13
  401eff:	48 c7 43 60 50 00 00 	movq   $0x50,0x60(%rbx)
  401f06:	00 
  401f07:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  401f0e:	00 
  401f0f:	48 c7 43 38 00 00 00 	movq   $0x0,0x38(%rbx)
  401f16:	00 
  401f17:	48 89 43 58          	mov    %rax,0x58(%rbx)
  401f1b:	48 c7 43 28 00 00 00 	movq   $0x0,0x28(%rbx)
  401f22:	00 
  401f23:	48 83 7b 20 00       	cmpq   $0x0,0x20(%rbx)
  401f28:	74 1f                	je     401f49 <vfprintf+0xe3>
  401f2a:	4c 8d 44 24 18       	lea    0x18(%rsp),%r8
  401f2f:	48 8d 8c 24 90 00 00 	lea    0x90(%rsp),%rcx
  401f36:	00 
  401f37:	48 89 e2             	mov    %rsp,%rdx
  401f3a:	4c 89 fe             	mov    %r15,%rsi
  401f3d:	48 89 df             	mov    %rbx,%rdi
  401f40:	e8 d1 f5 ff ff       	callq  401516 <printf_core>
  401f45:	89 c5                	mov    %eax,%ebp
  401f47:	eb 0f                	jmp    401f58 <vfprintf+0xf2>
  401f49:	48 89 df             	mov    %rbx,%rdi
  401f4c:	e8 c4 11 00 00       	callq  403115 <__towrite>
  401f51:	85 c0                	test   %eax,%eax
  401f53:	74 d5                	je     401f2a <vfprintf+0xc4>
  401f55:	83 cd ff             	or     $0xffffffff,%ebp
  401f58:	4d 85 ed             	test   %r13,%r13
  401f5b:	74 3b                	je     401f98 <vfprintf+0x132>
  401f5d:	31 d2                	xor    %edx,%edx
  401f5f:	31 f6                	xor    %esi,%esi
  401f61:	48 89 df             	mov    %rbx,%rdi
  401f64:	ff 53 48             	callq  *0x48(%rbx)
  401f67:	48 83 7b 28 00       	cmpq   $0x0,0x28(%rbx)
  401f6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  401f71:	4c 89 6b 58          	mov    %r13,0x58(%rbx)
  401f75:	48 c7 43 60 00 00 00 	movq   $0x0,0x60(%rbx)
  401f7c:	00 
  401f7d:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  401f84:	00 
  401f85:	48 c7 43 38 00 00 00 	movq   $0x0,0x38(%rbx)
  401f8c:	00 
  401f8d:	48 c7 43 28 00 00 00 	movq   $0x0,0x28(%rbx)
  401f94:	00 
  401f95:	0f 44 e8             	cmove  %eax,%ebp
  401f98:	8b 03                	mov    (%rbx),%eax
  401f9a:	ba ff ff ff ff       	mov    $0xffffffff,%edx
  401f9f:	a8 20                	test   $0x20,%al
  401fa1:	0f 45 ea             	cmovne %edx,%ebp
  401fa4:	41 09 c4             	or     %eax,%r12d
  401fa7:	45 85 f6             	test   %r14d,%r14d
  401faa:	44 89 23             	mov    %r12d,(%rbx)
  401fad:	74 08                	je     401fb7 <vfprintf+0x151>
  401faf:	48 89 df             	mov    %rbx,%rdi
  401fb2:	e8 ba 0f 00 00       	callq  402f71 <__unlockfile>
  401fb7:	48 81 c4 38 01 00 00 	add    $0x138,%rsp
  401fbe:	89 e8                	mov    %ebp,%eax
  401fc0:	5b                   	pop    %rbx
  401fc1:	5d                   	pop    %rbp
  401fc2:	41 5c                	pop    %r12
  401fc4:	41 5d                	pop    %r13
  401fc6:	41 5e                	pop    %r14
  401fc8:	41 5f                	pop    %r15
  401fca:	c3                   	retq   
  401fcb:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)

0000000000401fd0 <strnlen>:
  401fd0:	55                   	push   %rbp
  401fd1:	53                   	push   %rbx
  401fd2:	48 89 f2             	mov    %rsi,%rdx
  401fd5:	48 89 f3             	mov    %rsi,%rbx
  401fd8:	31 f6                	xor    %esi,%esi
  401fda:	48 89 fd             	mov    %rdi,%rbp
  401fdd:	48 83 ec 08          	sub    $0x8,%rsp
  401fe1:	e8 da 12 00 00       	callq  4032c0 <memchr>
  401fe6:	48 89 c2             	mov    %rax,%rdx
  401fe9:	48 29 ea             	sub    %rbp,%rdx
  401fec:	48 85 c0             	test   %rax,%rax
  401fef:	48 89 d8             	mov    %rbx,%rax
  401ff2:	48 0f 45 c2          	cmovne %rdx,%rax
  401ff6:	48 83 c4 08          	add    $0x8,%rsp
  401ffa:	5b                   	pop    %rbx
  401ffb:	5d                   	pop    %rbp
  401ffc:	c3                   	retq   

0000000000401ffd <memset>:
  401ffd:	48 0f b6 c6          	movzbq %sil,%rax
  402001:	49 b8 01 01 01 01 01 	movabs $0x101010101010101,%r8
  402008:	01 01 01 
  40200b:	49 0f af c0          	imul   %r8,%rax
  40200f:	48 83 fa 7e          	cmp    $0x7e,%rdx
  402013:	77 78                	ja     40208d <memset+0x90>
  402015:	85 d2                	test   %edx,%edx
  402017:	74 70                	je     402089 <memset+0x8c>
  402019:	40 88 37             	mov    %sil,(%rdi)
  40201c:	40 88 74 17 ff       	mov    %sil,-0x1(%rdi,%rdx,1)
  402021:	83 fa 02             	cmp    $0x2,%edx
  402024:	76 63                	jbe    402089 <memset+0x8c>
  402026:	66 89 47 01          	mov    %ax,0x1(%rdi)
  40202a:	66 89 44 17 fd       	mov    %ax,-0x3(%rdi,%rdx,1)
  40202f:	83 fa 06             	cmp    $0x6,%edx
  402032:	76 55                	jbe    402089 <memset+0x8c>
  402034:	89 47 03             	mov    %eax,0x3(%rdi)
  402037:	89 44 17 f9          	mov    %eax,-0x7(%rdi,%rdx,1)
  40203b:	83 fa 0e             	cmp    $0xe,%edx
  40203e:	76 49                	jbe    402089 <memset+0x8c>
  402040:	48 89 47 07          	mov    %rax,0x7(%rdi)
  402044:	48 89 44 17 f1       	mov    %rax,-0xf(%rdi,%rdx,1)
  402049:	83 fa 1e             	cmp    $0x1e,%edx
  40204c:	76 3b                	jbe    402089 <memset+0x8c>
  40204e:	48 89 47 0f          	mov    %rax,0xf(%rdi)
  402052:	48 89 47 17          	mov    %rax,0x17(%rdi)
  402056:	48 89 44 17 e1       	mov    %rax,-0x1f(%rdi,%rdx,1)
  40205b:	48 89 44 17 e9       	mov    %rax,-0x17(%rdi,%rdx,1)
  402060:	83 fa 3e             	cmp    $0x3e,%edx
  402063:	76 24                	jbe    402089 <memset+0x8c>
  402065:	48 89 47 1f          	mov    %rax,0x1f(%rdi)
  402069:	48 89 47 27          	mov    %rax,0x27(%rdi)
  40206d:	48 89 47 2f          	mov    %rax,0x2f(%rdi)
  402071:	48 89 47 37          	mov    %rax,0x37(%rdi)
  402075:	48 89 44 17 c1       	mov    %rax,-0x3f(%rdi,%rdx,1)
  40207a:	48 89 44 17 c9       	mov    %rax,-0x37(%rdi,%rdx,1)
  40207f:	48 89 44 17 d1       	mov    %rax,-0x2f(%rdi,%rdx,1)
  402084:	48 89 44 17 d9       	mov    %rax,-0x27(%rdi,%rdx,1)
  402089:	48 89 f8             	mov    %rdi,%rax
  40208c:	c3                   	retq   
  40208d:	f7 c7 0f 00 00 00    	test   $0xf,%edi
  402093:	49 89 f8             	mov    %rdi,%r8
  402096:	48 89 44 17 f8       	mov    %rax,-0x8(%rdi,%rdx,1)
  40209b:	48 89 d1             	mov    %rdx,%rcx
  40209e:	75 0b                	jne    4020ab <memset+0xae>
  4020a0:	48 c1 e9 03          	shr    $0x3,%rcx
  4020a4:	f3 48 ab             	rep stos %rax,%es:(%rdi)
  4020a7:	4c 89 c0             	mov    %r8,%rax
  4020aa:	c3                   	retq   
  4020ab:	31 d2                	xor    %edx,%edx
  4020ad:	29 fa                	sub    %edi,%edx
  4020af:	83 e2 0f             	and    $0xf,%edx
  4020b2:	48 89 07             	mov    %rax,(%rdi)
  4020b5:	48 89 47 08          	mov    %rax,0x8(%rdi)
  4020b9:	48 29 d1             	sub    %rdx,%rcx
  4020bc:	48 01 d7             	add    %rdx,%rdi
  4020bf:	eb df                	jmp    4020a0 <memset+0xa3>

00000000004020c1 <__start_sched>:
  4020c1:	31 c0                	xor    %eax,%eax
  4020c3:	c3                   	retq   

00000000004020c4 <init_file_lock>:
  4020c4:	48 85 ff             	test   %rdi,%rdi
  4020c7:	74 14                	je     4020dd <init_file_lock+0x19>
  4020c9:	8b 87 8c 00 00 00    	mov    0x8c(%rdi),%eax
  4020cf:	85 c0                	test   %eax,%eax
  4020d1:	79 0a                	jns    4020dd <init_file_lock+0x19>
  4020d3:	c7 87 8c 00 00 00 00 	movl   $0x0,0x8c(%rdi)
  4020da:	00 00 00 
  4020dd:	c3                   	retq   

00000000004020de <__acquire_ptc>:
  4020de:	c3                   	retq   

00000000004020df <__pthread_exit>:
  4020df:	41 57                	push   %r15
  4020e1:	41 56                	push   %r14
  4020e3:	41 55                	push   %r13
  4020e5:	41 54                	push   %r12
  4020e7:	55                   	push   %rbp
  4020e8:	53                   	push   %rbx
  4020e9:	64 48 8b 1c 25 00 00 	mov    %fs:0x0,%rbx
  4020f0:	00 00 
  4020f2:	48 81 ec 88 00 00 00 	sub    $0x88,%rsp
  4020f9:	c6 43 48 01          	movb   $0x1,0x48(%rbx)
  4020fd:	48 89 bb 88 00 00 00 	mov    %rdi,0x88(%rbx)
  402104:	c6 43 49 00          	movb   $0x0,0x49(%rbx)
  402108:	48 8b 83 90 00 00 00 	mov    0x90(%rbx),%rax
  40210f:	48 85 c0             	test   %rax,%rax
  402112:	74 16                	je     40212a <__pthread_exit+0x4b>
  402114:	48 8b 10             	mov    (%rax),%rdx
  402117:	48 8b 78 08          	mov    0x8(%rax),%rdi
  40211b:	48 8b 40 10          	mov    0x10(%rax),%rax
  40211f:	48 89 83 90 00 00 00 	mov    %rax,0x90(%rbx)
  402126:	ff d2                	callq  *%rdx
  402128:	eb de                	jmp    402108 <__pthread_exit+0x29>
  40212a:	48 8d ab c8 00 00 00 	lea    0xc8(%rbx),%rbp
  402131:	e8 a8 ff ff ff       	callq  4020de <__acquire_ptc>
  402136:	48 89 ef             	mov    %rbp,%rdi
  402139:	e8 a1 12 00 00       	callq  4033df <__lock>
  40213e:	48 89 e7             	mov    %rsp,%rdi
  402141:	e8 2e 0d 00 00       	callq  402e74 <__block_all_sigs>
  402146:	83 c8 ff             	or     $0xffffffff,%eax
  402149:	f0 0f c1 05 9b 37 20 	lock xadd %eax,0x20379b(%rip)        # 6058ec <__libc+0xc>
  402150:	00 
  402151:	85 c0                	test   %eax,%eax
  402153:	75 21                	jne    402176 <__pthread_exit+0x97>
  402155:	48 89 ef             	mov    %rbp,%rdi
  402158:	c7 05 8a 37 20 00 00 	movl   $0x0,0x20378a(%rip)        # 6058ec <__libc+0xc>
  40215f:	00 00 00 
  402162:	e8 1c 13 00 00       	callq  403483 <__unlock>
  402167:	48 89 e7             	mov    %rsp,%rdi
  40216a:	e8 35 0d 00 00       	callq  402ea4 <__restore_sigs>
  40216f:	31 ff                	xor    %edi,%edi
  402171:	e8 ba df ff ff       	callq  400130 <exit>
  402176:	e8 79 07 00 00       	callq  4028f4 <__vm_lock>
  40217b:	4c 8d 8b a0 00 00 00 	lea    0xa0(%rbx),%r9
  402182:	41 ba 00 00 00 40    	mov    $0x40000000,%r10d
  402188:	41 bc 80 00 00 00    	mov    $0x80,%r12d
  40218e:	41 bd ca 00 00 00    	mov    $0xca,%r13d
  402194:	41 be 01 00 00 00    	mov    $0x1,%r14d
  40219a:	41 bf ca 00 00 00    	mov    $0xca,%r15d
  4021a0:	41 b8 01 00 00 00    	mov    $0x1,%r8d
  4021a6:	48 8b 83 a0 00 00 00 	mov    0xa0(%rbx),%rax
  4021ad:	48 85 c0             	test   %rax,%rax
  4021b0:	74 67                	je     402219 <__pthread_exit+0x13a>
  4021b2:	4c 39 c8             	cmp    %r9,%rax
  4021b5:	74 62                	je     402219 <__pthread_exit+0x13a>
  4021b7:	8b 48 e8             	mov    -0x18(%rax),%ecx
  4021ba:	8b 70 e0             	mov    -0x20(%rax),%esi
  4021bd:	48 8d 78 e4          	lea    -0x1c(%rax),%rdi
  4021c1:	48 89 83 b0 00 00 00 	mov    %rax,0xb0(%rbx)
  4021c8:	48 8b 10             	mov    (%rax),%rdx
  4021cb:	48 89 93 a0 00 00 00 	mov    %rdx,0xa0(%rbx)
  4021d2:	44 89 d2             	mov    %r10d,%edx
  4021d5:	87 50 e4             	xchg   %edx,-0x1c(%rax)
  4021d8:	c1 ea 1f             	shr    $0x1f,%edx
  4021db:	48 c7 83 b0 00 00 00 	movq   $0x0,0xb0(%rbx)
  4021e2:	00 00 00 00 
  4021e6:	75 04                	jne    4021ec <__pthread_exit+0x10d>
  4021e8:	85 c9                	test   %ecx,%ecx
  4021ea:	74 ba                	je     4021a6 <__pthread_exit+0xc7>
  4021ec:	f7 d6                	not    %esi
  4021ee:	4c 89 e8             	mov    %r13,%rax
  4021f1:	4c 89 f2             	mov    %r14,%rdx
  4021f4:	81 e6 80 00 00 00    	and    $0x80,%esi
  4021fa:	41 0f 45 f4          	cmovne %r12d,%esi
  4021fe:	83 ce 01             	or     $0x1,%esi
  402201:	48 63 f6             	movslq %esi,%rsi
  402204:	0f 05                	syscall 
  402206:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  40220a:	75 9a                	jne    4021a6 <__pthread_exit+0xc7>
  40220c:	4c 89 f8             	mov    %r15,%rax
  40220f:	4c 89 c6             	mov    %r8,%rsi
  402212:	4c 89 c2             	mov    %r8,%rdx
  402215:	0f 05                	syscall 
  402217:	eb 8d                	jmp    4021a6 <__pthread_exit+0xc7>
  402219:	e8 de 06 00 00       	callq  4028fc <__vm_unlock>
  40221e:	e8 bb fe ff ff       	callq  4020de <__acquire_ptc>
  402223:	e8 b6 fe ff ff       	callq  4020de <__acquire_ptc>
  402228:	ba 01 00 00 00       	mov    $0x1,%edx
  40222d:	b8 02 00 00 00       	mov    $0x2,%eax
  402232:	f0 0f b1 53 40       	lock cmpxchg %edx,0x40(%rbx)
  402237:	83 f8 02             	cmp    $0x2,%eax
  40223a:	7e 3f                	jle    40227b <__pthread_exit+0x19c>
  40223c:	48 83 7b 50 00       	cmpq   $0x0,0x50(%rbx)
  402241:	74 38                	je     40227b <__pthread_exit+0x19c>
  402243:	83 f8 04             	cmp    $0x4,%eax
  402246:	75 09                	jne    402251 <__pthread_exit+0x172>
  402248:	31 ff                	xor    %edi,%edi
  40224a:	b8 da 00 00 00       	mov    $0xda,%eax
  40224f:	0f 05                	syscall 
  402251:	48 83 bb a8 00 00 00 	cmpq   $0x0,0xa8(%rbx)
  402258:	00 
  402259:	74 0e                	je     402269 <__pthread_exit+0x18a>
  40225b:	be 18 00 00 00       	mov    $0x18,%esi
  402260:	31 ff                	xor    %edi,%edi
  402262:	b8 11 01 00 00       	mov    $0x111,%eax
  402267:	0f 05                	syscall 
  402269:	e8 57 06 00 00       	callq  4028c5 <__vm_wait>
  40226e:	48 8b 73 58          	mov    0x58(%rbx),%rsi
  402272:	48 8b 7b 50          	mov    0x50(%rbx),%rdi
  402276:	e8 c5 06 00 00       	callq  402940 <__unmapself>
  40227b:	48 89 ef             	mov    %rbp,%rdi
  40227e:	c7 43 38 00 00 00 00 	movl   $0x0,0x38(%rbx)
  402285:	e8 f9 11 00 00       	callq  403483 <__unlock>
  40228a:	ba 3c 00 00 00       	mov    $0x3c,%edx
  40228f:	31 ff                	xor    %edi,%edi
  402291:	48 89 d0             	mov    %rdx,%rax
  402294:	0f 05                	syscall 
  402296:	eb f9                	jmp    402291 <__pthread_exit+0x1b2>

0000000000402298 <start>:
  402298:	48 83 ec 18          	sub    $0x18,%rsp
  40229c:	f6 47 4a 02          	testb  $0x2,0x4a(%rdi)
  4022a0:	49 89 f8             	mov    %rdi,%r8
  4022a3:	74 28                	je     4022cd <start+0x35>
  4022a5:	48 b8 00 00 00 00 03 	movabs $0x300000000,%rax
  4022ac:	00 00 00 
  4022af:	48 8d 74 24 08       	lea    0x8(%rsp),%rsi
  4022b4:	41 ba 08 00 00 00    	mov    $0x8,%r10d
  4022ba:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  4022bf:	31 d2                	xor    %edx,%edx
  4022c1:	bf 01 00 00 00       	mov    $0x1,%edi
  4022c6:	b8 0e 00 00 00       	mov    $0xe,%eax
  4022cb:	0f 05                	syscall 
  4022cd:	49 8b 78 78          	mov    0x78(%r8),%rdi
  4022d1:	41 ff 90 80 00 00 00 	callq  *0x80(%r8)
  4022d8:	48 89 c7             	mov    %rax,%rdi
  4022db:	e8 ff fd ff ff       	callq  4020df <__pthread_exit>

00000000004022e0 <start_c11>:
  4022e0:	48 89 f8             	mov    %rdi,%rax
  4022e3:	48 83 ec 08          	sub    $0x8,%rsp
  4022e7:	48 8b 7f 78          	mov    0x78(%rdi),%rdi
  4022eb:	ff 90 80 00 00 00    	callq  *0x80(%rax)
  4022f1:	48 63 f8             	movslq %eax,%rdi
  4022f4:	e8 e6 fd ff ff       	callq  4020df <__pthread_exit>

00000000004022f9 <__do_cleanup_push>:
  4022f9:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
  402300:	00 00 
  402302:	48 8b 90 90 00 00 00 	mov    0x90(%rax),%rdx
  402309:	48 89 57 10          	mov    %rdx,0x10(%rdi)
  40230d:	48 89 b8 90 00 00 00 	mov    %rdi,0x90(%rax)
  402314:	c3                   	retq   

0000000000402315 <__do_cleanup_pop>:
  402315:	48 8b 57 10          	mov    0x10(%rdi),%rdx
  402319:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
  402320:	00 00 
  402322:	48 89 90 90 00 00 00 	mov    %rdx,0x90(%rax)
  402329:	c3                   	retq   

000000000040232a <__pthread_create>:
  40232a:	41 57                	push   %r15
  40232c:	41 56                	push   %r14
  40232e:	31 c0                	xor    %eax,%eax
  402330:	41 55                	push   %r13
  402332:	41 54                	push   %r12
  402334:	49 89 f8             	mov    %rdi,%r8
  402337:	55                   	push   %rbp
  402338:	53                   	push   %rbx
  402339:	49 89 c9             	mov    %rcx,%r9
  40233c:	b9 0e 00 00 00       	mov    $0xe,%ecx
  402341:	48 81 ec 18 01 00 00 	sub    $0x118,%rsp
  402348:	83 3d 91 35 20 00 00 	cmpl   $0x0,0x203591(%rip)        # 6058e0 <__libc>
  40234f:	48 8d 7c 24 38       	lea    0x38(%rsp),%rdi
  402354:	f3 ab                	rep stos %eax,%es:(%rdi)
  402356:	b8 26 00 00 00       	mov    $0x26,%eax
  40235b:	0f 84 57 04 00 00    	je     4027b8 <__pthread_create+0x48e>
  402361:	64 4c 8b 3c 25 00 00 	mov    %fs:0x0,%r15
  402368:	00 00 
  40236a:	83 3d 73 35 20 00 00 	cmpl   $0x0,0x203573(%rip)        # 6058e4 <__libc+0x4>
  402371:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
  402376:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  40237b:	48 89 34 24          	mov    %rsi,(%rsp)
  40237f:	4c 89 44 24 20       	mov    %r8,0x20(%rsp)
  402384:	0f 85 82 00 00 00    	jne    40240c <__pthread_create+0xe2>
  40238a:	e8 06 0f 00 00       	callq  403295 <__ofl_lock>
  40238f:	48 8b 18             	mov    (%rax),%rbx
  402392:	48 85 db             	test   %rbx,%rbx
  402395:	74 0e                	je     4023a5 <__pthread_create+0x7b>
  402397:	48 89 df             	mov    %rbx,%rdi
  40239a:	e8 25 fd ff ff       	callq  4020c4 <init_file_lock>
  40239f:	48 8b 5b 70          	mov    0x70(%rbx),%rbx
  4023a3:	eb ed                	jmp    402392 <__pthread_create+0x68>
  4023a5:	e8 00 0f 00 00       	callq  4032aa <__ofl_unlock>
  4023aa:	48 8b 3d f7 32 20 00 	mov    0x2032f7(%rip),%rdi        # 6056a8 <__stdin_used>
  4023b1:	e8 0e fd ff ff       	callq  4020c4 <init_file_lock>
  4023b6:	48 8b 3d 4b 2d 20 00 	mov    0x202d4b(%rip),%rdi        # 605108 <__stdout_used>
  4023bd:	e8 02 fd ff ff       	callq  4020c4 <init_file_lock>
  4023c2:	48 8b 3d 3f 2c 20 00 	mov    0x202c3f(%rip),%rdi        # 605008 <__stderr_used>
  4023c9:	e8 f6 fc ff ff       	callq  4020c4 <init_file_lock>
  4023ce:	48 b8 00 00 00 00 03 	movabs $0x300000000,%rax
  4023d5:	00 00 00 
  4023d8:	48 8d 74 24 30       	lea    0x30(%rsp),%rsi
  4023dd:	41 ba 08 00 00 00    	mov    $0x8,%r10d
  4023e3:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  4023e8:	bf 01 00 00 00       	mov    $0x1,%edi
  4023ed:	b8 0e 00 00 00       	mov    $0xe,%eax
  4023f2:	48 89 da             	mov    %rbx,%rdx
  4023f5:	0f 05                	syscall 
  4023f7:	c7 05 e3 34 20 00 01 	movl   $0x1,0x2034e3(%rip)        # 6058e4 <__libc+0x4>
  4023fe:	00 00 00 
  402401:	49 c7 87 98 00 00 00 	movq   $0x6056b8,0x98(%r15)
  402408:	b8 56 60 00 
  40240c:	48 8b 04 24          	mov    (%rsp),%rax
  402410:	48 8d 58 ff          	lea    -0x1(%rax),%rbx
  402414:	48 83 fb fd          	cmp    $0xfffffffffffffffd,%rbx
  402418:	77 0f                	ja     402429 <__pthread_create+0xff>
  40241a:	b9 0e 00 00 00       	mov    $0xe,%ecx
  40241f:	48 8d 7c 24 38       	lea    0x38(%rsp),%rdi
  402424:	48 89 c6             	mov    %rax,%rsi
  402427:	f3 a5                	rep movsl %ds:(%rsi),%es:(%rdi)
  402429:	e8 b0 fc ff ff       	callq  4020de <__acquire_ptc>
  40242e:	48 83 fb fd          	cmp    $0xfffffffffffffffd,%rbx
  402432:	76 16                	jbe    40244a <__pthread_create+0x120>
  402434:	8b 05 d2 2d 20 00    	mov    0x202dd2(%rip),%eax        # 60520c <__default_stacksize>
  40243a:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  40243f:	8b 05 c3 2d 20 00    	mov    0x202dc3(%rip),%eax        # 605208 <__default_guardsize>
  402445:	48 89 44 24 40       	mov    %rax,0x40(%rsp)
  40244a:	8b 05 60 32 20 00    	mov    0x203260(%rip),%eax        # 6056b0 <__block_new_threads>
  402450:	85 c0                	test   %eax,%eax
  402452:	74 16                	je     40246a <__pthread_create+0x140>
  402454:	b9 01 00 00 00       	mov    $0x1,%ecx
  402459:	ba 01 00 00 00       	mov    $0x1,%edx
  40245e:	31 f6                	xor    %esi,%esi
  402460:	bf b0 56 60 00       	mov    $0x6056b0,%edi
  402465:	e8 c2 11 00 00       	callq  40362c <__wait>
  40246a:	48 8b 4c 24 48       	mov    0x48(%rsp),%rcx
  40246f:	48 8b 05 8a 34 20 00 	mov    0x20348a(%rip),%rax        # 605900 <__libc+0x20>
  402476:	48 8b 6c 24 38       	mov    0x38(%rsp),%rbp
  40247b:	48 85 c9             	test   %rcx,%rcx
  40247e:	74 76                	je     4024f6 <__pthread_create+0x1cc>
  402480:	48 8b 15 39 32 20 00 	mov    0x203239(%rip),%rdx        # 6056c0 <__pthread_tsd_size>
  402487:	49 89 ce             	mov    %rcx,%r14
  40248a:	48 29 e9             	sub    %rbp,%rcx
  40248d:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  402492:	48 89 e9             	mov    %rbp,%rcx
  402495:	49 83 e6 f0          	and    $0xfffffffffffffff0,%r14
  402499:	48 c1 e9 03          	shr    $0x3,%rcx
  40249d:	48 01 c2             	add    %rax,%rdx
  4024a0:	48 39 ca             	cmp    %rcx,%rdx
  4024a3:	73 3e                	jae    4024e3 <__pthread_create+0x1b9>
  4024a5:	48 81 fa ff 07 00 00 	cmp    $0x7ff,%rdx
  4024ac:	77 35                	ja     4024e3 <__pthread_create+0x1b9>
  4024ae:	48 8b 0d 0b 32 20 00 	mov    0x20320b(%rip),%rcx        # 6056c0 <__pthread_tsd_size>
  4024b5:	31 f6                	xor    %esi,%esi
  4024b7:	49 29 ce             	sub    %rcx,%r14
  4024ba:	4c 89 74 24 28       	mov    %r14,0x28(%rsp)
  4024bf:	49 29 c6             	sub    %rax,%r14
  4024c2:	4c 89 f7             	mov    %r14,%rdi
  4024c5:	e8 33 fb ff ff       	callq  401ffd <memset>
  4024ca:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  4024cf:	48 85 c9             	test   %rcx,%rcx
  4024d2:	0f 84 ae 00 00 00    	je     402586 <__pthread_create+0x25c>
  4024d8:	45 31 ed             	xor    %r13d,%r13d
  4024db:	45 31 e4             	xor    %r12d,%r12d
  4024de:	e9 f6 00 00 00       	jmpq   4025d9 <__pthread_create+0x2af>
  4024e3:	48 8d aa ff 0f 00 00 	lea    0xfff(%rdx),%rbp
  4024ea:	48 81 e5 00 f0 ff ff 	and    $0xfffffffffffff000,%rbp
  4024f1:	e9 90 00 00 00       	jmpq   402586 <__pthread_create+0x25c>
  4024f6:	48 8b 74 24 40       	mov    0x40(%rsp),%rsi
  4024fb:	48 8b 15 be 31 20 00 	mov    0x2031be(%rip),%rdx        # 6056c0 <__pthread_tsd_size>
  402502:	48 8d 9c 28 ff 0f 00 	lea    0xfff(%rax,%rbp,1),%rbx
  402509:	00 
  40250a:	4c 8d ae ff 0f 00 00 	lea    0xfff(%rsi),%r13
  402511:	48 01 d3             	add    %rdx,%rbx
  402514:	48 81 e3 00 f0 ff ff 	and    $0xfffffffffffff000,%rbx
  40251b:	49 81 e5 00 f0 ff ff 	and    $0xfffffffffffff000,%r13
  402522:	4d 85 ed             	test   %r13,%r13
  402525:	49 8d 6c 1d 00       	lea    0x0(%r13,%rbx,1),%rbp
  40252a:	74 57                	je     402583 <__pthread_create+0x259>
  40252c:	45 31 c9             	xor    %r9d,%r9d
  40252f:	41 83 c8 ff          	or     $0xffffffff,%r8d
  402533:	31 d2                	xor    %edx,%edx
  402535:	31 ff                	xor    %edi,%edi
  402537:	b9 22 00 00 00       	mov    $0x22,%ecx
  40253c:	48 89 ee             	mov    %rbp,%rsi
  40253f:	e8 04 08 00 00       	callq  402d48 <__mmap>
  402544:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  402548:	49 89 c4             	mov    %rax,%r12
  40254b:	0f 84 54 02 00 00    	je     4027a5 <__pthread_create+0x47b>
  402551:	4a 8d 3c 28          	lea    (%rax,%r13,1),%rdi
  402555:	ba 03 00 00 00       	mov    $0x3,%edx
  40255a:	48 89 de             	mov    %rbx,%rsi
  40255d:	45 31 f6             	xor    %r14d,%r14d
  402560:	e8 93 08 00 00       	callq  402df8 <__mprotect>
  402565:	85 c0                	test   %eax,%eax
  402567:	74 48                	je     4025b1 <__pthread_create+0x287>
  402569:	e8 72 06 00 00       	callq  402be0 <__errno_location>
  40256e:	83 38 26             	cmpl   $0x26,(%rax)
  402571:	74 3e                	je     4025b1 <__pthread_create+0x287>
  402573:	48 89 ee             	mov    %rbp,%rsi
  402576:	4c 89 e7             	mov    %r12,%rdi
  402579:	e8 b2 08 00 00       	callq  402e30 <__munmap>
  40257e:	e9 22 02 00 00       	jmpq   4027a5 <__pthread_create+0x47b>
  402583:	45 31 f6             	xor    %r14d,%r14d
  402586:	45 31 c9             	xor    %r9d,%r9d
  402589:	41 83 c8 ff          	or     $0xffffffff,%r8d
  40258d:	31 ff                	xor    %edi,%edi
  40258f:	b9 22 00 00 00       	mov    $0x22,%ecx
  402594:	ba 03 00 00 00       	mov    $0x3,%edx
  402599:	48 89 ee             	mov    %rbp,%rsi
  40259c:	e8 a7 07 00 00       	callq  402d48 <__mmap>
  4025a1:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  4025a5:	49 89 c4             	mov    %rax,%r12
  4025a8:	0f 84 f7 01 00 00    	je     4027a5 <__pthread_create+0x47b>
  4025ae:	45 31 ed             	xor    %r13d,%r13d
  4025b1:	48 8b 05 08 31 20 00 	mov    0x203108(%rip),%rax        # 6056c0 <__pthread_tsd_size>
  4025b8:	48 89 e9             	mov    %rbp,%rcx
  4025bb:	48 29 c1             	sub    %rax,%rcx
  4025be:	4c 01 e1             	add    %r12,%rcx
  4025c1:	4d 85 f6             	test   %r14,%r14
  4025c4:	75 13                	jne    4025d9 <__pthread_create+0x2af>
  4025c6:	49 89 ce             	mov    %rcx,%r14
  4025c9:	4c 2b 35 30 33 20 00 	sub    0x203330(%rip),%r14        # 605900 <__libc+0x20>
  4025d0:	4b 8d 04 2c          	lea    (%r12,%r13,1),%rax
  4025d4:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  4025d9:	48 89 cf             	mov    %rcx,%rdi
  4025dc:	48 2b 3d 1d 33 20 00 	sub    0x20331d(%rip),%rdi        # 605900 <__libc+0x20>
  4025e3:	48 89 4c 24 28       	mov    %rcx,0x28(%rsp)
  4025e8:	e8 f0 03 00 00       	callq  4029dd <__copy_tls>
  4025ed:	48 89 c3             	mov    %rax,%rbx
  4025f0:	4c 89 60 50          	mov    %r12,0x50(%rax)
  4025f4:	48 89 68 58          	mov    %rbp,0x58(%rax)
  4025f8:	4c 89 70 60          	mov    %r14,0x60(%rax)
  4025fc:	4c 89 f0             	mov    %r14,%rax
  4025ff:	48 2b 44 24 08       	sub    0x8(%rsp),%rax
  402604:	48 89 1b             	mov    %rbx,(%rbx)
  402607:	83 7c 24 50 00       	cmpl   $0x0,0x50(%rsp)
  40260c:	48 8b 4c 24 28       	mov    0x28(%rsp),%rcx
  402611:	4c 89 6b 70          	mov    %r13,0x70(%rbx)
  402615:	48 c7 83 c0 00 00 00 	movq   $0x605920,0xc0(%rbx)
  40261c:	20 59 60 00 
  402620:	48 89 43 68          	mov    %rax,0x68(%rbx)
  402624:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  402629:	48 89 8b 98 00 00 00 	mov    %rcx,0x98(%rbx)
  402630:	48 89 83 80 00 00 00 	mov    %rax,0x80(%rbx)
  402637:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  40263c:	48 89 43 78          	mov    %rax,0x78(%rbx)
  402640:	74 0e                	je     402650 <__pthread_create+0x326>
  402642:	c7 43 40 03 00 00 00 	movl   $0x3,0x40(%rbx)
  402649:	ba 00 0f 5d 00       	mov    $0x5d0f00,%edx
  40264e:	eb 0c                	jmp    40265c <__pthread_create+0x332>
  402650:	c7 43 40 02 00 00 00 	movl   $0x2,0x40(%rbx)
  402657:	ba 00 0f 7d 00       	mov    $0x7d0f00,%edx
  40265c:	44 8b 6c 24 54       	mov    0x54(%rsp),%r13d
  402661:	45 85 ed             	test   %r13d,%r13d
  402664:	74 5b                	je     4026c1 <__pthread_create+0x397>
  402666:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
  40266b:	48 8d 7c 24 70       	lea    0x70(%rsp),%rdi
  402670:	c7 84 24 08 01 00 00 	movl   $0xffffffff,0x108(%rsp)
  402677:	ff ff ff ff 
  40267b:	89 54 24 08          	mov    %edx,0x8(%rsp)
  40267f:	41 bd 01 00 00 00    	mov    $0x1,%r13d
  402685:	48 89 44 24 78       	mov    %rax,0x78(%rsp)
  40268a:	48 8b 44 24 18       	mov    0x18(%rsp),%rax
  40268f:	48 89 44 24 70       	mov    %rax,0x70(%rsp)
  402694:	48 8d 44 24 38       	lea    0x38(%rsp),%rax
  402699:	48 89 84 24 00 01 00 	mov    %rax,0x100(%rsp)
  4026a0:	00 
  4026a1:	48 89 7b 78          	mov    %rdi,0x78(%rbx)
  4026a5:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
  4026ac:	00 
  4026ad:	48 c7 83 80 00 00 00 	movq   $0x4020c1,0x80(%rbx)
  4026b4:	c1 20 40 00 
  4026b8:	e8 cf 07 00 00       	callq  402e8c <__block_app_sigs>
  4026bd:	8b 54 24 08          	mov    0x8(%rsp),%edx
  4026c1:	48 8d 83 a0 00 00 00 	lea    0xa0(%rbx),%rax
  4026c8:	48 89 83 a0 00 00 00 	mov    %rax,0xa0(%rbx)
  4026cf:	41 8b 47 44          	mov    0x44(%r15),%eax
  4026d3:	83 e0 01             	and    $0x1,%eax
  4026d6:	8d 0c 00             	lea    (%rax,%rax,1),%ecx
  4026d9:	8a 43 4a             	mov    0x4a(%rbx),%al
  4026dc:	83 e0 fd             	and    $0xfffffffd,%eax
  4026df:	09 c8                	or     %ecx,%eax
  4026e1:	88 43 4a             	mov    %al,0x4a(%rbx)
  4026e4:	49 8b 47 28          	mov    0x28(%r15),%rax
  4026e8:	48 89 43 28          	mov    %rax,0x28(%rbx)
  4026ec:	f0 ff 05 f9 31 20 00 	lock incl 0x2031f9(%rip)        # 6058ec <__libc+0xc>
  4026f3:	48 83 3c 24 ff       	cmpq   $0xffffffffffffffff,(%rsp)
  4026f8:	48 8d 43 40          	lea    0x40(%rbx),%rax
  4026fc:	b9 e0 22 40 00       	mov    $0x4022e0,%ecx
  402701:	bf 98 22 40 00       	mov    $0x402298,%edi
  402706:	4c 8d 43 38          	lea    0x38(%rbx),%r8
  40270a:	4c 89 f6             	mov    %r14,%rsi
  40270d:	49 89 d9             	mov    %rbx,%r9
  402710:	48 0f 44 f9          	cmove  %rcx,%rdi
  402714:	48 83 ec 08          	sub    $0x8,%rsp
  402718:	48 89 d9             	mov    %rbx,%rcx
  40271b:	50                   	push   %rax
  40271c:	31 c0                	xor    %eax,%eax
  40271e:	e8 2e 02 00 00       	callq  402951 <__clone>
  402723:	41 89 c6             	mov    %eax,%r14d
  402726:	e8 b3 f9 ff ff       	callq  4020de <__acquire_ptc>
  40272b:	45 85 ed             	test   %r13d,%r13d
  40272e:	58                   	pop    %rax
  40272f:	5a                   	pop    %rdx
  402730:	74 7f                	je     4027b1 <__pthread_create+0x487>
  402732:	48 8d bc 24 80 00 00 	lea    0x80(%rsp),%rdi
  402739:	00 
  40273a:	e8 65 07 00 00       	callq  402ea4 <__restore_sigs>
  40273f:	45 85 f6             	test   %r14d,%r14d
  402742:	79 1e                	jns    402762 <__pthread_create+0x438>
  402744:	f0 ff 0d a1 31 20 00 	lock decl 0x2031a1(%rip)        # 6058ec <__libc+0xc>
  40274b:	4d 85 e4             	test   %r12,%r12
  40274e:	b8 0b 00 00 00       	mov    $0xb,%eax
  402753:	74 63                	je     4027b8 <__pthread_create+0x48e>
  402755:	48 89 ee             	mov    %rbp,%rsi
  402758:	4c 89 e7             	mov    %r12,%rdi
  40275b:	e8 d0 06 00 00       	callq  402e30 <__munmap>
  402760:	eb 48                	jmp    4027aa <__pthread_create+0x480>
  402762:	41 b8 ca 00 00 00    	mov    $0xca,%r8d
  402768:	48 8d bc 24 08 01 00 	lea    0x108(%rsp),%rdi
  40276f:	00 
  402770:	45 31 d2             	xor    %r10d,%r10d
  402773:	48 83 ca ff          	or     $0xffffffffffffffff,%rdx
  402777:	be 80 00 00 00       	mov    $0x80,%esi
  40277c:	4c 89 c0             	mov    %r8,%rax
  40277f:	0f 05                	syscall 
  402781:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  402785:	75 07                	jne    40278e <__pthread_create+0x464>
  402787:	31 f6                	xor    %esi,%esi
  402789:	4c 89 c0             	mov    %r8,%rax
  40278c:	0f 05                	syscall 
  40278e:	8b 84 24 08 01 00 00 	mov    0x108(%rsp),%eax
  402795:	85 c0                	test   %eax,%eax
  402797:	75 1f                	jne    4027b8 <__pthread_create+0x48e>
  402799:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  40279e:	48 89 18             	mov    %rbx,(%rax)
  4027a1:	31 c0                	xor    %eax,%eax
  4027a3:	eb 13                	jmp    4027b8 <__pthread_create+0x48e>
  4027a5:	e8 34 f9 ff ff       	callq  4020de <__acquire_ptc>
  4027aa:	b8 0b 00 00 00       	mov    $0xb,%eax
  4027af:	eb 07                	jmp    4027b8 <__pthread_create+0x48e>
  4027b1:	45 85 f6             	test   %r14d,%r14d
  4027b4:	79 e3                	jns    402799 <__pthread_create+0x46f>
  4027b6:	eb 8c                	jmp    402744 <__pthread_create+0x41a>
  4027b8:	48 81 c4 18 01 00 00 	add    $0x118,%rsp
  4027bf:	5b                   	pop    %rbx
  4027c0:	5d                   	pop    %rbp
  4027c1:	41 5c                	pop    %r12
  4027c3:	41 5d                	pop    %r13
  4027c5:	41 5e                	pop    %r14
  4027c7:	41 5f                	pop    %r15
  4027c9:	c3                   	retq   

00000000004027ca <pthread_timedjoin_np>:
  4027ca:	41 56                	push   %r14
  4027cc:	41 55                	push   %r13
  4027ce:	49 89 d5             	mov    %rdx,%r13
  4027d1:	41 54                	push   %r12
  4027d3:	55                   	push   %rbp
  4027d4:	49 89 f4             	mov    %rsi,%r12
  4027d7:	53                   	push   %rbx
  4027d8:	48 89 fd             	mov    %rdi,%rbp
  4027db:	48 83 ec 10          	sub    $0x10,%rsp
  4027df:	e8 da 00 00 00       	callq  4028be <__pthread_testcancel>
  4027e4:	48 8d 74 24 0c       	lea    0xc(%rsp),%rsi
  4027e9:	bf 01 00 00 00       	mov    $0x1,%edi
  4027ee:	e8 a5 00 00 00       	callq  402898 <__pthread_setcancelstate>
  4027f3:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%rsp)
  4027f8:	75 09                	jne    402803 <pthread_timedjoin_np+0x39>
  4027fa:	31 f6                	xor    %esi,%esi
  4027fc:	31 ff                	xor    %edi,%edi
  4027fe:	e8 95 00 00 00       	callq  402898 <__pthread_setcancelstate>
  402803:	4c 8d 75 40          	lea    0x40(%rbp),%r14
  402807:	31 db                	xor    %ebx,%ebx
  402809:	8b 75 40             	mov    0x40(%rbp),%esi
  40280c:	85 f6                	test   %esi,%esi
  40280e:	75 17                	jne    402827 <pthread_timedjoin_np+0x5d>
  402810:	8b 7c 24 0c          	mov    0xc(%rsp),%edi
  402814:	31 f6                	xor    %esi,%esi
  402816:	e8 7d 00 00 00       	callq  402898 <__pthread_setcancelstate>
  40281b:	83 fb 6e             	cmp    $0x6e,%ebx
  40281e:	74 4f                	je     40286f <pthread_timedjoin_np+0xa5>
  402820:	83 fb 16             	cmp    $0x16,%ebx
  402823:	75 26                	jne    40284b <pthread_timedjoin_np+0x81>
  402825:	eb 48                	jmp    40286f <pthread_timedjoin_np+0xa5>
  402827:	83 fb 6e             	cmp    $0x6e,%ebx
  40282a:	74 e4                	je     402810 <pthread_timedjoin_np+0x46>
  40282c:	83 fb 16             	cmp    $0x16,%ebx
  40282f:	74 df                	je     402810 <pthread_timedjoin_np+0x46>
  402831:	83 fe 02             	cmp    $0x2,%esi
  402834:	7e 01                	jle    402837 <pthread_timedjoin_np+0x6d>
  402836:	f4                   	hlt    
  402837:	45 31 c0             	xor    %r8d,%r8d
  40283a:	4c 89 e9             	mov    %r13,%rcx
  40283d:	31 d2                	xor    %edx,%edx
  40283f:	4c 89 f7             	mov    %r14,%rdi
  402842:	e8 76 0c 00 00       	callq  4034bd <__timedwait_cp>
  402847:	89 c3                	mov    %eax,%ebx
  402849:	eb be                	jmp    402809 <pthread_timedjoin_np+0x3f>
  40284b:	4d 85 e4             	test   %r12,%r12
  40284e:	74 0b                	je     40285b <pthread_timedjoin_np+0x91>
  402850:	48 8b 85 88 00 00 00 	mov    0x88(%rbp),%rax
  402857:	49 89 04 24          	mov    %rax,(%r12)
  40285b:	48 8b 7d 50          	mov    0x50(%rbp),%rdi
  40285f:	31 db                	xor    %ebx,%ebx
  402861:	48 85 ff             	test   %rdi,%rdi
  402864:	74 09                	je     40286f <pthread_timedjoin_np+0xa5>
  402866:	48 8b 75 58          	mov    0x58(%rbp),%rsi
  40286a:	e8 c1 05 00 00       	callq  402e30 <__munmap>
  40286f:	48 83 c4 10          	add    $0x10,%rsp
  402873:	89 d8                	mov    %ebx,%eax
  402875:	5b                   	pop    %rbx
  402876:	5d                   	pop    %rbp
  402877:	41 5c                	pop    %r12
  402879:	41 5d                	pop    %r13
  40287b:	41 5e                	pop    %r14
  40287d:	c3                   	retq   

000000000040287e <__pthread_join>:
  40287e:	31 d2                	xor    %edx,%edx
  402880:	e9 45 ff ff ff       	jmpq   4027ca <pthread_timedjoin_np>

0000000000402885 <pthread_tryjoin_np>:
  402885:	8b 47 40             	mov    0x40(%rdi),%eax
  402888:	83 f8 02             	cmp    $0x2,%eax
  40288b:	74 05                	je     402892 <pthread_tryjoin_np+0xd>
  40288d:	e9 ec ff ff ff       	jmpq   40287e <__pthread_join>
  402892:	b8 10 00 00 00       	mov    $0x10,%eax
  402897:	c3                   	retq   

0000000000402898 <__pthread_setcancelstate>:
  402898:	83 ff 02             	cmp    $0x2,%edi
  40289b:	b8 16 00 00 00       	mov    $0x16,%eax
  4028a0:	77 1a                	ja     4028bc <__pthread_setcancelstate+0x24>
  4028a2:	64 48 8b 14 25 00 00 	mov    %fs:0x0,%rdx
  4028a9:	00 00 
  4028ab:	48 85 f6             	test   %rsi,%rsi
  4028ae:	74 06                	je     4028b6 <__pthread_setcancelstate+0x1e>
  4028b0:	0f b6 42 48          	movzbl 0x48(%rdx),%eax
  4028b4:	89 06                	mov    %eax,(%rsi)
  4028b6:	40 88 7a 48          	mov    %dil,0x48(%rdx)
  4028ba:	31 c0                	xor    %eax,%eax
  4028bc:	c3                   	retq   

00000000004028bd <__testcancel>:
  4028bd:	c3                   	retq   

00000000004028be <__pthread_testcancel>:
  4028be:	31 c0                	xor    %eax,%eax
  4028c0:	e9 f8 ff ff ff       	jmpq   4028bd <__testcancel>

00000000004028c5 <__vm_wait>:
  4028c5:	8b 15 fd 2d 20 00    	mov    0x202dfd(%rip),%edx        # 6056c8 <vmlock>
  4028cb:	85 d2                	test   %edx,%edx
  4028cd:	75 01                	jne    4028d0 <__vm_wait+0xb>
  4028cf:	c3                   	retq   
  4028d0:	48 83 ec 08          	sub    $0x8,%rsp
  4028d4:	b9 01 00 00 00       	mov    $0x1,%ecx
  4028d9:	be cc 56 60 00       	mov    $0x6056cc,%esi
  4028de:	bf c8 56 60 00       	mov    $0x6056c8,%edi
  4028e3:	e8 44 0d 00 00       	callq  40362c <__wait>
  4028e8:	8b 15 da 2d 20 00    	mov    0x202dda(%rip),%edx        # 6056c8 <vmlock>
  4028ee:	85 d2                	test   %edx,%edx
  4028f0:	75 e2                	jne    4028d4 <__vm_wait+0xf>
  4028f2:	58                   	pop    %rax
  4028f3:	c3                   	retq   

00000000004028f4 <__vm_lock>:
  4028f4:	f0 ff 05 cd 2d 20 00 	lock incl 0x202dcd(%rip)        # 6056c8 <vmlock>
  4028fb:	c3                   	retq   

00000000004028fc <__vm_unlock>:
  4028fc:	bf c8 56 60 00       	mov    $0x6056c8,%edi
  402901:	83 c9 ff             	or     $0xffffffff,%ecx
  402904:	f0 0f c1 0d bc 2d 20 	lock xadd %ecx,0x202dbc(%rip)        # 6056c8 <vmlock>
  40290b:	00 
  40290c:	ff c9                	dec    %ecx
  40290e:	75 2f                	jne    40293f <__vm_unlock+0x43>
  402910:	8b 05 b6 2d 20 00    	mov    0x202db6(%rip),%eax        # 6056cc <vmlock+0x4>
  402916:	85 c0                	test   %eax,%eax
  402918:	74 25                	je     40293f <__vm_unlock+0x43>
  40291a:	41 b8 ca 00 00 00    	mov    $0xca,%r8d
  402920:	ba ff ff ff 7f       	mov    $0x7fffffff,%edx
  402925:	be 81 00 00 00       	mov    $0x81,%esi
  40292a:	4c 89 c0             	mov    %r8,%rax
  40292d:	0f 05                	syscall 
  40292f:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  402933:	75 0a                	jne    40293f <__vm_unlock+0x43>
  402935:	be 01 00 00 00       	mov    $0x1,%esi
  40293a:	4c 89 c0             	mov    %r8,%rax
  40293d:	0f 05                	syscall 
  40293f:	c3                   	retq   

0000000000402940 <__unmapself>:
  402940:	b8 0b 00 00 00       	mov    $0xb,%eax
  402945:	0f 05                	syscall 
  402947:	48 31 ff             	xor    %rdi,%rdi
  40294a:	b8 3c 00 00 00       	mov    $0x3c,%eax
  40294f:	0f 05                	syscall 

0000000000402951 <__clone>:
  402951:	31 c0                	xor    %eax,%eax
  402953:	b0 38                	mov    $0x38,%al
  402955:	49 89 fb             	mov    %rdi,%r11
  402958:	48 89 d7             	mov    %rdx,%rdi
  40295b:	4c 89 c2             	mov    %r8,%rdx
  40295e:	4d 89 c8             	mov    %r9,%r8
  402961:	4c 8b 54 24 08       	mov    0x8(%rsp),%r10
  402966:	4d 89 d9             	mov    %r11,%r9
  402969:	48 83 e6 f0          	and    $0xfffffffffffffff0,%rsi
  40296d:	48 83 ee 08          	sub    $0x8,%rsi
  402971:	48 89 0e             	mov    %rcx,(%rsi)
  402974:	0f 05                	syscall 
  402976:	85 c0                	test   %eax,%eax
  402978:	75 0f                	jne    402989 <__clone+0x38>
  40297a:	31 ed                	xor    %ebp,%ebp
  40297c:	5f                   	pop    %rdi
  40297d:	41 ff d1             	callq  *%r9
  402980:	89 c7                	mov    %eax,%edi
  402982:	31 c0                	xor    %eax,%eax
  402984:	b0 3c                	mov    $0x3c,%al
  402986:	0f 05                	syscall 
  402988:	f4                   	hlt    
  402989:	c3                   	retq   

000000000040298a <__init_tp>:
  40298a:	53                   	push   %rbx
  40298b:	48 89 3f             	mov    %rdi,(%rdi)
  40298e:	48 89 fb             	mov    %rdi,%rbx
  402991:	e8 12 0d 00 00       	callq  4036a8 <__set_thread_area>
  402996:	83 ca ff             	or     $0xffffffff,%edx
  402999:	85 c0                	test   %eax,%eax
  40299b:	78 3c                	js     4029d9 <__init_tp+0x4f>
  40299d:	75 0a                	jne    4029a9 <__init_tp+0x1f>
  40299f:	c7 05 37 2f 20 00 01 	movl   $0x1,0x202f37(%rip)        # 6058e0 <__libc>
  4029a6:	00 00 00 
  4029a9:	c7 43 40 02 00 00 00 	movl   $0x2,0x40(%rbx)
  4029b0:	48 8d 7b 40          	lea    0x40(%rbx),%rdi
  4029b4:	b8 da 00 00 00       	mov    $0xda,%eax
  4029b9:	0f 05                	syscall 
  4029bb:	89 43 38             	mov    %eax,0x38(%rbx)
  4029be:	48 8d 83 a0 00 00 00 	lea    0xa0(%rbx),%rax
  4029c5:	48 c7 83 c0 00 00 00 	movq   $0x605920,0xc0(%rbx)
  4029cc:	20 59 60 00 
  4029d0:	31 d2                	xor    %edx,%edx
  4029d2:	48 89 83 a0 00 00 00 	mov    %rax,0xa0(%rbx)
  4029d9:	89 d0                	mov    %edx,%eax
  4029db:	5b                   	pop    %rbx
  4029dc:	c3                   	retq   

00000000004029dd <__copy_tls>:
  4029dd:	41 55                	push   %r13
  4029df:	41 54                	push   %r12
  4029e1:	4c 8d 6f 08          	lea    0x8(%rdi),%r13
  4029e5:	55                   	push   %rbp
  4029e6:	53                   	push   %rbx
  4029e7:	49 89 fc             	mov    %rdi,%r12
  4029ea:	48 83 ec 08          	sub    $0x8,%rsp
  4029ee:	48 8b 05 0b 2f 20 00 	mov    0x202f0b(%rip),%rax        # 605900 <__libc+0x20>
  4029f5:	48 8b 1d 0c 2f 20 00 	mov    0x202f0c(%rip),%rbx        # 605908 <__libc+0x28>
  4029fc:	48 8b 2d f5 2e 20 00 	mov    0x202ef5(%rip),%rbp        # 6058f8 <__libc+0x18>
  402a03:	48 8d 84 07 10 ff ff 	lea    -0xf0(%rdi,%rax,1),%rax
  402a0a:	ff 
  402a0b:	48 f7 db             	neg    %rbx
  402a0e:	48 21 c3             	and    %rax,%rbx
  402a11:	48 85 ed             	test   %rbp,%rbp
  402a14:	74 29                	je     402a3f <__copy_tls+0x62>
  402a16:	48 89 d8             	mov    %rbx,%rax
  402a19:	48 2b 45 28          	sub    0x28(%rbp),%rax
  402a1d:	48 89 df             	mov    %rbx,%rdi
  402a20:	48 8b 75 08          	mov    0x8(%rbp),%rsi
  402a24:	49 83 c5 08          	add    $0x8,%r13
  402a28:	49 89 45 f8          	mov    %rax,-0x8(%r13)
  402a2c:	48 2b 7d 28          	sub    0x28(%rbp),%rdi
  402a30:	48 8b 55 10          	mov    0x10(%rbp),%rdx
  402a34:	e8 74 09 00 00       	callq  4033ad <memcpy>
  402a39:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  402a3d:	eb d2                	jmp    402a11 <__copy_tls+0x34>
  402a3f:	48 8b 05 ca 2e 20 00 	mov    0x202eca(%rip),%rax        # 605910 <__libc+0x30>
  402a46:	49 89 04 24          	mov    %rax,(%r12)
  402a4a:	4c 89 a3 e8 00 00 00 	mov    %r12,0xe8(%rbx)
  402a51:	48 89 d8             	mov    %rbx,%rax
  402a54:	4c 89 63 08          	mov    %r12,0x8(%rbx)
  402a58:	5a                   	pop    %rdx
  402a59:	5b                   	pop    %rbx
  402a5a:	5d                   	pop    %rbp
  402a5b:	41 5c                	pop    %r12
  402a5d:	41 5d                	pop    %r13
  402a5f:	c3                   	retq   

0000000000402a60 <__init_tls>:
  402a60:	41 54                	push   %r12
  402a62:	55                   	push   %rbp
  402a63:	45 31 d2             	xor    %r10d,%r10d
  402a66:	53                   	push   %rbx
  402a67:	4c 8b 5f 18          	mov    0x18(%rdi),%r11
  402a6b:	31 c9                	xor    %ecx,%ecx
  402a6d:	4c 8b 4f 28          	mov    0x28(%rdi),%r9
  402a71:	44 8b 05 94 27 20 00 	mov    0x202794(%rip),%r8d        # 60520c <__default_stacksize>
  402a78:	31 d2                	xor    %edx,%edx
  402a7a:	bd 00 00 80 00       	mov    $0x800000,%ebp
  402a7f:	bb 00 00 00 00       	mov    $0x0,%ebx
  402a84:	4c 89 d8             	mov    %r11,%rax
  402a87:	4d 85 c9             	test   %r9,%r9
  402a8a:	74 57                	je     402ae3 <__init_tls+0x83>
  402a8c:	8b 30                	mov    (%rax),%esi
  402a8e:	83 fe 06             	cmp    $0x6,%esi
  402a91:	75 05                	jne    402a98 <__init_tls+0x38>
  402a93:	4c 89 d9             	mov    %r11,%rcx
  402a96:	eb 0d                	jmp    402aa5 <__init_tls+0x45>
  402a98:	83 fe 02             	cmp    $0x2,%esi
  402a9b:	75 0e                	jne    402aab <__init_tls+0x4b>
  402a9d:	48 85 db             	test   %rbx,%rbx
  402aa0:	74 38                	je     402ada <__init_tls+0x7a>
  402aa2:	48 89 d9             	mov    %rbx,%rcx
  402aa5:	48 2b 48 10          	sub    0x10(%rax),%rcx
  402aa9:	eb 2f                	jmp    402ada <__init_tls+0x7a>
  402aab:	83 fe 07             	cmp    $0x7,%esi
  402aae:	74 27                	je     402ad7 <__init_tls+0x77>
  402ab0:	81 fe 51 e5 74 64    	cmp    $0x6474e551,%esi
  402ab6:	75 22                	jne    402ada <__init_tls+0x7a>
  402ab8:	48 8b 70 28          	mov    0x28(%rax),%rsi
  402abc:	45 89 c4             	mov    %r8d,%r12d
  402abf:	4c 39 e6             	cmp    %r12,%rsi
  402ac2:	76 16                	jbe    402ada <__init_tls+0x7a>
  402ac4:	48 81 fe 00 00 80 00 	cmp    $0x800000,%rsi
  402acb:	41 b2 01             	mov    $0x1,%r10b
  402ace:	48 0f 47 f5          	cmova  %rbp,%rsi
  402ad2:	49 89 f0             	mov    %rsi,%r8
  402ad5:	eb 03                	jmp    402ada <__init_tls+0x7a>
  402ad7:	48 89 c2             	mov    %rax,%rdx
  402ada:	49 ff c9             	dec    %r9
  402add:	48 03 47 20          	add    0x20(%rdi),%rax
  402ae1:	eb a4                	jmp    402a87 <__init_tls+0x27>
  402ae3:	45 84 d2             	test   %r10b,%r10b
  402ae6:	74 07                	je     402aef <__init_tls+0x8f>
  402ae8:	44 89 05 1d 27 20 00 	mov    %r8d,0x20271d(%rip)        # 60520c <__default_stacksize>
  402aef:	48 85 d2             	test   %rdx,%rdx
  402af2:	74 42                	je     402b36 <__init_tls+0xd6>
  402af4:	48 8b 42 20          	mov    0x20(%rdx),%rax
  402af8:	48 03 4a 10          	add    0x10(%rdx),%rcx
  402afc:	48 c7 05 f1 2d 20 00 	movq   $0x6056e0,0x202df1(%rip)        # 6058f8 <__libc+0x18>
  402b03:	e0 56 60 00 
  402b07:	48 89 05 e2 2b 20 00 	mov    %rax,0x202be2(%rip)        # 6056f0 <main_tls+0x10>
  402b0e:	48 8b 42 28          	mov    0x28(%rdx),%rax
  402b12:	48 89 0d cf 2b 20 00 	mov    %rcx,0x202bcf(%rip)        # 6056e8 <main_tls+0x8>
  402b19:	48 89 05 d8 2b 20 00 	mov    %rax,0x202bd8(%rip)        # 6056f8 <main_tls+0x18>
  402b20:	48 8b 42 30          	mov    0x30(%rdx),%rax
  402b24:	48 c7 05 e1 2d 20 00 	movq   $0x1,0x202de1(%rip)        # 605910 <__libc+0x30>
  402b2b:	01 00 00 00 
  402b2f:	48 89 05 ca 2b 20 00 	mov    %rax,0x202bca(%rip)        # 605700 <main_tls+0x20>
  402b36:	48 8b 0d bb 2b 20 00 	mov    0x202bbb(%rip),%rcx        # 6056f8 <main_tls+0x18>
  402b3d:	48 8b 15 bc 2b 20 00 	mov    0x202bbc(%rip),%rdx        # 605700 <main_tls+0x20>
  402b44:	48 89 c8             	mov    %rcx,%rax
  402b47:	48 03 05 9a 2b 20 00 	add    0x202b9a(%rip),%rax        # 6056e8 <main_tls+0x8>
  402b4e:	48 8d 72 ff          	lea    -0x1(%rdx),%rsi
  402b52:	48 f7 d8             	neg    %rax
  402b55:	48 21 f0             	and    %rsi,%rax
  402b58:	48 01 c8             	add    %rcx,%rax
  402b5b:	48 83 fa 07          	cmp    $0x7,%rdx
  402b5f:	48 89 05 92 2b 20 00 	mov    %rax,0x202b92(%rip)        # 6056f8 <main_tls+0x18>
  402b66:	48 89 05 9b 2b 20 00 	mov    %rax,0x202b9b(%rip)        # 605708 <main_tls+0x28>
  402b6d:	77 0b                	ja     402b7a <__init_tls+0x11a>
  402b6f:	48 c7 05 86 2b 20 00 	movq   $0x8,0x202b86(%rip)        # 605700 <main_tls+0x20>
  402b76:	08 00 00 00 
  402b7a:	48 8b 15 7f 2b 20 00 	mov    0x202b7f(%rip),%rdx        # 605700 <main_tls+0x20>
  402b81:	bf 20 57 60 00       	mov    $0x605720,%edi
  402b86:	48 8d 84 10 07 01 00 	lea    0x107(%rax,%rdx,1),%rax
  402b8d:	00 
  402b8e:	48 89 15 73 2d 20 00 	mov    %rdx,0x202d73(%rip)        # 605908 <__libc+0x28>
  402b95:	48 83 e0 f8          	and    $0xfffffffffffffff8,%rax
  402b99:	48 3d 78 01 00 00    	cmp    $0x178,%rax
  402b9f:	48 89 c6             	mov    %rax,%rsi
  402ba2:	48 89 05 57 2d 20 00 	mov    %rax,0x202d57(%rip)        # 605900 <__libc+0x20>
  402ba9:	76 1e                	jbe    402bc9 <__init_tls+0x169>
  402bab:	41 ba 22 00 00 00    	mov    $0x22,%r10d
  402bb1:	49 83 c8 ff          	or     $0xffffffffffffffff,%r8
  402bb5:	45 31 c9             	xor    %r9d,%r9d
  402bb8:	ba 03 00 00 00       	mov    $0x3,%edx
  402bbd:	31 ff                	xor    %edi,%edi
  402bbf:	b8 09 00 00 00       	mov    $0x9,%eax
  402bc4:	0f 05                	syscall 
  402bc6:	48 89 c7             	mov    %rax,%rdi
  402bc9:	e8 0f fe ff ff       	callq  4029dd <__copy_tls>
  402bce:	48 89 c7             	mov    %rax,%rdi
  402bd1:	e8 b4 fd ff ff       	callq  40298a <__init_tp>
  402bd6:	85 c0                	test   %eax,%eax
  402bd8:	79 01                	jns    402bdb <__init_tls+0x17b>
  402bda:	f4                   	hlt    
  402bdb:	5b                   	pop    %rbx
  402bdc:	5d                   	pop    %rbp
  402bdd:	41 5c                	pop    %r12
  402bdf:	c3                   	retq   

0000000000402be0 <__errno_location>:
  402be0:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
  402be7:	00 00 
  402be9:	48 83 c0 3c          	add    $0x3c,%rax
  402bed:	c3                   	retq   

0000000000402bee <__strerror_l>:
  402bee:	31 d2                	xor    %edx,%edx
  402bf0:	0f b6 82 60 49 40 00 	movzbl 0x404960(%rdx),%eax
  402bf7:	89 d1                	mov    %edx,%ecx
  402bf9:	84 c0                	test   %al,%al
  402bfb:	74 07                	je     402c04 <__strerror_l+0x16>
  402bfd:	48 ff c2             	inc    %rdx
  402c00:	39 f8                	cmp    %edi,%eax
  402c02:	75 ec                	jne    402bf0 <__strerror_l+0x2>
  402c04:	bf 40 42 40 00       	mov    $0x404240,%edi
  402c09:	85 c9                	test   %ecx,%ecx
  402c0b:	74 0d                	je     402c1a <__strerror_l+0x2c>
  402c0d:	80 3f 00             	cmpb   $0x0,(%rdi)
  402c10:	48 8d 7f 01          	lea    0x1(%rdi),%rdi
  402c14:	75 f7                	jne    402c0d <__strerror_l+0x1f>
  402c16:	ff c9                	dec    %ecx
  402c18:	eb ef                	jmp    402c09 <__strerror_l+0x1b>
  402c1a:	48 8b 76 28          	mov    0x28(%rsi),%rsi
  402c1e:	e9 2f 00 00 00       	jmpq   402c52 <__lctrans>

0000000000402c23 <strerror>:
  402c23:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
  402c2a:	00 00 
  402c2c:	48 8b b0 c0 00 00 00 	mov    0xc0(%rax),%rsi
  402c33:	e9 b6 ff ff ff       	jmpq   402bee <__strerror_l>

0000000000402c38 <_Exit>:
  402c38:	48 63 ff             	movslq %edi,%rdi
  402c3b:	b8 e7 00 00 00       	mov    $0xe7,%eax
  402c40:	0f 05                	syscall 
  402c42:	ba 3c 00 00 00       	mov    $0x3c,%edx
  402c47:	48 89 d0             	mov    %rdx,%rax
  402c4a:	0f 05                	syscall 
  402c4c:	eb f9                	jmp    402c47 <_Exit+0xf>

0000000000402c4e <__lctrans_impl>:
  402c4e:	48 89 f8             	mov    %rdi,%rax
  402c51:	c3                   	retq   

0000000000402c52 <__lctrans>:
  402c52:	e9 f7 ff ff ff       	jmpq   402c4e <__lctrans_impl>

0000000000402c57 <__lctrans_cur>:
  402c57:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
  402c5e:	00 00 
  402c60:	48 8b 80 c0 00 00 00 	mov    0xc0(%rax),%rax
  402c67:	48 8b 70 28          	mov    0x28(%rax),%rsi
  402c6b:	e9 de ff ff ff       	jmpq   402c4e <__lctrans_impl>

0000000000402c70 <__fpclassifyl>:
  402c70:	db 6c 24 08          	fldt   0x8(%rsp)
  402c74:	db 7c 24 e8          	fstpt  -0x18(%rsp)
  402c78:	8b 54 24 f0          	mov    -0x10(%rsp),%edx
  402c7c:	48 8b 4c 24 e8       	mov    -0x18(%rsp),%rcx
  402c81:	66 81 e2 ff 7f       	and    $0x7fff,%dx
  402c86:	48 89 ce             	mov    %rcx,%rsi
  402c89:	48 c1 ee 3f          	shr    $0x3f,%rsi
  402c8d:	0f b7 c2             	movzwl %dx,%eax
  402c90:	09 f0                	or     %esi,%eax
  402c92:	75 0c                	jne    402ca0 <__fpclassifyl+0x30>
  402c94:	31 c0                	xor    %eax,%eax
  402c96:	48 85 c9             	test   %rcx,%rcx
  402c99:	0f 95 c0             	setne  %al
  402c9c:	83 c0 02             	add    $0x2,%eax
  402c9f:	c3                   	retq   
  402ca0:	66 81 fa ff 7f       	cmp    $0x7fff,%dx
  402ca5:	8d 04 b5 00 00 00 00 	lea    0x0(,%rsi,4),%eax
  402cac:	75 0f                	jne    402cbd <__fpclassifyl+0x4d>
  402cae:	31 c0                	xor    %eax,%eax
  402cb0:	48 85 f6             	test   %rsi,%rsi
  402cb3:	74 08                	je     402cbd <__fpclassifyl+0x4d>
  402cb5:	31 c0                	xor    %eax,%eax
  402cb7:	48 01 c9             	add    %rcx,%rcx
  402cba:	0f 94 c0             	sete   %al
  402cbd:	c3                   	retq   

0000000000402cbe <__signbitl>:
  402cbe:	db 6c 24 08          	fldt   0x8(%rsp)
  402cc2:	db 7c 24 e8          	fstpt  -0x18(%rsp)
  402cc6:	8b 44 24 f0          	mov    -0x10(%rsp),%eax
  402cca:	66 c1 e8 0f          	shr    $0xf,%ax
  402cce:	0f b7 c0             	movzwl %ax,%eax
  402cd1:	c3                   	retq   

0000000000402cd2 <frexpl>:
  402cd2:	53                   	push   %rbx
  402cd3:	48 83 ec 10          	sub    $0x10,%rsp
  402cd7:	db 6c 24 20          	fldt   0x20(%rsp)
  402cdb:	d9 c0                	fld    %st(0)
  402cdd:	db 3c 24             	fstpt  (%rsp)
  402ce0:	8b 44 24 08          	mov    0x8(%rsp),%eax
  402ce4:	89 c1                	mov    %eax,%ecx
  402ce6:	66 81 e1 ff 7f       	and    $0x7fff,%cx
  402ceb:	75 30                	jne    402d1d <frexpl+0x4b>
  402ced:	d9 ee                	fldz   
  402cef:	d9 c9                	fxch   %st(1)
  402cf1:	db e9                	fucomi %st(1),%st
  402cf3:	dd d9                	fstp   %st(1)
  402cf5:	7a 02                	jp     402cf9 <frexpl+0x27>
  402cf7:	74 1c                	je     402d15 <frexpl+0x43>
  402cf9:	d8 0d bd 1c 00 00    	fmuls  0x1cbd(%rip)        # 4049bc <errid+0x5c>
  402cff:	48 83 ec 10          	sub    $0x10,%rsp
  402d03:	48 89 fb             	mov    %rdi,%rbx
  402d06:	db 3c 24             	fstpt  (%rsp)
  402d09:	e8 c4 ff ff ff       	callq  402cd2 <frexpl>
  402d0e:	83 2b 78             	subl   $0x78,(%rbx)
  402d11:	59                   	pop    %rcx
  402d12:	5e                   	pop    %rsi
  402d13:	eb 2c                	jmp    402d41 <frexpl+0x6f>
  402d15:	c7 07 00 00 00 00    	movl   $0x0,(%rdi)
  402d1b:	eb 24                	jmp    402d41 <frexpl+0x6f>
  402d1d:	66 81 f9 ff 7f       	cmp    $0x7fff,%cx
  402d22:	0f b7 d1             	movzwl %cx,%edx
  402d25:	74 1a                	je     402d41 <frexpl+0x6f>
  402d27:	dd d8                	fstp   %st(0)
  402d29:	66 25 00 80          	and    $0x8000,%ax
  402d2d:	81 ea fe 3f 00 00    	sub    $0x3ffe,%edx
  402d33:	66 0d fe 3f          	or     $0x3ffe,%ax
  402d37:	89 17                	mov    %edx,(%rdi)
  402d39:	66 89 44 24 08       	mov    %ax,0x8(%rsp)
  402d3e:	db 2c 24             	fldt   (%rsp)
  402d41:	48 83 c4 10          	add    $0x10,%rsp
  402d45:	5b                   	pop    %rbx
  402d46:	c3                   	retq   

0000000000402d47 <dummy>:
  402d47:	c3                   	retq   

0000000000402d48 <__mmap>:
  402d48:	55                   	push   %rbp
  402d49:	53                   	push   %rbx
  402d4a:	48 83 ec 28          	sub    $0x28,%rsp
  402d4e:	41 f7 c1 ff 0f 00 00 	test   $0xfff,%r9d
  402d55:	74 0d                	je     402d64 <__mmap+0x1c>
  402d57:	e8 84 fe ff ff       	callq  402be0 <__errno_location>
  402d5c:	c7 00 16 00 00 00    	movl   $0x16,(%rax)
  402d62:	eb 1a                	jmp    402d7e <__mmap+0x36>
  402d64:	48 b8 fe ff ff ff ff 	movabs $0x7ffffffffffffffe,%rax
  402d6b:	ff ff 7f 
  402d6e:	48 39 c6             	cmp    %rax,%rsi
  402d71:	76 16                	jbe    402d89 <__mmap+0x41>
  402d73:	e8 68 fe ff ff       	callq  402be0 <__errno_location>
  402d78:	c7 00 0c 00 00 00    	movl   $0xc,(%rax)
  402d7e:	48 83 c4 28          	add    $0x28,%rsp
  402d82:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  402d86:	5b                   	pop    %rbx
  402d87:	5d                   	pop    %rbp
  402d88:	c3                   	retq   
  402d89:	f6 c1 10             	test   $0x10,%cl
  402d8c:	89 d5                	mov    %edx,%ebp
  402d8e:	89 cb                	mov    %ecx,%ebx
  402d90:	74 2b                	je     402dbd <__mmap+0x75>
  402d92:	4c 89 4c 24 18       	mov    %r9,0x18(%rsp)
  402d97:	44 89 44 24 14       	mov    %r8d,0x14(%rsp)
  402d9c:	48 89 74 24 08       	mov    %rsi,0x8(%rsp)
  402da1:	48 89 3c 24          	mov    %rdi,(%rsp)
  402da5:	e8 1b fb ff ff       	callq  4028c5 <__vm_wait>
  402daa:	4c 8b 4c 24 18       	mov    0x18(%rsp),%r9
  402daf:	44 8b 44 24 14       	mov    0x14(%rsp),%r8d
  402db4:	48 8b 74 24 08       	mov    0x8(%rsp),%rsi
  402db9:	48 8b 3c 24          	mov    (%rsp),%rdi
  402dbd:	48 63 d5             	movslq %ebp,%rdx
  402dc0:	4c 63 d3             	movslq %ebx,%r10
  402dc3:	4d 63 c0             	movslq %r8d,%r8
  402dc6:	b8 09 00 00 00       	mov    $0x9,%eax
  402dcb:	0f 05                	syscall 
  402dcd:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  402dd1:	75 17                	jne    402dea <__mmap+0xa2>
  402dd3:	48 85 ff             	test   %rdi,%rdi
  402dd6:	75 12                	jne    402dea <__mmap+0xa2>
  402dd8:	83 e3 30             	and    $0x30,%ebx
  402ddb:	31 c0                	xor    %eax,%eax
  402ddd:	83 fb 20             	cmp    $0x20,%ebx
  402de0:	0f 95 c0             	setne  %al
  402de3:	48 f7 d8             	neg    %rax
  402de6:	48 83 c8 f4          	or     $0xfffffffffffffff4,%rax
  402dea:	48 83 c4 28          	add    $0x28,%rsp
  402dee:	48 89 c7             	mov    %rax,%rdi
  402df1:	5b                   	pop    %rbx
  402df2:	5d                   	pop    %rbp
  402df3:	e9 78 09 00 00       	jmpq   403770 <__syscall_ret>

0000000000402df8 <__mprotect>:
  402df8:	48 8d b4 37 ff 0f 00 	lea    0xfff(%rdi,%rsi,1),%rsi
  402dff:	00 
  402e00:	49 89 f8             	mov    %rdi,%r8
  402e03:	48 83 ec 08          	sub    $0x8,%rsp
  402e07:	49 81 e0 00 f0 ff ff 	and    $0xfffffffffffff000,%r8
  402e0e:	48 63 d2             	movslq %edx,%rdx
  402e11:	b8 0a 00 00 00       	mov    $0xa,%eax
  402e16:	48 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%rsi
  402e1d:	4c 89 c7             	mov    %r8,%rdi
  402e20:	4c 29 c6             	sub    %r8,%rsi
  402e23:	0f 05                	syscall 
  402e25:	48 89 c7             	mov    %rax,%rdi
  402e28:	e8 43 09 00 00       	callq  403770 <__syscall_ret>
  402e2d:	5a                   	pop    %rdx
  402e2e:	c3                   	retq   

0000000000402e2f <dummy>:
  402e2f:	c3                   	retq   

0000000000402e30 <__munmap>:
  402e30:	48 83 ec 18          	sub    $0x18,%rsp
  402e34:	48 89 7c 24 08       	mov    %rdi,0x8(%rsp)
  402e39:	48 89 34 24          	mov    %rsi,(%rsp)
  402e3d:	e8 83 fa ff ff       	callq  4028c5 <__vm_wait>
  402e42:	b8 0b 00 00 00       	mov    $0xb,%eax
  402e47:	48 8b 34 24          	mov    (%rsp),%rsi
  402e4b:	48 8b 7c 24 08       	mov    0x8(%rsp),%rdi
  402e50:	0f 05                	syscall 
  402e52:	48 89 c7             	mov    %rax,%rdi
  402e55:	e8 16 09 00 00       	callq  403770 <__syscall_ret>
  402e5a:	48 83 c4 18          	add    $0x18,%rsp
  402e5e:	c3                   	retq   

0000000000402e5f <wctomb>:
  402e5f:	48 85 ff             	test   %rdi,%rdi
  402e62:	74 0d                	je     402e71 <wctomb+0x12>
  402e64:	48 83 ec 08          	sub    $0x8,%rsp
  402e68:	31 d2                	xor    %edx,%edx
  402e6a:	e8 de 0b 00 00       	callq  403a4d <wcrtomb>
  402e6f:	5a                   	pop    %rdx
  402e70:	c3                   	retq   
  402e71:	31 c0                	xor    %eax,%eax
  402e73:	c3                   	retq   

0000000000402e74 <__block_all_sigs>:
  402e74:	48 89 fa             	mov    %rdi,%rdx
  402e77:	41 ba 08 00 00 00    	mov    $0x8,%r10d
  402e7d:	31 ff                	xor    %edi,%edi
  402e7f:	b8 0e 00 00 00       	mov    $0xe,%eax
  402e84:	be c8 49 40 00       	mov    $0x4049c8,%esi
  402e89:	0f 05                	syscall 
  402e8b:	c3                   	retq   

0000000000402e8c <__block_app_sigs>:
  402e8c:	48 89 fa             	mov    %rdi,%rdx
  402e8f:	41 ba 08 00 00 00    	mov    $0x8,%r10d
  402e95:	31 ff                	xor    %edi,%edi
  402e97:	b8 0e 00 00 00       	mov    $0xe,%eax
  402e9c:	be c0 49 40 00       	mov    $0x4049c0,%esi
  402ea1:	0f 05                	syscall 
  402ea3:	c3                   	retq   

0000000000402ea4 <__restore_sigs>:
  402ea4:	48 89 fe             	mov    %rdi,%rsi
  402ea7:	41 ba 08 00 00 00    	mov    $0x8,%r10d
  402ead:	31 d2                	xor    %edx,%edx
  402eaf:	bf 02 00 00 00       	mov    $0x2,%edi
  402eb4:	b8 0e 00 00 00       	mov    $0xe,%eax
  402eb9:	0f 05                	syscall 
  402ebb:	c3                   	retq   

0000000000402ebc <__lockfile>:
  402ebc:	8b 8f 8c 00 00 00    	mov    0x8c(%rdi),%ecx
  402ec2:	64 48 8b 04 25 00 00 	mov    %fs:0x0,%rax
  402ec9:	00 00 
  402ecb:	8b 50 38             	mov    0x38(%rax),%edx
  402ece:	31 c0                	xor    %eax,%eax
  402ed0:	81 e1 ff ff ff bf    	and    $0xbfffffff,%ecx
  402ed6:	39 ca                	cmp    %ecx,%edx
  402ed8:	0f 84 8c 00 00 00    	je     402f6a <__lockfile+0xae>
  402ede:	4c 8d 8f 8c 00 00 00 	lea    0x8c(%rdi),%r9
  402ee5:	f0 0f b1 97 8c 00 00 	lock cmpxchg %edx,0x8c(%rdi)
  402eec:	00 
  402eed:	85 c0                	test   %eax,%eax
  402eef:	74 7a                	je     402f6b <__lockfile+0xaf>
  402ef1:	81 ca 00 00 00 40    	or     $0x40000000,%edx
  402ef7:	41 54                	push   %r12
  402ef9:	41 bc 80 00 00 00    	mov    $0x80,%r12d
  402eff:	55                   	push   %rbp
  402f00:	41 89 d0             	mov    %edx,%r8d
  402f03:	53                   	push   %rbx
  402f04:	bd ca 00 00 00       	mov    $0xca,%ebp
  402f09:	31 db                	xor    %ebx,%ebx
  402f0b:	89 d8                	mov    %ebx,%eax
  402f0d:	f0 45 0f b1 01       	lock cmpxchg %r8d,(%r9)
  402f12:	85 c0                	test   %eax,%eax
  402f14:	89 c2                	mov    %eax,%edx
  402f16:	75 0b                	jne    402f23 <__lockfile+0x67>
  402f18:	5b                   	pop    %rbx
  402f19:	b8 01 00 00 00       	mov    $0x1,%eax
  402f1e:	5d                   	pop    %rbp
  402f1f:	41 5c                	pop    %r12
  402f21:	eb 47                	jmp    402f6a <__lockfile+0xae>
  402f23:	0f ba e2 1e          	bt     $0x1e,%edx
  402f27:	73 2c                	jae    402f55 <__lockfile+0x99>
  402f29:	81 ca 00 00 00 40    	or     $0x40000000,%edx
  402f2f:	45 31 d2             	xor    %r10d,%r10d
  402f32:	48 89 e8             	mov    %rbp,%rax
  402f35:	48 63 d2             	movslq %edx,%rdx
  402f38:	4c 89 cf             	mov    %r9,%rdi
  402f3b:	4c 89 e6             	mov    %r12,%rsi
  402f3e:	0f 05                	syscall 
  402f40:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  402f44:	75 c5                	jne    402f0b <__lockfile+0x4f>
  402f46:	45 31 d2             	xor    %r10d,%r10d
  402f49:	31 f6                	xor    %esi,%esi
  402f4b:	48 89 e8             	mov    %rbp,%rax
  402f4e:	4c 89 cf             	mov    %r9,%rdi
  402f51:	0f 05                	syscall 
  402f53:	eb b6                	jmp    402f0b <__lockfile+0x4f>
  402f55:	89 d1                	mov    %edx,%ecx
  402f57:	89 d0                	mov    %edx,%eax
  402f59:	81 c9 00 00 00 40    	or     $0x40000000,%ecx
  402f5f:	f0 41 0f b1 09       	lock cmpxchg %ecx,(%r9)
  402f64:	39 d0                	cmp    %edx,%eax
  402f66:	75 a3                	jne    402f0b <__lockfile+0x4f>
  402f68:	eb bf                	jmp    402f29 <__lockfile+0x6d>
  402f6a:	c3                   	retq   
  402f6b:	b8 01 00 00 00       	mov    $0x1,%eax
  402f70:	c3                   	retq   

0000000000402f71 <__unlockfile>:
  402f71:	4c 8d 8f 8c 00 00 00 	lea    0x8c(%rdi),%r9
  402f78:	31 c0                	xor    %eax,%eax
  402f7a:	87 87 8c 00 00 00    	xchg   %eax,0x8c(%rdi)
  402f80:	0f ba e0 1e          	bt     $0x1e,%eax
  402f84:	73 26                	jae    402fac <__unlockfile+0x3b>
  402f86:	41 b8 ca 00 00 00    	mov    $0xca,%r8d
  402f8c:	ba 01 00 00 00       	mov    $0x1,%edx
  402f91:	be 81 00 00 00       	mov    $0x81,%esi
  402f96:	4c 89 c0             	mov    %r8,%rax
  402f99:	4c 89 cf             	mov    %r9,%rdi
  402f9c:	0f 05                	syscall 
  402f9e:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  402fa2:	75 08                	jne    402fac <__unlockfile+0x3b>
  402fa4:	4c 89 c0             	mov    %r8,%rax
  402fa7:	48 89 d6             	mov    %rdx,%rsi
  402faa:	0f 05                	syscall 
  402fac:	c3                   	retq   

0000000000402fad <__aio_close>:
  402fad:	89 f8                	mov    %edi,%eax
  402faf:	c3                   	retq   

0000000000402fb0 <__stdio_close>:
  402fb0:	48 83 ec 08          	sub    $0x8,%rsp
  402fb4:	8b 7f 78             	mov    0x78(%rdi),%edi
  402fb7:	e8 f1 ff ff ff       	callq  402fad <__aio_close>
  402fbc:	48 63 f8             	movslq %eax,%rdi
  402fbf:	b8 03 00 00 00       	mov    $0x3,%eax
  402fc4:	0f 05                	syscall 
  402fc6:	48 89 c7             	mov    %rax,%rdi
  402fc9:	e8 a2 07 00 00       	callq  403770 <__syscall_ret>
  402fce:	5a                   	pop    %rdx
  402fcf:	c3                   	retq   

0000000000402fd0 <__stdio_seek>:
  402fd0:	48 63 7f 78          	movslq 0x78(%rdi),%rdi
  402fd4:	48 63 d2             	movslq %edx,%rdx
  402fd7:	b8 08 00 00 00       	mov    $0x8,%eax
  402fdc:	0f 05                	syscall 
  402fde:	48 89 c7             	mov    %rax,%rdi
  402fe1:	e9 8a 07 00 00       	jmpq   403770 <__syscall_ret>

0000000000402fe6 <__stdio_write>:
  402fe6:	41 57                	push   %r15
  402fe8:	41 56                	push   %r14
  402fea:	49 89 d7             	mov    %rdx,%r15
  402fed:	41 55                	push   %r13
  402fef:	41 54                	push   %r12
  402ff1:	41 bd 02 00 00 00    	mov    $0x2,%r13d
  402ff7:	55                   	push   %rbp
  402ff8:	53                   	push   %rbx
  402ff9:	41 be 14 00 00 00    	mov    $0x14,%r14d
  402fff:	48 89 fb             	mov    %rdi,%rbx
  403002:	48 83 ec 28          	sub    $0x28,%rsp
  403006:	48 8b 47 38          	mov    0x38(%rdi),%rax
  40300a:	4c 8b 67 28          	mov    0x28(%rdi),%r12
  40300e:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
  403013:	48 89 54 24 18       	mov    %rdx,0x18(%rsp)
  403018:	48 89 e5             	mov    %rsp,%rbp
  40301b:	49 29 c4             	sub    %rax,%r12
  40301e:	48 89 04 24          	mov    %rax,(%rsp)
  403022:	4c 89 64 24 08       	mov    %r12,0x8(%rsp)
  403027:	49 01 d4             	add    %rdx,%r12
  40302a:	48 63 7b 78          	movslq 0x78(%rbx),%rdi
  40302e:	49 63 d5             	movslq %r13d,%rdx
  403031:	4c 89 f0             	mov    %r14,%rax
  403034:	48 89 ee             	mov    %rbp,%rsi
  403037:	0f 05                	syscall 
  403039:	48 89 c7             	mov    %rax,%rdi
  40303c:	e8 2f 07 00 00       	callq  403770 <__syscall_ret>
  403041:	49 39 c4             	cmp    %rax,%r12
  403044:	75 19                	jne    40305f <__stdio_write+0x79>
  403046:	48 8b 43 58          	mov    0x58(%rbx),%rax
  40304a:	48 89 c2             	mov    %rax,%rdx
  40304d:	48 03 53 60          	add    0x60(%rbx),%rdx
  403051:	48 89 43 38          	mov    %rax,0x38(%rbx)
  403055:	48 89 43 28          	mov    %rax,0x28(%rbx)
  403059:	48 89 53 20          	mov    %rdx,0x20(%rbx)
  40305d:	eb 52                	jmp    4030b1 <__stdio_write+0xcb>
  40305f:	48 85 c0             	test   %rax,%rax
  403062:	79 27                	jns    40308b <__stdio_write+0xa5>
  403064:	83 0b 20             	orl    $0x20,(%rbx)
  403067:	41 83 fd 02          	cmp    $0x2,%r13d
  40306b:	48 c7 43 20 00 00 00 	movq   $0x0,0x20(%rbx)
  403072:	00 
  403073:	48 c7 43 38 00 00 00 	movq   $0x0,0x38(%rbx)
  40307a:	00 
  40307b:	48 c7 43 28 00 00 00 	movq   $0x0,0x28(%rbx)
  403082:	00 
  403083:	74 29                	je     4030ae <__stdio_write+0xc8>
  403085:	4c 2b 7d 08          	sub    0x8(%rbp),%r15
  403089:	eb 26                	jmp    4030b1 <__stdio_write+0xcb>
  40308b:	48 8b 55 08          	mov    0x8(%rbp),%rdx
  40308f:	49 29 c4             	sub    %rax,%r12
  403092:	48 39 d0             	cmp    %rdx,%rax
  403095:	76 0a                	jbe    4030a1 <__stdio_write+0xbb>
  403097:	48 29 d0             	sub    %rdx,%rax
  40309a:	48 83 c5 10          	add    $0x10,%rbp
  40309e:	41 ff cd             	dec    %r13d
  4030a1:	48 01 45 00          	add    %rax,0x0(%rbp)
  4030a5:	48 29 45 08          	sub    %rax,0x8(%rbp)
  4030a9:	e9 7c ff ff ff       	jmpq   40302a <__stdio_write+0x44>
  4030ae:	45 31 ff             	xor    %r15d,%r15d
  4030b1:	48 83 c4 28          	add    $0x28,%rsp
  4030b5:	4c 89 f8             	mov    %r15,%rax
  4030b8:	5b                   	pop    %rbx
  4030b9:	5d                   	pop    %rbp
  4030ba:	41 5c                	pop    %r12
  4030bc:	41 5d                	pop    %r13
  4030be:	41 5e                	pop    %r14
  4030c0:	41 5f                	pop    %r15
  4030c2:	c3                   	retq   

00000000004030c3 <__stdout_write>:
  4030c3:	48 83 ec 18          	sub    $0x18,%rsp
  4030c7:	f6 07 40             	testb  $0x40,(%rdi)
  4030ca:	49 89 f8             	mov    %rdi,%r8
  4030cd:	49 89 f1             	mov    %rsi,%r9
  4030d0:	49 89 d2             	mov    %rdx,%r10
  4030d3:	48 c7 47 48 e6 2f 40 	movq   $0x402fe6,0x48(%rdi)
  4030da:	00 
  4030db:	75 25                	jne    403102 <__stdout_write+0x3f>
  4030dd:	48 63 7f 78          	movslq 0x78(%rdi),%rdi
  4030e1:	48 8d 54 24 08       	lea    0x8(%rsp),%rdx
  4030e6:	be 13 54 00 00       	mov    $0x5413,%esi
  4030eb:	b8 10 00 00 00       	mov    $0x10,%eax
  4030f0:	0f 05                	syscall 
  4030f2:	48 85 c0             	test   %rax,%rax
  4030f5:	74 0b                	je     403102 <__stdout_write+0x3f>
  4030f7:	41 c7 80 90 00 00 00 	movl   $0xffffffff,0x90(%r8)
  4030fe:	ff ff ff ff 
  403102:	4c 89 d2             	mov    %r10,%rdx
  403105:	4c 89 ce             	mov    %r9,%rsi
  403108:	4c 89 c7             	mov    %r8,%rdi
  40310b:	e8 d6 fe ff ff       	callq  402fe6 <__stdio_write>
  403110:	48 83 c4 18          	add    $0x18,%rsp
  403114:	c3                   	retq   

0000000000403115 <__towrite>:
  403115:	8b 97 88 00 00 00    	mov    0x88(%rdi),%edx
  40311b:	8d 42 ff             	lea    -0x1(%rdx),%eax
  40311e:	09 d0                	or     %edx,%eax
  403120:	89 87 88 00 00 00    	mov    %eax,0x88(%rdi)
  403126:	8b 07                	mov    (%rdi),%eax
  403128:	a8 08                	test   $0x8,%al
  40312a:	74 09                	je     403135 <__towrite+0x20>
  40312c:	83 c8 20             	or     $0x20,%eax
  40312f:	89 07                	mov    %eax,(%rdi)
  403131:	83 c8 ff             	or     $0xffffffff,%eax
  403134:	c3                   	retq   
  403135:	48 8b 47 58          	mov    0x58(%rdi),%rax
  403139:	48 c7 47 10 00 00 00 	movq   $0x0,0x10(%rdi)
  403140:	00 
  403141:	48 c7 47 08 00 00 00 	movq   $0x0,0x8(%rdi)
  403148:	00 
  403149:	48 89 47 38          	mov    %rax,0x38(%rdi)
  40314d:	48 89 47 28          	mov    %rax,0x28(%rdi)
  403151:	48 03 47 60          	add    0x60(%rdi),%rax
  403155:	48 89 47 20          	mov    %rax,0x20(%rdi)
  403159:	31 c0                	xor    %eax,%eax
  40315b:	c3                   	retq   

000000000040315c <__towrite_needs_stdio_exit>:
  40315c:	e9 4b 0a 00 00       	jmpq   403bac <__stdio_exit>

0000000000403161 <__fwritex>:
  403161:	41 55                	push   %r13
  403163:	41 54                	push   %r12
  403165:	49 89 fd             	mov    %rdi,%r13
  403168:	55                   	push   %rbp
  403169:	53                   	push   %rbx
  40316a:	49 89 f4             	mov    %rsi,%r12
  40316d:	48 89 d3             	mov    %rdx,%rbx
  403170:	48 83 ec 08          	sub    $0x8,%rsp
  403174:	48 83 7a 20 00       	cmpq   $0x0,0x20(%rdx)
  403179:	74 23                	je     40319e <__fwritex+0x3d>
  40317b:	48 8b 43 20          	mov    0x20(%rbx),%rax
  40317f:	48 2b 43 28          	sub    0x28(%rbx),%rax
  403183:	4c 39 e0             	cmp    %r12,%rax
  403186:	73 26                	jae    4031ae <__fwritex+0x4d>
  403188:	48 8b 43 48          	mov    0x48(%rbx),%rax
  40318c:	4c 89 e2             	mov    %r12,%rdx
  40318f:	4c 89 ee             	mov    %r13,%rsi
  403192:	59                   	pop    %rcx
  403193:	48 89 df             	mov    %rbx,%rdi
  403196:	5b                   	pop    %rbx
  403197:	5d                   	pop    %rbp
  403198:	41 5c                	pop    %r12
  40319a:	41 5d                	pop    %r13
  40319c:	ff e0                	jmpq   *%rax
  40319e:	48 89 d7             	mov    %rdx,%rdi
  4031a1:	e8 6f ff ff ff       	callq  403115 <__towrite>
  4031a6:	85 c0                	test   %eax,%eax
  4031a8:	74 d1                	je     40317b <__fwritex+0x1a>
  4031aa:	31 c0                	xor    %eax,%eax
  4031ac:	eb 56                	jmp    403204 <__fwritex+0xa3>
  4031ae:	83 bb 90 00 00 00 00 	cmpl   $0x0,0x90(%rbx)
  4031b5:	4c 89 e5             	mov    %r12,%rbp
  4031b8:	78 16                	js     4031d0 <__fwritex+0x6f>
  4031ba:	48 85 ed             	test   %rbp,%rbp
  4031bd:	74 13                	je     4031d2 <__fwritex+0x71>
  4031bf:	41 80 7c 2d ff 0a    	cmpb   $0xa,-0x1(%r13,%rbp,1)
  4031c5:	48 8d 45 ff          	lea    -0x1(%rbp),%rax
  4031c9:	74 20                	je     4031eb <__fwritex+0x8a>
  4031cb:	48 89 c5             	mov    %rax,%rbp
  4031ce:	eb ea                	jmp    4031ba <__fwritex+0x59>
  4031d0:	31 ed                	xor    %ebp,%ebp
  4031d2:	48 8b 7b 28          	mov    0x28(%rbx),%rdi
  4031d6:	4c 89 e2             	mov    %r12,%rdx
  4031d9:	4c 89 ee             	mov    %r13,%rsi
  4031dc:	e8 cc 01 00 00       	callq  4033ad <memcpy>
  4031e1:	4c 01 63 28          	add    %r12,0x28(%rbx)
  4031e5:	49 8d 04 2c          	lea    (%r12,%rbp,1),%rax
  4031e9:	eb 19                	jmp    403204 <__fwritex+0xa3>
  4031eb:	48 89 ea             	mov    %rbp,%rdx
  4031ee:	4c 89 ee             	mov    %r13,%rsi
  4031f1:	48 89 df             	mov    %rbx,%rdi
  4031f4:	ff 53 48             	callq  *0x48(%rbx)
  4031f7:	48 39 c5             	cmp    %rax,%rbp
  4031fa:	77 08                	ja     403204 <__fwritex+0xa3>
  4031fc:	49 01 ed             	add    %rbp,%r13
  4031ff:	49 29 ec             	sub    %rbp,%r12
  403202:	eb ce                	jmp    4031d2 <__fwritex+0x71>
  403204:	5a                   	pop    %rdx
  403205:	5b                   	pop    %rbx
  403206:	5d                   	pop    %rbp
  403207:	41 5c                	pop    %r12
  403209:	41 5d                	pop    %r13
  40320b:	c3                   	retq   

000000000040320c <fwrite>:
  40320c:	41 57                	push   %r15
  40320e:	41 56                	push   %r14
  403210:	b8 00 00 00 00       	mov    $0x0,%eax
  403215:	41 55                	push   %r13
  403217:	41 54                	push   %r12
  403219:	49 89 f5             	mov    %rsi,%r13
  40321c:	55                   	push   %rbp
  40321d:	53                   	push   %rbx
  40321e:	48 89 d3             	mov    %rdx,%rbx
  403221:	4c 0f af ea          	imul   %rdx,%r13
  403225:	49 89 ff             	mov    %rdi,%r15
  403228:	48 89 f5             	mov    %rsi,%rbp
  40322b:	48 83 ec 18          	sub    $0x18,%rsp
  40322f:	48 85 f6             	test   %rsi,%rsi
  403232:	49 89 cc             	mov    %rcx,%r12
  403235:	48 0f 44 d8          	cmove  %rax,%rbx
  403239:	8b 81 8c 00 00 00    	mov    0x8c(%rcx),%eax
  40323f:	45 31 f6             	xor    %r14d,%r14d
  403242:	85 c0                	test   %eax,%eax
  403244:	78 0b                	js     403251 <fwrite+0x45>
  403246:	48 89 cf             	mov    %rcx,%rdi
  403249:	e8 6e fc ff ff       	callq  402ebc <__lockfile>
  40324e:	41 89 c6             	mov    %eax,%r14d
  403251:	4c 89 e2             	mov    %r12,%rdx
  403254:	4c 89 ee             	mov    %r13,%rsi
  403257:	4c 89 ff             	mov    %r15,%rdi
  40325a:	e8 02 ff ff ff       	callq  403161 <__fwritex>
  40325f:	45 85 f6             	test   %r14d,%r14d
  403262:	74 12                	je     403276 <fwrite+0x6a>
  403264:	4c 89 e7             	mov    %r12,%rdi
  403267:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
  40326c:	e8 00 fd ff ff       	callq  402f71 <__unlockfile>
  403271:	48 8b 44 24 08       	mov    0x8(%rsp),%rax
  403276:	49 39 c5             	cmp    %rax,%r13
  403279:	74 08                	je     403283 <fwrite+0x77>
  40327b:	31 d2                	xor    %edx,%edx
  40327d:	48 f7 f5             	div    %rbp
  403280:	48 89 c3             	mov    %rax,%rbx
  403283:	48 83 c4 18          	add    $0x18,%rsp
  403287:	48 89 d8             	mov    %rbx,%rax
  40328a:	5b                   	pop    %rbx
  40328b:	5d                   	pop    %rbp
  40328c:	41 5c                	pop    %r12
  40328e:	41 5d                	pop    %r13
  403290:	41 5e                	pop    %r14
  403292:	41 5f                	pop    %r15
  403294:	c3                   	retq   

0000000000403295 <__ofl_lock>:
  403295:	48 83 ec 08          	sub    $0x8,%rsp
  403299:	bf 98 58 60 00       	mov    $0x605898,%edi
  40329e:	e8 3c 01 00 00       	callq  4033df <__lock>
  4032a3:	b8 a0 58 60 00       	mov    $0x6058a0,%eax
  4032a8:	5a                   	pop    %rdx
  4032a9:	c3                   	retq   

00000000004032aa <__ofl_unlock>:
  4032aa:	bf 98 58 60 00       	mov    $0x605898,%edi
  4032af:	e9 cf 01 00 00       	jmpq   403483 <__unlock>
  4032b4:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  4032bb:	00 00 00 
  4032be:	66 90                	xchg   %ax,%ax

00000000004032c0 <memchr>:
  4032c0:	40 f6 c7 07          	test   $0x7,%dil
  4032c4:	40 0f b6 f6          	movzbl %sil,%esi
  4032c8:	75 1f                	jne    4032e9 <memchr+0x29>
  4032ca:	eb 2c                	jmp    4032f8 <memchr+0x38>
  4032cc:	0f 1f 40 00          	nopl   0x0(%rax)
  4032d0:	0f b6 07             	movzbl (%rdi),%eax
  4032d3:	39 c6                	cmp    %eax,%esi
  4032d5:	0f 84 a5 00 00 00    	je     403380 <memchr+0xc0>
  4032db:	48 83 c7 01          	add    $0x1,%rdi
  4032df:	48 83 ea 01          	sub    $0x1,%rdx
  4032e3:	40 f6 c7 07          	test   $0x7,%dil
  4032e7:	74 0f                	je     4032f8 <memchr+0x38>
  4032e9:	48 85 d2             	test   %rdx,%rdx
  4032ec:	75 e2                	jne    4032d0 <memchr+0x10>
  4032ee:	31 c0                	xor    %eax,%eax
  4032f0:	f3 c3                	repz retq 
  4032f2:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  4032f8:	31 c0                	xor    %eax,%eax
  4032fa:	48 85 d2             	test   %rdx,%rdx
  4032fd:	74 f1                	je     4032f0 <memchr+0x30>
  4032ff:	0f b6 07             	movzbl (%rdi),%eax
  403302:	39 c6                	cmp    %eax,%esi
  403304:	74 7a                	je     403380 <memchr+0xc0>
  403306:	4c 63 d6             	movslq %esi,%r10
  403309:	49 b8 01 01 01 01 01 	movabs $0x101010101010101,%r8
  403310:	01 01 01 
  403313:	4d 0f af d0          	imul   %r8,%r10
  403317:	48 83 fa 07          	cmp    $0x7,%rdx
  40331b:	76 6a                	jbe    403387 <memchr+0xc7>
  40331d:	4c 89 d0             	mov    %r10,%rax
  403320:	48 33 07             	xor    (%rdi),%rax
  403323:	48 89 c1             	mov    %rax,%rcx
  403326:	4c 29 c0             	sub    %r8,%rax
  403329:	49 b8 80 80 80 80 80 	movabs $0x8080808080808080,%r8
  403330:	80 80 80 
  403333:	48 f7 d1             	not    %rcx
  403336:	48 21 c8             	and    %rcx,%rax
  403339:	4c 85 c0             	test   %r8,%rax
  40333c:	75 49                	jne    403387 <memchr+0xc7>
  40333e:	49 b9 ff fe fe fe fe 	movabs $0xfefefefefefefeff,%r9
  403345:	fe fe fe 
  403348:	eb 1b                	jmp    403365 <memchr+0xa5>
  40334a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)
  403350:	4c 89 d0             	mov    %r10,%rax
  403353:	48 33 07             	xor    (%rdi),%rax
  403356:	4a 8d 0c 08          	lea    (%rax,%r9,1),%rcx
  40335a:	48 f7 d0             	not    %rax
  40335d:	48 21 c8             	and    %rcx,%rax
  403360:	4c 85 c0             	test   %r8,%rax
  403363:	75 1b                	jne    403380 <memchr+0xc0>
  403365:	48 83 ea 08          	sub    $0x8,%rdx
  403369:	48 83 c7 08          	add    $0x8,%rdi
  40336d:	48 83 fa 07          	cmp    $0x7,%rdx
  403371:	77 dd                	ja     403350 <memchr+0x90>
  403373:	48 85 d2             	test   %rdx,%rdx
  403376:	0f 84 72 ff ff ff    	je     4032ee <memchr+0x2e>
  40337c:	0f 1f 40 00          	nopl   0x0(%rax)
  403380:	0f b6 07             	movzbl (%rdi),%eax
  403383:	39 c6                	cmp    %eax,%esi
  403385:	74 22                	je     4033a9 <memchr+0xe9>
  403387:	48 8d 4f 01          	lea    0x1(%rdi),%rcx
  40338b:	48 01 d7             	add    %rdx,%rdi
  40338e:	66 90                	xchg   %ax,%ax
  403390:	48 39 cf             	cmp    %rcx,%rdi
  403393:	48 89 c8             	mov    %rcx,%rax
  403396:	0f 84 52 ff ff ff    	je     4032ee <memchr+0x2e>
  40339c:	0f b6 10             	movzbl (%rax),%edx
  40339f:	48 83 c1 01          	add    $0x1,%rcx
  4033a3:	39 d6                	cmp    %edx,%esi
  4033a5:	75 e9                	jne    403390 <memchr+0xd0>
  4033a7:	f3 c3                	repz retq 
  4033a9:	48 89 f8             	mov    %rdi,%rax
  4033ac:	c3                   	retq   

00000000004033ad <memcpy>:
  4033ad:	48 89 f8             	mov    %rdi,%rax
  4033b0:	48 83 fa 08          	cmp    $0x8,%rdx
  4033b4:	72 14                	jb     4033ca <memcpy+0x1d>
  4033b6:	f7 c7 07 00 00 00    	test   $0x7,%edi
  4033bc:	74 0c                	je     4033ca <memcpy+0x1d>
  4033be:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
  4033bf:	48 ff ca             	dec    %rdx
  4033c2:	f7 c7 07 00 00 00    	test   $0x7,%edi
  4033c8:	75 f4                	jne    4033be <memcpy+0x11>
  4033ca:	48 89 d1             	mov    %rdx,%rcx
  4033cd:	48 c1 e9 03          	shr    $0x3,%rcx
  4033d1:	f3 48 a5             	rep movsq %ds:(%rsi),%es:(%rdi)
  4033d4:	83 e2 07             	and    $0x7,%edx
  4033d7:	74 05                	je     4033de <memcpy+0x31>
  4033d9:	a4                   	movsb  %ds:(%rsi),%es:(%rdi)
  4033da:	ff ca                	dec    %edx
  4033dc:	75 fb                	jne    4033d9 <memcpy+0x2c>
  4033de:	c3                   	retq   

00000000004033df <__lock>:
  4033df:	8b 05 07 25 20 00    	mov    0x202507(%rip),%eax        # 6058ec <__libc+0xc>
  4033e5:	85 c0                	test   %eax,%eax
  4033e7:	0f 84 95 00 00 00    	je     403482 <__lock+0xa3>
  4033ed:	ba 01 00 00 80       	mov    $0x80000001,%edx
  4033f2:	31 c0                	xor    %eax,%eax
  4033f4:	f0 0f b1 17          	lock cmpxchg %edx,(%rdi)
  4033f8:	85 c0                	test   %eax,%eax
  4033fa:	89 c2                	mov    %eax,%edx
  4033fc:	0f 84 80 00 00 00    	je     403482 <__lock+0xa3>
  403402:	be 0a 00 00 00       	mov    $0xa,%esi
  403407:	8d 82 ff ff ff 7f    	lea    0x7fffffff(%rdx),%eax
  40340d:	85 d2                	test   %edx,%edx
  40340f:	0f 48 d0             	cmovs  %eax,%edx
  403412:	8d 8a 01 00 00 80    	lea    -0x7fffffff(%rdx),%ecx
  403418:	89 d0                	mov    %edx,%eax
  40341a:	f0 0f b1 0f          	lock cmpxchg %ecx,(%rdi)
  40341e:	39 c2                	cmp    %eax,%edx
  403420:	74 60                	je     403482 <__lock+0xa3>
  403422:	ff ce                	dec    %esi
  403424:	89 c2                	mov    %eax,%edx
  403426:	75 df                	jne    403407 <__lock+0x28>
  403428:	53                   	push   %rbx
  403429:	41 b8 01 00 00 00    	mov    $0x1,%r8d
  40342f:	f0 44 0f c1 07       	lock xadd %r8d,(%rdi)
  403434:	41 b9 ca 00 00 00    	mov    $0xca,%r9d
  40343a:	41 ff c0             	inc    %r8d
  40343d:	bb 80 00 00 00       	mov    $0x80,%ebx
  403442:	45 85 c0             	test   %r8d,%r8d
  403445:	44 89 c2             	mov    %r8d,%edx
  403448:	79 22                	jns    40346c <__lock+0x8d>
  40344a:	49 63 d0             	movslq %r8d,%rdx
  40344d:	45 31 d2             	xor    %r10d,%r10d
  403450:	4c 89 c8             	mov    %r9,%rax
  403453:	48 89 de             	mov    %rbx,%rsi
  403456:	0f 05                	syscall 
  403458:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  40345c:	75 07                	jne    403465 <__lock+0x86>
  40345e:	31 f6                	xor    %esi,%esi
  403460:	4c 89 c8             	mov    %r9,%rax
  403463:	0f 05                	syscall 
  403465:	41 8d 90 ff ff ff 7f 	lea    0x7fffffff(%r8),%edx
  40346c:	44 8d 82 00 00 00 80 	lea    -0x80000000(%rdx),%r8d
  403473:	89 d0                	mov    %edx,%eax
  403475:	f0 44 0f b1 07       	lock cmpxchg %r8d,(%rdi)
  40347a:	39 c2                	cmp    %eax,%edx
  40347c:	41 89 c0             	mov    %eax,%r8d
  40347f:	75 c1                	jne    403442 <__lock+0x63>
  403481:	5b                   	pop    %rbx
  403482:	c3                   	retq   

0000000000403483 <__unlock>:
  403483:	8b 07                	mov    (%rdi),%eax
  403485:	85 c0                	test   %eax,%eax
  403487:	79 33                	jns    4034bc <__unlock+0x39>
  403489:	b8 ff ff ff 7f       	mov    $0x7fffffff,%eax
  40348e:	f0 0f c1 07          	lock xadd %eax,(%rdi)
  403492:	3d 01 00 00 80       	cmp    $0x80000001,%eax
  403497:	74 23                	je     4034bc <__unlock+0x39>
  403499:	41 b8 ca 00 00 00    	mov    $0xca,%r8d
  40349f:	ba 01 00 00 00       	mov    $0x1,%edx
  4034a4:	be 81 00 00 00       	mov    $0x81,%esi
  4034a9:	4c 89 c0             	mov    %r8,%rax
  4034ac:	0f 05                	syscall 
  4034ae:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  4034b2:	75 08                	jne    4034bc <__unlock+0x39>
  4034b4:	4c 89 c0             	mov    %r8,%rax
  4034b7:	48 89 d6             	mov    %rdx,%rsi
  4034ba:	0f 05                	syscall 
  4034bc:	c3                   	retq   

00000000004034bd <__timedwait_cp>:
  4034bd:	41 54                	push   %r12
  4034bf:	55                   	push   %rbp
  4034c0:	b8 80 00 00 00       	mov    $0x80,%eax
  4034c5:	53                   	push   %rbx
  4034c6:	48 63 ee             	movslq %esi,%rbp
  4034c9:	48 89 fb             	mov    %rdi,%rbx
  4034cc:	48 83 ec 20          	sub    $0x20,%rsp
  4034d0:	45 85 c0             	test   %r8d,%r8d
  4034d3:	44 0f 45 c0          	cmovne %eax,%r8d
  4034d7:	48 85 c9             	test   %rcx,%rcx
  4034da:	74 7a                	je     403556 <__timedwait_cp+0x99>
  4034dc:	48 81 79 08 ff c9 9a 	cmpq   $0x3b9ac9ff,0x8(%rcx)
  4034e3:	3b 
  4034e4:	49 89 cc             	mov    %rcx,%r12
  4034e7:	76 0a                	jbe    4034f3 <__timedwait_cp+0x36>
  4034e9:	b8 16 00 00 00       	mov    $0x16,%eax
  4034ee:	e9 dc 00 00 00       	jmpq   4035cf <__timedwait_cp+0x112>
  4034f3:	48 8d 74 24 10       	lea    0x10(%rsp),%rsi
  4034f8:	89 d7                	mov    %edx,%edi
  4034fa:	44 89 44 24 0c       	mov    %r8d,0xc(%rsp)
  4034ff:	e8 f7 01 00 00       	callq  4036fb <__clock_gettime>
  403504:	85 c0                	test   %eax,%eax
  403506:	44 8b 44 24 0c       	mov    0xc(%rsp),%r8d
  40350b:	75 dc                	jne    4034e9 <__timedwait_cp+0x2c>
  40350d:	49 8b 44 24 08       	mov    0x8(%r12),%rax
  403512:	48 2b 44 24 18       	sub    0x18(%rsp),%rax
  403517:	49 8b 14 24          	mov    (%r12),%rdx
  40351b:	48 2b 54 24 10       	sub    0x10(%rsp),%rdx
  403520:	48 85 c0             	test   %rax,%rax
  403523:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  403528:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  40352d:	79 13                	jns    403542 <__timedwait_cp+0x85>
  40352f:	48 ff ca             	dec    %rdx
  403532:	48 05 00 ca 9a 3b    	add    $0x3b9aca00,%rax
  403538:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
  40353d:	48 89 44 24 18       	mov    %rax,0x18(%rsp)
  403542:	48 83 7c 24 10 00    	cmpq   $0x0,0x10(%rsp)
  403548:	b8 6e 00 00 00       	mov    $0x6e,%eax
  40354d:	4c 8d 64 24 10       	lea    0x10(%rsp),%r12
  403552:	79 05                	jns    403559 <__timedwait_cp+0x9c>
  403554:	eb 79                	jmp    4035cf <__timedwait_cp+0x112>
  403556:	45 31 e4             	xor    %r12d,%r12d
  403559:	48 83 ec 08          	sub    $0x8,%rsp
  40355d:	49 63 d0             	movslq %r8d,%rdx
  403560:	45 31 c9             	xor    %r9d,%r9d
  403563:	6a 00                	pushq  $0x0
  403565:	48 89 de             	mov    %rbx,%rsi
  403568:	bf ca 00 00 00       	mov    $0xca,%edi
  40356d:	4d 89 e0             	mov    %r12,%r8
  403570:	48 89 e9             	mov    %rbp,%rcx
  403573:	e8 b2 06 00 00       	callq  403c2a <__syscall_cp>
  403578:	f7 d8                	neg    %eax
  40357a:	83 f8 26             	cmp    $0x26,%eax
  40357d:	5e                   	pop    %rsi
  40357e:	5f                   	pop    %rdi
  40357f:	75 22                	jne    4035a3 <__timedwait_cp+0xe6>
  403581:	48 83 ec 08          	sub    $0x8,%rsp
  403585:	48 89 e9             	mov    %rbp,%rcx
  403588:	31 d2                	xor    %edx,%edx
  40358a:	6a 00                	pushq  $0x0
  40358c:	45 31 c9             	xor    %r9d,%r9d
  40358f:	4d 89 e0             	mov    %r12,%r8
  403592:	48 89 de             	mov    %rbx,%rsi
  403595:	bf ca 00 00 00       	mov    $0xca,%edi
  40359a:	e8 8b 06 00 00       	callq  403c2a <__syscall_cp>
  40359f:	5a                   	pop    %rdx
  4035a0:	59                   	pop    %rcx
  4035a1:	f7 d8                	neg    %eax
  4035a3:	83 f8 04             	cmp    $0x4,%eax
  4035a6:	74 12                	je     4035ba <__timedwait_cp+0xfd>
  4035a8:	83 f8 6e             	cmp    $0x6e,%eax
  4035ab:	74 0d                	je     4035ba <__timedwait_cp+0xfd>
  4035ad:	83 f8 7d             	cmp    $0x7d,%eax
  4035b0:	ba 00 00 00 00       	mov    $0x0,%edx
  4035b5:	0f 45 c2             	cmovne %edx,%eax
  4035b8:	eb 15                	jmp    4035cf <__timedwait_cp+0x112>
  4035ba:	83 f8 04             	cmp    $0x4,%eax
  4035bd:	75 10                	jne    4035cf <__timedwait_cp+0x112>
  4035bf:	8b 15 e3 22 20 00    	mov    0x2022e3(%rip),%edx        # 6058a8 <__eintr_valid_flag>
  4035c5:	85 d2                	test   %edx,%edx
  4035c7:	ba 00 00 00 00       	mov    $0x0,%edx
  4035cc:	0f 44 c2             	cmove  %edx,%eax
  4035cf:	48 83 c4 20          	add    $0x20,%rsp
  4035d3:	5b                   	pop    %rbx
  4035d4:	5d                   	pop    %rbp
  4035d5:	41 5c                	pop    %r12
  4035d7:	c3                   	retq   

00000000004035d8 <__timedwait>:
  4035d8:	55                   	push   %rbp
  4035d9:	53                   	push   %rbx
  4035da:	89 f5                	mov    %esi,%ebp
  4035dc:	48 89 fb             	mov    %rdi,%rbx
  4035df:	bf 01 00 00 00       	mov    $0x1,%edi
  4035e4:	48 83 ec 28          	sub    $0x28,%rsp
  4035e8:	48 8d 74 24 1c       	lea    0x1c(%rsp),%rsi
  4035ed:	89 54 24 0c          	mov    %edx,0xc(%rsp)
  4035f1:	48 89 0c 24          	mov    %rcx,(%rsp)
  4035f5:	44 89 44 24 08       	mov    %r8d,0x8(%rsp)
  4035fa:	e8 99 f2 ff ff       	callq  402898 <__pthread_setcancelstate>
  4035ff:	44 8b 44 24 08       	mov    0x8(%rsp),%r8d
  403604:	48 8b 0c 24          	mov    (%rsp),%rcx
  403608:	89 ee                	mov    %ebp,%esi
  40360a:	8b 54 24 0c          	mov    0xc(%rsp),%edx
  40360e:	48 89 df             	mov    %rbx,%rdi
  403611:	e8 a7 fe ff ff       	callq  4034bd <__timedwait_cp>
  403616:	8b 7c 24 1c          	mov    0x1c(%rsp),%edi
  40361a:	31 f6                	xor    %esi,%esi
  40361c:	89 c3                	mov    %eax,%ebx
  40361e:	e8 75 f2 ff ff       	callq  402898 <__pthread_setcancelstate>
  403623:	48 83 c4 28          	add    $0x28,%rsp
  403627:	89 d8                	mov    %ebx,%eax
  403629:	5b                   	pop    %rbx
  40362a:	5d                   	pop    %rbp
  40362b:	c3                   	retq   

000000000040362c <__wait>:
  40362c:	b8 80 00 00 00       	mov    $0x80,%eax
  403631:	85 c9                	test   %ecx,%ecx
  403633:	41 54                	push   %r12
  403635:	0f 45 c8             	cmovne %eax,%ecx
  403638:	55                   	push   %rbp
  403639:	49 89 f0             	mov    %rsi,%r8
  40363c:	53                   	push   %rbx
  40363d:	b8 65 00 00 00       	mov    $0x65,%eax
  403642:	89 d3                	mov    %edx,%ebx
  403644:	ff c8                	dec    %eax
  403646:	74 18                	je     403660 <__wait+0x34>
  403648:	4d 85 c0             	test   %r8,%r8
  40364b:	75 0a                	jne    403657 <__wait+0x2b>
  40364d:	8b 17                	mov    (%rdi),%edx
  40364f:	39 da                	cmp    %ebx,%edx
  403651:	75 50                	jne    4036a3 <__wait+0x77>
  403653:	f3 90                	pause  
  403655:	eb ed                	jmp    403644 <__wait+0x18>
  403657:	41 8b 10             	mov    (%r8),%edx
  40365a:	85 d2                	test   %edx,%edx
  40365c:	74 ef                	je     40364d <__wait+0x21>
  40365e:	eb 05                	jmp    403665 <__wait+0x39>
  403660:	4d 85 c0             	test   %r8,%r8
  403663:	74 04                	je     403669 <__wait+0x3d>
  403665:	f0 41 ff 00          	lock incl (%r8)
  403669:	48 63 d3             	movslq %ebx,%rdx
  40366c:	4c 63 c9             	movslq %ecx,%r9
  40366f:	bd ca 00 00 00       	mov    $0xca,%ebp
  403674:	41 bc ca 00 00 00    	mov    $0xca,%r12d
  40367a:	8b 07                	mov    (%rdi),%eax
  40367c:	39 c3                	cmp    %eax,%ebx
  40367e:	75 1a                	jne    40369a <__wait+0x6e>
  403680:	45 31 d2             	xor    %r10d,%r10d
  403683:	48 89 e8             	mov    %rbp,%rax
  403686:	4c 89 ce             	mov    %r9,%rsi
  403689:	0f 05                	syscall 
  40368b:	48 83 f8 da          	cmp    $0xffffffffffffffda,%rax
  40368f:	75 e9                	jne    40367a <__wait+0x4e>
  403691:	31 f6                	xor    %esi,%esi
  403693:	4c 89 e0             	mov    %r12,%rax
  403696:	0f 05                	syscall 
  403698:	eb e0                	jmp    40367a <__wait+0x4e>
  40369a:	4d 85 c0             	test   %r8,%r8
  40369d:	74 04                	je     4036a3 <__wait+0x77>
  40369f:	f0 41 ff 08          	lock decl (%r8)
  4036a3:	5b                   	pop    %rbx
  4036a4:	5d                   	pop    %rbp
  4036a5:	41 5c                	pop    %r12
  4036a7:	c3                   	retq   

00000000004036a8 <__set_thread_area>:
  4036a8:	48 89 fe             	mov    %rdi,%rsi
  4036ab:	bf 02 10 00 00       	mov    $0x1002,%edi
  4036b0:	b8 9e 00 00 00       	mov    $0x9e,%eax
  4036b5:	0f 05                	syscall 
  4036b7:	c3                   	retq   

00000000004036b8 <cgt_init>:
  4036b8:	55                   	push   %rbp
  4036b9:	53                   	push   %rbx
  4036ba:	48 89 f5             	mov    %rsi,%rbp
  4036bd:	89 fb                	mov    %edi,%ebx
  4036bf:	be d0 49 40 00       	mov    $0x4049d0,%esi
  4036c4:	bf e5 49 40 00       	mov    $0x4049e5,%edi
  4036c9:	48 83 ec 08          	sub    $0x8,%rsp
  4036cd:	e8 ce 00 00 00       	callq  4037a0 <__vdsosym>
  4036d2:	48 89 c2             	mov    %rax,%rdx
  4036d5:	b8 b8 36 40 00       	mov    $0x4036b8,%eax
  4036da:	f0 48 0f b1 15 2d 1b 	lock cmpxchg %rdx,0x201b2d(%rip)        # 605210 <vdso_func>
  4036e1:	20 00 
  4036e3:	48 85 d2             	test   %rdx,%rdx
  4036e6:	74 0a                	je     4036f2 <cgt_init+0x3a>
  4036e8:	59                   	pop    %rcx
  4036e9:	48 89 ee             	mov    %rbp,%rsi
  4036ec:	89 df                	mov    %ebx,%edi
  4036ee:	5b                   	pop    %rbx
  4036ef:	5d                   	pop    %rbp
  4036f0:	ff e2                	jmpq   *%rdx
  4036f2:	5a                   	pop    %rdx
  4036f3:	b8 da ff ff ff       	mov    $0xffffffda,%eax
  4036f8:	5b                   	pop    %rbx
  4036f9:	5d                   	pop    %rbp
  4036fa:	c3                   	retq   

00000000004036fb <__clock_gettime>:
  4036fb:	55                   	push   %rbp
  4036fc:	53                   	push   %rbx
  4036fd:	89 fd                	mov    %edi,%ebp
  4036ff:	48 89 f3             	mov    %rsi,%rbx
  403702:	48 83 ec 08          	sub    $0x8,%rsp
  403706:	48 8b 05 03 1b 20 00 	mov    0x201b03(%rip),%rax        # 605210 <vdso_func>
  40370d:	48 85 c0             	test   %rax,%rax
  403710:	74 12                	je     403724 <__clock_gettime+0x29>
  403712:	ff d0                	callq  *%rax
  403714:	85 c0                	test   %eax,%eax
  403716:	74 4e                	je     403766 <__clock_gettime+0x6b>
  403718:	83 f8 ea             	cmp    $0xffffffea,%eax
  40371b:	48 c7 c7 ea ff ff ff 	mov    $0xffffffffffffffea,%rdi
  403722:	74 3d                	je     403761 <__clock_gettime+0x66>
  403724:	48 63 fd             	movslq %ebp,%rdi
  403727:	b8 e4 00 00 00       	mov    $0xe4,%eax
  40372c:	48 89 de             	mov    %rbx,%rsi
  40372f:	0f 05                	syscall 
  403731:	83 f8 da             	cmp    $0xffffffda,%eax
  403734:	48 63 f8             	movslq %eax,%rdi
  403737:	75 28                	jne    403761 <__clock_gettime+0x66>
  403739:	85 ed                	test   %ebp,%ebp
  40373b:	48 c7 c7 ea ff ff ff 	mov    $0xffffffffffffffea,%rdi
  403742:	75 1d                	jne    403761 <__clock_gettime+0x66>
  403744:	31 f6                	xor    %esi,%esi
  403746:	b8 60 00 00 00       	mov    $0x60,%eax
  40374b:	48 89 df             	mov    %rbx,%rdi
  40374e:	0f 05                	syscall 
  403750:	69 43 08 e8 03 00 00 	imul   $0x3e8,0x8(%rbx),%eax
  403757:	48 98                	cltq   
  403759:	48 89 43 08          	mov    %rax,0x8(%rbx)
  40375d:	31 c0                	xor    %eax,%eax
  40375f:	eb 05                	jmp    403766 <__clock_gettime+0x6b>
  403761:	e8 0a 00 00 00       	callq  403770 <__syscall_ret>
  403766:	5a                   	pop    %rdx
  403767:	5b                   	pop    %rbx
  403768:	5d                   	pop    %rbp
  403769:	c3                   	retq   
  40376a:	66 0f 1f 44 00 00    	nopw   0x0(%rax,%rax,1)

0000000000403770 <__syscall_ret>:
  403770:	48 81 ff 00 f0 ff ff 	cmp    $0xfffffffffffff000,%rdi
  403777:	77 07                	ja     403780 <__syscall_ret+0x10>
  403779:	48 89 f8             	mov    %rdi,%rax
  40377c:	c3                   	retq   
  40377d:	0f 1f 00             	nopl   (%rax)
  403780:	53                   	push   %rbx
  403781:	48 89 fb             	mov    %rdi,%rbx
  403784:	e8 57 f4 ff ff       	callq  402be0 <__errno_location>
  403789:	89 df                	mov    %ebx,%edi
  40378b:	f7 df                	neg    %edi
  40378d:	89 38                	mov    %edi,(%rax)
  40378f:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  403796:	5b                   	pop    %rbx
  403797:	c3                   	retq   
  403798:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40379f:	00 

00000000004037a0 <__vdsosym>:
  4037a0:	4c 8b 05 49 21 20 00 	mov    0x202149(%rip),%r8        # 6058f0 <__libc+0x10>
  4037a7:	49 8b 00             	mov    (%r8),%rax
  4037aa:	48 83 f8 21          	cmp    $0x21,%rax
  4037ae:	0f 84 5a 02 00 00    	je     403a0e <__vdsosym+0x26e>
  4037b4:	31 c9                	xor    %ecx,%ecx
  4037b6:	48 85 c0             	test   %rax,%rax
  4037b9:	75 11                	jne    4037cc <__vdsosym+0x2c>
  4037bb:	e9 80 01 00 00       	jmpq   403940 <__vdsosym+0x1a0>
  4037c0:	48 85 c0             	test   %rax,%rax
  4037c3:	48 89 d1             	mov    %rdx,%rcx
  4037c6:	0f 84 74 01 00 00    	je     403940 <__vdsosym+0x1a0>
  4037cc:	48 8d 51 02          	lea    0x2(%rcx),%rdx
  4037d0:	49 8b 04 d0          	mov    (%r8,%rdx,8),%rax
  4037d4:	48 83 f8 21          	cmp    $0x21,%rax
  4037d8:	75 e6                	jne    4037c0 <__vdsosym+0x20>
  4037da:	48 8d 04 cd 18 00 00 	lea    0x18(,%rcx,8),%rax
  4037e1:	00 
  4037e2:	4d 8b 1c 00          	mov    (%r8,%rax,1),%r11
  4037e6:	4d 85 db             	test   %r11,%r11
  4037e9:	0f 84 51 01 00 00    	je     403940 <__vdsosym+0x1a0>
  4037ef:	45 0f b7 4b 38       	movzwl 0x38(%r11),%r9d
  4037f4:	4c 89 da             	mov    %r11,%rdx
  4037f7:	49 03 53 20          	add    0x20(%r11),%rdx
  4037fb:	4d 85 c9             	test   %r9,%r9
  4037fe:	0f 84 3c 01 00 00    	je     403940 <__vdsosym+0x1a0>
  403804:	41 57                	push   %r15
  403806:	41 56                	push   %r14
  403808:	31 c0                	xor    %eax,%eax
  40380a:	41 55                	push   %r13
  40380c:	41 54                	push   %r12
  40380e:	31 c9                	xor    %ecx,%ecx
  403810:	55                   	push   %rbp
  403811:	53                   	push   %rbx
  403812:	48 c7 c5 ff ff ff ff 	mov    $0xffffffffffffffff,%rbp
  403819:	48 83 ec 28          	sub    $0x28,%rsp
  40381d:	45 0f b7 53 36       	movzwl 0x36(%r11),%r10d
  403822:	eb 1a                	jmp    40383e <__vdsosym+0x9e>
  403824:	0f 1f 40 00          	nopl   0x0(%rax)
  403828:	41 83 f8 02          	cmp    $0x2,%r8d
  40382c:	0f 84 d6 00 00 00    	je     403908 <__vdsosym+0x168>
  403832:	48 83 c1 01          	add    $0x1,%rcx
  403836:	4c 01 d2             	add    %r10,%rdx
  403839:	4c 39 c9             	cmp    %r9,%rcx
  40383c:	74 20                	je     40385e <__vdsosym+0xbe>
  40383e:	44 8b 02             	mov    (%rdx),%r8d
  403841:	41 83 f8 01          	cmp    $0x1,%r8d
  403845:	75 e1                	jne    403828 <__vdsosym+0x88>
  403847:	4c 89 dd             	mov    %r11,%rbp
  40384a:	48 83 c1 01          	add    $0x1,%rcx
  40384e:	48 03 6a 08          	add    0x8(%rdx),%rbp
  403852:	48 2b 6a 10          	sub    0x10(%rdx),%rbp
  403856:	4c 01 d2             	add    %r10,%rdx
  403859:	4c 39 c9             	cmp    %r9,%rcx
  40385c:	75 e0                	jne    40383e <__vdsosym+0x9e>
  40385e:	48 85 c0             	test   %rax,%rax
  403861:	0f 84 8c 00 00 00    	je     4038f3 <__vdsosym+0x153>
  403867:	48 83 fd ff          	cmp    $0xffffffffffffffff,%rbp
  40386b:	0f 84 82 00 00 00    	je     4038f3 <__vdsosym+0x153>
  403871:	48 8b 18             	mov    (%rax),%rbx
  403874:	48 85 db             	test   %rbx,%rbx
  403877:	74 7a                	je     4038f3 <__vdsosym+0x153>
  403879:	48 83 c0 08          	add    $0x8,%rax
  40387d:	45 31 ed             	xor    %r13d,%r13d
  403880:	45 31 c0             	xor    %r8d,%r8d
  403883:	31 c9                	xor    %ecx,%ecx
  403885:	45 31 c9             	xor    %r9d,%r9d
  403888:	45 31 e4             	xor    %r12d,%r12d
  40388b:	eb 22                	jmp    4038af <__vdsosym+0x10f>
  40388d:	0f 1f 00             	nopl   (%rax)
  403890:	48 83 fb 04          	cmp    $0x4,%rbx
  403894:	0f 84 96 00 00 00    	je     403930 <__vdsosym+0x190>
  40389a:	48 83 fb 05          	cmp    $0x5,%rbx
  40389e:	4c 0f 44 e2          	cmove  %rdx,%r12
  4038a2:	48 83 c0 10          	add    $0x10,%rax
  4038a6:	48 8b 58 f8          	mov    -0x8(%rax),%rbx
  4038aa:	48 85 db             	test   %rbx,%rbx
  4038ad:	74 2f                	je     4038de <__vdsosym+0x13e>
  4038af:	48 89 ea             	mov    %rbp,%rdx
  4038b2:	48 03 10             	add    (%rax),%rdx
  4038b5:	48 83 fb 06          	cmp    $0x6,%rbx
  4038b9:	74 5d                	je     403918 <__vdsosym+0x178>
  4038bb:	76 d3                	jbe    403890 <__vdsosym+0xf0>
  4038bd:	48 81 fb f0 ff ff 6f 	cmp    $0x6ffffff0,%rbx
  4038c4:	74 5a                	je     403920 <__vdsosym+0x180>
  4038c6:	48 81 fb fc ff ff 6f 	cmp    $0x6ffffffc,%rbx
  4038cd:	4c 0f 44 ea          	cmove  %rdx,%r13
  4038d1:	48 83 c0 10          	add    $0x10,%rax
  4038d5:	48 8b 58 f8          	mov    -0x8(%rax),%rbx
  4038d9:	48 85 db             	test   %rbx,%rbx
  4038dc:	75 d1                	jne    4038af <__vdsosym+0x10f>
  4038de:	4d 85 e4             	test   %r12,%r12
  4038e1:	0f 94 c2             	sete   %dl
  4038e4:	4d 85 c9             	test   %r9,%r9
  4038e7:	0f 94 c0             	sete   %al
  4038ea:	08 c2                	or     %al,%dl
  4038ec:	75 05                	jne    4038f3 <__vdsosym+0x153>
  4038ee:	48 85 c9             	test   %rcx,%rcx
  4038f1:	75 50                	jne    403943 <__vdsosym+0x1a3>
  4038f3:	31 c0                	xor    %eax,%eax
  4038f5:	48 83 c4 28          	add    $0x28,%rsp
  4038f9:	5b                   	pop    %rbx
  4038fa:	5d                   	pop    %rbp
  4038fb:	41 5c                	pop    %r12
  4038fd:	41 5d                	pop    %r13
  4038ff:	41 5e                	pop    %r14
  403901:	41 5f                	pop    %r15
  403903:	c3                   	retq   
  403904:	0f 1f 40 00          	nopl   0x0(%rax)
  403908:	4c 89 d8             	mov    %r11,%rax
  40390b:	48 03 42 08          	add    0x8(%rdx),%rax
  40390f:	e9 1e ff ff ff       	jmpq   403832 <__vdsosym+0x92>
  403914:	0f 1f 40 00          	nopl   0x0(%rax)
  403918:	49 89 d1             	mov    %rdx,%r9
  40391b:	eb 85                	jmp    4038a2 <__vdsosym+0x102>
  40391d:	0f 1f 00             	nopl   (%rax)
  403920:	49 89 d0             	mov    %rdx,%r8
  403923:	e9 7a ff ff ff       	jmpq   4038a2 <__vdsosym+0x102>
  403928:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40392f:	00 
  403930:	48 89 d1             	mov    %rdx,%rcx
  403933:	e9 6a ff ff ff       	jmpq   4038a2 <__vdsosym+0x102>
  403938:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40393f:	00 
  403940:	31 c0                	xor    %eax,%eax
  403942:	c3                   	retq   
  403943:	44 8b 51 04          	mov    0x4(%rcx),%r10d
  403947:	4d 85 ed             	test   %r13,%r13
  40394a:	4c 0f 44 c3          	cmove  %rbx,%r8
  40394e:	45 85 d2             	test   %r10d,%r10d
  403951:	74 a0                	je     4038f3 <__vdsosym+0x153>
  403953:	48 89 74 24 10       	mov    %rsi,0x10(%rsp)
  403958:	48 89 7c 24 18       	mov    %rdi,0x18(%rsp)
  40395d:	4d 89 cf             	mov    %r9,%r15
  403960:	41 be 27 00 00 00    	mov    $0x27,%r14d
  403966:	eb 1c                	jmp    403984 <__vdsosym+0x1e4>
  403968:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  40396f:	00 
  403970:	48 83 c3 01          	add    $0x1,%rbx
  403974:	44 89 d0             	mov    %r10d,%eax
  403977:	49 83 c7 18          	add    $0x18,%r15
  40397b:	48 39 d8             	cmp    %rbx,%rax
  40397e:	0f 86 6f ff ff ff    	jbe    4038f3 <__vdsosym+0x153>
  403984:	41 0f b6 47 04       	movzbl 0x4(%r15),%eax
  403989:	89 c6                	mov    %eax,%esi
  40398b:	83 e6 0f             	and    $0xf,%esi
  40398e:	41 0f a3 f6          	bt     %esi,%r14d
  403992:	73 dc                	jae    403970 <__vdsosym+0x1d0>
  403994:	c0 e8 04             	shr    $0x4,%al
  403997:	be 06 04 00 00       	mov    $0x406,%esi
  40399c:	0f a3 c6             	bt     %eax,%esi
  40399f:	73 cf                	jae    403970 <__vdsosym+0x1d0>
  4039a1:	66 41 83 7f 06 00    	cmpw   $0x0,0x6(%r15)
  4039a7:	74 c7                	je     403970 <__vdsosym+0x1d0>
  4039a9:	41 8b 37             	mov    (%r15),%esi
  4039ac:	48 8b 7c 24 10       	mov    0x10(%rsp),%rdi
  4039b1:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
  4039b6:	48 89 0c 24          	mov    %rcx,(%rsp)
  4039ba:	4c 01 e6             	add    %r12,%rsi
  4039bd:	e8 2e 02 00 00       	callq  403bf0 <strcmp>
  4039c2:	85 c0                	test   %eax,%eax
  4039c4:	48 8b 0c 24          	mov    (%rsp),%rcx
  4039c8:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
  4039cd:	75 36                	jne    403a05 <__vdsosym+0x265>
  4039cf:	4d 85 c0             	test   %r8,%r8
  4039d2:	74 6d                	je     403a41 <__vdsosym+0x2a1>
  4039d4:	41 0f b7 3c 58       	movzwl (%r8,%rbx,2),%edi
  4039d9:	4c 89 ee             	mov    %r13,%rsi
  4039dc:	66 81 e7 ff 7f       	and    $0x7fff,%di
  4039e1:	eb 08                	jmp    4039eb <__vdsosym+0x24b>
  4039e3:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  4039e8:	48 01 c6             	add    %rax,%rsi
  4039eb:	f6 46 02 01          	testb  $0x1,0x2(%rsi)
  4039ef:	75 0d                	jne    4039fe <__vdsosym+0x25e>
  4039f1:	0f b7 46 04          	movzwl 0x4(%rsi),%eax
  4039f5:	66 25 ff 7f          	and    $0x7fff,%ax
  4039f9:	66 39 c7             	cmp    %ax,%di
  4039fc:	74 1a                	je     403a18 <__vdsosym+0x278>
  4039fe:	8b 46 10             	mov    0x10(%rsi),%eax
  403a01:	85 c0                	test   %eax,%eax
  403a03:	75 e3                	jne    4039e8 <__vdsosym+0x248>
  403a05:	44 8b 51 04          	mov    0x4(%rcx),%r10d
  403a09:	e9 62 ff ff ff       	jmpq   403970 <__vdsosym+0x1d0>
  403a0e:	b8 08 00 00 00       	mov    $0x8,%eax
  403a13:	e9 ca fd ff ff       	jmpq   4037e2 <__vdsosym+0x42>
  403a18:	8b 46 0c             	mov    0xc(%rsi),%eax
  403a1b:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
  403a20:	4c 89 44 24 08       	mov    %r8,0x8(%rsp)
  403a25:	48 89 0c 24          	mov    %rcx,(%rsp)
  403a29:	8b 34 06             	mov    (%rsi,%rax,1),%esi
  403a2c:	4c 01 e6             	add    %r12,%rsi
  403a2f:	e8 bc 01 00 00       	callq  403bf0 <strcmp>
  403a34:	85 c0                	test   %eax,%eax
  403a36:	48 8b 0c 24          	mov    (%rsp),%rcx
  403a3a:	4c 8b 44 24 08       	mov    0x8(%rsp),%r8
  403a3f:	75 c4                	jne    403a05 <__vdsosym+0x265>
  403a41:	48 89 e8             	mov    %rbp,%rax
  403a44:	49 03 47 08          	add    0x8(%r15),%rax
  403a48:	e9 a8 fe ff ff       	jmpq   4038f5 <__vdsosym+0x155>

0000000000403a4d <wcrtomb>:
  403a4d:	48 85 ff             	test   %rdi,%rdi
  403a50:	b8 01 00 00 00       	mov    $0x1,%eax
  403a55:	0f 84 fa 00 00 00    	je     403b55 <wcrtomb+0x108>
  403a5b:	83 fe 7f             	cmp    $0x7f,%esi
  403a5e:	0f 86 f2 00 00 00    	jbe    403b56 <wcrtomb+0x109>
  403a64:	48 83 ec 08          	sub    $0x8,%rsp
  403a68:	89 f0                	mov    %esi,%eax
  403a6a:	48 89 fa             	mov    %rdi,%rdx
  403a6d:	64 48 8b 0c 25 00 00 	mov    %fs:0x0,%rcx
  403a74:	00 00 
  403a76:	48 8b 89 c0 00 00 00 	mov    0xc0(%rcx),%rcx
  403a7d:	48 83 39 00          	cmpq   $0x0,(%rcx)
  403a81:	75 1b                	jne    403a9e <wcrtomb+0x51>
  403a83:	2d 80 df 00 00       	sub    $0xdf80,%eax
  403a88:	83 f8 7f             	cmp    $0x7f,%eax
  403a8b:	0f 87 b4 00 00 00    	ja     403b45 <wcrtomb+0xf8>
  403a91:	40 88 37             	mov    %sil,(%rdi)
  403a94:	b8 01 00 00 00       	mov    $0x1,%eax
  403a99:	e9 b6 00 00 00       	jmpq   403b54 <wcrtomb+0x107>
  403a9e:	81 fe ff 07 00 00    	cmp    $0x7ff,%esi
  403aa4:	77 1d                	ja     403ac3 <wcrtomb+0x76>
  403aa6:	89 f1                	mov    %esi,%ecx
  403aa8:	83 e0 3f             	and    $0x3f,%eax
  403aab:	c1 f9 06             	sar    $0x6,%ecx
  403aae:	83 c8 80             	or     $0xffffff80,%eax
  403ab1:	83 c9 c0             	or     $0xffffffc0,%ecx
  403ab4:	88 47 01             	mov    %al,0x1(%rdi)
  403ab7:	b8 02 00 00 00       	mov    $0x2,%eax
  403abc:	88 0f                	mov    %cl,(%rdi)
  403abe:	e9 91 00 00 00       	jmpq   403b54 <wcrtomb+0x107>
  403ac3:	8d 8e 00 20 ff ff    	lea    -0xe000(%rsi),%ecx
  403ac9:	81 f9 ff 1f 00 00    	cmp    $0x1fff,%ecx
  403acf:	76 08                	jbe    403ad9 <wcrtomb+0x8c>
  403ad1:	81 fe ff d7 00 00    	cmp    $0xd7ff,%esi
  403ad7:	77 28                	ja     403b01 <wcrtomb+0xb4>
  403ad9:	89 c1                	mov    %eax,%ecx
  403adb:	c1 f9 0c             	sar    $0xc,%ecx
  403ade:	83 c9 e0             	or     $0xffffffe0,%ecx
  403ae1:	88 0a                	mov    %cl,(%rdx)
  403ae3:	89 c1                	mov    %eax,%ecx
  403ae5:	83 e0 3f             	and    $0x3f,%eax
  403ae8:	c1 f9 06             	sar    $0x6,%ecx
  403aeb:	83 c8 80             	or     $0xffffff80,%eax
  403aee:	83 e1 3f             	and    $0x3f,%ecx
  403af1:	88 42 02             	mov    %al,0x2(%rdx)
  403af4:	b8 03 00 00 00       	mov    $0x3,%eax
  403af9:	83 c9 80             	or     $0xffffff80,%ecx
  403afc:	88 4a 01             	mov    %cl,0x1(%rdx)
  403aff:	eb 53                	jmp    403b54 <wcrtomb+0x107>
  403b01:	8d 8e 00 00 ff ff    	lea    -0x10000(%rsi),%ecx
  403b07:	81 f9 ff ff 0f 00    	cmp    $0xfffff,%ecx
  403b0d:	77 36                	ja     403b45 <wcrtomb+0xf8>
  403b0f:	89 f1                	mov    %esi,%ecx
  403b11:	83 e0 3f             	and    $0x3f,%eax
  403b14:	c1 f9 12             	sar    $0x12,%ecx
  403b17:	83 c8 80             	or     $0xffffff80,%eax
  403b1a:	83 c9 f0             	or     $0xfffffff0,%ecx
  403b1d:	88 47 03             	mov    %al,0x3(%rdi)
  403b20:	b8 04 00 00 00       	mov    $0x4,%eax
  403b25:	88 0f                	mov    %cl,(%rdi)
  403b27:	89 f1                	mov    %esi,%ecx
  403b29:	c1 f9 0c             	sar    $0xc,%ecx
  403b2c:	83 e1 3f             	and    $0x3f,%ecx
  403b2f:	83 c9 80             	or     $0xffffff80,%ecx
  403b32:	88 4f 01             	mov    %cl,0x1(%rdi)
  403b35:	89 f1                	mov    %esi,%ecx
  403b37:	c1 f9 06             	sar    $0x6,%ecx
  403b3a:	83 e1 3f             	and    $0x3f,%ecx
  403b3d:	83 c9 80             	or     $0xffffff80,%ecx
  403b40:	88 4f 02             	mov    %cl,0x2(%rdi)
  403b43:	eb 0f                	jmp    403b54 <wcrtomb+0x107>
  403b45:	e8 96 f0 ff ff       	callq  402be0 <__errno_location>
  403b4a:	c7 00 54 00 00 00    	movl   $0x54,(%rax)
  403b50:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
  403b54:	5a                   	pop    %rdx
  403b55:	c3                   	retq   
  403b56:	40 88 37             	mov    %sil,(%rdi)
  403b59:	b8 01 00 00 00       	mov    $0x1,%eax
  403b5e:	c3                   	retq   

0000000000403b5f <close_file>:
  403b5f:	48 85 ff             	test   %rdi,%rdi
  403b62:	74 47                	je     403bab <close_file+0x4c>
  403b64:	53                   	push   %rbx
  403b65:	8b 87 8c 00 00 00    	mov    0x8c(%rdi),%eax
  403b6b:	48 89 fb             	mov    %rdi,%rbx
  403b6e:	85 c0                	test   %eax,%eax
  403b70:	78 05                	js     403b77 <close_file+0x18>
  403b72:	e8 45 f3 ff ff       	callq  402ebc <__lockfile>
  403b77:	48 8b 43 38          	mov    0x38(%rbx),%rax
  403b7b:	48 39 43 28          	cmp    %rax,0x28(%rbx)
  403b7f:	74 0a                	je     403b8b <close_file+0x2c>
  403b81:	31 d2                	xor    %edx,%edx
  403b83:	31 f6                	xor    %esi,%esi
  403b85:	48 89 df             	mov    %rbx,%rdi
  403b88:	ff 53 48             	callq  *0x48(%rbx)
  403b8b:	48 8b 73 08          	mov    0x8(%rbx),%rsi
  403b8f:	48 8b 43 10          	mov    0x10(%rbx),%rax
  403b93:	48 39 c6             	cmp    %rax,%rsi
  403b96:	74 12                	je     403baa <close_file+0x4b>
  403b98:	48 29 c6             	sub    %rax,%rsi
  403b9b:	48 89 df             	mov    %rbx,%rdi
  403b9e:	48 8b 43 50          	mov    0x50(%rbx),%rax
  403ba2:	5b                   	pop    %rbx
  403ba3:	ba 01 00 00 00       	mov    $0x1,%edx
  403ba8:	ff e0                	jmpq   *%rax
  403baa:	5b                   	pop    %rbx
  403bab:	c3                   	retq   

0000000000403bac <__stdio_exit>:
  403bac:	53                   	push   %rbx
  403bad:	e8 e3 f6 ff ff       	callq  403295 <__ofl_lock>
  403bb2:	48 8b 18             	mov    (%rax),%rbx
  403bb5:	48 85 db             	test   %rbx,%rbx
  403bb8:	74 0e                	je     403bc8 <__stdio_exit+0x1c>
  403bba:	48 89 df             	mov    %rbx,%rdi
  403bbd:	e8 9d ff ff ff       	callq  403b5f <close_file>
  403bc2:	48 8b 5b 70          	mov    0x70(%rbx),%rbx
  403bc6:	eb ed                	jmp    403bb5 <__stdio_exit+0x9>
  403bc8:	48 8b 3d d9 1a 20 00 	mov    0x201ad9(%rip),%rdi        # 6056a8 <__stdin_used>
  403bcf:	e8 8b ff ff ff       	callq  403b5f <close_file>
  403bd4:	48 8b 3d 2d 15 20 00 	mov    0x20152d(%rip),%rdi        # 605108 <__stdout_used>
  403bdb:	e8 7f ff ff ff       	callq  403b5f <close_file>
  403be0:	5b                   	pop    %rbx
  403be1:	48 8b 3d 20 14 20 00 	mov    0x201420(%rip),%rdi        # 605008 <__stderr_used>
  403be8:	e9 72 ff ff ff       	jmpq   403b5f <close_file>
  403bed:	0f 1f 00             	nopl   (%rax)

0000000000403bf0 <strcmp>:
  403bf0:	0f b6 07             	movzbl (%rdi),%eax
  403bf3:	0f b6 16             	movzbl (%rsi),%edx
  403bf6:	38 c2                	cmp    %al,%dl
  403bf8:	75 1c                	jne    403c16 <strcmp+0x26>
  403bfa:	84 d2                	test   %dl,%dl
  403bfc:	75 06                	jne    403c04 <strcmp+0x14>
  403bfe:	eb 20                	jmp    403c20 <strcmp+0x30>
  403c00:	84 c0                	test   %al,%al
  403c02:	74 1c                	je     403c20 <strcmp+0x30>
  403c04:	48 83 c7 01          	add    $0x1,%rdi
  403c08:	48 83 c6 01          	add    $0x1,%rsi
  403c0c:	0f b6 07             	movzbl (%rdi),%eax
  403c0f:	0f b6 16             	movzbl (%rsi),%edx
  403c12:	38 d0                	cmp    %dl,%al
  403c14:	74 ea                	je     403c00 <strcmp+0x10>
  403c16:	29 d0                	sub    %edx,%eax
  403c18:	c3                   	retq   
  403c19:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  403c20:	31 c0                	xor    %eax,%eax
  403c22:	c3                   	retq   

0000000000403c23 <__syscall_cp_c>:
  403c23:	31 c0                	xor    %eax,%eax
  403c25:	e9 05 00 00 00       	jmpq   403c2f <__syscall>

0000000000403c2a <__syscall_cp>:
  403c2a:	e9 f4 ff ff ff       	jmpq   403c23 <__syscall_cp_c>

0000000000403c2f <__syscall>:
  403c2f:	48 89 f8             	mov    %rdi,%rax
  403c32:	48 89 f7             	mov    %rsi,%rdi
  403c35:	48 89 d6             	mov    %rdx,%rsi
  403c38:	48 89 ca             	mov    %rcx,%rdx
  403c3b:	4d 89 c2             	mov    %r8,%r10
  403c3e:	4d 89 c8             	mov    %r9,%r8
  403c41:	4c 8b 4c 24 08       	mov    0x8(%rsp),%r9
  403c46:	0f 05                	syscall 
  403c48:	c3                   	retq   
  403c49:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)

0000000000403c50 <__do_global_ctors_aux>:
  403c50:	48 8b 05 81 13 20 00 	mov    0x201381(%rip),%rax        # 604fd8 <__CTOR_LIST__>
  403c57:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  403c5b:	74 28                	je     403c85 <__do_global_ctors_aux+0x35>
  403c5d:	55                   	push   %rbp
  403c5e:	48 89 e5             	mov    %rsp,%rbp
  403c61:	53                   	push   %rbx
  403c62:	bb d8 4f 60 00       	mov    $0x604fd8,%ebx
  403c67:	48 83 ec 08          	sub    $0x8,%rsp
  403c6b:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
  403c70:	48 83 eb 08          	sub    $0x8,%rbx
  403c74:	ff d0                	callq  *%rax
  403c76:	48 8b 03             	mov    (%rbx),%rax
  403c79:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  403c7d:	75 f1                	jne    403c70 <__do_global_ctors_aux+0x20>
  403c7f:	48 83 c4 08          	add    $0x8,%rsp
  403c83:	5b                   	pop    %rbx
  403c84:	5d                   	pop    %rbp
  403c85:	f3 c3                	repz retq 

Disassembly of section .fini:

0000000000403c87 <_fini>:
  403c87:	50                   	push   %rax
  403c88:	e8 83 c5 ff ff       	callq  400210 <__do_global_dtors_aux>
  403c8d:	58                   	pop    %rax
  403c8e:	c3                   	retq   
