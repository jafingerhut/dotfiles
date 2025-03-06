if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

if [ -x /opt/homebrew/bin/brew ]
then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi
