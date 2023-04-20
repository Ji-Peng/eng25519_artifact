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

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

enable_language(C)
# This flag is used regardless of Debug or Release type 
set(CMAKE_C_FLAGS "-Wall -Wextra -Werror")
# Debug flag includes -g option
set(CMAKE_C_FLAGS_DEBUG "-g -O0 -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")
# Release flag
set(CMAKE_C_FLAGS_RELEASE "-O2 -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")

project(dot_timer)

add_executable(tls_timer tls_timer.c)
add_executable(dot_timer DoT_timer.c)
target_include_directories(tls_timer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(tls_timer PRIVATE ${CMAKE_BINARY_DIR})
target_include_directories(dot_timer PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(dot_timer PRIVATE ${CMAKE_BINARY_DIR})

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
# target_link_libraries(tls_timer OpenSSL::Crypto)
target_link_libraries(tls_timer OpenSSL::SSL)
target_link_libraries(dot_timer OpenSSL::SSL)
target_include_directories(tls_timer PRIVATE ${OPENSSL_INCLUDE_DIR})
target_include_directories(dot_timer PRIVATE ${OPENSSL_INCLUDE_DIR})

set_target_properties(tls_timer PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)
set_target_properties(dot_timer PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

# Throw an error in case of undefined symbols during linking
target_link_libraries(tls_timer "-Wl,-z,defs")
target_link_libraries(dot_timer "-Wl,-z,defs")

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

install(TARGETS tls_timer dot_timer)