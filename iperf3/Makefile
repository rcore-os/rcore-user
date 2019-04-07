iperf3_version := 3.6
iperf3_tarball := iperf3-$(iperf3_version).tar.gz
iperf3_tarball_path := src/$(iperf3_tarball)
build_dir := build/$(arch)
iperf3_dir := $(build_dir)/iperf-$(iperf3_version)
prefix := $(arch)-linux-musl-
bin_unstripped := build/$(arch)/iperf3_unstripped
bin := build/$(arch)/iperf3

ifeq ($(arch), mipsel)
	prefix := mipsel-linux-musln32-
endif

cc := $(prefix)gcc
strip := $(prefix)strip

$(iperf3_tarball_path):
	wget https://github.com/esnet/iperf/archive/$(iperf3_version).tar.gz -O $(iperf3_tarball_path)

$(iperf3_dir): $(iperf3_tarball_path)
	mkdir -p $(build_dir)
	cd $(build_dir) && tar xvf ../../$(iperf3_tarball_path)

$(iperf3_dir)/src/iperf3: $(iperf3_dir)
	sed -i 's/AM_INIT_AUTOMAKE$$/AM_INIT_AUTOMAKE\([foreign]\)/' $(iperf3_dir)/configure.ac
	sed -i 's/-pg//' $(iperf3_dir)/src/Makefile.am
	cd $(iperf3_dir) && autoreconf
	cd $(iperf3_dir) && ./configure CC=$(cc) --disable-shared --enable-static --without-openssl --host $(arch)-linux-musl
	cd $(iperf3_dir) && make iperf3_CFLAGS="--static"

$(bin_unstripped): $(iperf3_dir)/src/iperf3
	cp $(iperf3_dir)/src/iperf3 $(bin_unstripped)

$(bin): $(bin_unstripped)
	cp $(bin_unstripped) $(bin)
	$(strip) $(bin)

.PHONY: all clean

all: $(bin)

clean:
	rm -rf build/$(arch)
