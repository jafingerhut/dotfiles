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
# -p{Password}        Add a password specified on the command line
# -p                  Add a password, interactively prompting user for the password

FOUNDBIN=0

for f in 7z 7zz
do
    which ${f}
    exit_status=$?
    if [ ${exit_status} -eq 0 ]
    then
	FOUNDBIN=1
	SEVENZIPBIN="$f"
    fi
done

if [ ${FOUNDBIN} -eq 0 ]
then
    1>&2 echo "None of these commands were found in your command path:"
    1>&2 echo "    7z 7zz"
    1>&2 echo ""
    1>&2 echo "On Ubuntu Linux you can use this command to install '7z':"
    1>&2 echo "    sudo apt-get install 7zip"
    1>&2 echo "On macOS with Homebrew you can use this command to install '7zz':"
    1>&2 echo "    brew install sevenzip"
    exit 1
fi

ARCHIVE_TO_CREATE="archive.7z"

echo "Creating archive ${ARCHIVE_TO_CREATE} ..."
${SEVENZIPBIN} a \
  -t7z -m0=lzma2 -mx=9 -mfb=64 \
  -md=32m -ms=on -mhe=on -p \
   "${ARCHIVE_TO_CREATE}" $*

# Verify the archive is encrypted

echo "----------------------------------------------------------------------"
echo "Reading archive to verify.  After entering the same password again,"
echo "look for occurrences of lines like this after each 'Path' line for"
echo "files in the archive (you may see 'Encrypted = -' for directories):"
echo ""
echo "    Encrypted = +"
echo "    Method = LZMA2:12 7zAES"
echo "----------------------------------------------------------------------"
echo ""
${SEVENZIPBIN} l -slt "${ARCHIVE_TO_CREATE}"
#${SEVENZIPBIN} l -slt "${ARCHIVE_TO_CREATE}" | egrep '(Path|Encrypted|AES|password)'
