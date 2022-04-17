# Set up path/environment for Homebrew, if it is installed on this system

# Check for default install location on a Linux system:


if [ -e /home/linuxbrew/.linuxbrew/bin/brew ]
then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
