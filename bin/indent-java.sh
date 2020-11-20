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
    # --pad-first-paren-out seems to add space before a left paren
    # that surrounds the parameters of a method call, too, but I do not
    # want that.
    #astyle --style=java --pad-first-paren-out $j
    astyle --style=java $j
    set -x
    /bin/cp $j ${TMP_FNAME}
    # I wish I knew how to make astyle force a space between
    # if/switch/while/for and the following left parenthesis, but not
    # between a method call and the following left parenthesis.  Until
    # then, this is fairly close.  Unfortunately it will muck with the
    # contents of any Java strings that contain this pattern, too, but
    # that is rare in most Java program.
    sed 's/\(if\|switch\|for\|while\)(/\1 (/g' ${TMP_FNAME} > $j
done

