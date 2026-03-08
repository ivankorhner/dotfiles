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

This repo works with VS Code/Cursor dev containers.

### Setup

1. Set the environment variable in your host shell (already included in this repo's `.zshrc`):
   ```bash
   export DOTFILES_REPO=ivankorhner/dotfiles
   ```

2. Add to `.devcontainer.json`:
   ```json
   "dotfiles": {
     "repository": "${localEnv:DOTFILES_REPO}",
     "installCommand": "install.sh"
   }
   ```

This makes dotfiles optional - users without `DOTFILES_REPO` set will skip dotfiles installation and use default bash.

## Updating Existing Configs

Edit files in `~/dotfiles/`, then commit and push:

```bash
cd ~/dotfiles
git add .
git commit -m "Update config"
git push
```

Changes are immediately reflected in `~/.zshrc` etc. via symlinks.

## Adding New Content

### Adding a Zsh Plugin

```bash
# 1. Install plugin locally (test it first)
git clone https://github.com/author/plugin-name \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/plugin-name

# 2. Add to .zshrc plugins list
# Edit ~/dotfiles/.zshrc and add plugin name to plugins=()

# 3. Update install.sh to auto-install the plugin
# Add installation block to install.sh:
#   if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/plugin-name" ]; then
#       git clone https://github.com/author/plugin-name ...
#   fi

# 4. Commit and push
cd ~/dotfiles
git add .zshrc install.sh
git commit -m "Add plugin-name plugin"
git push
```

### Adding a New Dotfile

```bash
# 1. Copy the file to dotfiles repo
cp ~/.vimrc ~/dotfiles/.vimrc

# 2. Update install.sh to link it
# Add to the "Install dotfiles" section:
#   link .vimrc

# 3. Commit and push
cd ~/dotfiles
git add .vimrc install.sh
git commit -m "Add .vimrc configuration"
git push
```

### Adding Config Directories (e.g., .config/nvim/)

```bash
# 1. Copy directory to dotfiles
cp -r ~/.config/nvim ~/dotfiles/.config/

# 2. Update install.sh to create directory and link
# Add before linking dotfiles:
#   mkdir -p ~/.config
#   if [ -d "$DOTFILES_DIR/.config/nvim" ]; then
#       ln -sf "$DOTFILES_DIR/.config/nvim" ~/.config/nvim
#   fi

# 3. Commit and push
cd ~/dotfiles
git add .config install.sh
git commit -m "Add neovim configuration"
git push
```

## Testing Changes

Before pushing, test that install.sh works:

```bash
# Remove symlinks
rm ~/.zshrc ~/.p10k.zsh ~/.gitconfig

# Re-run installer
cd ~/dotfiles
./install.sh

# Reload shell
exec zsh
```
