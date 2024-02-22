#! /bin/bash

# Output a list of relative path file names, one per line, of only
# those files that contain a match for a pattern.

find . \! -type d -print0 | xargs -0 grep -c $* | grep -v ':0$' | egrep -v '/.gitignore' | grep -v '/.git/' | sed 's/:[0-9]*$//'
