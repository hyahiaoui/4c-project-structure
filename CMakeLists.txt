cmake_minimum_required(VERSION 3.18)

project(4c-project-structure)

include(build/conanbuildinfo.cmake)

conan_basic_setup()

set(CMAKE_CXX_STANDARD 17)

include_directories(lib)

add_subdirectory(lib)
add_subdirectory(app)
add_subdirectory(test)

link_libraries("-static")
