#!/usr/bin/env bash
set -euo pipefail

# Bootstrap: curl -fsSL <raw-url>/install.sh | bash
# 1. cek dependensi (wajib: ansible-vault, git, stow)
# 2. clone ~/.dotfiles (kalau belum ada)
# 3. stow bin/ + local-bin/ + idea/, symlink tmux.conf
# 4. jalankan setup.sh (clone vault, decrypt password, install secrets, switch ke SSH)

DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="https://github.com/reimiii/.dotfiles.git"

echo "==> Preflight check"
missing=()
for cmd in ansible-vault git stow; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if [[ ${#missing[@]} -gt 0 ]]; then
    echo "ERROR: dependensi belum terinstall: ${missing[*]}"
    echo "Install dulu, contoh (Arch):"
    echo "  sudo pacman -S ansible stow git"
    exit 1
fi

if [[ -e "$DOTFILES" && ! -d "$DOTFILES/.git" ]]; then
    echo "ERROR: '$DOTFILES' sudah ada tapi bukan git repo. Hapus dulu atau pindahkan."
    exit 1
fi

if [[ ! -d "$DOTFILES/.git" ]]; then
    echo "==> Cloning dotfiles"
    git clone "$DOTFILES_REPO" "$DOTFILES"
fi

echo "==> Installing configs (stow)"
cd "$DOTFILES"
stow bin/ idea/ local-bin/
ln -sf "$DOTFILES/tmux-conf/.tmux.conf" "$HOME/.tmux.conf"

echo "==> Running setup.sh (secrets: clone vault + decrypt)"
"$DOTFILES/setup.sh"
