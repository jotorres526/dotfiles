#!/bin/bash

currDir=pwd

# Symlinking everything to its place
ln -s $currDir/.xmobar $HOME/.xmobar
ln -s $currDir/.xmonad $HOME/.xmonad
ln -s $currDir/.zsh $HOME/.zsh
ln -s $currDir/kitty $HOME/.config/kitty
ln -s $currDir/nvim $HOME/.config/nvim
ln -s $currDir/rofi $HOME/.config/rofi
ln -s $currDir/.aliases $HOME/.aliases
ln -s $currDir/compton.conf $HOME/.config/compton.conf
