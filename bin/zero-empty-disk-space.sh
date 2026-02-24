#! /bin/bash

set -x
FNAME="/bigemptyfile"
sudo dd if=/dev/zero | sudo dd of=${FNAME} bs=4096k
sudo /bin/rm -f ${FNAME}
