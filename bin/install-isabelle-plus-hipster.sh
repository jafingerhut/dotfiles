#! /bin/bash


# Remember the current directory when the script was started:
INSTALL_DIR="${PWD}"

THIS_SCRIPT_FILE_MAYBE_RELATIVE="$0"
THIS_SCRIPT_DIR_MAYBE_RELATIVE="${THIS_SCRIPT_FILE_MAYBE_RELATIVE%/*}"
THIS_SCRIPT_DIR_ABSOLUTE=`readlink -f "${THIS_SCRIPT_DIR_MAYBE_RELATIVE}"`

echo "------------------------------------------------------------"
echo "Time and disk space used before installation begins:"
date
df -h .
df -BM .

set -x
sudo apt-get --yes install curl git
set +x

echo "------------------------------------------------------------"
echo "Installing Haskell stack"
date
cd "${INSTALL_DIR}"

# Instructions from
# https://docs.haskellstack.org/en/stable/install_and_upgrade/#linux

curl -sSL https://get.haskellstack.org/ | sh


echo "------------------------------------------------------------"
echo "Installing TIP: Tons of Inductive Problems - tools"
date
cd "${INSTALL_DIR}"

# Without first installing this Ubuntu package, I have seen errors
# during the 'stack install' step below.  The suggestion to install
# the libtinfo-dev Ubuntu package I found on this web page, while
# doing a Google search on the error message:

# https://www.reddit.com/r/haskell/comments/7rwsnl/stack_error_while_constructing_the_build_plan/

sudo apt-get --yes install libtinfo-dev

set -x
git clone https://github.com/tip-org/tools
cd tools
stack setup
stack install
set +x


echo "------------------------------------------------------------"
echo "Installing Isabelle 2019"
date
cd "${INSTALL_DIR}"

set -x
curl -L https://isabelle.in.tum.de/dist/Isabelle2019_linux.tar.gz --output Isabelle2019_linux.tar.gz
tar xzf Isabelle2019_linux.tar.gz
set +x


echo "------------------------------------------------------------"
echo "Installing Hipster"
date
cd "${INSTALL_DIR}"

set -x
git clone https://github.com/moajohansson/IsaHipster.git
set +x


echo "------------------------------------------------------------"
echo "Configuring Isabelle to find Hipster and TIP-tools"
date
cd "${INSTALL_DIR}"

# On a system where I ran the 2 commands above in the directory
# /home/andy/hipster (where $HOME was /home/andy), then in that same
# directory ran the command:

#  $ ./Isabelle2019/Isabelle2019 &

# Then select menu entry Utilities -> Favorites -> $ISABELLE_HOME
# one of the GUI window panes showed the directory tree to
# -> /home/andy/hipster/isabelle2019

# Selecting menu entry Utilities -> Favorites -> $ISABELLE_HOME_USER
# -> /home/andy/.isabelle/Isabelle2019

# Selecting menu entry Utilities -> Favorites -> $JEDIT_HOME
# -> /home/andy/hipster/Isabelle2019/src/Tools/jEdit

# Selecting menu entry Utilities -> Favorites -> $JEDIT_SETTINGS
# -> /home/andy/.isabelle/Isabelle2019/jedit

ISABELLE_HOME_USER="$HOME/.isabelle/Isabelle2019"
SETTINGS="${ISABELLE_HOME_USER}/etc/settings"
mkdir -p `dirname "${SETTINGS}"`
echo "HIPSTER_HOME=${INSTALL_DIR}/IsaHipster" >> "${SETTINGS}"
echo "HASKELL_HOME=${HOME}/.local/bin" >> "${SETTINGS}"

echo "------------------------------------------------------------"
echo "Time and disk space used when installation was complete:"
date
df -h .
df -BM .

echo "export PATH=\"${INSTALL_DIR}/Isabelle2019:\$PATH\"" > "${INSTALL_DIR}/isabelle-setup.bash"

echo ""
echo "------------------------------------------------------------"
echo "Created the file: ${INSTALL_DIR}/isabelle-setup.bash"
echo ""
echo "If you use a Bash-like command shell, you can source that file,"
echo "then the following command will be found in your command path:"
echo ""
echo "Isabelle2019"
