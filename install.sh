#!/bin/bash
# install.sh — bootstrap a new machine from scratch.
# Run once on a fresh system; then use setup.sh for subsequent machines.
set -euo pipefail

os=$(uname -s)
dotfiles_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ─── macOS: Homebrew ──────────────────────────────────────────────────────────
if [[ "$os" == "Darwin" ]]; then
  if ! command -v brew &>/dev/null; then
    echo "==> Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"

  echo "==> Installing Brewfile packages..."
  brew bundle --file="$dotfiles_dir/Brewfile"
fi

# ─── Linux (Arch/Omarchy): pacman + mise ─────────────────────────────────────
if [[ "$os" == "Linux" ]]; then
  echo "==> Installing Arch packages..."
  sudo pacman -S --needed --noconfirm \
    $(grep -v '^#\|^$' "$dotfiles_dir/packages.arch")

  # mise is not in the official Arch repos — install via the official script
  if ! command -v mise &>/dev/null; then
    echo "==> Installing mise..."
    curl https://mise.run | sh
    export PATH="$HOME/.local/bin:$PATH"
  fi
fi

# ─── Oh-My-Zsh ────────────────────────────────────────────────────────────────
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "==> Installing Oh-My-Zsh..."
  RUNZSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# ─── OMZ custom plugins ───────────────────────────────────────────────────────
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_if_missing() {
  local url="$1" dest="$2"
  if [[ ! -d "$dest" ]]; then
    echo "  cloning $(basename "$dest")..."
    git clone --depth=1 "$url" "$dest"
  fi
}

clone_if_missing \
  https://github.com/zsh-users/zsh-autosuggestions \
  "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

clone_if_missing \
  https://github.com/zsh-users/zsh-syntax-highlighting \
  "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

clone_if_missing \
  https://github.com/zsh-users/zsh-history-substring-search \
  "$ZSH_CUSTOM/plugins/zsh-history-substring-search"

# ─── mise: install language versions from .mise.toml ─────────────────────────
if command -v mise &>/dev/null; then
  echo "==> Installing language versions via mise..."
  mise install --cd "$dotfiles_dir"
fi

# ─── Set zsh as default shell ─────────────────────────────────────────────────
zsh_path=$(which zsh)
if [[ "$SHELL" != "$zsh_path" ]]; then
  echo "==> Setting zsh as default shell..."
  if ! grep -qF "$zsh_path" /etc/shells; then
    echo "$zsh_path" | sudo tee -a /etc/shells
  fi
  chsh -s "$zsh_path"
fi

# ─── Dotfile symlinks ─────────────────────────────────────────────────────────
echo "==> Linking dotfiles..."
"$dotfiles_dir/setup.sh"

echo ""
echo "==> Done! Start a new terminal session to use zsh."
