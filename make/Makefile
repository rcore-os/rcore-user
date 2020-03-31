make_version := 4.3
make_tarball := make-$(make_version).tar.gz
make_tarball_path := src/$(make_tarball)
build_dir := build/$(arch)
make_dir := $(build_dir)/make-$(make_version)

# http://ftp.gnu.org/gnu/make/make-4.3.tar.gz

.PHONY: all clean make

$(make_tarball_path):
	mkdir -p src
	wget http://ftp.gnu.org/gnu/make/make-$(make_version).tar.gz -O $(make_tarball_path)

prefix = $(shell readlink -f ../build/$(arch)/usr)

$(make_dir): $(make_tarball_path)
	mkdir -p $(build_dir)
	cd $(build_dir) && tar xvf ../../$(make_tarball_path)

make: $(make_dir)
	@echo prefix=$(prefix)
	cd $(build_dir)/make-4.3 && \
	./configure --prefix=$(readlink -f ../../../../build/$(arch)/usr) && \
	make && \
	make install

all: make

clean:
	rm -rf build/$(arch)
