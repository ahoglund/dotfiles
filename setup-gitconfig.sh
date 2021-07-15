#!/bin/bash

setup_gitconfig () {
  if ! [ -f gitconfig.local ]
  then
    echo 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    echo ' - What is your github author name?'
    read -e git_authorname
    echo ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" gitconfig.local.example > gitconfig.local

    ln -s $(pwd)/gitconfig.local ~/.gitconfig.local
  fi
}

setup_gitconfig
