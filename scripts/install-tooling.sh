#!/usr/bin/env bash
# Install UV + Python, nvm + Node, Claude Code CLI, Cursor Agent CLI.
# Assumes Homebrew + `gh` may already be present (see Brewfile / bootstrap).
set -euo pipefail

have() { command -v "$1" >/dev/null 2>&1; }

echo "==> UV"
if have uv; then
  echo "  uv already installed: $(uv --version)"
else
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi

# Ensure ~/.local/bin on PATH for this session
export PATH="${HOME}/.local/bin:${PATH}"

echo "==> Python 3.12 (via UV)"
uv python install 3.12
uv python pin --global 3.12 || true

echo "==> nvm + Node (current LTS / default)"
if [[ -s "${HOME}/.nvm/nvm.sh" ]]; then
  # shellcheck disable=SC1091
  . "${HOME}/.nvm/nvm.sh"
  echo "  nvm already installed"
else
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  # shellcheck disable=SC1091
  . "${HOME}/.nvm/nvm.sh"
fi
nvm install --lts
nvm alias default 'lts/*'

echo "==> Claude Code CLI"
if have claude; then
  echo "  claude already installed: $(claude --version 2>/dev/null || true)"
else
  curl -fsSL https://claude.ai/install.sh | bash
fi

echo "==> Cursor Agent CLI"
if have agent || have cursor-agent; then
  echo "  cursor agent already on PATH"
else
  curl -fsS https://cursor.com/install | bash
fi

echo "Tooling install finished."
