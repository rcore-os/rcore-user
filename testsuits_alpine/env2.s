
env2:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	50                   	push   %rax
    1001:	e8 ad 01 00 00       	callq  11b3 <frame_dummy>
    1006:	e8 ce 02 00 00       	callq  12d9 <__do_global_ctors_aux>
    100b:	58                   	pop    %rax
    100c:	c3                   	retq   

Disassembly of section .plt:

0000000000001010 <.plt>:
    1010:	ff 35 82 2f 00 00    	pushq  0x2f82(%rip)        # 3f98 <_GLOBAL_OFFSET_TABLE_+0x8>
    1016:	ff 25 84 2f 00 00    	jmpq   *0x2f84(%rip)        # 3fa0 <_GLOBAL_OFFSET_TABLE_+0x10>
    101c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000001020 <unsetenv@plt>:
    1020:	ff 25 82 2f 00 00    	jmpq   *0x2f82(%rip)        # 3fa8 <unsetenv>
    1026:	68 00 00 00 00       	pushq  $0x0
    102b:	e9 e0 ff ff ff       	jmpq   1010 <.plt>

0000000000001030 <printf@plt>:
    1030:	ff 25 7a 2f 00 00    	jmpq   *0x2f7a(%rip)        # 3fb0 <printf>
    1036:	68 01 00 00 00       	pushq  $0x1
    103b:	e9 d0 ff ff ff       	jmpq   1010 <.plt>

0000000000001040 <getenv@plt>:
    1040:	ff 25 72 2f 00 00    	jmpq   *0x2f72(%rip)        # 3fb8 <getenv>
    1046:	68 02 00 00 00       	pushq  $0x2
    104b:	e9 c0 ff ff ff       	jmpq   1010 <.plt>

0000000000001050 <puts@plt>:
    1050:	ff 25 6a 2f 00 00    	jmpq   *0x2f6a(%rip)        # 3fc0 <puts>
    1056:	68 03 00 00 00       	pushq  $0x3
    105b:	e9 b0 ff ff ff       	jmpq   1010 <.plt>

0000000000001060 <setenv@plt>:
    1060:	ff 25 62 2f 00 00    	jmpq   *0x2f62(%rip)        # 3fc8 <setenv>
    1066:	68 04 00 00 00       	pushq  $0x4
    106b:	e9 a0 ff ff ff       	jmpq   1010 <.plt>

0000000000001070 <__libc_start_main@plt>:
    1070:	ff 25 5a 2f 00 00    	jmpq   *0x2f5a(%rip)        # 3fd0 <__libc_start_main>
    1076:	68 05 00 00 00       	pushq  $0x5
    107b:	e9 90 ff ff ff       	jmpq   1010 <.plt>

Disassembly of section .plt.got:

0000000000001080 <__cxa_finalize@plt>:
    1080:	ff 25 52 2f 00 00    	jmpq   *0x2f52(%rip)        # 3fd8 <__cxa_finalize>
    1086:	66 90                	xchg   %ax,%ax

0000000000001088 <__deregister_frame_info@plt>:
    1088:	ff 25 52 2f 00 00    	jmpq   *0x2f52(%rip)        # 3fe0 <__deregister_frame_info>
    108e:	66 90                	xchg   %ax,%ax

0000000000001090 <__register_frame_info@plt>:
    1090:	ff 25 62 2f 00 00    	jmpq   *0x2f62(%rip)        # 3ff8 <__register_frame_info>
    1096:	66 90                	xchg   %ax,%ax

Disassembly of section .text:

0000000000001098 <_start>:
    1098:	48 31 ed             	xor    %rbp,%rbp
    109b:	48 89 e7             	mov    %rsp,%rdi
    109e:	48 8d 35 6b 2d 00 00 	lea    0x2d6b(%rip),%rsi        # 3e10 <_DYNAMIC>
    10a5:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
    10a9:	e8 00 00 00 00       	callq  10ae <_start_c>

