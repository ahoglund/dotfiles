#!/bin/bash

for i in $(cat .vimbundles); do
  mkdir -p ~/.vim/bundle/;
  cd ~/.vim/bundle/;
  git clone $i;
done;

mkdir -p ~/.vim/autoload ~/.vim/bundle;
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim;
brew install the_silver_searcher;
