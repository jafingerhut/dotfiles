#! /bin/bash

set -x
FNAME=`mktemp --tmpdir big-empty-zero-file-XXXXXXXX`
dd if=/dev/zero of=${FNAME} bs=4096k
rm -f ${FNAME}
