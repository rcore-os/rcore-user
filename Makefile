# arch = {riscv32, riscv64, x86_64, aarch64, mipsel}
# mode = {debug, release}
arch ?= riscv32
mode ?= debug
out_dir ?= build/$(arch)
out_img ?= build/$(arch).img
out_qcow2 ?= build/$(arch).qcow2

prebuilt_version ?= 0.1.2
rcore_fs_fuse_revision ?= 351d382

prebuilt_tar := build/$(arch)_v$(prebuilt_version).tar.gz
rust_src_dir := rust/src/bin
rust_bin_path := rust/target/$(arch)-rcore/$(mode)
rust_bins := $(patsubst $(rust_src_dir)/%.rs, $(rust_bin_path)/%, $(wildcard $(rust_src_dir)/*.rs))
ucore_bin_path := ucore/build/$(arch)
biscuit_bin_path := biscuit/build/$(arch)
app_bin_path := app/build/$(arch)
busybox := $(out_dir)/busybox
alpine_version_major := 3.10
alpine_version_full := 3.10.2
alpine_file := alpine-minirootfs-$(alpine_version_full)-$(arch).tar.gz
alpine := alpine/$(alpine_file)

rust_build_args := --target targets/$(arch)-rcore.json
cmake_build_args := -DARCH=$(arch)

ifeq ($(mode), release)
rust_build_args += --release
cmake_build_args += -DCMAKE_BUILD_TYPE=Release
else ifeq ($(mode), debug)
cmake_build_args += -DCMAKE_BUILD_TYPE=Debug
endif


.PHONY: all clean build rust ucore biscuit app bin busybox nginx redis alpine iperf3

all: build

rust:
	@echo Building rust programs
	@cd rust && cargo xbuild $(rust_build_args)
	@rm -rf $(out_dir)/rust && mkdir -p $(out_dir)/rust
	@cp $(rust_bins) $(out_dir)/rust

ucore:
	@echo Building ucore programs
	@mkdir -p ucore/build
	@cd ucore/build && cmake $(cmake_build_args) .. && make -j
	@rm -rf $(out_dir)/ucore && mkdir -p $(out_dir)/ucore
	@cp $(ucore_bin_path)/* $(out_dir)/ucore

biscuit:
	@echo Building biscuit programs
	@mkdir -p biscuit/build
	@cd biscuit/build && cmake $(cmake_build_args) .. && make -j
	@rm -rf $(out_dir)/biscuit && mkdir -p $(out_dir)/biscuit
	@cp $(biscuit_bin_path)/* $(out_dir)/biscuit

app:
	@echo Building custom test programs
	@mkdir -p app/build
	@cd app/build && cmake $(cmake_build_args) .. && make -j
	@rm -rf $(out_dir)/app && mkdir -p $(out_dir)/app
	@cp $(app_bin_path)/* $(out_dir)/app

$(busybox):
ifeq ($(arch), x86_64)
	@wget https://www.busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64 -O $(busybox)
else ifeq ($(arch), aarch64)
	@wget https://raw.githubusercontent.com/docker-library/busybox/a3f79e474f617f7ff008148555df93bc7ae4a9ab/musl/busybox.tar.xz -O busybox.tar.xz
	@mkdir -p tmp
	@tar -x -C tmp -f busybox.tar.xz
	@mv tmp/bin/busybox $(busybox)
	@rm -rf tmp && rm busybox.tar.xz
else ifeq ($(arch), mipsel)
	@wget https://www.busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-mipsel -O $(busybox)
else ifeq ($(arch), $(filter $(arch), riscv64 riscv32))
	@wget https://github.com/rcore-os/busybox-prebuilts/raw/master/busybox-1.30.1-${arch}/busybox -O $(busybox)
endif

busybox: $(busybox)

nginx:
ifneq ($(shell uname), Darwin)
	@echo Building nginx
	mkdir -p $(out_dir)/usr/local/nginx/conf
	mkdir -p $(out_dir)/usr/local/nginx/logs
	@cd nginx && make arch=$(arch) all
	@cp nginx/build/$(arch)/nginx $(out_dir)
	@cp nginx/nginx.conf $(out_dir)/usr/local/nginx/conf
endif

redis:
ifneq ($(shell uname), Darwin)
	@echo Building redis
	@mkdir -p $(out_dir)
	@cd redis && make arch=$(arch) all
	@cp redis/build/$(arch)/redis-server $(out_dir)/redis-server
	@cp redis/build/$(arch)/redis-cli $(out_dir)/redis-cli
	@cp redis/redis.conf $(out_dir)/redis.conf
endif

iperf3:
ifeq ($(arch), x86_64)
ifneq ($(shell uname), Darwin)
	@echo Building iperf3
	@mkdir -p $(out_dir)/dev
	@dd if=/dev/urandom of=$(out_dir)/dev/urandom count=512
	@cd iperf3 && make arch=$(arch) all
	@cp iperf3/build/$(arch)/iperf3 $(out_dir)
endif
endif

$(alpine):
	-wget "http://dl-cdn.alpinelinux.org/alpine/v$(alpine_version_major)/releases/$(arch)/$(alpine_file)" -O $(alpine)

alpine: $(alpine)
ifeq ($(arch), $(filter $(arch), x86_64 aarch64))
	@mkdir -p $(out_dir)/etc
	@echo "nameserver 101.6.6.6" > $(out_dir)/etc/resolv.conf
	@cd $(out_dir) && tar xf ../../$(alpine)
endif

test:
ifeq ($(arch), $(filter $(arch), x86_64 aarch64))
	@echo setup test DIR
	@mkdir -p $(out_dir)
	@cp -r testsuits_alpine $(out_dir)/test
endif

ifeq ($(prebuilt), 1)
build: $(prebuilt_tar)
	@tar -xzf $< -C build
else
build: alpine rust ucore biscuit app busybox nginx redis iperf3 test
endif

$(prebuilt_tar):
	@mkdir -p build
	@wget https://github.com/rcore-os/rcore-user/releases/download/v$(prebuilt_version)/$(arch).tar.gz -O $@

sfsimg: $(out_qcow2)

$(out_img): build rcore-fs-fuse
	@rcore-fs-fuse $@ $(out_dir) zip

$(out_qcow2): $(out_img)
	@echo Generating sfsimg
	@qemu-img convert -f raw $< -O qcow2 $@
	@qemu-img resize $@ +1G

tar: build
	@cd build && tar -czf $(arch).tar.gz $(arch)

rcore-fs-fuse:
ifneq ($(shell rcore-fs-fuse dir image git-version), $(rcore_fs_fuse_revision))
	@echo Installing rcore-fs-fuse
	@cargo install rcore-fs-fuse --git https://github.com/rcore-os/rcore-fs --rev $(rcore_fs_fuse_revision) --force
endif

clean:
	@cd rust && cargo clean
	@rm -rf biscuit/build ucore/build app/build
	@rm -rf $(out_dir)
