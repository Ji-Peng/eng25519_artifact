project("dummy_provider")

set(providers_sources "base.c" "curve25519.c")

add_library(${provider} STATIC ${providers_sources})
set_property(TARGET ${provider} PROPERTY POSITION_INDEPENDENT_CODE ON)
set_target_properties(${provider} PROPERTIES PREFIX "")

target_include_directories(${provider} PRIVATE ${PROJECT_BINARY_DIR})
target_include_directories(${provider} PRIVATE ${CMAKE_SOURCE_DIR})
# target_include_directories(${provider} PRIVATE "/root/eng25519/")