cmake_minimum_required(VERSION 3.0)

project(biscuit_user)
enable_language(ASM)

# Path
aux_source_directory(c SRCS)
aux_source_directory(c/libs LIBS)
include_directories(c/include)
set(EXECUTABLE_OUTPUT_PATH ${ARCH})

# Find the kernel release
execute_process(
  COMMAND uname -r
  OUTPUT_VARIABLE KERNEL_RELEASE
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

# Find the headers
find_path(KERNEL_HEADERS_DIR
  include/linux/user.h
  PATHS /usr/lib/modules/${KERNEL_RELEASE}/build
)

# Toolchain
if (${ARCH} STREQUAL i386)
    if(APPLE)
        set(PREFIX          i386-elf-)
    endif ()
    set(CMAKE_C_FLAGS       "-m32 -mno-red-zone")
elseif (${ARCH} STREQUAL x86_64)
    if(APPLE)
        set(PREFIX          x86_64-linux-musl-)
    else ()
        set(PREFIX          musl-)
    endif ()
    set(CMAKE_C_FLAGS       "-m64 -mno-red-zone")
elseif (${ARCH} STREQUAL riscv32)
    set(PREFIX              riscv64-unknown-elf-)
    set(CMAKE_C_FLAGS       "-march=rv32imac -mabi=ilp32 -mcmodel=medany")
elseif (${ARCH} STREQUAL riscv64)
    set(PREFIX              riscv64-unknown-elf-)
    set(CMAKE_C_FLAGS       "-march=rv64imac -mabi=lp64 -mcmodel=medany")
elseif (${ARCH} STREQUAL aarch64)
    if(APPLE)
        set(PREFIX          aarch64-none-elf-)
    else ()
        set(PREFIX          aarch64-elf-)
    endif ()
else ()
    message("Unsupported arch: ${ARCH}")
endif ()
set(CMAKE_ASM_COMPILER      ${PREFIX}gcc)
set(CMAKE_C_COMPILER        ${PREFIX}gcc)
set(CMAKE_RANLIB            ${PREFIX}ranlib)
set(CMAKE_C_FLAGS           "${CMAKE_C_FLAGS} -Wall -Wno-pointer-to-int-cast -Wno-format -MMD -MP -O -g -fPIC -static -std=gnu99")
set(CMAKE_ASM_FLAGS         ${CMAKE_C_FLAGS})
set(CMAKE_C_LINK_FLAGS      "${LINK_FLAGS} -pthread")  # override default value to get rid of '-Wl,-search_paths_first -Wl,-headerpad_max_install_names'
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)                  # override default value to get rid of '-rdynamic' on Linux

if (KERNEL_HEADERS_DIR)
	include_directories(${KERNEL_HEADERS_DIR}/include/uapi)
endif ()

# Execuatble
foreach (PATH ${SRCS})
    get_filename_component(NAME ${PATH} NAME_WE)
    add_executable(${NAME} ${PATH})
endforeach ()
