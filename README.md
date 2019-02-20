# rCore-user

[![Build Status](https://travis-ci.org/wangrunji0408/rcore_user.svg?branch=master)](https://travis-ci.org/wangrunji0408/rcore_user)

User programs for [rCore OS](https://github.com/wangrunji0408/RustOS).



Now it has 2 parts:

* `ucore`: C-lang, from the original [ucore_os_lab](https://github.com/chyyuu/ucore_os_plus)
* `biscuit`: C/C++, from [Biscuit](https://github.com/mit-pdos/biscuit), based on a partial libc `litc`. (WIP)

## Build

For ucore:

```bash
cd ucore
mkdir build && cd build
cmake -DARCH={i386,x86_64,riscv32,riscv64,aarch64} ..
make
```

For biscuit:

```bash
cd biscuit
mkdir build && cd build
cmake -DARCH=x86_64 ..
make
```

## Notice

* The syscall ids have been set compatible with Linux64.
* So the ucore part can not run on the original ucore.