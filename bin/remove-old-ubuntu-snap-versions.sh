#! /bin/bash

# Removes old revisions of snaps
# CLOSE ALL SNAPS BEFORE RUNNING THIS

# I found this script here:
# https://www.linuxuprising.com/2019/04/how-to-remove-old-snap-versions-to-free.html

# In this discussion I found that it should be safe to delete the snap
# cache directory:
# https://askubuntu.com/questions/1075050/how-to-remove-uninstalled-snaps-from-cache

set -eu

BEFORE=`df -BM .`
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
    while read snapname revision; do
        sudo snap remove "$snapname" --revision="$revision"
    done
# askubuntu.com Q&A where I found the following command:
# https://askubuntu.com/questions/1075050/how-to-remove-uninstalled-snaps-from-cache
sudo sh -c 'rm -rf /var/lib/snapd/cache/*'
sudo apt clean
sudo apt autoremove
sudo apt clean
AFTER=`df -BM .`
echo "Before: $BEFORE"
echo "After:  $AFTER"
