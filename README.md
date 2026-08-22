# dotfiles - ze noir - night

Personal dotfiles managed with GNU Stow.

## Contents

- `bin/` — personal scripts (stowed to `~/bin`)
- `local-bin/` — database CLI wrappers (stowed to `~/.local/bin`)
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
3. Stows `bin/` + `local-bin/` + `idea/`, symlinks `~/.tmux.conf`
4. Runs `setup.sh`

## Manual setup

```bash
git clone https://github.com/reimiii/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow bin/ local-bin/ idea/
ln -s ~/.dotfiles/tmux-conf/.tmux.conf ~/.tmux.conf
./setup.sh
```

## setup.sh (secrets)

- Clones the `vault` repo to `~/vault` over HTTPS (asks before removing an existing copy)
- Prompts for the **vault password** to decrypt `.ssh/id_ed25519` + `gpg/key.asc` to a temp dir
  (the vault working tree stays encrypted at all times)
- Installs `~/.gitconfig`, `~/.ssh` (`chmod 600` on the key), imports the GPG key,
  loads the SSH agent, installs the vault pre-commit guard
- Switches the `vault` and `.dotfiles` remotes to SSH

## Docker databases (dev)

Two local database containers created with plain `docker run`:

| Container   | Image            | Host port        | Volume         |
|-------------|------------------|------------------|----------------|
| `mysql9`    | `mysql:9.6.0`    | `127.0.0.1:3306` | `mysql-data`   |
| `mariadb12` | `mariadb:12.3.2` | `127.0.0.1:3307` | `mariadb-data` |

> Root passwords are intentionally empty (allow empty password) — for local
> development only; ports are bound to `127.0.0.1`, never expose them.

### Recreate containers

```bash
docker run -d --name mysql9 \
  -p 127.0.0.1:3306:3306 \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=yes \
  -v mysql-data:/var/lib/mysql \
  mysql:9.6.0

docker run -d --name mariadb12 \
  -p 127.0.0.1:3307:3306 \
  -e MARIADB_ALLOW_EMPTY_ROOT_PASSWORD=yes \
  -v mariadb-data:/var/lib/mysql \
  mariadb:12.3.2
```

Data lives in named volumes (`mysql-data`, `mariadb-data`) — safe even if the
containers themselves are removed.

### CLI wrappers (`local-bin/` package)

Wrappers in `~/.local/bin` so you can call the client CLIs directly without
thinking about `docker exec`:

- `mysql` → `docker exec -i mysql9 mysql`
- `mariadb` → `docker exec -i mariadb12 mariadb` (strips `--host`/`--port` args automatically)
- `mysqldump` → `docker exec mysql9 mysqldump`

Usage examples:

```bash
mysql -u root                        # MySQL shell (mysql9 container)
mariadb -u root                      # MariaDB shell (mariadb12 container)
mysqldump -u root mydb > db.sql      # dump one database from mysql9
mysqldump -u root --all-databases > backup.sql
```

### Start / stop

```bash
docker start mysql9 mariadb12
docker stop  mysql9 mariadb12
```

## Dependencies

```bash
sudo pacman -S ansible stow git docker
```

Scripts in `bin/` additionally need: `fzf`, `tmux`, `curl`, `xclip`, `fd`.
