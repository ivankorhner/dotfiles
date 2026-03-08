#!/bin/bash
# Dotfiles installer - installs zsh, oh-my-zsh, plugins, and creates symlinks

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "Installing dotfiles from $DOTFILES_DIR..."

# Install zsh if not present
if ! command -v zsh &> /dev/null; then
    echo "Installing zsh..."
    if command -v apt-get &> /dev/null; then
        sudo apt-get update && sudo apt-get install -y zsh
    elif command -v dnf &> /dev/null; then
        sudo dnf install -y zsh
    elif command -v yum &> /dev/null; then
        sudo yum install -y zsh
    else
        echo "Warning: Cannot install zsh automatically. Please install manually."
    fi
fi

# Install oh-my-zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install Powerlevel10k theme
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k" ]; then
    echo "Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

# Install zsh-autosuggestions plugin
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "Installing zsh-autosuggestions..."
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "Installing zsh-syntax-highlighting..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

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
    else
        echo "  Skipping $file (not found)"
    fi
}

# Install dotfiles
link .zshrc
link .p10k.zsh
link .gitconfig
link .aliases

echo ""
echo "Dotfiles installed successfully!"
echo ""
echo "To make zsh your default shell, run:"
echo "  chsh -s \$(which zsh)"
echo ""
echo "Then reload your shell or open a new terminal."
