#! /bin/bash

# Compress a single file or directory using xz with options that often
# give some of the highest compression ratios I have found with open
# source programs.  Use options that enable a decompressor to run in a
# Gigabyte of RAM or less.  Note: The compression can be quite slow,
# e.g. 30 to 35 minutes on a 2023 model M3 MacBook Pro for a directory
# with total size about 8 GBytes.

if [[ $# -lt 1 ]]
then
    1>&2 echo "Usage: $0 <file_or_directory>"
    exit 1
fi

DIRNAME="$1"
# Remove trailing / character if one is present
DIRNAME="${DIRNAME%/}"
OUTNAME="${DIRNAME}.tar.xz"

if [ ! -e "${DIRNAME}" ]
then
    1>&2 echo "No such file: ${DIRNAME}"
    exit 1
fi

if [ -e "${OUTNAME}" ]
then
    1>&2 echo "Compressed output file exists already: ${OUTNAME}"
    1>&@ echo "Aborting.  Remove or rename that file if you wish to proceed."
    exit 1
fi

echo "Size of input file/dir:"
du -sh "${DIRNAME}"
echo "Creating archive: ${OUTNAME}"

tar cf - "${DIRNAME}" | xz -e -9 --lzma2=dict=512MiB - > "${OUTNAME}"
