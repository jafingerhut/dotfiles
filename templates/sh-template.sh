#! /bin/sh

# I'm not sure, but "$@" might be a bash-ism Here are different
# behavior of different choices for what goes in the "for a in ..."
# line:

######################################################################
# for a in $*
#
# > sh-template.sh  a b c 'd e'
# 4
# arg 1 is :a:
# arg 2 is :b:
# arg 3 is :c:
# arg 4 is :d:
# arg 5 is :e:
# usage: sh-template.sh arg1
######################################################################
# for a in "$*"
#
# > sh-template.sh  a b c 'd e'
# 4
# arg 1 is :a b c d e:
# usage: sh-template.sh arg1
######################################################################
# for a in "$@"
#
# > sh-template.sh  a b c 'd e'
# 4
# arg 1 is :a:
# arg 2 is :b:
# arg 3 is :c:
# arg 4 is :d e:
# usage: sh-template.sh arg1
######################################################################


# I found this bit of trickery at the StackOverflow link below.  I
# have tested that if the script is referenced through a symbolic link
# (1 level of linking testd), it gets the directory where the symbolic
# link is, not the directory where the linked-to file is located.  I
# believe that is what we want if this script is checked out as a
# linked tree: the directory of the checked-out version, which might
# have changes to other files in the checked-out tree in that same
# directory, and we want to see those.
# http://stackoverflow.com/questions/421772/how-can-a-bash-script-know-the-directory-it-is-installed-in-when-it-is-sourced-w

INSTALL_DIR=$(dirname $(readlink -f "$BASH_SOURCE"))
#echo "INSTALL_DIR=:${INSTALL_DIR}:"
#exit 0


echo $#
i=0
for a in "$@"
do
  i=`expr $i + 1`
  echo "arg $i is :$a:"
done

if [ $# -ne 1 ]
then
    1>&2 echo "usage: `basename $0` arg1"
    exit 1
fi

echo "Do something here with arg 1 = $1"

exit 0

# Example of attempting to create a temporary file, and aborting with
# an error message if it fails.

TMP_FILE_NAME=`mktemp -t my-cmd-name-$$-tmp-XXXXXX`
EXIT_STATUS=$?
if [ $EXIT_STATUS != 0 ]
then
    1>&2 echo "The following command failed with exit status $EXIT_STATUS"
    1>&2 echo "mktemp -t my-cmd-name-$$-tmp-XXXXXX"
    exit $EXIT_STATUS
fi

# This doesn't do what I want, which is to go through each of the
# colon-separated directories in $PATH.  I'm sure it isn't hard to do,
# but I'm not going to figure it out right now.

for d in $PATH
do
  if [ ! -d $d ]
  then
      echo $d NOT DIRECTORY
  fi
done

#if list
#then
#   ...
#elif list
#then
#   ...
#else
#   ...
#fi

#for name in word
#do
#   ...
#done

#for (( expr1 ; expr2 ; expr3 ))
#do
#   ...
#done

#while list
#do
#   ...
#done

#case word in
#pattern) ... ;;
#pattern | pattern) ... ;;
#...
#esac

#bash function definition:
#fn_name()
#{
#    local first_arg="$1"
#    local local_var=0
#    ... code here ...
#    return ${local_var}
#}
