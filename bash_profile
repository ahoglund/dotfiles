## source bashrc ##
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

## private or company specific stuff ##
if [ -f ~/.bash_private ]; then
  source ~/.bash_private
fi

## env preferences ##
export PATH=$PATH:$HOME/bin:/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=$GOBIN:$PATH
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin
export GO111MODULE=auto
export LIBRARY_PATH=$LIBRARY_PATH:/usr/local/opt/openssl/lib/

# remember history between IEx sessions
export ERL_AFLAGS="-kernel shell_history enabled"

# set command line editor to vi
# set -o vi

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
alias glog='git log --pretty=oneline --graph'
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
alias vimrc="vim ~/.vimrc"
alias bash_profile="vim ~/.bash_profile"
alias git_conflicts='git diff --name-only --diff-filter=U'
alias gcp="git cherry-pick"
alias dc="docker-compose"
alias agl="ag -l"

## activate bash completion ##
if [ "$(uname -s)" == "Darwin" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi

# git branch in prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

if [ -f ~/.git-prompt.sh ]; then
  source ~/.git-prompt.sh
fi

export PATH="$HOME/.cargo/bin:$PATH"

eval "$(rbenv init -)"
