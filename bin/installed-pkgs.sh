#! /bin/bash

linux_version_warning() {
    1>&2 echo "Found ID ${ID} and VERSION_ID ${VERSION_ID} in /etc/os-release"
    1>&2 echo "This script only supports these:"
    1>&2 echo "    ID ubuntu fedora"
}

if [ ! -r /etc/os-release ]
then
    1>&2 echo "No file /etc/os-release.  Cannot determine what OS this is."
    linux_version_warning
    exit 1
fi
source /etc/os-release

if [ "${ID}" = "ubuntu" ]
then
    dpkg -l | cat
elif [ "${ID}" = "fedora" ]
then
    dnf list --installed | cat
fi
