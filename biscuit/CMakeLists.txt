cmake_minimum_required(VERSION 3.0)

project(biscuit_user)
enable_language(ASM)

# Path
aux_source_directory(c SRCS)
aux_source_directory(c/libs LIBS)
include_directories(c/include)
set(EXECUTABLE_OUTPUT_PATH ${ARCH})

# Toolchain
if (${ARCH} STREQUAL i386)
    if(APPLE)
        set(PREFIX          i386-elf-)
    endif ()
    set(CMAKE_C_FLAGS       "-m32 -mno-red-zone")
elseif (${ARCH} STREQUAL x86_64)
    if(APPLE)
        set(PREFIX          x86_64-elf-)
    endif ()
    set(CMAKE_C_FLAGS       "-m64 -mno-red-zone")
elseif (${ARCH} STREQUAL riscv32)
    set(PREFIX              riscv64-unknown-elf-)
    set(CMAKE_C_FLAGS       "-march=rv32imac -mabi=ilp32 -mcmodel=medany")
elseif (${ARCH} STREQUAL riscv64)
    set(PREFIX              riscv64-unknown-elf-)
    set(CMAKE_C_FLAGS       "-march=rv64imac -mabi=lp64 -mcmodel=medany")
elseif (${ARCH} STREQUAL aarch64)
    set(PREFIX              aarch64-none-elf-)
    set(LINK_FLAGS          "-Ttext 0xffff000000000000")
else()
    message("Unsupported arch: ${ARCH}")
endif ()
set(CMAKE_ASM_COMPILER      ${PREFIX}gcc)
set(CMAKE_C_COMPILER        ${PREFIX}gcc)
set(CMAKE_RANLIB            ${PREFIX}ranlib)
set(CMAKE_C_FLAGS           "${CMAKE_C_FLAGS} -Wall -Werror -MMD -MP -O -g -ffreestanding -nostdlib -nostdinc -fno-builtin -fno-stack-protector -fPIC -std=gnu11")
set(CMAKE_ASM_FLAGS         ${CMAKE_C_FLAGS})
set(CMAKE_C_LINK_FLAGS      "${LINK_FLAGS} -nostdlib")  # override default value to get rid of '-Wl,-search_paths_first -Wl,-headerpad_max_install_names'
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)                  # override default value to get rid of '-rdynamic' on Linux

# Library
add_library(ulib ${LIBS})

# Execuatble
foreach (PATH ${SRCS})
    get_filename_component(NAME ${PATH} NAME_WE)
    add_executable(${NAME} ${PATH})
    target_link_libraries(${NAME} ulib gcc)
endforeach ()
