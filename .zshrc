export PATH=$HOME/bin:$HOME/go/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions
)

# Docker CLI completions (must be set before oh-my-zsh runs compinit)
fpath=($HOME/.docker/completions $fpath)

source $ZSH/oh-my-zsh.sh

eval "$(~/.local/bin/mise activate zsh)"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=023'

alias dev="cd ~/development && ls"
alias gpr="gh pr create --web"
alias nvim-config="cd ~/.config/nvim && nvim ."
alias n="nvim ."
alias c="clear"
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias lg="lazygit"
alias configgit="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"

function t() {
  if [[ $1 =~ '^[0-9]+$' ]]; then
    tree -L "$1"
  else
    tree "$@"
  fi
}

alias cc='claude'
alias ccc='claude -c'
alias ccr='claude --resume'

source <(fzf --zsh)
eval "$(starship init zsh)"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# DYLD_LIBRARY_PATH conflicts with browser automation tools (Playwright,
# Puppeteer, browser-use) on macOS — unset it after shell init.
if [[ -n "$DYLD_LIBRARY_PATH" ]]; then
    unset DYLD_LIBRARY_PATH
fi

if [ -z "$DISABLE_ZOXIDE" ]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1

# Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

# OpenClaw completions
source "$HOME/.openclaw/completions/openclaw.zsh"
