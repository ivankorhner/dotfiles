# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set DOTFILES_DIR for modular sourcing
DOTFILES_DIR="${HOME}/dotfiles"

# Load logic units
source "${DOTFILES_DIR}/.zsh/env.zsh"
source "${DOTFILES_DIR}/.zsh/omz.zsh"
source "${DOTFILES_DIR}/.zsh/git.zsh"
source "${DOTFILES_DIR}/.zsh/dncm.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
