# User programs from ucore_os_lab in C-lang

[![Build Status](https://travis-ci.org/wangrunji0408/rcore_user.svg?branch=master)](https://travis-ci.org/wangrunji0408/rcore_user)

## Build
```bash
mkdir build && cd build
cmake -DARCH={i386,x86_64,riscv32,riscv64,aarch64} ..
make
```