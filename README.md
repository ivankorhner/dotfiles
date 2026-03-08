# Dotfiles

Personal shell configuration files.

## Contents

- `.zshrc` - Zsh configuration
- `.bashrc` - Bash configuration
- `.gitconfig` - Git configuration
- `.aliases` - Shell aliases (if present)

## Installation

```bash
git clone https://github.com/korhner/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The install script creates symlinks from your home directory to this repo.

## Dev Container Integration

This repo works with VS Code/Cursor dev containers. Add to `.devcontainer.json`:

```json
"dotfiles": {
  "repository": "korhner/dotfiles",
  "installCommand": "install.sh"
}
```

## Updating

Edit files in `~/dotfiles/`, then commit and push:

```bash
cd ~/dotfiles
git add .
git commit -m "Update config"
git push
```

Changes are immediately reflected in `~/.zshrc` etc. via symlinks.
