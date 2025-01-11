#!/bin/bash

# Install Packages
sudo apt-get update -y
sudo apt-get install bat -y
curl -sfL git.io/antibody | sudo sh -s - -b /usr/local/bin

# Stow everything
cd ~/dotfiles
stow git
stow nvim
stow p10k
stow zsh

# Setup Zsh
command -v zsh | sudo tee -a /etc/shells
sudo chsh -s $(which zsh) $USER
antibody bundle < ~/dotfiles/zsh/.zsh_plugins.txt > ~/.zsh_plugins.sh
exec zsh
