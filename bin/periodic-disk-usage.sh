#! /bin/bash

# Determine the current used and available disk space on the volume
# that contains the current directory every 1 second.  Print the
# column headings for the first run only, to avoid repeating the
# headers every time.  The output should look something like this:

# Filesystem     1M-blocks  Used Available Use% Mounted on
# /dev/sda5         59661M 7754M    48845M  14% /
# /dev/sda5         59661M 7754M    48845M  14% /
# /dev/sda5         59661M 7754M    48845M  14% /
# /dev/sda5         59661M 7754M    48845M  14% /

# You must kill the process to make it stop, e.g. by typing Ctrl-C in
# the terminal where the process was started.

# If you want to find the minimum and maximum disk usage, you can then
# run commands like the following on the output:

# sort -n -k 3,3 out.txt | head -n 2
# sort -n -k 3,3 out.txt | tail -n 1

df -BM .
while true
do
	sleep 1
	df -BM . | tail -n 1
done
