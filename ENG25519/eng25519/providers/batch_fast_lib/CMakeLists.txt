project("batch_fast_provider")

file(STRINGS "CMakeLists.sources" PROVIDER_SOURCES)

# set(provider "batch_fast_lib")

add_library(${provider} STATIC ${PROVIDER_SOURCES})
set_target_properties(${provider} PROPERTIES PREFIX "")

target_include_directories(${provider} PRIVATE ${PROJECT_BINARY_DIR})
target_include_directories(${provider} PRIVATE ${CMAKE_SOURCE_DIR})
target_include_directories(${provider} PRIVATE "fast_avx512f/thirdparty/pmp-inv-master/include")

target_link_libraries(${provider} PUBLIC OpenSSL::Crypto)
