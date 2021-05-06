#! /bin/bash

if [ $# -ne 1 ]
then
    1>&2 echo "usage: `basename $0` <shared-folder-name>"
    exit 1
fi

SHARED_FOLDER_NAME="$1"

ln -s /media/sf_${SHARED_FOLDER_NAME}/ ~/${SHARED_FOLDER_NAME}
