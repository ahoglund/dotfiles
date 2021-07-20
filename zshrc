if [ -f ~/.zsh_private ]; then
  source ~/.zsh_private
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$PATH
#eval "$(nodenv init -)"
eval "$(rbenv init -)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git rails ruby)

source $ZSH/oh-my-zsh.sh

PATH=$PATH:$HOME/bin:/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin
export CLICOLOR=1
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$PATH
export GO111MODULE=auto
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/
export PATH="$HOME/.cargo/bin:$PATH"

# remember history between IEx sessions
export ERL_AFLAGS="-kernel shell_history enabled"

## command aliases ##
alias git=hub
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlhp'
alias llh='ls -FGlAhp'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias .5='cd ../../../../../'
alias .6='cd ../../../../../../'
alias cssh='i2cssh'
alias sed='gsed'
alias rspec="rspec -fd"
alias be="bundle exec"
alias bi="bundle install"
alias cleanup_merged_branches="git branch --merged master | grep -v master | xargs -n 1 git branch -d"
alias sps="spring status"
alias spr="spring rspec"
alias sprc="spring rails console"
alias sprs="spring rails server"
alias sprr="spring rake routes"
alias tmux="TERM=xterm-256color tmux"
alias tmuxconf="vim ~/.tmux.conf"
alias vimrc="vim ~/.vim/init.vim"
alias zshrc="vim ~/.zshrc"
alias git_conflicts='git diff --name-only --diff-filter=U'
alias dc="docker-compose"
alias agl="ag -l"

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
