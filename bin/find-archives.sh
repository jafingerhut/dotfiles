#! /bin/bash

# Try to quickly find files that appear to be archive files, based
# upon their file names alone.

find . \
     -name '*.tar.*' \
     -o -name '*.tar' \
     -o -name '*.jar' \
     -o -name '*.tgz' \
     -o -name '*.xz' \
     -o -name '*.zip' \
     -o -name '*.7z'
