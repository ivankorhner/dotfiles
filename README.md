# Dotfiles

Personal shell configuration files with automatic zsh setup.

## Contents

- `.zshrc` - Zsh configuration (Powerlevel10k theme)
- `.gitconfig` - Git configuration
- `.aliases` - Shell aliases (if present)
- `install.sh` - Automated installer

## Installation

```bash
git clone https://github.com/korhner/dotfiles.git ~/dotfiles
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

The install script automatically:
- Installs zsh (if not present)
- Installs Oh My Zsh
- Installs Powerlevel10k theme
- Installs zsh plugins (autosuggestions, syntax-highlighting)
- Creates symlinks from your home directory to this repo

To set zsh as your default shell:
```bash
chsh -s $(which zsh)
```

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
