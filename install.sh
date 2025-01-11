#!/bin/bash

# Install Packages
sudo apt update -y
sudo apt install bat -y

# Stow everything
mkdir ~/.config
cd ~/dotfiles
stow --target ~/.config . -v

# Setup Zsh
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh
exec zsh

