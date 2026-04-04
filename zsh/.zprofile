# .zprofile — login shell only (runs once per login session)
# PATH and tool initializations that should only happen once.

# ─── Homebrew (macOS only) ────────────────────────────────────────────────────
if [[ "$(uname -s)" == "Darwin" ]]; then
  [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ─── mise — language version manager (replaces rbenv + nodenv) ───────────────
# Manages Node, Ruby, Go, Python, Erlang, Elixir, and 100+ others.
# Versions declared in .mise.toml at repo/project root.
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
