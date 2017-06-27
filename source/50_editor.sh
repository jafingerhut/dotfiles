# Editing

alias vi=vim

if [ -x "/opt/local/bin/emacs" ]
then
    # On my Macs, I like to use the MacPorts-installed version of
    # Emacs over the version that comes with OS X by default, which is
    # still version 21.x originally released in 2007, even on the
    # latest Mac OS Sierra!
    EMACS="/opt/local/bin/emacs"
elif [ -x "/router/bin/emacs-24.5" ]
then
    # Among machines I commonly use, /router/bin/emacs-24.5 only
    # exists on Cisco Enterprise Linux machines.
    EMACS="/router/bin/emacs-24.5"
else
    EMACS="emacs"
fi

export EDITOR="${EMACS}"
export VISUAL="${EDITOR}"
alias e="${EDITOR}"
alias emacs="${EDITOR}"
