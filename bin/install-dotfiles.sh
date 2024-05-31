source /etc/os-release
if [ ${ID} = "ubuntu" -o ${ID} = "debian" ]
then
    sudo apt-get --yes install curl
fi
export github_user=jafingerhut
bash -c "$(curl -fsSL https://raw.github.com/$github_user/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
