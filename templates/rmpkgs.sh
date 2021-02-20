# Template bash script to remove packages from Ubuntu Linux system
# e.g. do this:

# cd
# cp ~/.dotfiles/templates/rmpkgs.sh ~
# large-pkgs.py | grep linux >> rmpkgs.sh
# [ hand edit rmpkgs.sh to keep only lines for packages you want to remove ]
# source rmpkgs.sh

df -BM .
df -h .
sudo apt clean
sudo apt autoremove
sudo apt purge

# put packages to remove on line above

sudo apt clean
df -BM .
df -h .
