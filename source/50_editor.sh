# Editing

# On my Macs, I like to use the MacPorts-installed version of Emacs
# over the version that comes with OS X by default.
export MACPORTS_EMACS="/opt/local/bin/emacs"
export EMACS="emacs"
if [ -f "${MACPORTS_EMACS}" ]; then
    export EMACS="${MACPORTS_EMACS}"
fi

export EDITOR="${EMACS}"
export VISUAL="${EDITOR}"
alias e="${EDITOR}"
alias vi=vim
