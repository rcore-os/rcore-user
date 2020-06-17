nginx_version := 1.14.2
nginx_tarball := nginx-$(nginx_version).tar.gz
nginx_tarball_path := src/nginx-$(nginx_version).tar.gz
build_dir := build/$(ARCH)
nginx_dir := $(build_dir)/nginx-$(nginx_version)
prefix := $(ARCH)-linux-musl-
bin_unstripped := build/$(ARCH)/nginx_unstripped
bin := build/$(ARCH)/nginx

ifeq ($(ARCH), mipsel)
	prefix := mipsel-linux-musln32-
endif

cc := $(prefix)gcc
strip := $(prefix)strip

$(nginx_tarball_path):
	wget https://nginx.org/download/$(nginx_tarball) -O $(nginx_tarball_path)

$(nginx_dir): $(nginx_tarball_path)
	mkdir -p $(build_dir)
	cd $(build_dir) && tar xvf ../../$(nginx_tarball_path)

$(nginx_dir)/objs/nginx: $(nginx_dir)
	sed -i 's/-Wl,-E//' $(nginx_dir)/auto/cc/conf
	# cross compile, do not run
	sed -i 's/ngx_feature_run=yes/ngx_feature_run=no/' $(nginx_dir)/auto/cc/name
	sed -i 's/ngx_test="$$CC /ngx_test="gcc /' $(nginx_dir)/auto/types/sizeof
	cd $(nginx_dir) && ./configure --with-cc=$(cc) --with-cc-opt=-static --with-ld-opt=-static --without-pcre --without-http_rewrite_module --without-http_gzip_module --with-poll_module --without-http_upstream_zone_module
	cd $(nginx_dir) && printf "#ifndef NGX_SYS_NERR\n#define NGX_SYS_NERR  132\n#endif\n" >> objs/ngx_auto_config.h
	cd $(nginx_dir) && printf "#ifndef NGX_HAVE_SVSVSHM\n#define NGX_HAVE_SYSVSHM  1\n#endif\n" >> objs/ngx_auto_config.h
	# FIXME: overflow will occur on 32-bit platforms, this is only a temporary workaround
	cd $(nginx_dir) && make CFLAGS="${CFLGAS} -Wno-error=overflow"

$(bin_unstripped): $(nginx_dir)/objs/nginx
	cp $(nginx_dir)/objs/nginx $(bin_unstripped)

$(bin): $(bin_unstripped)
	cp $(bin_unstripped) $(bin)
	$(strip) $(bin)

.PHONY: all clean

all: $(bin)

clean:
	rm -rf build/$(ARCH)
