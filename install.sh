#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

PACKAGES=(stow zsh vim neofetch git curl)

echo "==> Installing packages: ${PACKAGES[*]}"
sudo apt-get update
sudo apt-get install -y "${PACKAGES[@]}"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

P10K_DIR="$HOME/.oh-my-zsh/custom/themes/powerlevel10k"
if [ ! -d "$P10K_DIR" ]; then
  echo "==> Installing Powerlevel10k"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
fi

echo "==> Stowing packages"
cd "$DOTFILES_DIR"
for pkg in zsh vim neofetch p10k; do
  if [ -d "$pkg" ]; then
    echo "    stow $pkg"
    stow --adopt "$pkg" 2>/dev/null || stow "$pkg"
  fi
done

echo "==> Done! Restart your shell or run 'zsh' to apply changes."
