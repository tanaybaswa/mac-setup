#!/usr/bin/env bash
# Idempotently append PATH / tool hooks to zsh startup files.
set -euo pipefail

ZPROFILE="${HOME}/.zprofile"
ZSHRC="${HOME}/.zshrc"

ensure_line() {
  local file="$1"
  local marker="$2"
  local block="$3"
  touch "$file"
  if grep -Fq "$marker" "$file" 2>/dev/null; then
    echo "  skip (already present): $marker"
    return
  fi
  printf '\n%s\n' "$block" >>"$file"
  echo "  appended: $marker"
}

echo "==> Shell config"

# Homebrew
ensure_line "$ZPROFILE" "brew shellenv" \
'eval "$(/opt/homebrew/bin/brew shellenv zsh)"'

# UV / ~/.local/bin
ensure_line "$ZSHRC" '.local/bin/env' \
'. "$HOME/.local/bin/env"
alias python='\''python3.12'\'''

# nvm
ensure_line "$ZSHRC" 'NVM_DIR' \
'export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'

echo "Shell snippets ensured. Open a new terminal (or run: source ~/.zshrc)."
