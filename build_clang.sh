#!/bin/bash

baseDir="$( realpath -e -- "$( dirname -- "${BASH_SOURCE[0]}"; )"; )"
version="17.0.6"

baseDir="$( realpath -e -- "$( dirname -- "${BASH_SOURCE[0]}";  )"; )"
downloadUrl="https://github.com/llvm/llvm-project/archive/refs/tags/llvmorg-18.1.1.tar.gz"
archiveFileName="llvmorg-18.1.1.tar.gz"
distrDirName="llvm-project-llvmorg-18.1.1"

prefix="$1"
if [ -z "${prefix}" ]; then
    echo "prefix not set"
    exit 1
fi

echo "---------------------------------------------------------------"
echo "baseDir: ${baseDir}"
echo "prefix: ${prefix}"
echo "downloadUrl: ${downloadUrl}"
echo "archiveFileName: ${archiveFileName}"
echo "distrDirName: ${distrDirName}"
echo "---------------------------------------------------------------"

set -e -x

pushd .

if [ ! -d "${distrDirName}" ]; then
    if [ ! -f "${archiveFileName}" ]; then
        curl -L -O "${downloadUrl}"
    fi
    tar xpf "${archiveFileName}"
fi
cd "${distrDirName}"

mkdir -p build
cd build

cmake -DCMAKE_BUILD_TYPE=Release -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra" -DCMAKE_INSTALL_PREFIX="${prefix}" ../llvm

# build and install
make -j`nproc`
make install

popd
