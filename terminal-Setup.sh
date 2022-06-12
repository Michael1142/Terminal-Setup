# Homebrew install 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Powerline Status bar 
brew install python
pip3 install --user powerline-status

# Patched fonts install
brew tap homebrew/cask-fonts && brew  install --cask font-fira-code

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

# Show hidden files and folders 
defaults write com.apple.Finder AppleShowAllFiles true

# replace default zsh config
cp dotfiles/.zshrc /Users/$USER/.zshrc

echo "You need to set your terminal font to a powerline patched font.\n"
echo "Set the font by opening iTerm2 pressing cmd + \",\" and going to profiles -> text -> selecting Fira Code as the Font.\n\n"
echo "You may want to enable font ligatures or change the theme if you're feeling extra fancy...\n"
echo "To enable cmd and opt to jump around text in iterm go to preferences -> profiles -> keys -> key mappings and select \"Natural Text Encoding\" from the Presets..."
