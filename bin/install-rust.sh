#! /bin/bash

# Steps I tested on an Ubuntu 18.04 Linux system to install Rust and
# Cargo, and the 'cargo-download' crate, which makes it
# straightforward to download the source code of any other crate.

warning() {
    1>&2 echo ""
    1>&2 echo "This install script has only been tested on these"
    1>&2 echo "systems so far:"
    1>&2 echo "    Ubuntu 18.04"
    1>&2 echo "    Ubuntu 19.10"
    1>&2 echo ""
    1>&2 echo "Proceed at your own risk of significant time spent"
    1>&2 echo "figuring out how to make it all work, or consider"
    1>&2 echo "getting VirtualBox and creating a virtual machine with"
    1>&2 echo "one of the tested systems above."
}

continue_yes_or_no() {
    local prompt="$1"
    local answer
    while true
    do
        echo -n "${prompt} [y/n] "
        read answer
        case ${answer:0:1} in
        y|Y) return 1 ;;
        n|N) return 0 ;;
        *) echo "Please answer y or n" ;;
        esac
    done
}

lsb_release >& /dev/null
if [ $? != 0 ]
then
    1>&2 echo "No 'lsb_release' found in your command path."
    warning
    exit 1
fi

continue_status=1

distributor_id=`lsb_release -si`
release=`lsb_release -sr`
if [ "${distributor_id}" = "Ubuntu" -a \( "${release}" = "18.04" -o "${release}" = "19.10" \) ]
then
    echo "Found distributor '${distributor_id}' release '${release}'.  Continuing with installation."
else
    warning
    1>&2 echo ""
    1>&2 echo "Here is what command 'lsb_release -a' shows this OS to be:"
    lsb_release -a
    continue_yes_or_no "Continue with installation attempt?"
    continue_status=$?
fi

if [ $continue_status == 0 ]
then
    echo "Aborting installation"
    exit 1
fi

echo "Continuing with installation..."
#echo "(Aborting for test purposes)"
#exit 0

# Command from Rust web site recommended on Linux and macOS for
# installing Rust and Cargo, found on this page:
# https://doc.rust-lang.org/cargo/getting-started/installation.html
sudo apt-get --yes install curl
curl https://sh.rustup.rs -sSf | sh

# Then I logged off and back on again so that changes to $HOME/.profile
# would take effect.  Could probably also have simply done:
source $HOME/.profile

# Ubuntu package possibly required in order for 'cargo install
# cargo-download' to succeed.

sudo apt-get install libssl-dev pkg-config
cargo install cargo-download

# To use cargo-download to download the source files for the crate 'im'
#cargo-download im > im-13.0.0.tar.gz
