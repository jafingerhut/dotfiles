#! /bin/bash

# A teensy tiny shell script to help me enable access to shared
# folders in guest Linux VMs run within VirtualBox.

# I have written more full instructions here:

# https://github.com/jafingerhut/jafingerhut.github.com/blob/master/notes/macos-virtualbox-ubuntu-install-notes.md#set-up-shared-folders-between-ubuntu-guest-os-and-host-macos

set -x
sudo usermod -a -G vboxsf $USER
set +x

echo "Now reboot the guest VM.  After rebooting, run the command below to"
echo "create a symbolic link named:"
echo ""
echo "    $HOME/p4-docs"
echo ""
echo "to the directory"
echo ""
echo "    /media/sf_p4-docs"
echo ""
echo "$ vbox-link-sf.sh p4-docs"
echo ""
echo "Replace 'p4-docs' with any name of a shared folder you prefer."
