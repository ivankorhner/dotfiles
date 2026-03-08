#!/bin/bash
# Dotfiles installer - creates symlinks from ~ to ~/dotfiles

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR..."

# Backup existing files
backup() {
    local file="$1"
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        local backup_name="$HOME/$file.backup.$(date +%Y%m%d_%H%M%S)"
        echo "  Backing up $file to $backup_name"
        mv "$HOME/$file" "$backup_name"
    fi
}

# Create symlink
link() {
    local file="$1"
    if [ -f "$DOTFILES_DIR/$file" ]; then
        backup "$file"
        ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
        echo "  Linked $file"
    fi
}

# Install dotfiles
link .zshrc
link .bashrc
link .gitconfig
link .aliases

echo "Dotfiles installed successfully!"
echo "Reload your shell: source ~/.zshrc (or source ~/.bashrc)"
