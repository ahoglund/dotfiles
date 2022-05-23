#!/bin/bash

exec 2>&1
set -x

rm -f $HOME/bin

rm -rf $HOME/.oh-my-zsh
rm -rf $HOME/.oh-my-bash
rm -rf $HOME/.config
rm -rf $HOME/.gnupg
rm -rf $HOME/.fzf
rm -rf $HOME/.hammerspoon
rm -rf $HOME/.config
rm -rf $HOME/.git_template
rm -rf $HOME/.clipper.json

rm -f $HOME/.tmux.conf
rm -f $HOME/.bash_profile
rm -f $HOME/.gitconfig
rm -f $HOME/.gemrc
rm -f $HOME/.bash_private
rm -f $HOME/.zsh_private
rm -f $HOME/.profile
rm -f $HOME/.zprofile
rm -f $HOME/creation.log
rm -f $HOME/.fzf.bash
rm -f $HOME/.fzf.zsh
rm -f $HOME/.zshrc
rm -f $HOME/.zsh_history
rm -f $HOME/.shell.pre-oh-my-zsh
rm -f $HOME/.zshrc.pre-oh-my-zsh*
rm -f $HOME/.bash_history
rm -f $HOME/.bashrc
rm -f $HOME/.ctags
rm -f $HOME/.viminfo
