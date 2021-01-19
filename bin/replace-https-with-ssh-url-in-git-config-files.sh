#! /bin/bash

# Find all files named config that are in a directory named .git that
# contain the indicated string, showing the matching lines:

# find . -name config | grep '/\.git/config' | xargs grep 'url = https://github.com/'

# Show only the file names that contain a match:

# find . -name config | grep '/\.git/config' | xargs grep --files-with-matches 'url = https://github.com/'

# Replace all occurrences of the string 'url = https://github.com/'
# with 'url = git@github.com:' in one file named 'file.txt' using
# one-line in Perl:

# perl -pi.bak -e 's-url = https://github.com/-url = git@github.com:-g' file.txt

find . -name config | grep '/\.git/config' | xargs grep --files-with-matches 'url = https://github.com/' | xargs perl -pi.bak -e 's-url = https://github.com/-url = git\@github.com:-g'
