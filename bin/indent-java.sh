#! /bin/bash

if [ $# -lt 1 ]
then
    1>&2 echo "usage: `basename $0` <java-source-filename> ..."
    exit 1
fi

# To install astyle on macOS:
# + brew install astyle
# + sudo port install astyle
# To install astyle on Ubuntu Linux:
# + sudo apt-get install astyle

TMP_FNAME="/tmp/indent-java-$$"

for j in $*
do
    echo $j
    /bin/cp $j $j.orig
    astyle --style=java --pad-first-paren-out $j
    set -x
    /bin/cp $j ${TMP_FNAME}
    sed 's/\(if|switch|for|while\)(/\1 \(/g' ${TMP_FNAME} > $j
done

