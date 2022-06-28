#!/usr/bin/env bash

cwd=$(pwd)

# Homebrew install 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Powerline Status bar 
brew install python
pip3 install --user powerline-status

# Patched fonts install
brew tap homebrew/cask-fonts && brew  install --cask font-fira-code

# pre .zshrc dependencies
# Dev
mkdir ~/repos

# Python
mkdir ~/.virtualenvs
brew install python3
brew install virtualenvwrapper

# Java
brew install openjdk@11

# Oh my zsh Cobalt theme
mkdir ~/.iterm_theme
cd ~/.iterm_theme
git clone https://github.com/wesbos/Cobalt2-iterm.git
cd ./Cobalt2-iterm
cp ./cobalt2.zsh-theme ~/.oh-my-zsh/themes/cobalt2.zsh-theme

# ZSH Plugins config
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git


# Useful terminal utilities
brew install cask iterm2
brew install tldr
brew install git

# .vimrc setup 
touch ~/.vimrc
echo "syntax enable" >> ~/.vimrc
echo "set number" >> ~/.vimrc
echo "set tabstop=4" >> ~/.vimrc
echo "set shiftwidth=4" >> ~/.vimrc
echo "set softtabstop=4" >> ~/.vimrc
echo "set expandtab" >> ~/.vimrc

# replace default zsh config
cd $cwd
cp dotfiles/.zshrc /Users/$USER/.zshrc

# Show hidden files and folders 
defaults write com.apple.Finder AppleShowAllFiles true

# Launch zsh 
exec /bin/zsh

echo "Refer to post install instructions https://github.com/Michael1142/Terminal-Setup"