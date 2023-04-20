cmake_minimum_required(VERSION 3.10)

# default type is Release
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# we use some asm language functions
enable_language(C ASM)
# This flag is used regardless of Debug or Release type 
# set(CMAKE_C_FLAGS "-Wall -Wextra -Werror")
set(CMAKE_C_FLAGS "-ffunction-sections -fdata-sections")
# Debug flag includes -g option
set(CMAKE_C_FLAGS_DEBUG "-g -mavx512ifma -O0 -funroll-loops -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")
# Release flag
set(CMAKE_C_FLAGS_RELEASE "-mavx512ifma -O2 -funroll-loops -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")
# Same flag with C language
set(CMAKE_ASM_FLAGS ${CMAKE_C_FLAGS})
set(CMAKE_ASM_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_ASM_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE})

project(batch_avx512)

# FindOpenSSL.cmake is in ${CMAKE_CURRENT_LIST_DIR}/cmake/Modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")

# get detailed output when using make
set(CMAKE_VERBOSE_MAKEFILE ON)

# get source files from the file "CMakeLists.sources"
file(STRINGS "CMakeLists.sources" SOURCES)

set(EXEC_NAME benchmark)
# generate a executable file for testing
add_executable(${EXEC_NAME} ${SOURCES} "test.c")

# OpenSSL will be found by FindOpenSSL.cmake
find_package(OpenSSL REQUIRED)
message("OpenSSL root dir: ${OPENSSL_ROOT_DIR}")
message("OpenSSL version: ${OPENSSL_VERSION}")
message("OpenSSL include dir: ${OPENSSL_INCLUDE_DIR}")
message("OpenSSL libraries: ${OPENSSL_LIBRARIES}")
target_link_libraries(${EXEC_NAME} OpenSSL::Crypto)
target_include_directories(${EXEC_NAME} PRIVATE ${OPENSSL_INCLUDE_DIR} inc)
target_link_options(${EXEC_NAME} PUBLIC "LINKER:--gc-sections")

# get a json file including all compile commands
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

enable_testing()
add_test(NAME batch_avx512_correctness
    COMMAND ${EXEC_NAME} correctness)
set_tests_properties(batch_avx512_correctness PROPERTIES PASS_REGULAR_EXPRESSION
    "TEST : PASS including comparison with test vector in RFC7748!")