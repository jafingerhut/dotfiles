#! /bin/bash

# Decompress a file/directory that was created with compress-dir.sh

if [[ $# -lt 1 ]]
then
    1>&2 echo "Usage: $0 <archive_file>"
    exit 1
fi

ARCHIVE_NAME="$1"

xz -d -c "${ARCHIVE_NAME}" | tar xf -
