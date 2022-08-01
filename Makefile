# Options:
# ARCH = {riscv32, riscv64, x86_64, aarch64, mipsel}
# MODE = {debug, release}
# PREBUILT: use prebuilt tar from github
# EN_* = y/n: include application or not
# targets: build, pack
ARCH ?= riscv32
MODE ?= debug
export ARCH
export MODE
EN_RUST ?= y
EN_UCORE ?= y
EN_VMM ?= n
EN_RUST_RVM_VMM ?= n
ifneq ($(shell uname), Darwin)
	EN_BISCUIT ?= y
	EN_APP ?= y
	EN_NGINX ?= y
	EN_MUSL_RUST ?= y
ifeq ($(ARCH), x86_64)
	EN_IPERF3 ?= y
endif
endif
ifeq ($(ARCH), $(filter $(ARCH), x86_64 aarch64 riscv64))
	EN_LIBC_TEST ?= y
endif
ifeq ($(ARCH), $(filter $(ARCH), x86_64 aarch64))
	EN_ALPINE ?= y
	EN_TEST ?= y
endif
ifeq ($(ARCH), $(filter $(ARCH), x86_64))
	EN_MUSL_GCC ?= y
endif

out_dir := build/$(ARCH)
out_img := build/$(ARCH).img
out_qcow2 := build/$(ARCH).qcow2
ld_path_file := $(out_dir)/etc/ld-musl-$(ARCH).path
rcore_fs_fuse_revision := 7f5eeac
biscuit_bin_path := biscuit/build/$(ARCH)
app_bin_path := app/build/$(ARCH)
busybox := $(out_dir)/busybox
alpine_version_major := 3.12
alpine_version_full := 3.12.0
alpine_file := alpine-minirootfs-$(alpine_version_full)-$(ARCH).tar.gz
alpine := alpine/$(alpine_file)
rust_src_dir := rust/src/bin
rust_bin_path := rust/target/$(ARCH)-rcore/$(MODE)
rust_build_args := -Z build-std=core,alloc --target targets/$(ARCH)-rcore.json
rust_bins := $(patsubst $(rust_src_dir)/%.rs, $(rust_bin_path)/%, $(wildcard $(rust_src_dir)/*.rs))
ucore_bin_path := ucore/build/$(ARCH)
musl-gcc_version := 6
musl-gcc := musl-gcc/build/$(ARCH)/musl-gcc
cmake_build_args := -DARCH=$(ARCH)

ifeq ($(MODE), release)
rust_build_args += --release
cmake_build_args += -DCMAKE_BUILD_TYPE=Release
else ifeq ($(MODE), debug)
cmake_build_args += -DCMAKE_BUILD_TYPE=Debug
endif

.PHONY: all clean build rust ucore biscuit app bin busybox nginx redis alpine iperf3 musl-gcc pre make libc-test vmm rust-rvm-vmm rcore-guest

all: build

# rust programs
rust:
ifeq ($(EN_RUST), y)
	@echo Building rust programs
	@cd rust && cargo build $(rust_build_args)
	@for i in $(rust_bins); do make -f rust/Makefile strip STRIP_FILE=$$i; done
	@rm -rf $(out_dir)/rust && mkdir -p $(out_dir)/rust
	@for i in $(rust_bins); do cp $$i-strip $(out_dir)/rust/$$(basename $$i); done
else
	@echo Building rust disabled
endif

# ucore programs
ucore:
ifeq ($(EN_UCORE), y)
	@echo Building ucore programs
	@mkdir -p ucore/build
	@cd ucore/build && cmake $(cmake_build_args) .. && make -j
	@rm -rf $(out_dir)/ucore && mkdir -p $(out_dir)/ucore
	@cp $(ucore_bin_path)/* $(out_dir)/ucore
else
	@echo Building ucore disabled
endif

# biscuit
biscuit:
ifeq ($(EN_BISCUIT), y)
	@echo Building biscuit programs
	@mkdir -p biscuit/build
	@cd biscuit/build && cmake $(cmake_build_args) .. && make -j
	@rm -rf $(out_dir)/biscuit && mkdir -p $(out_dir)/biscuit
	@cp $(biscuit_bin_path)/* $(out_dir)/biscuit
else
	@echo Building biscuit disabled
endif

# app
app:
ifeq ($(EN_APP), y)
	@echo Building app programs
	@mkdir -p app/build
	@cd app/build && cmake $(cmake_build_args) .. && make -j
	@rm -rf $(out_dir)/app && mkdir -p $(out_dir)/app
	@cp $(app_bin_path)/* $(out_dir)/app
else
	@echo Building app disabled
endif

# busybox
busybox: $(busybox)

$(busybox):
ifeq ($(ARCH), x86_64)
	@wget https://www.busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-x86_64 -O $(busybox)
else ifeq ($(ARCH), aarch64)
	@wget https://raw.githubusercontent.com/docker-library/busybox/a3f79e474f617f7ff008148555df93bc7ae4a9ab/musl/busybox.tar.xz -O busybox.tar.xz
	@mkdir -p tmp
	@tar -x -C tmp -f busybox.tar.xz
	@mv tmp/bin/busybox $(busybox)
	@rm -rf tmp && rm busybox.tar.xz
else ifeq ($(ARCH), mipsel)
	@wget https://www.busybox.net/downloads/binaries/1.31.0-defconfig-multiarch-musl/busybox-mipsel -O $(busybox)
else ifeq ($(ARCH), $(filter $(ARCH), riscv64 riscv32))
	@wget https://github.com/rcore-os/busybox-prebuilts/raw/master/busybox-1.30.1-${ARCH}/busybox -O $(busybox)
endif

# nginx
nginx:
ifeq ($(EN_NGINX), y)
	@echo Building nginx
	mkdir -p $(out_dir)/usr/local/nginx/conf
	mkdir -p $(out_dir)/usr/local/nginx/logs
	@cd nginx && make ARCH=$(ARCH) all
	@cp nginx/build/$(ARCH)/nginx $(out_dir)
	@cp nginx/nginx.conf $(out_dir)/usr/local/nginx/conf
else
	@echo Building nginx disabled
endif

# redis
redis:
ifeq ($(EN_REDIS), y)
	@echo Building redis
	@mkdir -p $(out_dir)
	@cd redis && make ARCH=$(ARCH) all
	@cp redis/build/$(ARCH)/redis-server $(out_dir)/redis-server
	@cp redis/build/$(ARCH)/redis-cli $(out_dir)/redis-cli
	@cp redis/redis.conf $(out_dir)/redis.conf
else
	@echo Building redis disabled
endif

# iperf3
iperf3:
ifeq ($(EN_IPERF3), y)
	@echo Building iperf3
	@mkdir -p $(out_dir)/dev
	@dd if=/dev/urandom of=$(out_dir)/dev/urandom count=512
	@cd iperf3 && make ARCH=$(ARCH) all
	@cp iperf3/build/$(ARCH)/iperf3 $(out_dir)
else
	@echo Building iperf3 disabled
endif

# alpine
alpine: $(alpine)
ifeq ($(EN_ALPINE), y)
	@echo Setup alpine rootfs
	@mkdir -p $(out_dir)/etc
	@echo "nameserver 101.6.6.6" > $(out_dir)/etc/resolv.conf
	@cd $(out_dir) && tar xf ../../$(alpine)
else
	@echo Alpine rootfs disabled
endif

$(alpine):
	-wget "http://dl-cdn.alpinelinux.org/alpine/v$(alpine_version_major)/releases/$(ARCH)/$(alpine_file)" -O $(alpine)

# musl-gcc
musl-gcc: $(musl-gcc)
ifeq ($(EN_MUSL_GCC), y)
	@echo Building musl-gcc
	@cp -r $(musl-gcc)/* $(out_dir)/usr/ || true # might fail in vanilla macOS, but is ok
	@mkdir -p $(out_dir)/etc
else
	@echo Musl-gcc disabled
endif

$(musl-gcc):
ifeq ($(EN_MUSL_GCC), y)
	cd musl-gcc && make all ARCH=$(ARCH)
endif

# tests
test:
ifeq ($(EN_TEST), y)
	@echo Setup tests
	@mkdir -p $(out_dir)
	@cp -r testsuits_alpine $(out_dir)/test
	@cp test.sh $(out_dir)
else
	@echo Tests disabled
endif

# libc-test
libc-test:
ifeq ($(EN_LIBC_TEST), y)
	@echo Building libc-test
	@mkdir -p $(out_dir)/libc-test
	@cp -r -p libc-test $(out_dir)
	@cd $(out_dir)/libc-test && make build ARCH=$(ARCH) -k
else
	@echo Libc-test disabled
endif

# vmm
vmm: | vmm/*
ifeq ($(EN_VMM), y)
	@echo Building rcore-vmm
	@mkdir -p $(out_dir)/vmm
	@cd vmm && make build-$(ARCH) ARCH=$(ARCH)
	@cp vmm/build/$(ARCH)/* $(out_dir)/vmm/
else
	@echo rcore-vmm disabled
endif

# rust-rvm-vmm
rust-rvm-vmm: | rust-rvm-vmm/* rcore-guest
ifeq ($(EN_RUST_RVM_VMM), y)
	@echo Building rust-rvm-vmm
	@cd rust-rvm-vmm && cargo build $(rust_build_args) && make strip
	@rm -rf $(out_dir)/rust-rvm-vmm && mkdir -p $(out_dir)/rust-rvm-vmm
	@cp rust-rvm-vmm/target/$(ARCH)-rcore/$(MODE)/rust-rvm-vmm-strip $(out_dir)/rust-rvm-vmm/vmm
else
	@echo rust-rvm-vmm disabled
endif

# prebuilt rCore guest image

rcore_guest_image := build/$(ARCH)/vmm/rcore
rcore-guest: $(rcore_guest_image)
$(rcore_guest_image):
ifeq ($(ARCH), riscv64)
	@mkdir -p build/$(ARCH)/vmm
	@wget "https://github.com/rcore-riscv-hypervisor-dev/rcore-guest-image-blob/blob/master/kernel.img?raw=true" -O $@
else
	@echo rcore guest image not supported
endif
# prebuilt
prebuilt_version := 0.1.2
prebuilt_tar := build/$(ARCH)_v$(prebuilt_version).tar.gz
$(prebuilt_tar):
	@mkdir -p build
	@wget https://github.com/rcore-os/rcore-user/releases/download/v$(prebuilt_version)/$(ARCH).tar.gz -O $@

# build
ifdef PREBUILT
build: $(prebuilt_tar)
	@tar -xzf $< -C build
else
build: rcore-fs-fuse pre alpine rust ucore biscuit app busybox nginx redis iperf3 test musl-gcc make libc-test vmm rust-rvm-vmm rcore-guest
endif

sfsimg: $(out_qcow2)

# pack qcow2 and img without building again
pack:
	rcore-fs-fuse $(out_img) $(out_dir) zip
	qemu-img convert -f raw $(out_img) -O qcow2 $(out_qcow2)
	qemu-img resize $(out_qcow2) +1G

$(out_img): build rcore-fs-fuse
	rcore-fs-fuse $@ $(out_dir) zip

$(out_qcow2): $(out_img)
	@echo Generating sfsimg
	@qemu-img convert -f raw $< -O qcow2 $@
	@qemu-img resize $@ +1G

make:
	cd make && make make

pre:
	@mkdir -p $(out_dir)
	@mkdir -p $(out_dir)/etc
	cat /dev/null > $(ld_path_file)
	@echo "/usr/$(ARCH)-linux-musl/lib" >> $(ld_path_file)
	@echo "/usr/lib" >> $(ld_path_file)

tar: build
	@cd build && tar -czf $(ARCH).tar.gz $(ARCH)

rcore-fs-fuse:
ifneq ($(shell rcore-fs-fuse dir image git-version), $(rcore_fs_fuse_revision))
	@echo Installing rcore-fs-fuse
	@cargo install rcore-fs-fuse --git https://github.com/rcore-os/rcore-fs --rev $(rcore_fs_fuse_revision) --force
endif

clean:
	@cd rust && cargo clean
	@if [ -d vmm ]; then cd vmm && make clean; fi
	@rm -rf biscuit/build ucore/build app/build
	@rm -rf $(out_dir)
