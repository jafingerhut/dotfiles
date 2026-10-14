# RHEL family only stuff. Abort if not in RHEL family.
echo "got here 21_rhel_family_dnf.sh #1" >> $HOME/log-debug-dotfile.txt
is_rhel_family || return 1
echo "got here 21_rhel_family_dnf.sh #2" >> $HOME/log-debug-dotfile.txt

# Install DNF packages.
packages=(
#  mate-terminal
  emacs
)

if (( ${#packages[@]} > 0 )); then
  e_header "Installing DNF packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    sudo dnf -y install "$package"
  done
fi
