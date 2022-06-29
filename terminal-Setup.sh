#!/usr/bin/env bash

brew_install() {
    echo "\nInstalling $1"
    if brew list $1 &>/dev/null; then
        echo "${1} is already installed"
    else
        brew install $1 && echo "$1 is installed"
    fi
}


CWD=$(pwd)

# Homebrew install 
which -s brew
if [[ $? != 0 ]] ; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

# oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
	echo "oh-my-zsh is installed"
 else
 	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Python
if [[ "$(python3 -V)" =~ "Python 3" ]]; then
    echo "Python 3 is installed"
else
    brew_install python
fi 

# Powerline Status bar 
pip3 install --user powerline-status

# Patched fonts install
brew tap homebrew/cask-fonts && brew  install --cask font-fira-code

# pre .zshrc dependencies
# Dev
if [ ! -d "~/repos" ]; then
    mkdir ~/repos
fi

# Python dev
if [ ! -d "~/.virtualenvs" ]; then
    mkdir ~/.virtualenvs
fi
brew_install virtualenvwrapper

# Java
brew_install openjdk@11

# Kubctl - for intel silicon
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"

# Oh my zsh Cobalt theme
if [ ! -d "~/.iterm_theme" ]; then
    mkdir ~/.iterm_theme
    cd ~/.iterm_theme
    git clone https://github.com/wesbos/Cobalt2-iterm.git
    cd ./Cobalt2-iterm
    cp ./cobalt2.zsh-theme ~/.oh-my-zsh/themes/cobalt2.zsh-theme
fi

# ZSH Plugins config
cd ~/.oh-my-zsh/custom/plugins
git clone https://github.com/zsh-users/zsh-autosuggestions.git
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git

# Useful terminal utilities
brew install cask "iterm2"
brew_install "tldr"
brew_install "git"

# replace default zsh config
cd $CWD
ZSH_FILE=~/.zshrc
if test -f $ZSH_FILE; then
    mv $ZSH_FILE $ZSH_FILE"_old"
    echo $ZSH_FILE "already exsists old configuraltion moved to" $ZSH_FILE"_old"
fi
cp dotfiles/.zshrc $ZSH_FILE

# replace .vimrc file 
VIM_FILE=~/.vimrc
if test -f $VIM_FILE; then
    mv $VIM_FILE $VIM_FILE"_old"
    echo $VIM_FILE "already exsists old configuraltion moved to" $VIM_FILE"_old"
fi
cp dotfiles/.vimrc $VIM_FILE

# Show hidden files and folders 
defaults write com.apple.Finder AppleShowAllFiles true

# Launch zsh 
exec /bin/zsh

echo "Refer to post install instructions https://github.com/Michael1142/Terminal-Setup"