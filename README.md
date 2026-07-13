# mac-setup

Bootstrap scripts to recreate a lean Mac developer environment: core GUI apps, Python/Node tooling, and the macOS Dock / hot-corner preferences from this machine.

## What it installs

### GUI apps (Homebrew casks)

| App | Why |
|-----|-----|
| [Google Chrome](https://www.google.com/chrome/) | Browser |
| [Cursor](https://cursor.com/) | Primary editor |
| [Ghostty](https://ghostty.org/) | Terminal |
| [Wispr Flow](https://wisprflow.ai/) | Voice dictation |

### CLIs / runtimes

| Tool | How |
|------|-----|
| Homebrew | Official installer |
| [GitHub CLI](https://cli.github.com/) (`gh`) | Brewfile |
| [UV](https://docs.astral.sh/uv/) + Python 3.12 | Official UV installer |
| [nvm](https://github.com/nvm-sh/nvm) + Node (LTS) | Official nvm installer |
| [Claude Code](https://claude.ai/code) CLI | Official install script |
| [Cursor Agent](https://cursor.com/) CLI (`agent` / `cursor-agent`) | Official install script |

### macOS preferences

- Dock autohide with **zero show delay**
- Hot corner **bottom-right → Mission Control**
- Top-right → Notification Center (others off)

## What it does *not* install

No Firefox, VS Code, Codex, Ollama, Notion, Slack/Teams/WhatsApp/Zoom, Loom, Tailscale, Stats, Amphetamine, DaisyDisk, LibreOffice, Word, Logi Tune, Enkrypt AI, or extra Apple stock apps.

## Quick start (new Mac)

```bash
# Optional: clone first
git clone https://github.com/tanaybaswa/mac-setup.git
cd mac-setup

chmod +x scripts/*.sh config/*.sh
./scripts/bootstrap.sh
```

Then open a new terminal (or `source ~/.zshrc`) and finish sign-ins listed at the end of the bootstrap output.

## Scripts

| Script | Purpose |
|--------|---------|
| `scripts/bootstrap.sh` | Full setup (Homebrew → Brewfile → tooling → shell → defaults) |
| `scripts/install-tooling.sh` | UV/Python, nvm/Node, Claude Code, Cursor Agent only |
| `scripts/audit.sh` | Read-only dump of apps, brew packages, CLI versions, Dock prefs |
| `config/macos-defaults.sh` | Dock + hot corners only |
| `config/zsh-snippets.sh` | Append PATH hooks for brew / UV / nvm (idempotent) |

Re-run any script safely; most steps skip work that is already done.

## Manual steps after bootstrap

1. **Chrome / Cursor / Wispr Flow** — sign in and restore sync as needed.
2. **`gh auth login`** — GitHub authentication.
3. **`claude`** — Claude Code auth.
4. **Cursor settings & skills** — not shipped in this public repo; restore from your own sync or a private backup.

## Inventory (source of truth for this repo)

Intentionally **core-only**. Extend the `Brewfile` or `install-tooling.sh` if you add must-haves later.

## License

MIT
