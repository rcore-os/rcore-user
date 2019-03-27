# arch = {riscv32, riscv64, x86_64, aarch64}
# mode = {debug, release}
arch ?= riscv32
mode ?= debug
out_dir ?= build/$(arch)
out_img ?= build/$(arch).img
out_qcow2 ?= build/$(arch).qcow2

rust_src_dir := rust/src/bin
rust_bin_path := rust/target/$(arch)-rcore/$(mode)
rust_bins := $(patsubst $(rust_src_dir)/%.rs, $(rust_bin_path)/%, $(wildcard $(rust_src_dir)/*.rs))
ucore_bin_path := ucore/build/$(arch)
biscuit_bin_path := biscuit/build/$(arch)
busybox := $(out_dir)/busybox

rust_build_args := --target targets/$(arch)-rcore.json
cmake_build_args := -DARCH=$(arch)

ifeq ($(mode), release)
rust_build_args += --release
cmake_build_args += -DCMAKE_BUILD_TYPE=Release
endif


.PHONY: all clean build rust ucore biscuit bin busybox nginx redis

all: build

rust:
	@echo Building rust programs
	@cd rust && cargo xbuild $(rust_build_args)
	@rm -rf $(out_dir)/rust && mkdir -p $(out_dir)/rust
	@cp $(rust_bins) $(out_dir)/rust

ucore:
ifneq ($(arch), x86_64)
	@echo Building ucore programs
	@mkdir -p ucore/build
	@cd ucore/build && cmake $(cmake_build_args) .. && make
	@rm -rf $(out_dir)/ucore && mkdir -p $(out_dir)/ucore
	@cp $(ucore_bin_path)/* $(out_dir)/ucore
endif

biscuit:
ifeq ($(arch), $(filter $(arch), x86_64 aarch64 riscv64))
ifneq ($(shell uname)-$(arch), Darwin-riscv64)
	@echo Building biscuit programs
	@mkdir -p biscuit/build
	@cd biscuit/build && cmake $(cmake_build_args) .. && make
	@rm -rf $(out_dir)/biscuit && mkdir -p $(out_dir)/biscuit
	@cp $(biscuit_bin_path)/* $(out_dir)/biscuit
endif
endif

$(busybox):
ifeq ($(arch), x86_64)
	@wget https://raw.githubusercontent.com/docker-library/busybox/82bc0333a9ae148fbb4246bcbff1487b3fc0c510/musl/busybox.tar.xz -O busybox.tar.xz
else ifeq ($(arch), aarch64)
	@wget https://raw.githubusercontent.com/docker-library/busybox/a3f79e474f617f7ff008148555df93bc7ae4a9ab/musl/busybox.tar.xz -O busybox.tar.xz
endif
ifeq ($(arch), $(filter $(arch), x86_64 aarch64))
	@mkdir -p tmp
	@tar -x -C tmp -f busybox.tar.xz
	@mv tmp/bin/busybox $(busybox)
	@rm -rf tmp && rm busybox.tar.xz
endif
ifeq ($(arch), riscv64)
	@wget https://github.com/rcore-os/busybox-riscv-prebuilts/raw/master/busybox-1.30.1-riscv64/busybox -O $(busybox)
endif

busybox: $(busybox)

nginx:
ifneq ($(arch), riscv32)
ifneq ($(shell uname), Darwin)
	@echo Building nginx
	mkdir -p $(out_dir)
	@cd nginx && make arch=$(arch) all
	@cp nginx/build/$(arch)/nginx $(out_dir)/nginx
endif
endif

redis:
ifneq ($(arch), riscv64)
ifneq ($(shell uname), Darwin)
	@echo Building redis
	@mkdir -p $(out_dir)
	@cd redis && make arch=$(arch) all
	@cp redis/build/$(arch)/redis-server $(out_dir)/redis-server
	@cp redis/build/$(arch)/redis-cli $(out_dir)/redis-cli
	@cp redis/redis.conf $(out_dir)/redis.conf
endif
endif

build: rust ucore biscuit $(busybox) nginx redis

sfsimg: $(out_qcow2)

$(out_img): build rcore-fs-fuse
	@rcore-fs-fuse $@ $(out_dir) zip

$(out_qcow2): $(out_img)
	@echo Generating sfsimg
	@qemu-img convert -f raw $< -O qcow2 $@
	@qemu-img resize $@ +1G

rcore-fs-fuse:
ifeq ($(shell which rcore-fs-fuse),)
	@echo Installing rcore-fs-fuse
	@cargo install rcore-fs-fuse --git https://github.com/rcore-os/rcore-fs --rev ff3dd7d
endif

clean:
	@cd rust && cargo clean
	@rm -rf biscuit/build ucore/build
	@rm -rf $(out_dir)
