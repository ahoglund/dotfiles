source ~/.config/fish/private.fish

# cmd
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
alias sps="spring status"
alias spr="spring rspec"
alias sprc="spring rails console"
alias sprs="spring rails server"
alias sprr="spring rake routes"
alias tmuxconf="vim ~/.tmux.conf"
alias vimrc="vim ~/.vimrc"
alias zshrc="vim ~/.zshrc"
alias git_conflicts='git diff --name-only --diff-filter=U'
alias dc="docker-compose"
alias agl="ag -l"
alias vim='nvim'

# env
set -x LIBRARY_PATH $LIBRARY_PATH /usr/local/opt/openssl/lib/
set -x CLICOLOR 1
set -x GREP_OPTIONS '--color=auto'
set -x GOPATH $HOME/src/go
set -x GOBIN $GOPATH/bin
set -x GO111MODULE auto

# remember history between IEx sessions
set -x ERL_AFLAGS "-kernel shell_history enabled"

fish_add_path /Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/itms/bin
fish_add_path $HOME/src/go/bin
fish_add_path $HOME/.rbenv/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.yarn/bin
fish_add_path /usr/local/opt/gnu-sed/libexec/gnubin
fish_add_path /usr/local/opt/fzf/bin
fish_add_path $GOBIN
fish_add_path $HOME/.config/yarn/global/node_modules/.bin

status --is-interactive; and source (rbenv init -|psub)
status --is-interactive; and source (nodenv init -|psub)
set -g fish_user_paths "/usr/local/opt/heroku-node/bin" $fish_user_paths
