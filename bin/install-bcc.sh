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
    1>&2 echo "This software has only been tested on:"
    1>&2 echo ""
    1>&2 echo "    Ubuntu 16.04"
    1>&2 echo "    Ubuntu 18.04"
    1>&2 echo "    Ubuntu 20.04"
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
    sudo apt-get --yes install bison build-essential cmake flex git libedit-dev libllvm6.0 llvm-6.0-dev libclang-6.0-dev python zlib1g-dev libelf-dev
    # This was not in the instructions, but when I tried running this
    # script on a minimal installation of Ubuntu 18.04 system, it
    # failed when running a Python3 script at the line:
    #     from distutils.core import setup
    sudo apt-get --yes install python3-distutils
elif [ "${distributor_id}" = "Ubuntu" -a "${ubuntu_release}" = "20.04" ]
then
    sudo apt install -y bison build-essential cmake flex git libedit-dev libllvm7 llvm-7-dev libclang-7-dev python zlib1g-dev libelf-dev libfl-dev
    # This was not in the instructions, but when I tried running this
    # script on a minimal installation of Ubuntu 20.04 system, it
    # failed when running a Python3 script at the line:
    #     from distutils.core import setup
    sudo apt-get --yes install python3-distutils
else
    ubuntu_version_warning
    1>&2 echo ""
    1>&2 echo "Here is what command 'lsb_release -a' shows this OS to be:"
    lsb_release -a
    exit 1
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
