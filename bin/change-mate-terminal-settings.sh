#! /bin/bash

# $ dconf list /org/mate/terminal/profiles/default/
# background-color
# palette
# bold-color
# foreground-color
# visible-name

KEYPATH="/org/mate/terminal/profiles/default/"

show_settings() {
    for j in `dconf list ${KEYPATH}`
    do
        echo "$j - `dconf read ${KEYPATH}${j}`"
    done
}

echo "Settings before attempted changes:"
show_settings
dconf write ${KEYPATH}use-theme-colors false
dconf write ${KEYPATH}background-color "'#2d2d09092222'"
dconf write ${KEYPATH}foreground-color "'#ffffffffffff'"
dconf write ${KEYPATH}scrollback-lines 10000

echo ""
echo "Settings after attempted changes:"
show_settings
