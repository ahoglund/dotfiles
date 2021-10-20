#!/bin/bash

exec > >(tee -i $HOME/creation.log)
exec 2>&1
set -x

PATH="$HOME/bin:$PATH"
dotfiles_dir=$(pwd)

os=$(uname -s)
flavor=$(egrep '^NAME=' /etc/os-release | sed 's/"//g' | cut -d= -f2)

if [ "$1" == "reset" ]; then
  $dotfiles_dir/reset.sh
fi

ln -s $dotfiles_dir/bin $HOME/bin

mkdir -p $HOME/.config/fish $HOME/.config/alacritty;

if [ "$os" == "Darwin" ]; then
  brew bundle
fi

# Setup fzf
if [ "$os" == "Darwin" ]; then
  $(brew --prefix)/opt/fzf/install
else
  curl -L https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz | tar xzC $HOME/bin
fi

#install neovim and ctags
if [ "$os" == "Linux" ]; then
  if [ "$flavor" == "Debian GNU/Linux" ]; then
    echo 'deb http://download.opensuse.org/repositories/shells:/fish:/release:/3/Debian_11/ /' | sudo tee /etc/apt/sources.list.d/shells:fish:release:3.list
    curl -fsSL https://download.opensuse.org/repositories/shells:fish:release:3/Debian_11/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/shells_fish_release_3.gpg > /dev/null
  fi

  sudo apt update
  sudo apt install -y software-properties-common
  sudo apt install -y fuse libfuse2 ctags hub tmux ripgrep npm rbenv fish
  curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
  chmod a+x $HOME/bin/nvim
fi

# A place for private configs
touch $HOME/.config/fish/private.fish

ln -s $dotfiles_dir/fish/functions $HOME/.config/fish/functions
ln -s $dotfiles_dir/fish/config.fish $HOME/.config/fish/config.fish

rm -f $HOME/.tmux.conf
ln -s $dotfiles_dir/tmux.conf $HOME/.tmux.conf

ln -s $dotfiles_dir/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml


rm -f $HOME/.gemrc
ln -s $dotfiles_dir/gemrc $HOME/.gemrc

ln -s $dotfiles_dir/git_template $HOME/.git_template
ln -s $dotfiles_dir/nvim $HOME/.config/nvim
ln -s $dotfiles_dir/hammerspoon/ $HOME/.hammerspoon

ln -s $dotfiles_dir/clipper.json/ $HOME/.clipper.json

# Use fish
sudo chsh -s $(which fish) $(whoami)

# Indexing Ruby std-lib
gem install gem-ctags
mkdir -p $HOME/.rbenv/plugins

if ! [ -d $HOME/.rbenv/plugins/rbenv-ctags ]; then
  git clone git://github.com/tpope/rbenv-ctags.git \
    $HOME/.rbenv/plugins/rbenv-ctags
  rbenv ctags
fi

# Setup GnuPG
mkdir -p $HOME/.gnupg
cd $HOME/.gnupg && ln -sf $dotfiles_dir/gpg-agent.conf gpg-agent.conf

cd $dotfiles_dir
# Setup gitconfig
if [ "$os" == "Darwin" ]
then
  GIT_CREDENTIAL='osxkeychain'
else
  GIT_CREDENTIAL='cache'
fi

rm -f $HOME/.gitconfig

sed -i -e "s/GIT_CREDENTIAL_HELPER/$GIT_CREDENTIAL/g" $dotfiles_dir/gitconfig.example
cp -p $dotfiles_dir/gitconfig.example $dotfiles_dir/gitconfig

if [ "$CODESPACES" == "" ]; then
 echo '[url "git@github.com:"]' >> gitconfig
 echo '  insteadOf = https://github.com/' >> gitconfig
fi

ln -s $dotfiles_dir/gitconfig $HOME/.gitconfig

# Install vim plugins
nvim +'PlugInstall --sync' +qa
