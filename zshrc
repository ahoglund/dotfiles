[ -f ~/.zsh_private ] && source ~/.zsh_private
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#eval "$(nodenv init -)"
eval "$(rbenv init -)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git rails ruby)

source $ZSH/oh-my-zsh.sh

source $HOME/.paths
source $HOME/.flags
source $HOME/.aliases

if type nvim > /dev/null 2>&1; then
  alias vim='nvim'
fi

eval "$(rbenv init -)"
