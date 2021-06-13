# 4c-project-structure

[![MIT license](https://img.shields.io/badge/License-MIT-blue.svg)](https://lbesson.mit-license.org/)
[![Continuous Integration](https://github.com/hyahiaoui/4c-project-structure/actions/workflows/ci.yml/badge.svg)](https://github.com/hyahiaoui/4c-project-structure/actions/workflows/ci.yml)

## Summary

 * [Description](#description)
 * [Usage Without Docker](#usage-without-docker)
 * [Usage With Docker](#usage-with-docker)

*****

## Description

Example of a C++ project structure with the 4 Cs: [Clang](https://clang.llvm.org), [Cmake](https://cmake.org), [Conan](https://conan.io), and [Catch2](https://github.com/catchorg/Catch2).

*****

## Usage Without Docker

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

Use the Makefile `build`  target to build the application and its tests on the host:

```bash
$ make build
./scripts/entrypoint.sh build
Configuration:
[settings]
arch=x86_64
arch_build=x86_64
build_type=Release
compiler=apple-clang
compiler.libcxx=libc++
compiler.version=12.0
os=Macos
os_build=Macos
[options]
[build_requires]
[env]

conanfile.txt: Installing package

...

[ 28%] Built target 4c-project-structure_lib
[ 57%] Building CXX object app/CMakeFiles/4c-project-structure_run.dir/main.cpp.o
[ 57%] Building CXX object test/CMakeFiles/4c-project-structure_test.dir/TestDummy.cpp.o
[ 71%] Building CXX object test/CMakeFiles/4c-project-structure_test.dir/main.cpp.o
[ 85%] Linking CXX executable bin/4c-project-structure_run
[ 85%] Built target 4c-project-structure_run
[100%] Linking CXX executable bin/4c-project-structure_test
[100%] Built target 4c-project-structure_test
+ exit 0
```

This target will:
 * Create and enter the building directory `build`
 * Install the project's requirements, using `conan`
 * Generate the building tools using `cmake`
 * Compile the application and the tests, using `make`

The resulting artifacts are to be found in the `build` folder:

 * the application's executable `build/app/bin/4c-project-structure_run` 
 * the tests executable `build/test/bin/4c-project-structure_test`

### Tests

Run the tests using 

```bash
$ ./scripts/entrypoint.sh test
[ 28%] Built target 4c-project-structure_lib
[ 57%] Built target 4c-project-structure_run
[100%] Built target 4c-project-structure_test
===============================================================================
All tests passed (1 assertion in 1 test case)
```

Or, using

```bash
$ ./build/test/bin/4c-project-structure_test
===============================================================================
All tests passed (1 assertion in 1 test case)
```

### Clean

Remove the buiding artifacts using

```bash
$ make clean

```

Or, using

```bash
$ ./scripts/entrypoint.sh clean
```

### Code formatting

One can format the C++ code using `clang-format` tool, by invoking

```bash
$ make format
```

Or, using

```bash
$ ./scripts/entrypoint.sh format
```

*****

## Usage With Docker

### Requirements

This project only requires Docker. All the operations are performed within a Docker container.

First, create the Docker image that will be used to run the following operations:

```bash
$ make dckr-image
 make dckr-image
docker-compose build --pull 4c-project
Building 4c-project
...
 => => writing image sha256:c31d379e2c6e8b1c27a485b1e209f2365075d497e804d7cd65164f8310c9c07a       0.0s
 => => naming to docker.io/library/4c-project-structure_4c-project                                 0.0s
```

### Compiling

Use the Makefile `dckr-build`  target to build the application and its tests within a Docker container:

```bash
$ make dckr-build 
docker-compose run --rm 4c-project build
Creating 4c-project-structure_4c-project_run ... done

...
```

The resulting artifacts are to be found in the `build` folder:

 * the application's executable `build/app/bin/4c-project-structure_run` 
 * the tests executable `build/test/bin/4c-project-structure_test`

> On MacOS, these artifacts will not run in the host, as they were compiled within Docker container, thus they are buit for Linux.

### Tests

Run the tests using 

```bash
$ make dckr-test
[ 28%] Built target 4c-project-structure_lib
[ 57%] Built target 4c-project-structure_run
[100%] Built target 4c-project-structure_test
===============================================================================
All tests passed (1 assertion in 1 test case)
```

### Clean

Remove the buiding artifacts using

```bash
$ make dckr-clean
docker-compose run --rm 4c-project clean
Creating 4c-project-structure_4c-project_run ... done
```

### Code formatting

One can format the C++ code using `clang-format` tool, by invoking

```bash
$ make dckr-format
```
