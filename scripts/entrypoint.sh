#!/bin/bash

########################################
# Exit as soon as any line in the bash script fails.
set -e

# Treat unset variables as an error and exit immediately.
set -u

SCRIPT=$(basename "$0")
BASE_DIR="/usr/src/app"
BUILD_DIR="${BASE_DIR}/build"

########################################
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
        make
    )
}
########################################
while (( $# ))
do
    case "$1" in
        shell | \
        build )
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
