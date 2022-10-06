#!/bin/bash

exec > >(tee -i $HOME/creation.log)
exec 2>&1
set -x

PATH="$HOME/bin:$PATH"
dotfiles_dir=$(pwd)
os=$(uname -s)

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

if [ "$os" == "Darwin" ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ "$os" == "Linux" ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Use fish
brew "fish"
sudo chsh -s $(which fish) $(whoami)

brew bundle
if [ "$1" == "reset" ]; then
  $dotfiles_dir/reset.sh
fi

$dotfiles_dir/setup.sh

if [ "$os" == "Linux" ]; then
  flavor=$(egrep '^NAME=' /etc/os-release | sed 's/"//g' | cut -d= -f2)

  sudo apt-get update -y
  sudo apt-get install -y software-properties-common build-essential

  if [ "$flavor" == "Ubuntu" ]; then
    sudo modprobe fuse
    sudo groupadd fuse
    user="$(whoami)"
    sudo usermod -a -G fuse $user
  fi

  wget -L -O $HOME/appimage.zip https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
  unzip $HOME/appimage.zip -d $HOME
  sudo chmod u+x $HOME/nvim.appimage
  sudo mv $HOME/nvim.appimage $HOME/bin/nvim
fi

# Install node
nodenv install 16.13

# Install coc-solargraph
gem install solargraph
nvim +'CocInstall coc-solargraph' +qa

# Install vim plugins
nvim +'PlugInstall --sync' +qa
