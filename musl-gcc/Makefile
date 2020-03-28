musl-gcc_version := 6
musl-gcc_tarball := musl-gcc-$(musl-gcc_version).tgz
musl-gcc_tarball_path := src/$(musl-gcc_tarball)
build_dir := build/$(arch)
musl-gcc_dir := $(build_dir)/musl-gcc/
musl-gcc = $(build_dir)/musl-gcc

prefix = x86_64-linux-musl

.PHONY: all clean

$(musl-gcc_tarball_path):
	@mkdir -p src
	wget "https://more.musl.cc/$(musl-gcc_version)/x86_64-linux-musl/$(arch)-linux-musl-cross.tgz" -O $(musl-gcc_tarball_path)

$(musl-gcc_dir): $(musl-gcc_tarball_path)
	@mkdir -p $(build_dir)
	@cd $(build_dir) && tar xvf ../../$(musl-gcc_tarball_path) && mv $(arch)-linux-musl-cross musl-gcc
	@cd $(musl-gcc_dir)/bin && cp $(prefix)-cc cc && cp $(prefix)-ld ld && cp $(prefix)-gcc gcc && cp $(prefix)-g++ g++

all: $(musl-gcc_dir)

clean:
	rm -rf build/$(arch)
