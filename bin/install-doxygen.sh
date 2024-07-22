#! /bin/bash

# I tried the steps in this script, but the precompiled binaries it
# installed did not work on an x86_64 Ubuntu 20.04 system:
#
# https://github.com/p4lang/p4c/blob/main/.github/workflows/deploy-docs.yml#L32-L37
#
# so I switched to working on a script that built doxygen from source
# code instead.

set -x
git clone https://github.com/doxygen/doxygen
cd doxygen
git checkout Release_1_11_0
mkdir build
cd build
cmake -G "Unix Makefiles" ..
make
sudo make install
