project("openssl_provider")

file(STRINGS "CMakeLists.sources" PROVIDER_SOURCES)

add_library(${provider} STATIC ${PROVIDER_SOURCES})
set_target_properties(${provider} PROPERTIES PREFIX "")

target_include_directories(${provider} PRIVATE ${PROJECT_BINARY_DIR})
target_include_directories(${provider} PRIVATE ${CMAKE_SOURCE_DIR})

target_link_libraries(${provider} PUBLIC OpenSSL::Crypto)
