#! /bin/bash

# Install Wireshark and tshark on Ubuntu system without having to
# answer _any_ questions interactively, except perhaps providing your
# password when prompted by 'sudo'.

# https://askubuntu.com/questions/1275842/install-wireshark-without-confirm

echo "wireshark-common wireshark-common/install-setuid boolean true" | sudo debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install wireshark tshark
