if [ "$ZSH_NAME" != "" ]
then
    echo "You appear to be running zsh."
    echo "The dotfiles shell scripts are all written assuming bash."
    echo "On macOS, you can change the default shell of the current"
    echo "user account to bash using this command:"
    echo ""
    echo "    chsh -s /bin/bash"
else
    if [[ -e /etc/os-release ]]
    then
        source /etc/os-release
        if [ ${ID} = "ubuntu" -o ${ID} = "debian" ]
        then
            sudo apt-get --yes install curl
        fi
    fi
    export github_user=jafingerhut
    bash -c "$(curl -fsSL https://raw.github.com/$github_user/dotfiles/master/bin/dotfiles)" && source ~/.bashrc
fi
