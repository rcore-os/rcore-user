redis_version := 5.0.3
redis_tarball := redis-$(redis_version).tar.gz
redis_tarball_path := src/redis-$(redis_version).tar.gz
build_dir := build/$(arch)
redis_dir := $(build_dir)/redis-$(redis_version)
cc := $(arch)-linux-musl-gcc
strip := $(arch)-linux-musl-strip
bin_server_unstripped := build/$(arch)/redis-server-unstripped
bin_server := build/$(arch)/redis-server
bin_cli_unstripped := build/$(arch)/redis-cli-unstripped
bin_cli := build/$(arch)/redis-cli

$(redis_tarball_path):
	wget http://download.redis.io/releases/$(redis_tarball) -O $(redis_tarball_path)

$(redis_dir): $(redis_tarball_path)
	mkdir -p $(build_dir)
	cd $(build_dir) && tar xvf ../../$(redis_tarball_path)

$(redis_dir)/src/redis-server: $(redis_dir)
	cd $(redis_dir) && make CC=$(cc) MALLOC=libc

$(bin_server_unstripped): $(redis_dir)/src/redis-server
	cp $(redis_dir)/src/redis-server $(bin_server_unstripped)

$(bin_server): $(bin_server_unstripped)
	cp $(bin_server_unstripped) $(bin_server)
	$(strip) $(bin_server)

$(bin_cli_unstripped): $(redis_dir)/src/redis-cli
	cp $(redis_dir)/src/redis-cli $(bin_cli_unstripped)

$(bin_cli): $(bin_cli_unstripped)
	cp $(bin_cli_unstripped) $(bin_cli)
	$(strip) $(bin_cli)

.PHONY: all clean

all: $(bin_server) $(bin_cli)

clean:
	rm -rf build/$(arch)
