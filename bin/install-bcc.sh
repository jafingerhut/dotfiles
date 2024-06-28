#! /bin/bash

# Install BCC, the BPF Compiler Collection tools.

# Based on instructions published here, limited to a few long term
# supported versions of Ubuntu Linux.

# https://github.com/iovisor/bcc/blob/master/INSTALL.md#ubuntu---source


INSTALL_DIR="${PWD}"

THIS_SCRIPT_FILE_MAYBE_RELATIVE="$0"
THIS_SCRIPT_DIR_MAYBE_RELATIVE="${THIS_SCRIPT_FILE_MAYBE_RELATIVE%/*}"
THIS_SCRIPT_DIR_ABSOLUTE=`readlink -f "${THIS_SCRIPT_DIR_MAYBE_RELATIVE}"`

ubuntu_version_warning() {
    1>&2 echo "Found ID ${ID} and VERSION_ID ${VERSION_ID} in /etc/os-release"
    1>&2 echo ""
    1>&2 echo "This software has only been tested on:"
    1>&2 echo ""
    1>&2 echo "    Ubuntu 20.04, 22.04"
    1>&2 echo ""
    1>&2 echo "See the following link to see if it has any advice"
    1>&2 echo "for other operating systems:"
    1>&2 echo ""
    1>&2 echo "https://github.com/iovisor/bcc/blob/master/INSTALL.md"
}

if [ ! -r /etc/os-release ]
then
    1>&2 echo "No file /etc/os-release.  Cannot determine what OS this is."
    ubuntu_version_warning
    exit 1
fi
source /etc/os-release

supported_distribution=0
if [ "${ID}" = "ubuntu" ]
then
    case "${VERSION_ID}" in
	20.04)
	    supported_distribution=1
	    # TODO: Try changing python to python3 in this list to see
	    # if that works a bit better.
	    # Using python, I know that `execsnoop -h` cannot find
	    # the Python bcc package, because it is running Python2.
	    set -x
	    sudo apt install -y zip bison build-essential cmake flex git \
		 libedit-dev libllvm12 llvm-12-dev libclang-12-dev python3 \
		 zlib1g-dev libelf-dev libfl-dev python3-setuptools \
		 liblzma-dev arping netperf iperf
	    set +x
	    ;;
	22.04)
	    supported_distribution=1
	    set -x
	    sudo apt install -y zip bison build-essential cmake flex git \
		 libedit-dev libllvm14 llvm-14-dev libclang-14-dev python3 \
		 zlib1g-dev libelf-dev libfl-dev python3-setuptools \
		 liblzma-dev libdebuginfod-dev arping netperf iperf
	    set +x
	    ;;
	24.04)
	    supported_distribution=1
	    set -x
	    sudo apt install -y zip bison build-essential cmake flex git \
		 libedit-dev libllvm18 llvm-18-dev libclang-18-dev python3 \
		 zlib1g-dev libelf-dev libfl-dev python3-setuptools \
		 liblzma-dev libdebuginfod-dev arping netperf iperf
	    set +x
	    ;;
    esac
fi

if [ ${supported_distribution} -eq 1 ]
then
    echo "Found supported ID ${ID} and VERSION_ID ${VERSION_ID} in /etc/os-release"
else
    ubuntu_version_warning
    exit 1
fi

set -x
git clone https://github.com/iovisor/bcc.git
cd bcc
git log -n 1 | head -n 4
mkdir build
cd build
cmake ..
make
sudo make install
cmake -DPYTHON_CMD=python3 ..
cd src/python/
make
sudo make install

# Replace occurrencs of '/usr/bin/env python'
# with '/usr/bin/env python3'
find /usr/share/bcc/tools \! -type d -a \! -type l | xargs sudo sed -i 's-/usr/bin/env python$-/usr/bin/env python3-'

set +x
1>&2 echo ""
1>&2 echo "------------------------------------------------------------"
1>&2 echo "We recommend that you add this directory to your command path:"
1>&2 echo ""
1>&2 echo "    /usr/share/bcc/tools"
1>&2 echo ""
1>&2 echo "e.g. with a command like this, if you use Bash:"
1>&2 echo ""
1>&2 echo "    export PATH=/usr/share/bcc/tools:\$PATH"
1>&2 echo ""
1>&2 echo "You should then be able to run a command like execsnoop using:"
1>&2 echo ""
1>&2 echo "    sudo `which execsnoop`"
1>&2 echo "------------------------------------------------------------"
