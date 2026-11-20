#! /bin/bash

SAVE=$PWD

for d in $(find . -name .git | egrep -v '/PI/(proto|third_party)/' | sort)
do
    echo "--------------------"
    echo $d
    cd $SAVE/$d/..
    git status .
done

