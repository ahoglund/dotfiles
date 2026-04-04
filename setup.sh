#!/bin/bash
# setup.sh — symlink dotfiles into $HOME using GNU Stow.
# Safe to run multiple times (--restow removes stale links first).
set -euo pipefail

dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
os=$(uname -s)

if ! command -v stow &>/dev/null; then
  echo "GNU Stow is required. Install it with: brew install stow"
  exit 1
fi

stow_pkg() {
  stow --dir="$dotfiles_dir" --target="$HOME" --restow "$1"
  echo "  stowed: $1"
}

echo "==> Linking dotfiles..."

stow_pkg zsh
stow_pkg zellij
stow_pkg alacritty
stow_pkg ruby
stow_pkg nvim
stow_pkg bin
stow_pkg gpg
stow_pkg misc

# macOS-only packages
[[ "$os" == "Darwin" ]] && stow_pkg hammerspoon

# git package (excludes gitconfig — that's generated from template below)
stow --dir="$dotfiles_dir" --target="$HOME" --restow \
  --ignore='.gitconfig' git

# ─── Git config ───────────────────────────────────────────────────────────────
# Generate ~/.gitconfig from template if it doesn't exist yet.
# Re-run manually to regenerate: rm ~/.gitconfig && ./setup.sh
if [[ ! -f "$HOME/.gitconfig" ]]; then
  echo "==> Generating ~/.gitconfig from template..."

  if [[ "$os" == "Darwin" ]]; then
    GIT_CREDENTIAL='osxkeychain'
  else
    GIT_CREDENTIAL='cache'
  fi

  sed "s/GIT_CREDENTIAL_HELPER/$GIT_CREDENTIAL/g" \
    "$dotfiles_dir/gitconfig.example" > "$HOME/.gitconfig"

  if [[ -z "${CODESPACES:-}" ]]; then
    cat >> "$HOME/.gitconfig" <<'EOF'
[url "git@github.com:"]
  insteadOf = https://github.com/
EOF
  fi
fi

# ─── Private / OS-specific zsh files ──────────────────────────────────────────
# These are gitignored — put secrets, tokens, or machine-specific config here.
touch "$HOME/.zsh_private"
touch "$HOME/.zsh_os"

echo "==> Done. Open a new shell or run: source ~/.zshrc"
