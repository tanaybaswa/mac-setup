#!/usr/bin/env bash
# Snapshot installed software on this Mac (read-only).
set -euo pipefail

section() { printf '\n## %s\n' "$1"; }

section "GUI apps (/Applications)"
ls -1 /Applications 2>/dev/null | sed 's/\.app$//' || true

section "Homebrew formulae"
if command -v brew >/dev/null 2>&1; then
  brew list --formula 2>/dev/null || true
else
  echo "(brew not found)"
fi

section "Homebrew casks"
if command -v brew >/dev/null 2>&1; then
  brew list --cask 2>/dev/null || true
else
  echo "(brew not found)"
fi

section "CLI versions"
for cmd in brew uv python3 node npm gh claude agent cursor-agent git; do
  if command -v "$cmd" >/dev/null 2>&1; then
    printf '%-14s %s\n' "$cmd" "$(command -v "$cmd")"
    "$cmd" --version 2>/dev/null | head -1 || true
  else
    printf '%-14s (missing)\n' "$cmd"
  fi
done

section "Dock / hot corners"
defaults read com.apple.dock autohide 2>/dev/null | sed 's/^/autohide=/' || true
defaults read com.apple.dock autohide-delay 2>/dev/null | sed 's/^/autohide-delay=/' || true
for corner in tl tr bl br; do
  defaults read com.apple.dock "wvous-${corner}-corner" 2>/dev/null | sed "s/^/${corner}=/" || true
done