00000000000010ae <_start_c>:
    10ae:	50                   	push   %rax
    10af:	48 8d 57 08          	lea    0x8(%rdi),%rdx
    10b3:	48 8b 37             	mov    (%rdi),%rsi
    10b6:	45 31 c9             	xor    %r9d,%r9d
    10b9:	4c 8d 05 3b 02 00 00 	lea    0x23b(%rip),%r8        # 12fb <_fini>
    10c0:	48 8d 0d 39 ff ff ff 	lea    -0xc7(%rip),%rcx        # 1000 <_init>
    10c7:	48 8d 3d 0c 01 00 00 	lea    0x10c(%rip),%rdi        # 11da <main>
    10ce:	e8 9d ff ff ff       	callq  1070 <__libc_start_main@plt>

00000000000010d3 <deregister_tm_clones>:
    10d3:	48 8d 3d 2e 2f 00 00 	lea    0x2f2e(%rip),%rdi        # 4008 <__TMC_END__>
    10da:	48 8d 05 27 2f 00 00 	lea    0x2f27(%rip),%rax        # 4008 <__TMC_END__>
    10e1:	48 39 f8             	cmp    %rdi,%rax
    10e4:	74 0e                	je     10f4 <deregister_tm_clones+0x21>
    10e6:	48 8b 05 03 2f 00 00 	mov    0x2f03(%rip),%rax        # 3ff0 <_ITM_deregisterTMCloneTable>
    10ed:	48 85 c0             	test   %rax,%rax
    10f0:	74 02                	je     10f4 <deregister_tm_clones+0x21>
    10f2:	ff e0                	jmpq   *%rax
    10f4:	c3                   	retq   

00000000000010f5 <register_tm_clones>:
    10f5:	48 8d 3d 0c 2f 00 00 	lea    0x2f0c(%rip),%rdi        # 4008 <__TMC_END__>
    10fc:	48 8d 35 05 2f 00 00 	lea    0x2f05(%rip),%rsi        # 4008 <__TMC_END__>
    1103:	b9 02 00 00 00       	mov    $0x2,%ecx
    1108:	48 29 fe             	sub    %rdi,%rsi
    110b:	48 c1 fe 03          	sar    $0x3,%rsi
    110f:	48 89 f0             	mov    %rsi,%rax
    1112:	48 99                	cqto   
    1114:	48 f7 f9             	idiv   %rcx
    1117:	48 89 c6             	mov    %rax,%rsi
    111a:	48 85 c0             	test   %rax,%rax
    111d:	74 0e                	je     112d <register_tm_clones+0x38>
    111f:	48 8b 05 c2 2e 00 00 	mov    0x2ec2(%rip),%rax        # 3fe8 <_ITM_registerTMCloneTable>
    1126:	48 85 c0             	test   %rax,%rax
    1129:	74 02                	je     112d <register_tm_clones+0x38>
    112b:	ff e0                	jmpq   *%rax
    112d:	c3                   	retq   

000000000000112e <__do_global_dtors_aux>:
    112e:	80 3d eb 2e 00 00 00 	cmpb   $0x0,0x2eeb(%rip)        # 4020 <completed.6136>
    1135:	75 7b                	jne    11b2 <__do_global_dtors_aux+0x84>
    1137:	55                   	push   %rbp
    1138:	48 83 3d 98 2e 00 00 	cmpq   $0x0,0x2e98(%rip)        # 3fd8 <__cxa_finalize>
    113f:	00 
    1140:	48 89 e5             	mov    %rsp,%rbp
    1143:	41 54                	push   %r12
    1145:	53                   	push   %rbx
    1146:	74 0c                	je     1154 <__do_global_dtors_aux+0x26>
    1148:	48 8b 3d b1 2e 00 00 	mov    0x2eb1(%rip),%rdi        # 4000 <__dso_handle>
    114f:	e8 2c ff ff ff       	callq  1080 <__cxa_finalize@plt>
    1154:	48 8d 05 a5 2c 00 00 	lea    0x2ca5(%rip),%rax        # 3e00 <__DTOR_LIST__>
    115b:	48 8d 1d a6 2c 00 00 	lea    0x2ca6(%rip),%rbx        # 3e08 <__DTOR_END__>
    1162:	48 29 c3             	sub    %rax,%rbx
    1165:	49 89 c4             	mov    %rax,%r12
    1168:	48 c1 fb 03          	sar    $0x3,%rbx
    116c:	48 ff cb             	dec    %rbx
    116f:	48 8b 05 b2 2e 00 00 	mov    0x2eb2(%rip),%rax        # 4028 <dtor_idx.6138>
    1176:	48 39 d8             	cmp    %rbx,%rax
    1179:	73 10                	jae    118b <__do_global_dtors_aux+0x5d>
    117b:	48 ff c0             	inc    %rax
    117e:	48 89 05 a3 2e 00 00 	mov    %rax,0x2ea3(%rip)        # 4028 <dtor_idx.6138>
    1185:	41 ff 14 c4          	callq  *(%r12,%rax,8)
    1189:	eb e4                	jmp    116f <__do_global_dtors_aux+0x41>
    118b:	e8 43 ff ff ff       	callq  10d3 <deregister_tm_clones>
    1190:	48 83 3d 48 2e 00 00 	cmpq   $0x0,0x2e48(%rip)        # 3fe0 <__deregister_frame_info>
    1197:	00 
    1198:	74 0c                	je     11a6 <__do_global_dtors_aux+0x78>
    119a:	48 8d 3d 37 0f 00 00 	lea    0xf37(%rip),%rdi        # 20d8 <__EH_FRAME_BEGIN__>
    11a1:	e8 e2 fe ff ff       	callq  1088 <__deregister_frame_info@plt>
    11a6:	5b                   	pop    %rbx
    11a7:	41 5c                	pop    %r12
    11a9:	c6 05 70 2e 00 00 01 	movb   $0x1,0x2e70(%rip)        # 4020 <completed.6136>
    11b0:	5d                   	pop    %rbp
    11b1:	c3                   	retq   
    11b2:	c3                   	retq   

