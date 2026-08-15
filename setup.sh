#!/usr/bin/env bash
set -euo pipefail

VAULT_DIR="$HOME/vault"
VAULT_HTTPS="https://github.com/reimiii/vault.git"
VAULT_SSH="git@github.com:reimiii/vault.git"
DOTFILES_SSH="git@github.com:reimiii/.dotfiles.git"

log() { printf '\n==> %s\n' "$*"; }

if [[ -d "$VAULT_DIR" ]]; then
    read -rp "Remove existing '$VAULT_DIR' (y/N)? " confirm
    [[ "${confirm,,}" == "y" ]] || { echo "Cancelled."; exit 0; }
    rm -rf "$VAULT_DIR"
fi

log "Cloning vault"
git clone "$VAULT_HTTPS" "$VAULT_DIR"

log "Decrypting secrets (ssh + gpg)"
cd "$VAULT_DIR"
ansible-vault decrypt .ssh/* gpg/key.asc

log "Installing .gitconfig"
cp "$VAULT_DIR/.gitconfig" "$HOME/"

log "Installing .ssh"
rm -rf "$HOME/.ssh"
cp -r "$VAULT_DIR/.ssh" "$HOME/"

log "Starting ssh-agent and loading key"
if ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
fi
ssh-add "$HOME/.ssh/id_ed25519"

log "Importing gpg key"
gpg --import "$VAULT_DIR/gpg/key.asc"

log "Switching vault remote to ssh"
git -C "$VAULT_DIR" remote set-url origin "$VAULT_SSH"

log "Switching .dotfiles remote to ssh"
git -C "$HOME/.dotfiles" remote set-url origin "$DOTFILES_SSH"

echo "Done."
