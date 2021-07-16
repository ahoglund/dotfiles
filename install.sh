#!/bin/bash

exec > >(tee -i $HOME/creation.log)
exec 2>&1
set -x

dotfiles_dir=$(pwd)

mkdir -p ~/.vim/autoload ~/.vim/bundle ~/.config/fish ~/.config/alacritty ~/.config/nvim;

if [ "$(uname -s)" == "Darwin" ]; then
  brew bundle
fi

# Setup fzf
if [ "$(uname -s)" == "Darwin" ]; then
  $(brew --prefix)/opt/fzf/install
else
  curl -L https://github.com/junegunn/fzf/releases/download/0.27.2/fzf-0.27.2-linux_amd64.tar.gz | tar xzC $HOME/bin
fi

#install neovim
if [ "$(uname -s)" == "Linux" ]; then
  apt-get install -y libfuse2
  curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
  chmod a+x $HOME/bin/nvim
fi

# Install vim plugins
vim -Es -u $HOME/.vimrc -c "PlugInstall | qa"

# Remove the oh-my's
rm -rf ~/.oh-my-zsh
rm -rf ~/.oh-my-bash

# A place for private configs
touch ~/.config/fish/private.fish
touch ~/.bash_private
touch ~/.zsh_private

ln -s $dotfiles_dir/fish/functions/ ~/.config/fish/functions/
ln -s $dotfiles_dir/fish/config.fish ~/.config/fish/config.fish

rm -f $HOME/.tmux.conf
ln -s $dotfiles_dir/tmux.conf ~/.tmux.conf
ln -s $dotfiles_dir/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

mv $HOME/.gitconfig $HOME/.gitconfig.private

ln -s $dotfiles_dir/gitconfig ~/.gitconfig
ln -s $dotfiles_dir/gemrc ~/.gemrc
ln -s $dotfiles_dir/bash_profile ~/.bash_profile
ln -s $dotfiles_dir/zshrc ~/.zshrc
ln -s $dotfiles_dir/git_template ~/.git_template

ln -s $dotfiles_dir/vim/init.vim ~/.vim/init.vim
ln -s ~/.config/nvim ~/.vim

ln -s $dotfiles_dir/hammerspoon/ ~/.hammerspoon

# I'd like to use fish, please
apt-get install -y fish
chsh -s /usr/bin/fish

# Indexing Ruby std-lib
gem install gem-ctags
mkdir -p ~/.rbenv/plugins

if ! [ -d ~/.rbenv/plugins/rbenv-ctags ]; then
  git clone git://github.com/tpope/rbenv-ctags.git \
    ~/.rbenv/plugins/rbenv-ctags
  rbenv ctags
fi

# Setup GnuPG
mkdir -p ~/.gnupg
cd ~/.gnupg && ln -sf $dotfiles_dir/gpg-agent.conf gpg-agent.conf

cd $dotfiles_dir
# Setup gitconfig
if [ "$(uname -s)" == "Darwin" ]
then
  GIT_CREDENTIAL='osxkeychain'
else
  GIT_CREDENTIAL='cache'
fi

sed -e "s/GIT_CREDENTIAL_HELPER/$GIT_CREDENTIAL/g" gitconfig.local.example > gitconfig
