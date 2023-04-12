ssh-agent -s >| ~/source-jafingerhut
echo 'git config --global user.name "Andy Fingerhut"' >> ~/source-jafingerhut
echo 'git config --global user.email "andy_fingerhut@alum.wustl.edu"' >> ~/source-jafingerhut
echo 'git config --global credential.helper cache' >> ~/source-jafingerhut
echo 'echo "Updated ~/.gitconfig for user id jafingerhut"' >> ~/source-jafingerhut
source ~/source-jafingerhut
ssh-add ~/.ssh/id_ed25519
