cmake_minimum_required(VERSION 3.0)

project(ucore_user)

# Path
set(ARCH_DIR src/arch/${ARCH})
aux_source_directory(src SRCS)
aux_source_directory(${ARCH_DIR}/libs LIBS)
aux_source_directory(${ARCH_DIR}/ulibs LIBS)
include_directories(${ARCH_DIR}/libs ${ARCH_DIR}/ulibs)
set(EXECUTABLE_OUTPUT_PATH ${ARCH})

# Toolchain
if (${ARCH} STREQUAL i386)
    if(APPLE)
        set(PREFIX          i386-elf-)
    endif ()
    set(CMAKE_C_FLAGS       "-fno-builtin -Wall -ggdb -nostdinc -m32")
elseif (${ARCH} STREQUAL x86_64)
    if(APPLE)
        set(PREFIX          x86_64-elf-)
    endif ()
    set(CMAKE_C_FLAGS       "-fno-builtin -Wall -ggdb -nostdinc -m64")
elseif (${ARCH} STREQUAL riscv32)
    set(PREFIX              riscv64-unknown-elf-)
    set(CMAKE_C_FLAGS       "-march=rv32imac -mabi=ilp32 -mcmodel=medany -std=gnu99 -fno-builtin -Wall -nostdinc -fno-stack-protector -ffunction-sections -fdata-sections")
elseif (${ARCH} STREQUAL riscv64)
    set(PREFIX              riscv64-unknown-elf-)
    set(CMAKE_C_FLAGS       "-march=rv64imac -mabi=lp64 -mcmodel=medany -std=gnu99 -fno-builtin -Wall -nostdinc -fno-stack-protector -ffunction-sections -fdata-sections")
elseif (${ARCH} STREQUAL aarch64)
    set(PREFIX              aarch64-none-elf-)
else()
    message("Unsupported arch: ${ARCH}")
endif ()
set(CMAKE_C_COMPILER        ${PREFIX}gcc)
set(CMAKE_RANLIB            ${PREFIX}ranlib)
set(CMAKE_EXE_LINKER_FLAGS  "-nostdlib")

# Library
add_library(ulib ${LIBS})

# Execuatble
foreach (PATH ${SRCS})
    get_filename_component(NAME ${PATH} NAME_WE)
    add_executable(${NAME} ${PATH})
    target_link_libraries(${NAME} ulib)
endforeach ()
