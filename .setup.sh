#!/bin/bash

brew install reattach-to-user-namespace
brew install tmux
brew install hub
brew install ctags
brew install the_silver_searcher nvim fzf
gem install gem-ctags

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.config;

ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

# Indexing Ruby std-lib
mkdir -p ~/.rbenv/plugins
git clone git://github.com/tpope/rbenv-ctags.git \
  ~/.rbenv/plugins/rbenv-ctags
rbenv ctags

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
ln -sf Publuc/ pub
