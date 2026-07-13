#!/usr/bin/env bash
# macOS UI tweaks that match this machine's preferred feel.
set -euo pipefail

echo "==> Dock: instant autohide (no delay), default slide animation"
defaults write com.apple.dock autohide -bool true
defaults write com.apple.dock autohide-delay -float 0
# Leave animation at macOS default (do not set autohide-time-modifier)
defaults delete com.apple.dock autohide-time-modifier 2>/dev/null || true

echo "==> Hot corners: bottom-right = Mission Control"
# Corner values: 1=disabled, 2=Mission Control, 3=Application Windows,
# 4=Desktop, 5=Start Screen Saver, 11=Launchpad, 12=Notification Center, 13=Lock Screen
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

# Keep other corners off (same as current machine)
defaults write com.apple.dock wvous-bl-corner -int 1
defaults write com.apple.dock wvous-bl-modifier -int 0
defaults write com.apple.dock wvous-tl-corner -int 1
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 12
defaults write com.apple.dock wvous-tr-modifier -int 0

killall Dock >/dev/null 2>&1 || true
echo "Done. Dock and hot corners applied."
