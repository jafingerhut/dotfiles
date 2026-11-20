#! /bin/bash

# Decompress a file/directory that was created with compress-dir.sh

if ! command -v xz >/dev/null 2>&1; then
    1>&2 echo "No command 'xz' found in command path."
    1>&2 echo "Some ways to install it:"
    1>&2 echo "    Homebrew: brew install xz"
    1>&2 echo "    Debian-based systems, e.g. Ubuntu: sudo apt-get install xz-utils"
    exit 1
fi

if [[ $# -lt 1 ]]
then
    1>&2 echo "Usage: $0 <archive_file>"
    exit 1
fi

ARCHIVE_NAME="$1"

xz -d -c "${ARCHIVE_NAME}" | tar xf -
