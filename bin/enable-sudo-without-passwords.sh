#! /bin/bash

# Copyright 2025 Andy Fingerhut
# SPDX-License-Identifier: Apache-2.0

# On at least an Ubuntu Linux system, and perhaps it also works on
# other Linux distributions as well, modify the sudoers configuration
# file so that the current user can run any command via sudo without
# having to enter a password.

# Note that while sudo commands run after this script succeeds should
# not require the user to enter a password, the sudo commands in
# _this_ script may definitely require that.

echo "${USER} ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers.d/99_${USER}
sudo chmod 440 /etc/sudoers.d/99_${USER}
