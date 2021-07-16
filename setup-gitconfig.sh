#!/bin/bash

dotfiles_dir=$1
setup_gitconfig () {
  if [ "$dotfiles_dir" == ""];
  then
    dotfiles_dir=$(pwd)
  fi

  if ! [ -f gitconfig.local ]
  then
    if [ "$(uname -s)" == "Darwin" ]
    then
      GIT_CREDENTIAL='osxkeychain'
    else
      GIT_CREDENTIAL='cache'
    fi

    sed -e "s/AUTHORNAME/$GIT_AUTHOR_NAME/g" -e "s/AUTHOREMAIL/$GIT_AUTHOR_EMAIL/g" -e "s/GIT_CREDENTIAL_HELPER/$GIT_CREDENTIAL/g" gitconfig.local.example > gitconfig.local

    cat gitconfig.local >> gitconfig
    rm gitconfig.local
  fi
}

setup_gitconfig
