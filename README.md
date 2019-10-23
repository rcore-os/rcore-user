# rCore-user

[![Build Status](https://travis-ci.org/rcore-os/rcore-user.svg?branch=master)](https://travis-ci.org/rcore-os/rcore-user)

<!--ts-->
   * [rCore-user](#rcore-user)
      * [Build](#build)
      * [Support matrix](#support-matrix)
      * [How to run real world programs](#how-to-run-real-world-programs)
         * [How to use Redis](#how-to-use-redis)
         * [How to use nginx](#how-to-use-nginx)
         * [How to use gcc](#how-to-use-gcc)

<!-- Added by: macbookpro, at: Fri Mar 29 14:02:36 CST 2019 -->

<!--te-->

User programs for [rCore OS](https://github.com/rcore-os/rCore).

Now it has 4 parts:

* `ucore`: C-lang, from the original [ucore_os_lab](https://github.com/chyyuu/ucore_os_plus)
* `biscuit`: C/C++, from [Biscuit](https://github.com/mit-pdos/biscuit), based on a `musl` instead of original `litc`.
* `rust`: Simple no_std Rust programs.
* `app`: C-lang, custom test programs based on `musl`.
* `nginx`, `redis`, `busybox`, `alpine`, `gcc`: Real world applications.



## Build

Install prebuilt musl toolchain from [musl.cc](https://musl.cc).

See Travis script 'install' section for details.

Then, build userspace programs for rCore:

```bash
$ make {ucore,biscuit,rust,nginx,redis,all} arch={x86_64,aarch64,riscv32,riscv64,mipsel}
$ make alpine arch={x86_64,aarch64} # if you want to use alpine rootfs
$ make test arch={x86_64} # test alpine real apps, e.g. python, gcc, rust, go, lua, etc.(need rootfs with these real apps)
$ make sfsimg arch={x86_64,aarch64,riscv32,riscv64,mipsel}
```

A rootfs is created at `build/$(arch)` and converted to `qcow2`.

## Support matrix

|                    | x86_64 | aarch64 | riscv32 | riscv64 | mipsel |
| ------------------ | ------ | ------- | ------- | ------- | ------ |
| ucore              | ✅     | ✅      | ✅     | ✅      | ❗     |
| rust               | ✅     | ✅      | ✅     | ✅      | ✅    |
| biscuit            | ✅     | ✅      | ✅     | ✅      | ✅    |
| app                | ✅     | ✅      | ✅     | ✅      | ✅    |
| nginx (linux only) | ✅     | ✅      | ❗      | ✅      | ❗      |
| redis (linux only) | ✅     | ✅      | ✅     | ✅      | ✅    |
| busybox            | ✅     | ✅      | ✅     | ✅      | ✅    |
| alpine rootfs      | ✅     | ✅      | ❌     | ❌      | ❌    |
| iperf3             | ✅     | ❌      | ❌     | ❌      | ❌    |
| test             	 | ✅     | ❌      | ❌     | ❌      | ❌    |

Note: ❗ means workarounds are used so that they may not work properly. ❌ means failure in compiling or not existed on such platform.

## How to run real world programs

### How to use Redis

If redis is dynamically linked to musl (default if you use commands above), you might need to copy `ld-musl-$(arch).so.1` to rootfs `/lib` by yourself .Alpine rootfs includes one as well.

After building redis, you should be able to run redis-server in rCore. Then, start `redis-server` in rCore:

```bash
/> redis-server redis.conf
```

Then you should be able to connect to it using `redis-cli` over the network:

```bash
$ redis-cli -h 10.0.0.2 get abc
(nil)
$ redis-cli -h 10.0.0.2 set abc def
OK
$ redis-cli -h 10.0.0.2 get abc
"def"
```

Note: `redis-cli` in rCore is not working at the time.

### How to use nginx

Nginx is statically linked to musl instead, so there is no need to copy its dynamic loader. A nginx.conf is provided in this repo and automatically copied to its destination. So, just start `nginx` directly:

```bash
/> nginx
```

Then you should be able to visit it via network:

```bash
$ curl http://10.0.0.2/
<html>
<head><title>Index of /</title></head>
<body bgcolor="white">
<h1>Index of /</h1><hr><pre><a href="../">../</a>
<a href="bin/">bin/</a>                                               01-Jan-1970 00:00                   -
<a href="biscuit/">biscuit/</a>                                           01-Jan-1970 00:00                   -
<a href="dev/">dev/</a>                                               01-Jan-1970 00:00                   -
<a href="etc/">etc/</a>                                               01-Jan-1970 00:00                   -
<a href="home/">home/</a>                                              01-Jan-1970 00:00                   -
<a href="lib/">lib/</a>                                               01-Jan-1970 00:00                   -
<a href="media/">media/</a>                                             01-Jan-1970 00:00                   -
<a href="mnt/">mnt/</a>                                               01-Jan-1970 00:00                   -
<a href="opt/">opt/</a>                                               01-Jan-1970 00:00                   -
<a href="proc/">proc/</a>                                              01-Jan-1970 00:00                   -
<a href="root/">root/</a>                                              01-Jan-1970 00:00                   -
<a href="run/">run/</a>                                               01-Jan-1970 00:00                   -
<a href="rust/">rust/</a>                                              01-Jan-1970 00:00                   -
<a href="sbin/">sbin/</a>                                              01-Jan-1970 00:00                   -
<a href="srv/">srv/</a>                                               01-Jan-1970 00:00                   -
<a href="sys/">sys/</a>                                               01-Jan-1970 00:00                   -
<a href="tmp/">tmp/</a>                                               01-Jan-1970 00:00                   -
<a href="usr/">usr/</a>                                               01-Jan-1970 00:00                   -
<a href="var/">var/</a>                                               01-Jan-1970 00:00                   -
<a href="busybox">busybox</a>                                            01-Jan-1970 00:00             1141024
<a href="nginx">nginx</a>                                              01-Jan-1970 00:00              741288
<a href="nginx-remote">nginx-remote</a>                                       01-Jan-1970 00:00              762440
<a href="nginx.conf">nginx.conf</a>                                         01-Jan-1970 00:00                  99
<a href="redis-cli">redis-cli</a>                                          01-Jan-1970 00:00              221256
<a href="redis-server">redis-server</a>                                       01-Jan-1970 00:00             1120888
<a href="redis.conf">redis.conf</a>                                         01-Jan-1970 00:00                  18
</pre><hr></body>
</html>
```

It is generated by `autoindex`.

Note: `nginx` might lead to an unresolved file system bug, so you might need to re-create sfs img after killing it.

### How to use gcc

First, download prebuilt musl toolchain from [musl.cc](https://musl.cc), for example `x86_64-linux-musl-cross.tgz`. Untar it into `build/x86_64` directory. You are expected have a `build/x86_64/x86_64-linux-musl` directory now.

To build a simple C program, `printf.c` for example:

```bash
$ x86_64-linux-musl-cross/bin/x86_64-linux-musl-gcc printf.c -c -o printf.o
$ x86_64-linux-musl-cross/bin/x86_64-linux-musl-ld -dynamic-linker /lib/ld-musl-x86_64.so.1 x86_64-linux-musl-cross/x86_64-linux-musl/lib/crt1.o x86_64-linux-musl-cross/x86_64-linux-musl/lib/crtn.o x86_64-linux-musl-cross/lib/gcc/x86_64-linux-musl/8.3.0/crtbeginS.o x86_64-linux-musl-cross/lib/gcc/x86_64-linux-musl/8.3.0/crtendS.o printf.o -o printf -lc -static
```

You can now run the produced program:

```bash
$ printf
Built within rCore
```

Note: the long linker args can be replaced by invoking gcc instead later when we fix the problem. If you encountered `rcore-fs-fuse` panicking, consider upgrading it to latest version.


### How to test real alpine apps
#### simple test for alpine minifs with little apps
```bash
1. make alpine arch=x86_64
2. make test arch=x86_64
3. make sfsimg arch=x86_64
4. cd $(RCORE_ROOT)/kernel; make run arch=x86_64 mode=release
```

#### test gcc/go/python2/python3/ruby/lua/java/rust
```bash
1. download x86_64.qcow2.realapps.xz from cloud tsinghua
2. xz -d x86_64.qcow2.realapps.xz; mv x86_64.qcow2.realapps x86_64.qcow2
3. mv x86_64.qcow2 $(RCORE_ROOT)/user/build
4. cd $(RCORE_ROOT)/kernel; make run arch=x86_64 mode=release
```
