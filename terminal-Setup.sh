#!/usr/bin/env bash

brew_install() {
    echo "\nInstalling $1"
    if brew list $1; then
        echo "${1} is already installed"
    else
        brew install $1 && echo "$1 is installed"
    fi
}

does_file_exist() {
    if test -f $1; then
        mv $1 $1"_old"
        echo $1 "already exsists old configuraltion moved to" $1"_old"
    else
        echo "$1 already exist"
    fi
}

does_dir_exist() {
    if [ ! -d $1 ]; then
        $2
    else
        echo "$1 already exist"
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
does_dir_exist "~/.oh-my-zsh" 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'

# Python
brew_install python

# Powerline Status bar 
pip3 install --user powerline-status

# Patched fonts install
brew tap homebrew/cask-fonts && brew_install "--cask font-fira-code"

# pre .zshrc dependencies

# Dev
does_dir_exist "~/repos" "mkdir ~/repos"

# Python dev
does_dir_exist "~/.virtualenvs" "mkdir ~/.virtualenvs"
brew_install virtualenvwrapper

# Java
brew_install openjdk@11

# Kubctl - for intel silicon
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/darwin/amd64/kubectl"

# Oh my zsh Cobalt theme
does_dir_exist "~/.iterm_theme" "mkdir ~/.iterm_theme"
cd ~/.iterm_theme
does_dir_exist "Cobalt2-iterm" "git clone https://github.com/wesbos/Cobalt2-iterm.git"
cd ./Cobalt2-iterm
cp ./cobalt2.zsh-theme ~/.oh-my-zsh/themes/cobalt2.zsh-theme

# ZSH Plugins config
cd ~/.oh-my-zsh/custom/plugins
does_dir_exist "zsh-autosuggestions" "git clone https://github.com/zsh-users/zsh-autosuggestions.git"
does_dir_exist "zsh-syntax-highlighting" "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git"


# Useful terminal utilities
brew_install "--cask iterm2"
brew_install "tldr"
brew_install "git"

# replace default zsh config
cd $CWD
ZSH_FILE=.zshrc
does_file_exist ~/$ZSH_FILE
cp dotfiles/$ZSH_FILE ~/$ZSH_FILE

# replace .vimrc file 
VIM_FILE=.vimrc
does_file_exist ~/$VIM_FILE
cp dotfiles/$VIM_FILE ~/$VIM_FILE

# Show hidden files and folders 
defaults write com.apple.Finder AppleShowAllFiles true

# Launch zsh 
exec /bin/zsh

echo "Refer to post install instructions https://github.com/Michael1142/Terminal-Setup"