export PATH=$HOME/bin:/usr/local/bin:/Users/lyo.quintao/go/bin:~/Library/Android/sdk/tools:~/Library/Android/sdk/platform-tools:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions 
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=023'

alias github="cd ~/Documents/GitHub && ls" 
alias dev_old="cd ~/Documents/development/Projects && ls"
alias dev="cd ~/development && ls"
alias gpr="gh pr create --web"
alias nvim-config="cd ~/.config/nvim && nvim ."
alias n="nvim ."
alias c="clear"
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias configgit="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias reload="docker compose down -v && docker compose up"

function t() {
  if [[ $1 =~ '^[0-9]+$' ]]; then
    tree -L "$1"
  else
    tree "$@"
  fi
}

export PATH="$PATH:/Users/lyo.quintao/go/bin"

bindkey -s ^a "nvims\n"

source <(fzf --zsh)
eval "$(starship init zsh)"

# export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
# ☝️ This line is commented out because DYLD_LIBRARY_PATH conflicts with browser automation tools
# like Playwright, Puppeteer, and browser-use on macOS. It causes browser launch failures.

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/lyo.quintao/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/lyo.quintao/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/lyo.quintao/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/lyo.quintao/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
eval "$(~/.local/bin/mise activate zsh)"

# Shopify Hydrogen alias to local projects
alias h2='$(npm prefix -s)/node_modules/.bin/shopify hydrogen'
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/lyo.quintao/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Fix for browser automation tools (Playwright, Puppeteer, browser-use)
# DYLD_LIBRARY_PATH can interfere with browser launches on macOS
# Unset it after all other shell initialization is complete
if [[ -n "$DYLD_LIBRARY_PATH" ]]; then
    unset DYLD_LIBRARY_PATH
fi

if [ -z "$DISABLE_ZOXIDE" ]; then
    eval "$(zoxide init --cmd cd zsh)"
fi

export CLAUDE_BASH_MAINTAIN_PROJECT_WORKING_DIR=1
