#!/usr/bin/env bash
# Install Brewfile entries only when missing.
# If a cask's .app is already in /Applications, skip entirely (no download).
set -euo pipefail

FORMULAE="gh"

app_present() {
  local name="$1"
  [ -d "/Applications/${name}.app" ] || [ -d "${HOME}/Applications/${name}.app" ]
}

install_cask_if_needed() {
  local cask="$1"
  local app="$2"

  if brew list --cask "$cask" >/dev/null 2>&1; then
    echo "  skip $cask (already brew-managed)"
  elif app_present "$app"; then
    echo "  skip $cask (/Applications/${app}.app already present — no download)"
  else
    echo "  install $cask"
    brew install --cask "$cask"
  fi
}

echo "==> Homebrew formulae"
for formula in $FORMULAE; do
  if brew list --formula "$formula" >/dev/null 2>&1 || command -v "$formula" >/dev/null 2>&1; then
    echo "  skip $formula (already installed)"
  else
    echo "  install $formula"
    brew install "$formula"
  fi
done

echo "==> Homebrew casks (skip if .app already exists)"
install_cask_if_needed "google-chrome" "Google Chrome"
install_cask_if_needed "cursor" "Cursor"
install_cask_if_needed "ghostty" "Ghostty"
install_cask_if_needed "wispr-flow" "Wispr Flow"

echo "Brew install pass finished."
