#!/bin/bash

set -e -x

destDir="$1"
if [ -z "${destDir}" ]; then
    destDir="${HOME}/env-dev"
fi

baseDir="$( realpath -e -- "$( dirname -- "${BASH_SOURCE[0]}"; )"; )"

pushd .

# create directory
mkdir -p "${destDir}"

# build gcc
${baseDir}/build_gcc.sh "${destDir}"

if [ ! -f "${destDir}/activate" ]; then
    cp "${baseDir}/activate" "${destDir}/activate"
fi

# update toolchain
source ${destDir}/activate

# build cmake
${baseDir}/build_cmake.sh "${destDir}"

# build clang
${baseDir}/build_clang.sh "${destDir}"

popd
