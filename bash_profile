## source bashrc ##
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

## private or company specific stuff ##
if [ -f ~/.bash_private ]; then
  source ~/.bash_private
fi

## setup git email ##
git config --local user.email "$GIT_EMAIL"

## env preferences ##
PATH=$PATH:$HOME/bin:/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'
export GOPATH=$HOME/src/go
export GOBIN=$GOPATH/bin
PATH=$GOBIN:$PATH
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
alias tmux="TERM=screen-256color-bce tmux"
alias tmuxconf="vim ~/.tmux.conf"
alias vimrc="vim ~/.vimrc"
alias bash_profile="vim ~/.bash_profile"
alias git_conflicts='git diff --name-only --diff-filter=U'
alias gcp="git cherry-pick"
alias dc="docker-compose"
alias agl="ag -l"

## activate bash completion ##
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

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

PS1="\[$BLUE\]\u\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\]\$ "

export PATH="$HOME/.cargo/bin:$PATH"

eval "$(nodenv init -)"
