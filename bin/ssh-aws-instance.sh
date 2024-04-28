#! /bin/bash

# Assume my common case of user id `ubuntu`, and a particular key-pair
# file that I use.

IPV4="$1"

ssh -i $HOME/.ssh/Andy2-aws-kp.pem ubuntu@${IPV4}
