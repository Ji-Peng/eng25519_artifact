cmake_minimum_required(VERSION 3.10)

# default type is Release
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug)
endif()

message(STATUS "CMAKE_BUILD_TYPE: ${CMAKE_BUILD_TYPE}")

# we use some asm language functions
enable_language(C ASM)
# This flag is used regardless of Debug or Release type 
# set(CMAKE_C_FLAGS "-Wall -Wextra -Werror")
# Debug flag includes -g option
set(CMAKE_C_FLAGS_DEBUG "-g -mavx512f -O0 -funroll-loops -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")
# Release flag
set(CMAKE_C_FLAGS_RELEASE "-mavx512f -O2 -funroll-loops -m64 -march=native -mtune=native -fomit-frame-pointer -fwrapv")

# for ASM, we use same FLAGS with C
set(CMAKE_ASM_FLAGS ${CMAKE_C_FLAGS})
set(CMAKE_ASM_FLAGS_DEBUG ${CMAKE_C_FLAGS_DEBUG})
set(CMAKE_ASM_FLAGS_RELEASE ${CMAKE_C_FLAGS_RELEASE})

project(hisil_avx512)

# get source files from the file "CMakeLists.sources"
file(STRINGS "CMakeLists.sources" SOURCES)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(EXEC_NAME hisil_avx512_test)
# generate a executable file for testing
add_executable(${EXEC_NAME} ${SOURCES} "main.c")
# include directory
target_include_directories(${EXEC_NAME} PRIVATE "thirdparty/pmp-inv-master/include")
target_include_directories(${EXEC_NAME} PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(${EXEC_NAME} PRIVATE ${CMAKE_BINARY_DIR})

set(CMAKE_VERBOSE_MAKEFILE ON)

set_target_properties(${EXEC_NAME} PROPERTIES INSTALL_RPATH_USE_LINK_PATH TRUE)

# Note that "-no-pie" is necessary for this project
target_link_libraries(${EXEC_NAME} "-Wl,-z,defs")

# get a json file including all compile commands
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)