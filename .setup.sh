#!/bin/bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

if [ "$(uname -s)" == "Darwin" ]
then
  brew install reattach-to-user-namespace
  brew install tmux
  brew install hub
  brew install ctags
  brew install the_silver_searcher nvim fzf
  mkdir -p Code
  ln -sf Code/ src
  ln -sf Applications/ apps
  ln -sf Downloads/ dld
  ln -sf Documents/ docs
  ln -sf Desktop/ dstp
  ln -sf Library/ lib
  ln -sf Music/ msc
  ln -sf Movies/ mvi
  ln -sf Pictures/ pics
  ln -sf Public/ pub
fi

gem install gem-ctags

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.config;

ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# disable dirty check in zsh git_prompt_info() function, speeds shell up a lot!
git config --add oh-my-zsh.hide-dirty 1

# Indexing Ruby std-lib
mkdir -p ~/.rbenv/plugins
git clone git://github.com/tpope/rbenv-ctags.git \
  ~/.rbenv/plugins/rbenv-ctags
rbenv ctags
