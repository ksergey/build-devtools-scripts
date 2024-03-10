#!/bin/bash

baseDir="$( realpath -e -- "$( dirname -- "${BASH_SOURCE[0]}";  )"; )"
downloadUrl="https://github.com/Kitware/CMake/archive/refs/tags/v3.28.3.tar.gz"
archiveFileName="v3.28.3.tar.gz"
distrDirName="CMake-3.28.3"

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

./configure --prefix="${prefix}"

# build and install
make -j`nproc`
make install

popd
