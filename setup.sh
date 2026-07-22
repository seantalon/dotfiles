#!/usr/bin/env bash
set -euo pipefail

# Resolve the repo dir as wherever this script actually lives, so symlinks
# point at the real clone regardless of where it was cloned to.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_SRC="$DOTFILES_DIR/.config"
CONFIG_DST="$HOME/.config"

echo "==> Installing fish, starship deps, and utilities"
sudo apt update
sudo apt install -y fish curl git

echo "==> Installing starship (if missing)"
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh -s -- -y
fi

echo "==> Symlinking configs"
mkdir -p "$CONFIG_DST/fish" "$CONFIG_DST/git"
ln -sf "$CONFIG_SRC/fish/config.fish"  "$CONFIG_DST/fish/config.fish"
ln -sf "$CONFIG_SRC/starship.toml"     "$CONFIG_DST/starship.toml"
ln -sf "$CONFIG_SRC/git/config"        "$CONFIG_DST/git/config"

echo "==> Seeding fish_variables (copy once, do NOT symlink — fish writes to it)"
if [[ ! -e "$CONFIG_DST/fish/fish_variables" && -e "$CONFIG_SRC/fish/fish_variables" ]]; then
    cp "$CONFIG_SRC/fish/fish_variables" "$CONFIG_DST/fish/fish_variables"
fi

echo "==> Adding guarded 'exec fish' to ~/.bashrc (if not already present)"
if ! grep -q 'FISH_STARTED' "$HOME/.bashrc" 2>/dev/null; then
    cat >> "$HOME/.bashrc" <<'EOF'

# Launch fish for interactive sessions, keeping bash as login shell.
# Guard lets `bash` from within fish give you a real bash, and skips bash -c.
if [[ $- == *i* ]] && [[ -z "${FISH_STARTED:-}" ]] && command -v fish >/dev/null; then
    export FISH_STARTED=1
    SHELL=$(command -v fish) exec fish
fi
EOF
fi

echo ""
echo "==> Done. Open a new terminal (or SSH session) to land in fish."
echo "    Need a plain bash? Run: bash --norc   (or just 'bash' from within fish)"
