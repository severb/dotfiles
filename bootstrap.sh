#!/bin/bash
# wget -qO- https://github.com/severb/dotfiles/raw/master/bootstrap.sh | /bin/bash

if [ -d ~/.dotfiles ]; then
    cd ~/.dotfiles
    git pull
else
    git clone git://github.com/severb/dotfiles.git ~/.dotfiles/
    cd ~/.dotfiles
    for cf in configs/*; do
        ln -s "$cf" ~/.$(basename "$cf")
    done
fi

git submodule init
git submodule update

