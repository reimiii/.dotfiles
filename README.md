# dotfiles

Personal dotfiles managed with GNU Stow.

## Contents

- `bin/` — personal scripts (stowed to `~/bin`)
- `idea/` — `.ideavimrc` (stowed to `~/.ideavimrc`)
- `tmux-conf/` — `.tmux.conf` (symlinked to `~/.tmux.conf`)
- `setup.sh` — sets up secrets from the `vault` repo (ssh, gpg, `.gitconfig`)
- `install.sh` — one-shot bootstrap (clone + stow + setup)

## Quick install (one-liner)

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/reimiii/.dotfiles/main/install.sh)
```

What it does:

1. Checks dependencies: `ansible-vault`, `git`, `stow` — aborts with an install hint if any are missing
2. Clones `~/.dotfiles` if it doesn't exist
3. Stows `bin/` + `idea/`, symlinks `~/.tmux.conf`
4. Runs `setup.sh`

## Manual setup

```bash
git clone https://github.com/reimiii/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow bin/ idea/
ln -s ~/.dotfiles/tmux-conf/.tmux.conf ~/.tmux.conf
./setup.sh
```

## setup.sh (secrets)

- Clones the `vault` repo to `~/vault` over HTTPS (asks before removing an existing copy)
- Prompts for the **vault password** to decrypt `.ssh/*` + `gpg/key.asc`
- Installs `~/.gitconfig`, `~/.ssh`, imports the GPG key, loads the SSH agent
- Switches the `vault` and `.dotfiles` remotes to SSH

## Dependencies

```bash
sudo pacman -S ansible stow git
```

Scripts in `bin/` additionally need: `fzf`, `tmux`, `curl`, `xclip`, `fd`, `docker`.
