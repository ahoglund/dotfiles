#!/bin/bash
brew install the_silver_searcher nvim fzf;

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.config;
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim

