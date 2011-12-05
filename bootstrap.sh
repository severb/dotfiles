#!/bin/bash
# To install the components run
# wget -qO- http://bitbucket.org/severb/dotfiles/raw/tip/bootstrap.sh | /bin/bash

echo 'Saving backup file in /tmp/dotfiles.tar.'
tar cf /tmp/dotfiles.tar ~/.dotfiles/

echo 'Deleting the old installment.'
rm -rf ~/.dotfiles/

hg clone https://severb@bitbucket.org/severb/dotfiles ~/.dotfiles/

echo 'Creating configs links.'
for cf in ~/.dotfiles/configs/*; do
rm -rf ~/.$(basename "$cf")
ln -s "$cf" ~/.$(basename "$cf")
done

# Create wiki script
echo "#!/bin/bash" > /tmp/wikico
echo hg clone https://severb@bitbucket.org/severb/wiki ~/.dotfiles/wiki >> /tmp/wikico
chmod +x /tmp/wikico
echo "(optional) Run /tmp/wikico to get the wiki."
