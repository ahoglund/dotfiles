# ─── Oh-My-Zsh ────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# No built-in theme — using Starship instead
ZSH_THEME=""

plugins=(
  git                          # git aliases (gst, gco, etc.)
  z                            # frecency-based cd
  fzf                          # Ctrl+R history, Ctrl+T files, Alt+C dirs
  zsh-autosuggestions          # fish-style inline suggestions
  zsh-syntax-highlighting      # real-time command coloring
  zsh-history-substring-search # up/down arrow searches by prefix
)

source "$ZSH/oh-my-zsh.sh"

# ─── History ──────────────────────────────────────────────────────────────────
HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000
setopt EXTENDED_HISTORY       # timestamp + elapsed time in history
setopt HIST_EXPIRE_DUPS_FIRST # expire duplicate entries first
setopt HIST_IGNORE_DUPS       # don't record consecutive duplicates
setopt HIST_IGNORE_ALL_DUPS   # remove older duplicate entries
setopt HIST_FIND_NO_DUPS      # skip duplicates when searching
setopt HIST_SAVE_NO_DUPS      # don't save duplicates to file
setopt HIST_IGNORE_SPACE      # skip commands prefixed with a space
setopt SHARE_HISTORY          # share history across all sessions

# ─── History substring search keybinds ────────────────────────────────────────
bindkey '^[[A' history-substring-search-up   # up arrow
bindkey '^[[B' history-substring-search-down # down arrow
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# ─── Autosuggestions ──────────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_STRATEGY=(history completion) # try history first, then completions
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
bindkey '^ ' autosuggest-accept              # Ctrl+Space to accept inline suggestion

# ─── fzf ──────────────────────────────────────────────────────────────────────
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git"'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# ─── Aliases ──────────────────────────────────────────────────────────────────
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'
alias ll='ls -FGlhp'
alias llh='ls -FGlAhp'
alias ..='cd ../'
alias ...='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'
alias vim='nvim'
alias vi='nvim'
alias dc='docker-compose'
alias g='git'
alias clip='nc -U ~/.clipper.sock'
alias be='bundle exec'
alias bi='bundle install'
alias rspec='rspec -fd'
alias git_conflicts='git diff --name-only --diff-filter=U'
alias tmuxconf='nvim ~/.tmux.conf'
alias vimrc='nvim ~/.config/nvim/init.lua'
alias zshrc='nvim ~/.zshrc'
alias agl='ag -l'

# Rails/Spring aliases
alias sps='spring status'
alias spr='spring rspec'
alias sprc='spring rails console'
alias sprs='spring rails server'
alias sprr='spring rake routes'

# ─── Functions ────────────────────────────────────────────────────────────────
# Delete merged git branches
cleanup_merged_branches() {
  git branch --merged | grep -v '\*\|main\|master\|develop' | xargs -n 1 git branch -d
}

# Jump to git root
alias gr='cd "$(git rev-parse --show-toplevel)"'

# ─── Environment ──────────────────────────────────────────────────────────────
export EDITOR='nvim'
export CLICOLOR=1
export GOPATH="$HOME/src/go"
export GOBIN="$GOPATH/bin"
export GO111MODULE=auto
export ERL_AFLAGS="-kernel shell_history enabled" # Erlang/IEx history

export PATH="$HOME/bin:$PATH"
export PATH="$GOBIN:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"             # Rust
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# macOS: GNU sed (brew install gnu-sed)
if [[ -d "/opt/homebrew/opt/gnu-sed/libexec/gnubin" ]]; then
  export PATH="/opt/homebrew/opt/gnu-sed/libexec/gnubin:$PATH"
fi

# ─── Private and OS-specific configs ──────────────────────────────────────────
# ~/.zsh_private  — secrets, tokens (gitignored)
# ~/.zsh_os       — machine-specific overrides
[[ -f "$HOME/.zsh_private" ]] && source "$HOME/.zsh_private"
[[ -f "$HOME/.zsh_os" ]] && source "$HOME/.zsh_os"

# ─── Starship prompt ──────────────────────────────────────────────────────────
if command -v starship &>/dev/null; then
  eval "$(starship init zsh)"
fi
