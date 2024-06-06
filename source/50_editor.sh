# Editing

if is_rhel_family
then
    # No alias for vi on Fedora, since at least for Fedora 34, vi is vim
    echo -n ""
else
    alias vi=vim
fi

if [ -x "/Applications/Emacs.app/Contents/MacOS/Emacs" ]
then
    # I often use GNU Emacs for Mac OS X downloaded from
    # https://emacsformacosx.com on my macOS systems.
    export EMACS="/Applications/Emacs.app/Contents/MacOS/Emacs"
elif [ -x "/opt/local/bin/emacs" ]
then
    # Several years ago now, I often used GNU Emacs as installed by
    # MacPorts.
    export EMACS="/opt/local/bin/emacs"
else
    export EMACS=`which emacs`
fi

# Override default Emacs font in my init.el if I am running on a machine
# with 'linwin' as part of the name.  I plan to use that as part of the
# name for Linux VMs I create on a Windows machine where this font size
# works better for my viewing.
if is_rhel_family
then
    export ANDY_EMACS_FONT="Liberation Mono:pixelsize=15:foundry=1ASC:weight=normal:slant=normal:width=normal:spacing=100:scalable=true"
else
    export ANDY_EMACS_FONT="10x20"
fi

export EMACS_NO_DISPLAY="$EMACS"
if is_rhel_family
then
    # At least when I tried to use Emacs27 on Fedora 34, it could not
    # use the default DISPLAY environment variable vlaue of
    # 'wayland-0', but the default value of GNOME_SETUP_DISPLAY
    # worked.
    export EMACS="DISPLAY=${GNOME_SETUP_DISPLAY} $EMACS"
fi

export EDITOR="${EMACS}"
export VISUAL="${EDITOR}"
alias e="${EDITOR}"
alias emacs="${EDITOR}"
