#!/bin/bash

exec 2>&1
set -x

PATH="$HOME/bin:$PATH"
dotfiles_dir=$(pwd)
os=$(uname -s)

#####
# Setup directories and symlinks
#####

mkdir -p $HOME/.config/fish $HOME/.config/alacritty
ln -s $dotfiles_dir/bin $HOME/bin

# FISH
# A place for private configs, ignored
touch $HOME/.config/fish/private.fish
# A place for os specific things, ignored by the dotfiles repo
touch $HOME/.config/fish/os.fish
ln -s $dotfiles_dir/fish/functions $HOME/.config/fish/functions
rm -f $HOME/.config/fish/config.fish
ln -s $dotfiles_dir/fish/config.fish $HOME/.config/fish/config.fish

cd $dotfiles_dir

echo ' eval "$(nodenv init -)"' >> $HOME/.config/fish/config.fish

if [ "$os" == "Darwin" ]; then
  echo 'fish_add_path /Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin' >> $HOME/.config/fish/os.fish
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> $HOME/.config/fish/os.fish
  echo 'status --is-interactive; and source (rbenv init -|psub)' >> $HOME/.config/fish/os.fish
  echo 'set -g default-command /opt/homebrew/bin/fish' >> $dotfiles_dir/tmux.conf
  echo 'set -g default-shell /opt/homebrew/bin/fish' >> $dotfiles_dir/tmux.conf
fi

if [ "$os" == "Linux" ]; then
  echo 'set -x LIBRARY_PATH $LIBRARY_PATH /usr/local/opt/openssl/lib/' >> $HOME/.config/fish/os.fish
  echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.config/fish/os.fish
  echo 'set -g default-command /home/linuxbrew/.linuxbrew/bin/fish' >> $dotfiles_dir/tmux.conf
  echo 'set -g default-shell /home/linuxbrew/.linuxbrew/bin/fish' >> $dotfiles_dir/tmux.conf

  # need the system conf.d files in homebrew, so this is the hack to do that.
  fish_version=$(fish -v | cut -d' ' -f3)
  mkdir -p /home/linuxbrew/.linuxbrew/Cellar/fish/$fish_version/etc/fish/conf.d/
  cp /etc/fish/conf.d/*fish /home/linuxbrew/.linuxbrew/Cellar/fish/$fish_version/etc/fish/conf.d/
fi

# TMUX
rm -f $HOME/.tmux.conf
ln -s $dotfiles_dir/tmux.conf $HOME/.tmux.conf
echo "set -g default-command $(which fish)" >> $dotfiles_dir/tmux.conf
echo "set -g default-shell $(which fish)" >> $dotfiles_dir/tmux.conf

# ALACRITTY
ln -s $dotfiles_dir/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml

# GITCONFIG

rm -f $HOME/.gitconfig
cp -p $dotfiles_dir/gitconfig.example $dotfiles_dir/gitconfig
ln -s $dotfiles_dir/gitconfig $HOME/.gitconfig
ln -s $dotfiles_dor/gitignore.global $HOME/.gitignore.global

if [ "$CODESPACES" == "" ]; then
 echo '[url "git@github.com:"]' >> gitconfig
 echo '  insteadOf = https://github.com/' >> gitconfig
fi

if [ "$os" == "Darwin" ]
then
  GIT_CREDENTIAL='osxkeychain'
else
  GIT_CREDENTIAL='cache'
fi

# this needs tweaking based on OS.
sed -e "s/GIT_CREDENTIAL_HELPER/$GIT_CREDENTIAL/g" -i '' $dotfiles_dir/gitconfig

# MISC
rm -f $HOME/.gemrc
ln -s $dotfiles_dir/gemrc $HOME/.gemrc
rm -f $HOME/.ctags
ln -s $dotfiles_dir/ctags $HOME/.ctags
ln -s $dotfiles_dir/git_template $HOME/.git_template
ln -s $dotfiles_dir/nvim $HOME/.config/nvim
ln -s $dotfiles_dir/hammerspoon $HOME/.hammerspoon
ln -s $dotfiles_dir/clipper.json $HOME/.clipper.json
ln -s $dotfiles_dir/irbrc $HOME/.irbrc
mkdir -p $HOME/.rbenv/plugins
# echo 3.1.2 > $HOME/.rbenv/version
# rbenv install 3.1.2

# Indexing Ruby std-lib
gem install gem-ctags
git clone https://github.com/tpope/rbenv-ctags.git $HOME/.rbenv/plugins/rbenv-ctags
#rbenv ctags

# Setup GnuPG
mkdir -p $HOME/.gnupg
cd $HOME/.gnupg && ln -sf $dotfiles_dir/gpg-agent.conf gpg-agent.conf

