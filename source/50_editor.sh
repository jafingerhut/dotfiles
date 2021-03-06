# Editing

alias vi=vim

if [ -x "/Applications/Emacs.app/Contents/MacOS/Emacs" ]
then
    # On a new Mac of mine, I am going to give it a whirl to try using
    # GNU Emacs for Mac OS X downloaded from
    # https://emacsformacosx.com
    export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
elif [ -x "/opt/local/bin/emacs" ]
then
    # On my Macs, I like to use the MacPorts-installed version of
    # Emacs over the version that comes with OS X by default, which is
    # still version 21.x originally released in 2007, even on the
    # latest Mac OS Sierra!
    export EMACS="/opt/local/bin/emacs"
elif [ -x "/router/bin/emacs-24.5" ]
then
    # Among machines I commonly use, /router/bin/emacs-24.5 only
    # exists on Cisco Enterprise Linux machines.
    export EMACS="/router/bin/emacs-24.5"
else
    export EMACS="emacs"
fi

# Override default Emacs font in my init.el if I am running on a machine
# with 'linwin' as part of the name.  I plan to use that as part of the
# name for Linux VMs I create on a Windows machine where this font size
# works better for my viewing.
if [[ `uname -n` == *"linwin"* ]]
then
    export ANDY_EMACS_FONT="10x20"
fi

export EDITOR="${EMACS}"
export VISUAL="${EDITOR}"
alias e="${EDITOR}"
alias emacs="${EDITOR}"
