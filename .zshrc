export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  zsh-autosuggestions 
  asdf
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=023'

alias github="cd ~/Documents/GitHub && ls" 
alias dev_old="cd ~/Documents/development/Projects && ls"
alias dev="cd ~/development && ls"
alias nvim-config="cd ~/.config/nvim && nvim ."
alias n="nvim ."
alias c="clear"
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias configgit="lazygit --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias reload="docker compose down -v && docker compose up"

function activate_conda() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/Users/lyo.quintao/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/Users/lyo.quintao/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/lyo.quintao/anaconda3/etc/profile.d/conda.sh"
      else
        export PATH="/Users/lyo.quintao/anaconda3/bin:$PATH"
      fi
  fi
  unset __conda_setup

  if [ -f "/Users/lyo.quintao/anaconda3/etc/profile.d/mamba.sh" ]; then
      . "/Users/lyo.quintao/anaconda3/etc/profile.d/mamba.sh"
  fi
# <<< conda initialize <<<
}

function t() {
  if [[ $1 =~ '^[0-9]+$' ]]; then
    tree -L "$1"
  else
    tree "$@"
  fi
}

export PATH="$PATH:/Users/lyo.quintao/go/bin"

bindkey -s ^a "nvims\n"
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

source <(fzf --zsh)
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"

export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

