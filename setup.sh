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

tmp="$(mktemp -d)"
trap 'rm -rf "$tmp"' EXIT

log "Decrypting secrets to temp dir"
ansible-vault decrypt --output "$tmp/id_ed25519" "$VAULT_DIR/.ssh/id_ed25519"
ansible-vault decrypt --output "$tmp/key.asc"    "$VAULT_DIR/gpg/key.asc"

log "Installing .gitconfig"
cp "$VAULT_DIR/.gitconfig" "$HOME/"

log "Installing .ssh"
rm -rf "$HOME/.ssh"
mkdir -p "$HOME/.ssh"
cp -r "$VAULT_DIR/.ssh/." "$HOME/.ssh/"
cp "$tmp/id_ed25519" "$HOME/.ssh/id_ed25519"
chmod 600 "$HOME/.ssh/id_ed25519"

log "Starting ssh-agent and loading key"
if ! ssh-add -l >/dev/null 2>&1; then
    eval "$(ssh-agent -s)"
fi
ssh-add "$HOME/.ssh/id_ed25519"

log "Importing gpg key"
gpg --import "$tmp/key.asc"

log "Installing vault pre-commit guard"
"$VAULT_DIR/scripts/install-hooks.sh"

log "Switching remotes to ssh"
git -C "$VAULT_DIR" remote set-url origin "$VAULT_SSH"
git -C "$HOME/.dotfiles" remote set-url origin "$DOTFILES_SSH"

echo "Done."
