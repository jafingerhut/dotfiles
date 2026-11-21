#! /bin/bash

# For UTM VMs with VirtioFS, at least Ubuntu Linux guest OS's, these
# commands should enable any shared folders to be accessible from the
# user's directory $HOME/shared

mkdir -p $HOME/shared

# Make them accessible right now

sudo mount -t virtiofs share $HOME/shared

# Make them accessible after the system reboots, automatically during
# each bootup.

echo share  $HOME/shared  virtiofs  rw,nofail  0  0 | tee -a /etc/fstab
