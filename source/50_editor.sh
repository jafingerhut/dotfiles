# Editing

if is_fedora
then
    # No alias for vi on Fedora, since at least for Fedora 34, vi is vim
    echo -n ""
else
    alias vi=vim
fi

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
    export EMACS=`which emacs`
fi

# Override default Emacs font in my init.el if I am running on a machine
# with 'linwin' as part of the name.  I plan to use that as part of the
# name for Linux VMs I create on a Windows machine where this font size
# works better for my viewing.
if is_fedora
then
    export ANDY_EMACS_FONT="Liberation Mono:pixelsize=15:foundry=1ASC:weight=normal:slant=normal:width=normal:spacing=100:scalable=true"
elif [[ `uname -n` == *"linwin"* ]]
then
    export ANDY_EMACS_FONT="10x20"
fi

if is_fedora
then
    # At least when I tried to use Emacs27 on Fedora 34, it could not
    # use the default DISPLAY environment variable vlaue of
    # 'wayland-0', but the default value of GNOME_SETUP_DISPLAY
    # worked.
    export EMACS_NO_DISPLAY="$EMACS"
    export EMACS="DISPLAY=${GNOME_SETUP_DISPLAY} $EMACS"
fi

export EDITOR="${EMACS}"
export VISUAL="${EDITOR}"
alias e="${EDITOR}"
alias emacs="${EDITOR}"
