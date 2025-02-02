#! /bin/bash

# Source:
# https://askubuntu.com/questions/928275/7z-command-line-with-highest-encryption-aes-256-encrypting-the-filenames

# Here is an explanation for those not well versed in the 7z command line:
# 
# a                   Add (dir1 to archive.7z)
# -t7z                Use a 7z archive
# -m0=lzma2           Use lzma2 method
# -mx=9               Use the '9' level of compression = Ultra
# -mfb=64             Use number of fast bytes for LZMA = 64
# -md=32m             Use a dictionary size = 32 megabytes
# -ms=on              Solid archive = on
# -mhe=on             7z format only : enables or disables archive header encryption
# -p{Password}        Add a password

#SEVENZIPBIN="7z"
SEVENZIPBIN="7zz"

ARCHIVE_TO_CREATE="archive.7z"

echo "Creating archive ${ARCHIVE_TO_CREATE} ..."
${SEVENZIPBIN} a \
  -t7z -m0=lzma2 -mx=9 -mfb=64 \
  -md=32m -ms=on -mhe=on \
   "${ARCHIVE_TO_CREATE}"  $*

# Verify the archive is encrypted

echo ""
echo "Reading archive to verify ..."
${SEVENZIPBIN} l -slt "${ARCHIVE_TO_CREATE}" | egrep '(Encrypted|AES|password)'
