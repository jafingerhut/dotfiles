ssh-agent -s >| ~/source-jfingerh
echo 'git config --global user.name "jfingerh"' >> ~/source-jfingerh
echo 'git config --global user.email "john.andy.fingerhut@intel.com"' >> ~/source-jfingerh
echo 'git config --global credential.helper cache' >> ~/source-jfingerh
echo 'echo "Updated ~/.gitconfig for user id jfingerh"' >> ~/source-jfingerh
source ~/source-jfingerh
ssh-add ~/.ssh/id_rsa
