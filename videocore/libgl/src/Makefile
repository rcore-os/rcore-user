.PHONY: all clean

ULIB_OBJ_ROOT := ../../build
LIBGL_OBJ_ROOT := $(ULIB_OBJ_ROOT)/libgl
LIBGL_A := $(LIBGL_OBJ_ROOT)/libgl.a
ULIB_SRC_ROOT := ../..

TARGET_CC = $(arch)-linux-musl-gcc
TARGET_AR = $(arch)-linux-musl-ar

TARGET_FLAGS = -Icommon -I../include -I.

obj-y += gl_context.o gl.o egl.o

include drivers/vc4/Makefile

obj-y += $(addprefix drivers/vc4/, $(VC4_OBJS))
target-obj := $(addprefix $(LIBGL_OBJ_ROOT)/, $(obj-y))

all: $(target-obj) $(LIBGL_A)

$(LIBGL_A): $(target-obj)
	$(TARGET_AR) -cr $@ $+

$(LIBGL_OBJ_ROOT)/%.o: %.c | $(LIBGL_OBJ_ROOT)
	$(TARGET_CC) $(TARGET_FLAGS) -c -o $@ $<

$(LIBGL_OBJ_ROOT):
	@mkdir -p $(LIBGL_OBJ_ROOT)
	@mkdir -p $(LIBGL_OBJ_ROOT)/drivers/vc4

clean:
	find . -name \*.o -exec rm -f {} \;
	rm -f $(LIBGL_A)
