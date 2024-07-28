#!/bin/bash

set -e

CONFIG_DIR="$HOME/.config"
CURRENT_DIR="$(pwd)"

#### PACKAGES ####
PACKAGES=("git" "curl" "vim" "neovim" "fish" "tlp" "lazygit")

echo "Enabling COPRs"
sudo dnf copr enable atim/lazygit -y

echo "Installing packages"
#install packages
sudo dnf install -y "${PACKAGES[@]}"

echo "Install starship"
# install starship
curl -sS https://starship.rs/install.sh | sh

echo "Install atuin"
# install atuin
curl --proto '=https' --tlsv1.2 -LsSf https://setup.atuin.sh | sh
echo "Packages installed"


#### CONFIGS ####
echo "Linking configs"
# tmux config
echo "Link tmux"
ln -sf $CURRENT_DIR/.tmux.conf "$HOME/.tmux.conf"

# tlp
echo "Link tlp"
sudo ln -sf $CURRENT_DIR/tlp.conf /etc/tlp.conf

# fish
echo "Link fish"
mkdir -p "$CONFIG_DIR/fish"
ln -sf $CURRENT_DIR/.config/fish/config.fish "$CONFIG_DIR/fish/config.fish"
ln -sf $CURRENT_DIR/.config/fish/themes "$CONFIG_DIR/fish/themes"

# kitty
echo "Link kitty"
mkdir -p "$CONFIG_DIR/kitty"
ln -sf $CURRENT_DIR/.config/kitty/kitty.conf "$CONFIG_DIR/kitty/kitty.conf"
ln -sf $CURRENT_DIR/.config/kitty/current-theme.conf "$CONFIG_DIR/kitty/current-theme.conf"

# starship
echo "Link starship"
ln -sf $CURRENT_DIR/.config/starship.toml "$CONFIG_DIR/starship.toml"

# vscode
echo "Link vscode"
mkdir -p "$CONFIG_DIR/Code/User"
ln -sf $CURRENT_DIR/.config/Code/User/settings.json "$CONFIG_DIR/Code/User/settings.json"
ln -sf $CURRENT_DIR/.config/Code/User/keybindings.json "$CONFIG_DIR/Code/User/keybindings.json"

# yazi
mkdir -p "$CONFIG_DIR/yazi"
ln -sf $CURRENT_DIR/.config/yazi/yazi.toml "$CONFIG_DIR/yazi/yazi.toml"
ln -sf $CURRENT_DIR/.config/yazi/theme.toml "$CONFIG_DIR/yazi/theme.toml"

# lazygit
mkdir -p "$CONFIG_DIR/lazygit"
ln -sf $CURRENT_DIR/.config/lazygit/config.yml "$CONFIG_DIR/lazygit/config.yml"

echo "Configs linked"
