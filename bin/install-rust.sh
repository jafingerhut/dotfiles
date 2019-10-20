#! /bin/bash

# Steps I tested on an Ubuntu 18.04 Linux system to install Rust and
# Cargo, and the 'cargo-download' crate, which makes it
# straightforward to download the source code of any other crate.

warning() {
    1>&2 echo ""
    1>&2 echo "This install script has only been tested on Ubuntu 18.04 so far."
    1>&2 echo "Proceed at your own risk of"
    1>&2 echo "significant time spent figuring out how to make it all work, or"
    1>&2 echo "consider getting VirtualBox and creating an Ubuntu 18.04 virtual"
    1>&2 echo "machine."
}

lsb_release >& /dev/null
if [ $? != 0 ]
then
    1>&2 echo "No 'lsb_release' found in your command path."
    warning
    exit 1
fi

distributor_id=`lsb_release -si`
release=`lsb_release -sr`
if [ "${distributor_id}" = "Ubuntu" -a \( "${release}" = "18.04" \) ]
then
    echo "Found distributor '${distributor_id}' release '${release}'.  Continuing with installation."
else
    warning
    1>&2 echo ""
    1>&2 echo "Here is what command 'lsb_release -a' shows this OS to be:"
    lsb_release -a
    exit 1
fi

# Command from Rust web site recommended on Linux and macOS for
# installing Rust and Cargo, found on this page:
# https://doc.rust-lang.org/cargo/getting-started/installation.html
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
