#!/bin/bash
set -e

if ! [ -f ~/.complete_alias ]; then
    echo "Downloading complete_alias..."
    # master, 06/2022
    curl -o ~/.complete_alias https://raw.githubusercontent.com/cykerway/complete-alias/f09f5c2f37ed5411cb21c145b01a3b4f919b9f9a/complete_alias
fi

if [ -d ~/.nvm ]; then
    echo "NVM is installed. Skipping npm prefix."
else
    echo "NVM is not installed. Setting up npm prefix."
    if ! command -v npm >/dev/null; then
        echo "ERROR: npm is not installed"
        exit 1
    fi
    mkdir -p $HOME/.npm-global/bin
    npm config set prefix $HOME/.npm-global
fi

if ! [ -f ~/.bashrc_mh ]; then
    echo "Setting up symlink ~/.bashrc_mh..."
    ln -sv $PWD/.bashrc_mh ~/.bashrc_mh
fi

if ! grep -F .bashrc_mh ~/.bashrc >/dev/null; then
    echo "Missing .bashrc_mh in .bashrc. Adding..."
    cp -v ~/.bashrc ~/.bashrc.OLD
    echo "

if [ -f ~/.bashrc_mh ]; then
    . ~/.bashrc_mh
fi
" >> ~/.bashrc
else
    echo "File .bashrc_mh is already being loaded."
fi

git config --global alias.diffc 'diff --cached'
