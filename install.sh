#!/bin/bash

exec > >(tee -i $HOME/creation.log)
exec 2>&1
set -x

if [ "$(uname -s)" == "Darwin" ]; then
  brew bundle
fi

# Setup fzf
if [ "$(uname -s)" == "Darwin" ]; then
  $(brew --prefix)/opt/fzf/install
fi

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.config/fish ~/.config/alacritty ~/.config/nvim;

# Install oh-my-zsh
if ! [ -d ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# A place for private configs
touch ~/.config/fish/private.fish
touch ~/.bash_private

ln -s $(pwd)/fish/functions/ ~/.config/fish/functions/
ln -s $(pwd)/fish/config.fish ~/.config/fish/config.fish
ln -s $(pwd)/tmux.conf ~/.tmux.conf
ln -s $(pwd)/start_tmux.sh ~/start_tmux.sh
ln -s $(pwd)/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $(pwd)/gitconfig ~/.gitconfig
ln -s $(pwd)/gemrc ~/.gemrc
ln -s $(pwd)/bash_profile ~/.bash_profile
ln -s $(pwd)/zshrc ~/.zshrc
ln -s $(pwd)/git_template ~/.git_template

ln -s $(pwd)/vim/init.vim ~/.vim/init.vim
ln -s ~/.config/nvim ~/.vim

ln -s $(pwd)/hammerspoon/ ~/.hammerspoon

 ln -sf $(pwd)/bin ~/bin

# Indexing Ruby std-lib
gem install gem-ctags
mkdir -p ~/.rbenv/plugins

if ! [ -d ~/.rbenv/plugins/rbenv-ctags ]; then
  git clone git://github.com/tpope/rbenv-ctags.git \
    ~/.rbenv/plugins/rbenv-ctags
  rbenv ctags
fi

# Setup GnuPG
mkdir -p ~/.gnupg
cd ~/.gnupg && ln -sf $HOME/dotfiles/gpg-agent.conf gpg-agent.conf

./setup-gitconfig.sh
