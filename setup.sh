#!/bin/bash

currDir=$(pwd)

# Symlinking everything to its place
ln -sf $currDir/.xmobar $HOME/.xmobar
ln -sf $currDir/.xmonad $HOME/.xmonad
ln -sf $currDir/.zsh $HOME/.zsh
ln -sf $currDir/kitty $HOME/.config/kitty
ln -sf $currDir/nvim $HOME/.config/nvim
ln -sf $currDir/rofi $HOME/.config/rofi
ln -sf $currDir/.aliases $HOME/.aliases
ln -sf $currDir/compton.conf $HOME/.config/compton.conf

echo Done.
