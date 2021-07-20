[ -f ~/.bashrc ] && source ~/.bashrc
[ -f ~/.bash_private ] && source ~/.bash_private
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh

source ./.paths
source ./.flags
source ./.aliases

## activate bash completion ##
if [ "$(uname -s)" == "Darwin" ]; then
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi
fi

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

eval "$(rbenv init -)"
