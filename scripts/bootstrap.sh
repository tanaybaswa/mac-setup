#!/usr/bin/env bash
# Bootstrap a new Mac toward this machine's preferred setup.
# Safe to re-run (idempotent where possible).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

echo "========================================"
echo " mac-setup"
echo "========================================"
echo "Root: $ROOT"
echo

# --- Homebrew ---------------------------------------------------------------
if ! command -v brew >/dev/null 2>&1; then
  echo "==> Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv zsh)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv zsh)"
  fi
else
  echo "==> Homebrew already installed"
  eval "$(brew shellenv zsh 2>/dev/null || true)"
fi

# --- Brewfile (apps + gh) ---------------------------------------------------
echo "==> brew bundle (Brewfile)"
brew bundle --file="${ROOT}/Brewfile"

# --- Language / AI CLIs -----------------------------------------------------
bash "${ROOT}/scripts/install-tooling.sh"

# --- Shell PATH hooks -------------------------------------------------------
bash "${ROOT}/config/zsh-snippets.sh"

# --- macOS defaults (Dock + hot corners) ------------------------------------
bash "${ROOT}/config/macos-defaults.sh"

echo
echo "========================================"
echo " Bootstrap complete"
echo "========================================"
echo
echo "Manual follow-ups (sign-in / accounts):"
echo "  - Google Chrome: sign in if desired"
echo "  - Cursor: sign in + sync settings/skills"
echo "  - Wispr Flow: sign in / license"
echo "  - Claude Code: run \`claude\` and authenticate"
echo "  - GitHub CLI: run \`gh auth login\`"
echo
echo "Verify with:  ./scripts/audit.sh"
echo "New shell:    source ~/.zshrc"
