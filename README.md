# rCore-user

[![Build Status](https://travis-ci.org/rcore-os/rcore-user.svg?branch=master)](https://travis-ci.org/rcore-os/rcore-user)

User programs for [rCore OS](https://github.com/rcore-os/rCore).


Now it has 4 parts:

* `ucore`: C-lang, from the original [ucore_os_lab](https://github.com/chyyuu/ucore_os_plus)
* `biscuit`: C/C++, from [Biscuit](https://github.com/mit-pdos/biscuit), based on a `musl` instead of original `litc`.
* `rust`: Simple no_std Rust programs.
* `nginx`, `redis`: Real world applications.

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

|                    | x86_64 | aarch64 | riscv32 | riscv64 |
| ------------------ | ------ | ------- | ------- | ------- |
| ucore              | ❌      | ✅       | ✅       | ✅       |
| rust               | ✅      | ✅       | ✅       | ✅       |
| biscuit            | ✅      | ✅       | ❌       | ✅       |
| nginx (linux only) | ✅      | ✅       | ❌       | ✅       |
| redis (linux only) | ✅      | ✅       | ✅       | ❌       |
| busybox            | ✅      | ✅       | ❌       | ✅       |



## How to use Redis

After running commands above, you should be able to run redis-server in rCore. Then, start `redis-server` in rCore:

```bash
/> redis-server redis.conf
```

Then you should be able to connect to it using `redis-cli`:

```bash
$ redis-cli -h 10.0.0.2 set abc def
OK
$ redis-cli -h 10.0.0.2 get abc
"def"
```

Note: `redis-cli` in rCore is not working at the time.
