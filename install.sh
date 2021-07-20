#!/bin/bash

exec > >(tee -i $HOME/creation.log)
exec 2>&1
set -x

dotfiles_dir=$(pwd)

ln -s $dotfiles_dir/bin $HOME/bin

mkdir -p $HOME/.config/fish $HOME/.config/alacritty;

if [ "$(uname -s)" == "Darwin" ]; then
  brew bundle
fi

# Setup fzf
if [ "$(uname -s)" == "Darwin" ]; then
  $(brew --prefix)/opt/fzf/install
else
  curl -L https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz | tar xzC $HOME/bin
fi

#install neovim and ctags
if [ "$(uname -s)" == "Linux" ]; then
  sudo apt-get install -y fuse libfuse2 ctags hub tmux ripgrep npm rbenv
  curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
  chmod a+x $HOME/bin/nvim
fi

# A place for private configs
#touch $HOME/.config/fish/private.fish
touch $HOME/.bash_private
touch $HOME/.zsh_private

#ln -s $dotfiles_dir/fish/functions $HOME/.config/fish/functions
#ln -s $dotfiles_dir/fish/config.fish $HOME/.config/fish/config.fish

rm -f $HOME/.tmux.conf
ln -s $dotfiles_dir/tmux.conf $HOME/.tmux.conf

ln -s $dotfiles_dir/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

if [ "$CODESPACES" == "" ]; then
 echo '[url "git@github.com:"]' >> gitconfig
 echo '  insteadOf = https://github.com/' >> gitconfig
fi

mv $HOME/.gitconfig $HOME/.gitconfig.private
ln -s $dotfiles_dir/gitconfig $HOME/.gitconfig

rm -f $HOME/.gemrc
ln -s $dotfiles_dir/gemrc $HOME/.gemrc

rm -f $HOME/.bash_profile
rm -f $HOME/.bashrc
ln -s $dotfiles_dir/bash_profile $HOME/.bash_profile
ln -s $dotfiles_dir/bashrc $HOME/.bashrc

rm -f $HOME/.zshrc
ln -s $dotfiles_dir/zshrc $HOME/.zshrc

ln -s $dotfiles_dir/git_template $HOME/.git_template

ln -s $dotfiles_dir/nvim $HOME/.config/nvim

ln -s $dotfiles_dir/hammerspoon/ $HOME/.hammerspoon

# Use fish
# sudo apt-get install -y fish
# sudo chsh -s /usr/bin/fish

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
if [ "$(uname -s)" == "Darwin" ]
then
  GIT_CREDENTIAL='osxkeychain'
else
  GIT_CREDENTIAL='cache'
fi

sed -e "s/GIT_CREDENTIAL_HELPER/$GIT_CREDENTIAL/g" gitconfig.local.example >> gitconfig

# Install vim plugins
$HOME/bin/nvim +'PlugInstall --sync' +qa
