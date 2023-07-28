# Where the magic happens.
export DOTFILES=~/.dotfiles

# Add binaries into the path
PATH=$DOTFILES/bin:$PATH
export PATH

# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}

src
# Start of Intel-proxy-specific setup section
export http_proxy="http://proxy-dmz.intel.com:911"
export https_proxy="http://proxy-dmz.intel.com:912"
export ftp_proxy="ftp://proxy-dmz.intel.com:21"
export socks_proxy="proxy-dmz.intel.com:1080"
export no_proxy="intel.com,*.intel.com,localhost,127.0.0.1,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12"
export ALL_PROXY='socks5://proxy-us.intel.com'
# End of Intel-proxy-specific setup section
