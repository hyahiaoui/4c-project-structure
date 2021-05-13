cmake_minimum_required(VERSION 3.20)
project(4c-project-structure)

include(build/conanbuildinfo.cmake)

conan_basic_setup()

add_compile_options(-std=c++11)
add_executable(app main.cpp)
target_link_libraries(app ${CONAN_LIBS})
link_libraries("-static")
