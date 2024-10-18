if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=( git
  bundler
  npm
  zsh-autosuggestions 
  nvm
  asdf
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=023'

alias github="cd ~/Documents/GitHub && ls" 
alias dev_old="cd ~/Documents/development/Projects && ls"
alias dev="cd ~/development && ls"
alias nvim-config="cd ~/.config/nvim && nvim ."
alias n="nvim ."
alias config="git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias reload="docker compose down -v && docker compose up"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$PATH:/Users/lyo.quintao/Documents/development/flutter/bin"


export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && \. "/usr/local/opt/nvm/etc/bash_completion"

source ~/powerlevel10k/powerlevel10k.zsh-theme

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

export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"
