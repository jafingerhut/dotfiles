#! /bin/bash

linux_version_warning() {
    1>&2 echo "Found ID ${ID} and VERSION_ID ${VERSION_ID} in /etc/os-release"
    1>&2 echo "This script only supports these:"
    1>&2 echo "    ID ubuntu fedora rocky"
}

if [ ! -r /etc/os-release ]
then
    1>&2 echo "No file /etc/os-release.  Cannot determine what OS this is."
    linux_version_warning
    exit 1
fi
source /etc/os-release

if [ "${ID}" = "ubuntu" -o "${ID}" = "debian" ]
then
    ID_FAMILY="debian_family"
elif [ "${ID}" = "fedora" -o "${ID}" = "rocky" ]
then
    ID_FAMILY="rhel_family"
fi

if [ "${ID_FAMILY}" = "debian_family" ]
then
    dpkg -l | cat
elif [ "${ID_FAMILY}" = "rhel_family" ]
then
    dnf list --installed | cat
fi
