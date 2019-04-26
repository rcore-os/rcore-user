redis_version := 5.0.3
redis_tarball := redis-$(redis_version).tar.gz
redis_tarball_path := src/redis-$(redis_version).tar.gz
build_dir := build/$(arch)
redis_dir := $(build_dir)/redis-$(redis_version)
prefix := $(arch)-linux-musl-
bin_server_unstripped := build/$(arch)/redis-server-unstripped
bin_server := build/$(arch)/redis-server
bin_cli_unstripped := build/$(arch)/redis-cli-unstripped
bin_cli := build/$(arch)/redis-cli

ifeq ($(arch), mipsel)
	prefix := mipsel-linux-musln32-
endif

cc := $(prefix)gcc
strip := $(prefix)strip

# $ARCH is also used in redis internal Makefile, avoid clashing
undefine ARCH

$(redis_tarball_path):
	wget http://download.redis.io/releases/$(redis_tarball) -O $(redis_tarball_path)

$(redis_dir)/src/config.h: $(redis_tarball_path)
	mkdir -p $(build_dir)
	cd $(build_dir) && tar xvf ../../$(redis_tarball_path)

$(redis_dir)/src/redis-server: $(redis_dir)/src/config.h
	# we do not support epoll at the time
	sed -i 's/#define HAVE_EPOLL 1//' $(redis_dir)/src/config.h
	# our accept does not have backlog
	sed -i 's/#define MAX_ACCEPTS_PER_CALL 1000/#define MAX_ACCEPTS_PER_CALL 1/' $(redis_dir)/src/networking.c
	# note: on some platforms gcc seems to forget linking with libatomic, fix it anyway
	sed -i 's/-ldl -pthread -lrt/-ldl -pthread -lrt -latomic/' $(redis_dir)/src/Makefile
	cd $(redis_dir) && make CC=$(cc) LDFLAGS="${LDFLAGS} -static" MALLOC=libc

$(bin_server_unstripped): $(redis_dir)/src/redis-server
	cp $(redis_dir)/src/redis-server $(bin_server_unstripped)

$(bin_server): $(bin_server_unstripped)
	cp $(bin_server_unstripped) $(bin_server)
	$(strip) $(bin_server)

$(bin_cli_unstripped): $(redis_dir)/src/redis-server
	cp $(redis_dir)/src/redis-cli $(bin_cli_unstripped)

$(bin_cli): $(bin_cli_unstripped)
	cp $(bin_cli_unstripped) $(bin_cli)
	$(strip) $(bin_cli)

.PHONY: all clean

all: $(bin_server) $(bin_cli)

clean:
	rm -rf build/$(arch)
