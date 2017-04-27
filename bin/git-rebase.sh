#! /bin/bash

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
