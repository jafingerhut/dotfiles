#! /bin/bash

######################################################################
# Advice from Chris Dodd on rebasing a Github PR, which I followed for
# one PR I had on p4lang/p4c repo, from my Github fork where my
# changes were on my fork's master branch, and it worked!
#
# Generally the way to deal with this (upstream changes to master you
# want in your working branch that you've already made a pull request
# for) is to use
#
#     git pull --rebase upstream master
#
# (or possibly origin master if your local repo is clone of
# p4c.org/p4c with your fork added as an upstream, rather than a clone
# of your fork, with p4c.org/p4c added as upstream)
#
# Followed by
#
#    git push -f
#
# to update the pull request in place.
#
######################################################################


# From Calin Cascaval

#MY_GITHUB_FORK_NAME="cascaval"
MY_GITHUB_FORK_NAME="jafingerhut"

if [[ $# -lt 1 ]]; then
    echo "Usage $0 branch_name"
    exit 1
fi

MY_BRANCH=$1

git checkout master && \
    git pull --ff origin master && \
    git checkout ${MY_BRANCH} && \
    git rebase master && \
    git push ${MY_GITHUB_FORK_NAME} +${MY_BRANCH} && \
