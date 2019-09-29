cmake_minimum_required(VERSION 3.0)

project(rcore_user_app)
set(CMAKE_OSX_DEPLOYMENT_TARGET "")

# Path
aux_source_directory(src SRCS)
include_directories(src/include)
set(EXECUTABLE_OUTPUT_PATH ${ARCH})

# Toolchain
set(PREFIX ${ARCH}-linux-musl-)

if (${ARCH} STREQUAL x86_64)
    set(CMAKE_C_FLAGS       "-m64")
elseif (${ARCH} STREQUAL riscv32)
    set(CMAKE_C_FLAGS       "-march=rv32gc -mcmodel=medany -static")
elseif (${ARCH} STREQUAL riscv64)
    set(CMAKE_C_FLAGS       "-march=rv64gc -mcmodel=medany -static")
elseif (${ARCH} STREQUAL aarch64)
elseif (${ARCH} STREQUAL mipsel)
    set(PREFIX              mipsel-linux-musln32-)
    set(CMAKE_C_FLAGS       "-static")
else()
    message("Unsupported arch: ${ARCH}")
endif ()
set(CMAKE_ASM_COMPILER      ${PREFIX}gcc)
set(CMAKE_C_COMPILER        ${PREFIX}gcc)
set(CMAKE_RANLIB            ${PREFIX}ranlib)
set(CMAKE_C_FLAGS           "${CMAKE_C_FLAGS} -ggdb -Wall")
set(CMAKE_ASM_FLAGS         ${CMAKE_C_FLAGS})
set(CMAKE_C_LINK_FLAGS      "${LINK_FLAGS}")
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)

# Execuatble
foreach (PATH ${SRCS})
    get_filename_component(NAME ${PATH} NAME_WE)
    add_executable(${NAME} ${PATH})
endforeach ()
