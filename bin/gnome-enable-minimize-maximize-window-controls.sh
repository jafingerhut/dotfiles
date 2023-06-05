#! /bin/bash

# I learned about this command that causes the minimize and maximize
# buttons to appear at the top right of GNOME window managed windows
# on this web page:
#
# https://trendoceans.com/how-to-get-minimize-and-maximize-button-in-gnome/

gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
