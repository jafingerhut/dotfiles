# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Some tools look for XCode, even though they don't need it.
# https://github.com/joyent/node/issues/3681
# https://github.com/mxcl/homebrew/issues/10245

# jafinger TBD: I think that I already have Xcode set up reasonably on
# all my Macs, and I am not yet sure what these commands might do to
# change that.  Comment it out for now.

#if [[ ! -d "$('xcode-select' -print-path 2>/dev/null)" ]]; then
#  sudo xcode-select -switch /usr/bin
#fi
