cmake_minimum_required(VERSION 3.10)

find_program(CCACHE_FOUND ccache)
if(CCACHE_FOUND)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
  set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
  message(STATUS "DEBUG:ccache:yes")
else()
  message(STATUS "DEBUG:ccache:no")
endif()

if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE Release)
endif()

option(PRINT_CC "Print the CPU cycles of cryptographic primitives" OFF)
if(PRINT_CC)
  add_definitions(-DPRINT_CC)
  message(STATUS "PRINT_CC:yes")
endif()

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# we use some asm language functions
enable_language(C ASM)
# This flag is used regardless of Debug or Release type 
set(CMAKE_C_FLAGS "-Wall -Wextra -Werror")
# Debug flag includes -g option
set(CMAKE_C_FLAGS_DEBUG "-g -mavx512ifma -O0 -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")
# Release flag
set(CMAKE_C_FLAGS_RELEASE "-mavx512ifma -O2 -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")

# for ASM, we use same FLAGS with C
set(CMAKE_ASM_FLAGS ${CMAKE_C_FLAGS})
set(CMAKE_ASM_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_ASM_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE})

set(ENGINE_NAME eng25519)
file(STRINGS "VERSION" version_in)
file(STRINGS "DESCRIPTION" description_in)
project(${ENGINE_NAME} VERSION ${version_in} DESCRIPTION ${description_in})

# set(provider "batch_fast_lib" CACHE STRING "Select backend provider. (Options are the names of folders in providers/)")

string(TIMESTAMP BUILD_TIMESTAMP "%Y-%m-%dT%H:%M:%SZ" UTC)
configure_file(eng25519.version.h.in eng25519.version.h)

