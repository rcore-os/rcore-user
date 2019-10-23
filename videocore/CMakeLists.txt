cmake_minimum_required(VERSION 3.0)

project(videocore)
enable_language(ASM)

aux_source_directory(src .)
file(GLOB_RECURSE LIBSGL RELATIVE ${CMAKE_SOURCE_DIR} "libgl/src/*.[c,h]")
include_directories(src/libgl/include ${ARCH_DIR})
set(EXECUTABLE_OUTPUT_PATH ${ARCH})

# Toolchain
set(PREFIX ${ARCH}-linux-musl-)

if (${ARCH} STREQUAL x86_64)
    set(CMAKE_C_FLAGS       "-m64")
elseif (${ARCH} STREQUAL riscv32)
    set(CMAKE_C_FLAGS       "-march=rv32imac -mabi=ilp32 -mcmodel=medany")
elseif (${ARCH} STREQUAL riscv64)
    set(CMAKE_C_FLAGS       "-march=rv64imac -mabi=lp64 -mcmodel=medany")
elseif (${ARCH} STREQUAL aarch64)
    set(CMAKE_C_FLAGS       "-mgeneral-regs-only")
elseif (${ARCH} STREQUAL mipsel)
    set(PREFIX              mipsel-linux-musln32-)
else()
    message("Unsupported arch: ${ARCH}")
endif ()
set(CMAKE_ASM_COMPILER      ${PREFIX}gcc)
set(CMAKE_C_COMPILER        ${PREFIX}gcc)
set(CMAKE_RANLIB            ${PREFIX}ranlib)
set(CMAKE_C_FLAGS           "${CMAKE_C_FLAGS} -fno-builtin -nostdinc -fno-stack-protector -ggdb -Wall")
set(CMAKE_ASM_FLAGS         ${CMAKE_C_FLAGS})
set(CMAKE_C_LINK_FLAGS      "${LINK_FLAGS} -nostdlib")  # override default value to get rid of '-Wl,-search_paths_first -Wl,-headerpad_max_install_names'
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)                  # override default value to get rid of '-rdynamic' on Linux

# Library
add_library(ulibgl ${LIBSGL})

# Execuatble
foreach (PATH ${SRCS})
    get_filename_component(NAME ${PATH} NAME_WE)
    add_executable(${NAME} ${PATH})
    target_link_libraries(${NAME} ulibgl)
endforeach ()
