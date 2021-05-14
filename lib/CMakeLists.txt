cmake_minimum_required(VERSION 3.18)

include(../build/conanbuildinfo.cmake)

conan_basic_setup()

set(BINARY ${CMAKE_PROJECT_NAME}_lib)

file(GLOB_RECURSE LIB_SOURCES LIST_DIRECTORIES true *.h *.cpp)

set(SOURCES ${LIB_SOURCES})

add_library(${BINARY} STATIC ${LIB_SOURCES})