00000000000011b3 <frame_dummy>:
    11b3:	48 83 3d 3d 2e 00 00 	cmpq   $0x0,0x2e3d(%rip)        # 3ff8 <__register_frame_info>
    11ba:	00 
    11bb:	74 18                	je     11d5 <frame_dummy+0x22>
    11bd:	55                   	push   %rbp
    11be:	48 8d 35 7b 2e 00 00 	lea    0x2e7b(%rip),%rsi        # 4040 <object.6148>
    11c5:	48 8d 3d 0c 0f 00 00 	lea    0xf0c(%rip),%rdi        # 20d8 <__EH_FRAME_BEGIN__>
    11cc:	48 89 e5             	mov    %rsp,%rbp
    11cf:	e8 bc fe ff ff       	callq  1090 <__register_frame_info@plt>
    11d4:	5d                   	pop    %rbp
    11d5:	e9 1b ff ff ff       	jmpq   10f5 <register_tm_clones>

00000000000011da <main>:
    11da:	55                   	push   %rbp
    11db:	48 89 e5             	mov    %rsp,%rbp
    11de:	48 83 ec 30          	sub    $0x30,%rsp
    11e2:	89 7d ec             	mov    %edi,-0x14(%rbp)
    11e5:	48 89 75 e0          	mov    %rsi,-0x20(%rbp)
    11e9:	48 89 55 d8          	mov    %rdx,-0x28(%rbp)
    11ed:	48 8d 3d 0c 0e 00 00 	lea    0xe0c(%rip),%rdi        # 2000 <_fini+0xd05>
    11f4:	e8 57 fe ff ff       	callq  1050 <puts@plt>
    11f9:	eb 14                	jmp    120f <main+0x35>
    11fb:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    11ff:	48 8b 00             	mov    (%rax),%rax
    1202:	48 89 c7             	mov    %rax,%rdi
    1205:	e8 46 fe ff ff       	callq  1050 <puts@plt>
    120a:	48 83 45 d8 08       	addq   $0x8,-0x28(%rbp)
    120f:	48 8b 45 d8          	mov    -0x28(%rbp),%rax
    1213:	48 8b 00             	mov    (%rax),%rax
    1216:	48 85 c0             	test   %rax,%rax
    1219:	75 e0                	jne    11fb <main+0x21>
    121b:	48 8d 3d 01 0e 00 00 	lea    0xe01(%rip),%rdi        # 2023 <_fini+0xd28>
    1222:	e8 29 fe ff ff       	callq  1050 <puts@plt>
    1227:	48 8d 3d 0d 0e 00 00 	lea    0xe0d(%rip),%rdi        # 203b <_fini+0xd40>
    122e:	e8 0d fe ff ff       	callq  1040 <getenv@plt>
    1233:	48 89 45 f8          	mov    %rax,-0x8(%rbp)
    1237:	48 83 7d f8 00       	cmpq   $0x0,-0x8(%rbp)
    123c:	74 18                	je     1256 <main+0x7c>
    123e:	48 8b 45 f8          	mov    -0x8(%rbp),%rax
    1242:	48 89 c6             	mov    %rax,%rsi
    1245:	48 8d 3d f4 0d 00 00 	lea    0xdf4(%rip),%rdi        # 2040 <_fini+0xd45>
    124c:	b8 00 00 00 00       	mov    $0x0,%eax
    1251:	e8 da fd ff ff       	callq  1030 <printf@plt>
    1256:	ba 01 00 00 00       	mov    $0x1,%edx
    125b:	48 8d 35 e8 0d 00 00 	lea    0xde8(%rip),%rsi        # 204a <_fini+0xd4f>
    1262:	48 8d 3d d2 0d 00 00 	lea    0xdd2(%rip),%rdi        # 203b <_fini+0xd40>
    1269:	e8 f2 fd ff ff       	callq  1060 <setenv@plt>
    126e:	48 8d 3d c6 0d 00 00 	lea    0xdc6(%rip),%rdi        # 203b <_fini+0xd40>
    1275:	e8 c6 fd ff ff       	callq  1040 <getenv@plt>
    127a:	48 89 c6             	mov    %rax,%rsi
    127d:	48 8d 3d cb 0d 00 00 	lea    0xdcb(%rip),%rdi        # 204f <_fini+0xd54>
    1284:	b8 00 00 00 00       	mov    $0x0,%eax
    1289:	e8 a2 fd ff ff       	callq  1030 <printf@plt>
    128e:	48 8d 3d a6 0d 00 00 	lea    0xda6(%rip),%rdi        # 203b <_fini+0xd40>
    1295:	e8 86 fd ff ff       	callq  1020 <unsetenv@plt>
    129a:	48 8d 3d 9a 0d 00 00 	lea    0xd9a(%rip),%rdi        # 203b <_fini+0xd40>
    12a1:	e8 9a fd ff ff       	callq  1040 <getenv@plt>
    12a6:	48 89 c6             	mov    %rax,%rsi
    12a9:	48 8d 3d 9f 0d 00 00 	lea    0xd9f(%rip),%rdi        # 204f <_fini+0xd54>
    12b0:	b8 00 00 00 00       	mov    $0x0,%eax
    12b5:	e8 76 fd ff ff       	callq  1030 <printf@plt>
    12ba:	ba 01 00 00 00       	mov    $0x1,%edx
    12bf:	48 8d 35 84 0d 00 00 	lea    0xd84(%rip),%rsi        # 204a <_fini+0xd4f>
    12c6:	48 8d 3d 6e 0d 00 00 	lea    0xd6e(%rip),%rdi        # 203b <_fini+0xd40>
    12cd:	e8 8e fd ff ff       	callq  1060 <setenv@plt>
    12d2:	b8 00 00 00 00       	mov    $0x0,%eax
    12d7:	c9                   	leaveq 
    12d8:	c3                   	retq   

00000000000012d9 <__do_global_ctors_aux>:
    12d9:	55                   	push   %rbp
    12da:	48 89 e5             	mov    %rsp,%rbp
    12dd:	53                   	push   %rbx
    12de:	48 8d 1d 0b 2b 00 00 	lea    0x2b0b(%rip),%rbx        # 3df0 <__CTOR_LIST__>
    12e5:	52                   	push   %rdx
    12e6:	48 8b 03             	mov    (%rbx),%rax
    12e9:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
    12ed:	74 08                	je     12f7 <__do_global_ctors_aux+0x1e>
    12ef:	ff d0                	callq  *%rax
    12f1:	48 83 eb 08          	sub    $0x8,%rbx
    12f5:	eb ef                	jmp    12e6 <__do_global_ctors_aux+0xd>
    12f7:	58                   	pop    %rax
    12f8:	5b                   	pop    %rbx
    12f9:	5d                   	pop    %rbp
    12fa:	c3                   	retq   

Disassembly of section .fini:

00000000000012fb <_fini>:
    12fb:	50                   	push   %rax
    12fc:	e8 2d fe ff ff       	callq  112e <__do_global_dtors_aux>
    1301:	58                   	pop    %rax
    1302:	c3                   	retq   
