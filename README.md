# rCore-user

[![Build Status](https://travis-ci.org/wangrunji0408/rcore_user.svg?branch=master)](https://travis-ci.org/wangrunji0408/rcore_user)

User programs for [rCore OS](https://github.com/wangrunji0408/RustOS).


Now it has 3 parts:

* `ucore`: C-lang, from the original [ucore_os_lab](https://github.com/chyyuu/ucore_os_plus)
* `biscuit`: C/C++, from [Biscuit](https://github.com/mit-pdos/biscuit), based on a `musl` instead of original `litc`.
* `rust`: Simple no_std Rust programs.

## Build

To build biscuit programs, install musl toolchain first:

```bash
# for ARCH linux
$ sudo pacman -Syu musl # archlinux
# for macOS
$ brew install FileSottile/musl-cross/musl-cross 
# for ubuntu 16.04, we should build gcc-musl for newest musl-1.1.21
# please see build-gcc-musl.md
# for riscv musl toolchain, please install [musl-riscv-toolchain](https://github.com/jiegec/musl-riscv-toolchain)
```

```bash
$ make {ucore,biscuit,rust,nginx,redis,all} arch={x86_64,aarch64,riscv32,riscv64}
$ make sfsimg arch={x86_64,aarch64,riscv32,riscv64}
```

Output to `build/$(arch)`

## Support matrix

|                             | x86_64 | aarch64 | riscv32 | riscv64 |
| --------------------------- | ------ | ------- | ------- | ------- |
| ucore                       | n      | y       | y       | y       |
| rust                        | y      | y       | y       | y       |
| biscuit                     | y      | y       | n       | y       |
| nginx                       | y      | y       | n       | y       |
| redis (build with redis=on) | y      | y       | y       | n       |
| busybox                     | y      | y       | n       | y       |




## Notice

* The syscall ids have been set compatible with [Linux64](https://syscalls64.paolostivanin.com).
* So the ucore part can not run on the original ucore.
