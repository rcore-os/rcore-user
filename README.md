# User programs from ucore_os_lab in C-lang

## Build
```bash
mkdir build && cd build
cmake -DARCH={i386,x86_64,riscv32,riscv64,aarch64} ..
make
```