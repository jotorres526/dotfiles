#!/bin/bash

currDir=$(pwd)

# Symlinking everything to its place
ln -snf $currDir/.xmobar $HOME/.xmobar
ln -snf $currDir/.xmonad $HOME/.xmonad
ln -snf $currDir/.zsh $HOME/.zsh
ln -snf $currDir/.zshrc $HOME/.zshrc
ln -snf $currDir/kitty $HOME/.config/kitty
ln -snf $currDir/nvim $HOME/.config/nvim
ln -snf $currDir/rofi $HOME/.config/rofi
ln -snf $currDir/.aliases $HOME/.aliases
ln -snf $currDir/compton.conf $HOME/.config/compton.conf

echo Done.
