#!/bin/bash

exec > >(tee -i $HOME/creation.log)
exec 2>&1
set -x

PATH="$HOME/bin:$PATH"
dotfiles_dir=$(pwd)
os=$(uname -s)

if [ "$1" == "reset" ]; then
  $dotfiles_dir/reset.sh
fi

$dotfiles_dir/setup.sh

if [ "$os" == "Darwin" ]; then
  brew bundle
  $(brew --prefix)/opt/fzf/install
else
  curl -L https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz | tar xzC $HOME/bin
fi

if [ "$os" == "Linux" ]; then
  flavor=$(egrep '^NAME=' /etc/os-release | sed 's/"//g' | cut -d= -f2)
  sudo apt-get update -y

  # Erlang
  # wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb
  # sudo dpkg -i erlang-solutions_2.0_all.deb

  if [ "$flavor" == "Debian GNU/Linux" ]; then
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
  fi

  if [ "$flavor" == "Ubuntu" ]; then
    # Fish
    sudo apt-add-repository -y ppa:fish-shell/release-3
    curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
    sudo apt-get install -y nodejs
  fi

  # Postgres
  # wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  # sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

  sudo apt-get update -y
  sudo apt-get install -y software-properties-common
  sudo apt-get install -y fuse libfuse2 tmux ripgrep npm rbenv fish
  sudo apt-get install -y exuberant-ctags hub

  # Elixir
  # sudo apt-get install -y esl-erlang
  # sudo apt-get install -y elixir

  # Postgres
  # sudo apt-get install -y postgresql postgresql-contrib

  wget -L -O $HOME/appimage.zip https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
  unzip $HOME/appimage.zip -d $HOME
  sudo chmod u+x $HOME/nvim.appimage
  sudo mv $HOME/nvim.appimage $HOME/bin/nvim
fi

# Use fish
sudo chsh -s $(which fish) $(whoami)

# Install vim plugins
nvim +'PlugInstall --sync' +qa
