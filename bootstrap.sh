#!/bin/bash
# To install the components run
# wget -qO- http://bitbucket.org/severb/dotfiles/raw/tip/bootstrap.sh | /bin/bash

if [-d ~/.dotfiles ]; then
    cd ~/.dotfiles
    git pull
else
    git clone git://github.com/severb/dotfiles.git ~/.dotfiles/
    for cf in ~/.dotfiles/configs/*; do
        ln -s "$cf" ~/.$(basename "$cf")
    done
fi

