# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

# If the old files isn't removed, the duplicate APT alias will break sudo!
sudoers_old="/etc/sudoers.d/sudoers-cowboy"; [[ -e "$sudoers_old" ]] && sudo rm "$sudoers_old"

# Installing this sudoers file makes life easier.
sudoers_file="sudoers-dotfiles"
sudoers_src=$DOTFILES/conf/ubuntu/$sudoers_file
sudoers_dest="/etc/sudoers.d/$sudoers_file"
if [[ ! -e "$sudoers_dest" || "$sudoers_dest" -ot "$sudoers_src" ]]; then
  cat <<EOF
The sudoers file can be updated to allow "sudo apt-get" to be executed
without asking for a password. You can verify that this worked correctly by
running "sudo -k apt-get". If it doesn't ask for a password, and the output
looks normal, it worked.

THIS SHOULD ONLY BE ATTEMPTED IF YOU ARE LOGGED IN AS ROOT IN ANOTHER SHELL.

This will be skipped if "Y" isn't pressed within the next $prompt_delay seconds.
EOF
  read -N 1 -t $prompt_delay -p "Update sudoers file? [y/N] " update_sudoers; echo
  if [[ "$update_sudoers" =~ [Yy] ]]; then
    e_header "Updating sudoers"
    visudo -cf "$sudoers_src" &&
    sudo cp "$sudoers_src" "$sudoers_dest" &&
    sudo chmod 0440 "$sudoers_dest" &&
    echo "File $sudoers_dest updated." ||
    echo "Error updating $sudoers_dest file."
  else
    echo "Skipping."
  fi
fi

# Update APT.
e_header "Updating APT"
sudo apt-get -qq update
sudo apt-get -qq dist-upgrade

# Install APT packages.
packages=(
#  ansible
  build-essential
#  cowsay
  dos2unix
  git-core
#  htop
#  id3tool
#  libssl-dev
  mate-terminal
  silversearcher-ag
  sshfs
  synaptic
  telnet
  tree
  vim
  xdiskusage
  xdu
)

install_emacs26_from_kelleyk_ppa=0
ubuntu_release=`lsb_release -s -r`
if [[ "${ubuntu_release}" > "19" ]]
then
    packages+=(emacs-gtk)
elif [[ "${ubuntu_release}" > "18" ]]
then
    install_emacs26_from_kelleyk_ppa=1
else
    packages+=(emacs24)
fi

if [ "${install_emacs26_from_kelleyk_ppa}" == 1 ]
then
    # In 2022-Apr I found instructions on this page that enabled me to
    # successfully install Emacs v26 on Ubuntu 18.04
    # https://www.reddit.com/r/emacs/comments/8pcw5a/what_is_the_most_painless_way_to_install_emacs_26/
    sudo add-apt-repository ppa:kelleyk/emacs
    sudo apt-get update
    sudo apt install emacs26
fi

packages=($(setdiff "${packages[*]}" "$(dpkg --get-selections | grep -v deinstall | awk '{print $1}')"))

if (( ${#packages[@]} > 0 )); then
  e_header "Installing APT packages: ${packages[*]}"
  for package in "${packages[@]}"; do
    sudo apt-get -qq install "$package"
  done
fi

# Install Git Extras
if [[ ! "$(type -P git-extras)" ]]; then
  if [ -d $DOTFILES/vendor/git-extras ]; then
    e_header "Installing Git Extras"
    (
      cd $DOTFILES/vendor/git-extras &&
      sudo make install
    )
  else
    e_header "Skipping installing Git Extras since there is no directory $DOTFILES/vendor/git-extras"
  fi
fi
