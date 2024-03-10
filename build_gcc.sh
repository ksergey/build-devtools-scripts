#!/bin/bash

baseDir="$( realpath -e -- "$( dirname -- "${BASH_SOURCE[0]}"; )"; )"
downloadUrl="http://mirror.linux-ia64.org/gnu/gcc/releases/gcc-13.2.0/gcc-13.2.0.tar.xz"
archiveFileName="gcc-13.2.0.tar.xz"
distrDirName="gcc-13.2.0"

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

./contrib/download_prerequisites

./configure --prefix="${prefix}" \
    --disable-multilib \
    --enable-languages=c,c++

# build and install
make -j`nproc`
make install-strip

popd
