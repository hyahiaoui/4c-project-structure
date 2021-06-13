#!/bin/bash

########################################
# Exit as soon as any line in the bash script fails.
set -e

# Treat unset variables as an error and exit immediately.
set -u

########################################
RED='\033[0;31m'
GREEN='\033[0;32m'
NOCOLOR='\033[0m'

PROGRAM=$(basename "$0")
PROGRAM_DIR=$(dirname "$0")
BASE_DIR=$(dirname "$PROGRAM_DIR")
BUILD_DIR="${BASE_DIR}/build"
SOURCE_DIRS="app lib test"

# The following can be LLVM, GNU, Google, Chromium, Microsoft, Mozilla or WebKit.
FORMAT_STYLE="WebKit"

########################################
function info
{
    local timestamp=$(date -u +"%Y-%m-%d %H:%M:%S")
    echo -e "${GREEN}${timestamp} INFO ${PROGRAM}${NOCOLOR} •" $*
}

function error
{
    local timestamp=$(date -u +"%Y-%m-%d %H:%M:%S")
    echo -e "${RED}${timestamp} ERROR ${PROGRAM}${NOCOLOR} •" $* >&2
}

function app-shell
{
    exec /bin/bash
}

function app-build
{
    (
        mkdir -p "${BUILD_DIR}"
        cd "${BUILD_DIR}"

        conan install .. --build=missing
        cmake ..
        make -j
    )
}

function app-clean
{
    rm -rf "${BUILD_DIR}"
}

function app-test
{
    (
        cd "${BUILD_DIR}"

        make -j

        ./test/bin/4c-project-structure_test
    )
}

function app-format
{
    local cc_files=$(find $SOURCE_DIRS -name '*.cc' 2>/dev/null)
    local cpp_files=$(find $SOURCE_DIRS -name '*.cpp' 2>/dev/null)
    local h_files=$(find $SOURCE_DIRS -name '*.h' 2>/dev/null)
    local hpp_files=$(find $SOURCE_DIRS -name '*.hpp' 2>/dev/null)

    if [ -z "${cc_files}${cpp_files}${h_files}${hpp_files}" ]; then
        error "Unable to locate files to format in folders $SOURCE_DIRS. Aborting."
        exit 1
    fi

    clang-format -i \
        --style="$FORMAT_STYLE" \
        ${cc_files} \
        ${cpp_files} \
        ${h_files} \
        ${hpp_files}
}
########################################
while (( $# ))
do
    case "$1" in
        build   | \
        clean   | \
        format  | \
        shell   | \
        test    )
            command=$1
            shift
            app-$command "$@"
            exit 0
        ;;

        *)
            echo "Unknown command '$1'"
            exit 1
        ;;

    esac
done

echo "Missing command"
exit 1
