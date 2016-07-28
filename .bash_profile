## source bashrc ##
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

## private or company specific stuff ##
if [ -f ~/.bash_private ]; then
  source ~/.bash_private
fi

## setup git email ##
git config --global user.email "$GIT_EMAIL"

## env preferences ##
PATH=$PATH:$HOME/bin:/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin
export CLICOLOR=1
export GREP_OPTIONS='--color=auto'

# set command line editor to vi
set -o vi

## command aliases ##
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
alias tmux="TERM=screen-256color-bce tmux"

## activate bash completion ##
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  source $(brew --prefix)/etc/bash_completion
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# git branch in prompt
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

source ~/.git-completion.sh
source ~/.git-prompt.sh
PS1="\[$BLUE\]\u\[$YELLOW\]\[$YELLOW\]\w\[\033[m\]\[$MAGENTA\]\$(__git_ps1)\[$WHITE\]\$ "

