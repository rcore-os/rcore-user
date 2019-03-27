# rCore-user

[![Build Status](https://travis-ci.org/rcore-os/rcore-user.svg?branch=master)](https://travis-ci.org/rcore-os/rcore-user)

User programs for [rCore OS](https://github.com/rcore-os/rCore).


Now it has 4 parts:

* `ucore`: C-lang, from the original [ucore_os_lab](https://github.com/chyyuu/ucore_os_plus)
* `biscuit`: C/C++, from [Biscuit](https://github.com/mit-pdos/biscuit), based on a `musl` instead of original `litc`.
* `rust`: Simple no_std Rust programs.
* `nginx`, `redis`, `busybox`, `alpine`: Real world applications.

## Build

To build biscuit programs, install musl toolchain first:

```bash
# 1. to download prebuilt binaries in Linux, visit [musl.cc](https://musl.cc)
# 2. to build musl toolchains from source:
# 2.1 for macOS musl toolchain for x86_64(,aarch64)
$ brew install FileSottile/musl-cross/musl-cross {--with-aarch64}
# 2.2 for ubuntu 16.04, we should build gcc-musl for newest musl-1.1.21, please see build-gcc-musl.md for instructions
# 2.3 for riscv musl toolchain, please install [musl-riscv-toolchain](https://github.com/jiegec/musl-riscv-toolchain)
```

Then, build userspace programs for rCore:

```bash
$ make {ucore,biscuit,rust,nginx,redis,all} arch={x86_64,aarch64,riscv32,riscv64}
$ make alpine arch={x86_64,aarch64} # if you want to use alpine rootfs
$ make sfsimg arch={x86_64,aarch64,riscv32,riscv64}
```

A rootfs is created at `build/$(arch)` and converted to `qcow2`.

## Support matrix

|                    | x86_64 | aarch64 | riscv32 | riscv64 |
| ------------------ | ------ | ------- | ------- | ------- |
| ucore              | ❌      | ✅       | ✅       | ✅       |
| rust               | ✅      | ✅       | ✅       | ✅       |
| biscuit            | ✅      | ✅       | ❌       | ✅       |
| nginx (linux only) | ✅      | ✅       | ❌       | ✅       |
| redis (linux only) | ✅      | ✅       | ✅       | ❌       |
| busybox            | ✅      | ✅       | ❌       | ✅       |
| alpine rootfs      | ✅      | ✅       | ❌       | ❌       |



## How to use Redis

If redis is dynamically linked to musl (default if you use commands above), you might need to copy `ld-musl-$(arch).so.1` to rootfs `/lib` . Alpine rootfs includes one as well.

After building redis, you should be able to run redis-server in rCore. Then, start `redis-server` in rCore:

```bash
/> redis-server redis.conf
```

Then you should be able to connect to it using `redis-cli` over the network:

```bash
$ redis-cli -h 10.0.0.2 set abc def
OK
$ redis-cli -h 10.0.0.2 get abc
"def"
```

Note: `redis-cli` in rCore is not working at the time.
