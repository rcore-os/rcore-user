musl-rust_version := 1.42.0
musl-rust_tarball := musl-rust-$(musl-rust_version).tar.gz
musl-rust_tarball_path := src/$(musl-rust_tarball)
build_dir := build/$(arch)
musl-rust_dir := $(build_dir)/musl-rust-$(musl-rust_version)
musl-rust = $(build_dir)/musl-rust

.PHONY: all clean

$(musl-rust_tarball_path):
	mkdir -p src
	wget https://static.rust-lang.org/dist/rust-$(musl-rust_version)-$(arch)-unknown-linux-musl.tar.gz -O $(musl-rust_tarball_path)

$(musl-rust_dir): $(musl-rust_tarball_path)
	mkdir -p $(build_dir)
	cd $(build_dir) && tar xvf ../../$(musl-rust_tarball_path)
	mv $(build_dir)/rust-$(musl-rust_version)-$(arch)-unknown-linux-musl $(musl-rust_dir)

$(musl-rust): $(musl-rust_dir)
	cd $(musl-rust_dir) && ./install.sh --prefix=../../../../build/$(arch)/usr

all: $(musl-rust)

clean:
	rm -rf build/$(arch)
