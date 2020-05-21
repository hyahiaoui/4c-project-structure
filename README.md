# 4c-project-structure

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)

## Summary

 * [Description](#description)
 * [Usage](#usage)
    * [Requirements](#requirements)
    * [Compiling](#compiling)

*****

## Description

Example of a C++ starting project structure with the 4 Cs: [Clang](https://clang.llvm.org), [Cmake](https://cmake.org), [Conan](https://conan.io), and [Catch2](https://github.com/catchorg/Catch2).

*****

## Usage

### Requirements

This project requires:

 * The [Clang](https://clang.llvm.org) C++ compiler,
 * The [Cmake](https://cmake.org) tools family,
 * The [Conan](https://conan.io) packages manager.
 * The tools and libraries described in the `conanfile.txt` file.

On macOS, `clang` is the default build system. Install the other requirements (using the [brew](https://brew.sh) packages manager), by issuing the following command:

```
$ brew install cmake conan
```

On linux (Ubuntu and debian-flavor distribution), issue the following commands (this requires the installation of the [pip](https://pip.pypa.io/en/stable/) packages manages):

```
$ apt-get update
$ apt-get install -y cmake clang
$ pip install conan
```

### Compiling

Create and enter the building directory:

> **warning** if you want to modify the building directory name, make sure to update the `include(build/conanbuildinfo.cmake)` line in the `CMakeLists.txt` file.

```
$ mkdir build && cd build
```

Define the compiler to be used:

```
$ export CC=clang
$ export CXX=clang++
```

Install the project's requirements, by issuing the command (in the `build` directory):

```
$ conan install .. --build=missing
```

Generate build files (`Makefile`, ...):

```
$ cmake ..
```

Compile the project:

```
$ make
```

Execute the produced artifact:

```
$ ./bin/app
```

Enjoy! :-)
