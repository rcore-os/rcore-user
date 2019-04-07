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
  PATHS /usr/lib/modules/${KERNEL_RELEASE}/build /usr/src/linux-headers-${KERNEL_RELEASE}
)

# Toolchain

set(PREFIX ${ARCH}-linux-musl-)

if (${ARCH} STREQUAL x86_64)
    set(CMAKE_C_FLAGS       "-m64 -mno-red-zone")
elseif (${ARCH} STREQUAL riscv32)
    set(CMAKE_C_FLAGS       "-march=rv32imafdc -mabi=ilp32d -mcmodel=medany")
elseif (${ARCH} STREQUAL riscv64)
    set(CMAKE_C_FLAGS       "-march=rv64imafdc -mabi=lp64d -mcmodel=medany")
elseif (${ARCH} STREQUAL aarch64)
elseif (${ARCH} STREQUAL mipsel)
    set(PREFIX ${ARCH}-linux-musln32-)
else ()
    message("Unsupported arch: ${ARCH}")
endif ()
set(CMAKE_ASM_COMPILER      ${PREFIX}gcc)
set(CMAKE_C_COMPILER        ${PREFIX}gcc)
set(CMAKE_RANLIB            ${PREFIX}ranlib)
set(CMAKE_C_FLAGS           "${CMAKE_C_FLAGS} -Wall -Wno-pointer-to-int-cast -Wno-format -MMD -MP -O -g -fPIC -static -std=gnu99")
set(CMAKE_ASM_FLAGS         ${CMAKE_C_FLAGS})
if (${ARCH} STREQUAL riscv64)
set(CMAKE_C_LINK_FLAGS      "${LINK_FLAGS}")  # override default value to get rid of '-Wl,-search_paths_first -Wl,-headerpad_max_install_names'
else ()
set(CMAKE_C_LINK_FLAGS      "${LINK_FLAGS} -pthread")  # override default value to get rid of '-Wl,-search_paths_first -Wl,-headerpad_max_install_names'
endif ()
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS)                  # override default value to get rid of '-rdynamic' on Linux

if (KERNEL_HEADERS_DIR)
	include_directories(${KERNEL_HEADERS_DIR}/include/uapi)
endif ()

# Executable
foreach (PATH ${SRCS})
	if (NOT ${ARCH} STREQUAL riscv64 OR NOT "${PATH}" MATCHES "^c/(usertests).c$")
		get_filename_component(NAME ${PATH} NAME_WE)
		add_executable(${NAME} ${PATH})
	endif ()
endforeach ()
