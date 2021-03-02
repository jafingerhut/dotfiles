#! /bin/bash

# Install the BPF Compiler Collection tools.

# Based on instructions published here, limited to a few long term
# supported versions of Ubuntu Linux.

# https://github.com/iovisor/bcc/blob/master/INSTALL.md#ubuntu---source


INSTALL_DIR="${PWD}"

THIS_SCRIPT_FILE_MAYBE_RELATIVE="$0"
THIS_SCRIPT_DIR_MAYBE_RELATIVE="${THIS_SCRIPT_FILE_MAYBE_RELATIVE%/*}"
THIS_SCRIPT_DIR_ABSOLUTE=`readlink -f "${THIS_SCRIPT_DIR_MAYBE_RELATIVE}"`

ubuntu_version_warning() {
    1>&2 echo "This software has only been tested on Ubuntu 16.04 and"
    1>&2 echo "18.04."
    1>&2 echo ""
    1>&2 echo "Proceed installing manually at your own risk of"
    1>&2 echo "significant time spent figuring out how to make it all"
    1>&2 echo "work, or consider getting VirtualBox and creating an"
    1>&2 echo "Ubuntu virtual machine with one of the tested versions."
}

lsb_release >& /dev/null
if [ $? != 0 ]
then
    1>&2 echo "No 'lsb_release' found in your command path."
    ubuntu_version_warning
    exit 1
fi

distributor_id=`lsb_release -si`
ubuntu_release=`lsb_release -s -r`
if [ "${distributor_id}" = "Ubuntu" -a \( "${ubuntu_release}" = "16.04" -o "${ubuntu_release}" = "18.04" \) ]
then
    echo "Found distributor '${distributor_id}' release '${ubuntu_release}'.  Continuing with installation."
else
    ubuntu_version_warning
    1>&2 echo ""
    1>&2 echo "Here is what command 'lsb_release -a' shows this OS to be:"
    lsb_release -a
    exit 1
fi

if [ "${distributor_id}" = "Ubuntu" -a "${ubuntu_release}" = "18.04" ]
then
    sudo apt-get --yes install bison build-essential cmake flex git libedit-dev libllvm6.0 llvm-6.0-dev libclang-6.0-dev python zlib1g-dev libelf-dev
else
    sudo apt-get --yes install bison build-essential cmake flex git libedit-dev libllvm3.7 llvm-3.7-dev libclang-3.7-dev python zlib1g-dev libelf-dev
fi

git clone https://github.com/iovisor/bcc.git
mkdir bcc/build
cd bcc/build
cmake ..
make
sudo make install
cmake -DPYTHON_CMD=python3 .. # build python3 binding
cd src/python/
make
sudo make install
