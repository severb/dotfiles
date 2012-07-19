#!/bin/bash
# wget -qO- https://github.com/severb/dotfiles/raw/master/bootstrap.sh | /bin/bash

if [ -d ~/.dotfiles ]; then
    cd ~/.dotfiles
    git pull
else
    git clone git://github.com/severb/dotfiles.git ~/.dotfiles/
    for cf in ~/.dotfiles/configs/*; do
        ln -s "$cf" ~/.$(basename "$cf")
    done
fi

cd ~/.dotfiles
git submodule init
git submodule update
