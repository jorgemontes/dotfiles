# :penguin: .dotfiles-debian

My `.dotfiles` repository for my Debian installation
Includes the apps:
- `zsh`
- `vim`
- `neofetch`
- `gnucash`
- `p10k` (Powerlevel10k)

## Install the dotfiles
```shell
git clone git@github.com:jorgemontes/.dotfiles-debian.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

The install script will:
- Install prerequisites (stow, zsh, vim, neofetch, git, curl)
- Install Oh My Zsh
- Install Powerlevel10k theme
- Stow all packages (zsh, vim, neofetch, p10k)

## Using GNU Stow

This repo uses [GNU Stow](https://www.gnu.org/software/stow/) to manage
dotfiles via symlinks. Each top-level directory is a "package" whose
internal structure mirrors `$HOME`.

### Layout

```
~/dotfiles/
├── zsh/
│   └── .zshrc          ->  ~/.zshrc
├── vim/
│   └── .vimrc          ->  ~/.vimrc
├── p10k/
│   └── .p10k.zsh       ->  ~/.p10k.zsh
└── neofetch/
    └── .config/
        └── neofetch/   ->  ~/.config/neofetch/
```

### Create a new package

1. Make the package directory inside the repo:
   ```shell
   mkdir -p ~/dotfiles/<pkg>
   ```
2. Move the existing dotfile into it, preserving its path relative to `$HOME`:
   ```shell
   mv ~/.somerc ~/dotfiles/<pkg>/.somerc
   # or for nested config:
   mkdir -p ~/dotfiles/<pkg>/.config/<app>
   mv ~/.config/<app>/* ~/dotfiles/<pkg>/.config/<app>/
   ```

### Install (stow) a package

From the dotfiles directory (stow uses the parent as the target, which is `$HOME`):

```shell
cd ~/dotfiles
stow <pkg>          # e.g. stow vim
```

This creates symlinks in `$HOME` pointing back into the repo.

### Uninstall (unstow)

```shell
cd ~/dotfiles
stow -D <pkg>
```

### Re-stow (after adding/removing files in a package)

```shell
cd ~/dotfiles
stow -R <pkg>
```

### Preview without changes

```shell
stow -n -v <pkg>
```

### Notes

- Stow refuses to overwrite an existing real file at the target; move
  (don't copy) the file into the package first, or back it up and remove it.
- If a target's parent directory already exists with unrelated content,
  use `--adopt` carefully (it pulls existing files into the package).