# read all source files from CMakeLists.sources
file(STRINGS "CMakeLists.sources" SOURCES)
add_library(${ENGINE_NAME} SHARED ${SOURCES} eng25519.version.h)
target_include_directories(${ENGINE_NAME} PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(${ENGINE_NAME} PRIVATE ${CMAKE_BINARY_DIR})

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# FindOpenSSL.cmake is in ${CMAKE_CURRENT_LIST_DIR}/cmake/Modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/Modules")
list(APPEND CMAKE_MODULE_PATH "~/.cmake/Modules")
message("DEBUG:CMAKE_MODULE_PATH=${CMAKE_MODULE_PATH}")

# get detailed output when using make
set(CMAKE_VERBOSE_MAKEFILE ON)

# OpenSSL will be found by FindOpenSSL.cmake
find_package(OpenSSL REQUIRED)
message("OpenSSL root dir: ${OPENSSL_ROOT_DIR}")
message("OpenSSL version: ${OPENSSL_VERSION}")
message("OpenSSL include dir: ${OPENSSL_INCLUDE_DIR}")
message("OpenSSL libraries: ${OPENSSL_LIBRARIES}")
target_link_libraries(${ENGINE_NAME} OpenSSL::Crypto)

set_target_properties(${ENGINE_NAME} PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

get_filename_component(OPENSSL_CRYPTO_LIB_PATH ${OPENSSL_CRYPTO_LIBRARY} DIRECTORY)

if(${OPENSSL_VERSION} VERSION_LESS 1.1.0)
    target_compile_definitions(${ENGINE_NAME} PRIVATE OPENSSL_V102_COMPAT)

    set_target_properties(${ENGINE_NAME} PROPERTIES PREFIX "lib")
    install(TARGETS ${ENGINE_NAME} DESTINATION ${OPENSSL_CRYPTO_LIB_PATH}/engines)
else()
    set_target_properties(${ENGINE_NAME} PROPERTIES PREFIX "")
    install(TARGETS ${ENGINE_NAME} DESTINATION ${OPENSSL_CRYPTO_LIB_PATH}/engines-1.1)
endif(${OPENSSL_VERSION} VERSION_LESS 1.1.0)

# Throw an error in case of undefined symbols during linking
target_link_libraries(${ENGINE_NAME} "-Wl,-z,defs")

if(NOT CMAKE_BUILD_TYPE STREQUAL "Release")
    add_definitions(-D_DEBUG)
endif()

add_subdirectory("providers/${provider}")
target_link_libraries(${ENGINE_NAME} ${provider})

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

set(test_app_SRC "test/apps.c" "test/ossl_compat.c")

add_executable(timer_warmup "util/timer_warmup.c")
install(TARGETS timer_warmup)

add_executable(heuristic_warmup "util/heuristic_warmup.c")
install(TARGETS heuristic_warmup)

add_executable(evp_test "test/evp_test.c" "test/ossl_compat.c" "ossl/ossl_compat.c")
set_target_properties(evp_test PROPERTIES COMPILE_DEFINITIONS "CUSTOM_OPENSSL_INIT;OPENSSL_NO_POLY1305;OPENSSL_NO_SIPHASH")
target_link_libraries(evp_test ${OPENSSL_LIBRARIES})
if(${OPENSSL_VERSION} VERSION_LESS 1.1.0)
    target_compile_definitions(evp_test PRIVATE OPENSSL_V102_COMPAT)
endif(${OPENSSL_VERSION} VERSION_LESS 1.1.0)
set_target_properties(evp_test PROPERTIES COMPILE_FLAGS "-Werror=implicit-function-declaration")
target_include_directories(evp_test PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(evp_test PRIVATE ${CMAKE_BINARY_DIR})
target_include_directories(evp_test PRIVATE ${OPENSSL_INCLUDE_DIR})

add_executable(evp_pkey_x25519 "test/evp_pkey_x25519.c" "test/ossl_compat.c" "ossl/ossl_compat.c" "test/apps.c")
set_target_properties(evp_pkey_x25519 PROPERTIES COMPILE_DEFINITIONS "CUSTOM_OPENSSL_INIT;OPENSSL_NO_POLY1305;OPENSSL_NO_SIPHASH")
target_link_libraries(evp_pkey_x25519 ${OPENSSL_LIBRARIES})
if(${OPENSSL_VERSION} VERSION_LESS 1.1.0)
    target_compile_definitions(evp_pkey_x25519 PRIVATE OPENSSL_V102_COMPAT)
endif(${OPENSSL_VERSION} VERSION_LESS 1.1.0)
set_target_properties(evp_pkey_x25519 PROPERTIES COMPILE_FLAGS "-Werror=implicit-function-declaration")
target_include_directories(evp_pkey_x25519 PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(evp_pkey_x25519 PRIVATE ${CMAKE_BINARY_DIR})
target_include_directories(evp_pkey_x25519 PRIVATE ${OPENSSL_INCLUDE_DIR})

enable_testing()

add_test(NAME rfc7748_x25519_evp_tests
  COMMAND evp_test ${CMAKE_SOURCE_DIR}/test/rfc7748.txt)
set_tests_properties(rfc7748_x25519_evp_tests PROPERTIES ENVIRONMENT
  "OPENSSL_CONF=/root/eng25519/test/eng25519.cnf")
set_property(TEST rfc7748_x25519_evp_tests APPEND PROPERTY ENVIRONMENT
  "OPENSSL_ENGINES=${CMAKE_BINARY_DIR}")
set_tests_properties(rfc7748_x25519_evp_tests PROPERTIES PASS_REGULAR_EXPRESSION
  " 0 errors, 0 skipped")

add_test(NAME gnupg_evp_tests
  COMMAND evp_test ${CMAKE_SOURCE_DIR}/test/gnugpg_t-ed25519.txt)
set_tests_properties(gnupg_evp_tests PROPERTIES ENVIRONMENT
  "OPENSSL_CONF=/root/eng25519/test/eng25519.cnf")
set_property(TEST gnupg_evp_tests APPEND PROPERTY ENVIRONMENT
  "OPENSSL_ENGINES=${CMAKE_BINARY_DIR}")
set_tests_properties(gnupg_evp_tests PROPERTIES PASS_REGULAR_EXPRESSION
  " 0 errors, 0 skipped")