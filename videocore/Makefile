build_dir := build/$(arch)
prefix := $(arch)-linux-musl-

ifeq ($(arch), mipsel)
	prefix := mipsel-linux-musln32-
endif

USER_LIB_SRCDIR = .

cc := $(prefix)gcc
strip := $(prefix)strip

user_lib := build/libgl/libgl.a

TARGET_CFLAGS += -I$(USER_LIB_SRCDIR)/libgl/include -I$(USER_LIB_SRCDIR)/libgl/src/common
TARGET_LDFLAGS += -Lbuild/libgl -lgl

define make-user-app
$2/$(notdir $1): $(addsuffix .c,$1)
	@echo LINK $$@
	$(cc) $(addsuffix .c,$1) $(TARGET_CFLAGS) $(TARGET_LDFLAGS) -o $$@
endef

.PHONY: all clean

GLESBIN := $(build_dir)/gles

USER_GLESLIST := $(basename $(wildcard *.c))

USER_GLES_BINS := $(addprefix $(GLESBIN)/, $(notdir $(USER_GLESLIST)))

all: $(user_lib) $(GLESBIN) $(USER_GLES_BINS)

$(foreach bdir,$(USER_GLESLIST),$(eval $(call make-user-app,$(bdir),$(GLESBIN))))

$(GLESBIN):
	mkdir -p $(build_dir)/gles

$(user_lib):
	mkdir -p $(build_dir)/libgl
	cd libgl/src && make arch=$(arch)

clean:
	rm -rf build/$(arch)
