# RHEL family only stuff. Abort if not in RHEL family.
is_rhel_family || return 1

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
