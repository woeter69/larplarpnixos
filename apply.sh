#!/usr/bin/env bash
set -e

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> 1. Copying NixOS & Home Manager configurations to /etc/nixos/..."
sudo cp "$REPO_DIR/nixos/configuration.nix" /etc/nixos/configuration.nix
sudo cp "$REPO_DIR/nixos/hardware-configuration.nix" /etc/nixos/hardware-configuration.nix
sudo cp "$REPO_DIR/nixos/home.nix" /etc/nixos/home.nix

echo "==> 2. Setting up user dotfiles and wallpapers..."
mkdir -p "$HOME/.config" "$HOME/.icons/default" "$HOME/Pictures/Wallpapers"

# Ensure all config scripts are executable
find "$REPO_DIR/config" -type f -name "*.sh" -exec chmod +x {} + 2>/dev/null || true

# Copy wallpapers
cp -n "$REPO_DIR"/wallpapers/* "$HOME/Pictures/Wallpapers/" 2>/dev/null || true

# Symlink user configs
for app in rofi wlogout hypr waybar niri gtk-3.0 gtk-4.0; do
    if [ -d "$REPO_DIR/config/$app" ]; then
        rm -rf "$HOME/.config/$app"
        ln -sfn "$REPO_DIR/config/$app" "$HOME/.config/$app"
        echo "  -> Linked ~/.config/$app"
    fi
done

# Setup default cursor theme
printf "[Icon Theme]\nName=Default\nComment=Default Cursor Theme\nInherits=Adwaita\n" > "$HOME/.icons/default/index.theme"

echo "==> 3. Rebuilding NixOS configuration..."
sudo nixos-rebuild switch

echo "==> 4. Reloading Niri and Waybar..."
niri msg action load-config-file 2>/dev/null || true
pkill waybar 2>/dev/null || true
nohup waybar >/dev/null 2>&1 &

echo "==> Done! NixOS and Niri setup successfully applied."
