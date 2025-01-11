#!/bin/bash

# Install Packages
sudo apt-get update -y
sudo apt-get install bat -y

# Stow everything
mkdir ~/.config
cd ~/dotfiles
stow --target ~/.config . -v

# Setup Zsh
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
antibody bundle < ~/dotfiles/.zsh_plugins.txt > ~/.zsh_plugins.sh
exec zsh

