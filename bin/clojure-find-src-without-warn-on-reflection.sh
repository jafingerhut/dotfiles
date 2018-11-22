#! /bin/bash

# Run this in the root directory of a clone of the repository
# https://github.com/clojure/clojure

# It will show a list of all '.clj' source files in src/clj/clojure and
# subdirectories that do _not_ contain any lines that contain the string

# set! *warn-on-reflection* true

find src/clj/clojure \! -type d | xargs grep -c 'set! \*warn-on-reflection\* true' | grep ':0'
