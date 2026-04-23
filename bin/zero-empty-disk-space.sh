#! /bin/bash

set -x

# On Ubuntu 26.04, the default installation of `dd` is a newer
# Rust-based implementation.  In my testing, it is an order of
# magnitude slower than the GNU version of `dd`.  Find and use GNU
# `dd`, which is installed by default on Ubuntu 26.04 systems with the
# name `gnudd`, if present.

DD="dd"
which gnudd >& /dev/null
exit_status=$?
if [ ${exit_status} -eq 0 ]
then
    DD="gnudd"
fi

FNAME="/bigemptyfile"
sudo ${DD} if=/dev/zero | sudo ${DD} of=${FNAME} bs=4096k
sudo /bin/rm -f ${FNAME}
