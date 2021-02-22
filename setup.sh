#!/bin/bash

currDir=$(pwd)

git submodule update --init --recursive

# Symlinking everything to its place
#ln -snf $currDir/.xmobar $HOME/
#ln -snf $currDir/.xmonad $HOME/
ln -snf $currDir/.zsh $HOME/
ln -snf $currDir/.zshrc $HOME/
#ln -snf $currDir/kitty $HOME/.config/
ln -snf $currDir/nvim $HOME/.config/
#ln -snf $currDir/rofi $HOME/.config/
ln -snf $currDir/.aliases $HOME/
#ln -snf $currDir/compton.conf $HOME/.config/

sudo apt update && sudo apt upgrade -y
sudo apt install build-essential flameshot visual-studio-code htop neovim trash-cli -y

echo Done.
