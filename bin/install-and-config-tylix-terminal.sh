#! /bin/bash

# On Ubuntu 26.04, the default terminal application, named ptyxis, has this
# behavior where holding down the control key and scrolling the mouse/touchpad
# up or down rapidly changes the font size large or smaller by many steps.
# I find myself triggering this behavior quite often, without intending to.
# A search on the Internet claims there is no way to disable this behavior
# in that particular application.

# It suggested installing a different
# terminal application instead, where that feature can be turned on/off via a
# configuration setting, of which one is tilix.

sudo apt-get install -y tilix

# Change tilix background color to a dark but not black one that I like.
PROFILE_UUID=$(gsettings get com.gexperts.Tilix.ProfilesList default | tr -d "'")
gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/$PROFILE_UUID/ use-theme-colors "false"
BG_COLOR="#300a24"
#BG_COLOR="#808080"
gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/$PROFILE_UUID/ background-color ${BG_COLOR}
FG_COLOR="#ffffff"
gsettings set com.gexperts.Tilix.Profile:/com/gexperts/Tilix/profiles/$PROFILE_UUID/ foreground-color ${FG_COLOR}

# Disable the title bar, to give more screen room for displaying text
# in the terminal.
TERMINAL_TITLE_STYLE="none"
#TERMINAL_TITLE_STYLE="normal"
gsettings set com.gexperts.Tilix.Settings terminal-title-style ${TERMINAL_TITLE_STYLE}
