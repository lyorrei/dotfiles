# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=( git
  bundler
  npm
  zsh-autosuggestions 
  nvm
  asdf
)

source $ZSH/oh-my-zsh.sh

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=023'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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
#

function t() {
  if [[ $1 =~ '^[0-9]+$' ]]; then
    tree -L "$1"
  else
    tree "$@"
  fi
}

export TURTLEBOT3_MODEL=burger
export ROS_DOMAIN_ID=21
export RMW_IMPLEMENTATION=rmw_cyclonedds_cpp
export OPENAI_API_KEY="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"
export OPENAI_ORGANIZATION_ID="org-SppTyDM6UaHXwn44xxi1zRHO"
export TELEGRAM_API_KEY="6789925207:AAGWEl8dbtY3-C-EO3-g9gJQURvYQozIuaI"
export PATH="$PATH:/Users/lyo.quintao/go/bin"

# alias nvim-default="XDG_CONFIG_HOME=~/.config/nvim NVIM_APPNAME=nvim-nvchad nvim"
# alias nvim-kick="XDG_CONFIG_HOME=~/.config/nvim NVIM_APPNAME=kickstart nvim"
# alias nvim-lazy="XDG_CONFIG_HOME=~/.config/nvim NVIM_APPNAME=nvim-lazy nvim"
# alias nvim-nvchad="XDG_CONFIG_HOME=~/.config/nvim NVIM_APPNAME=nvim-nvchad nvim"
# alias nvim-astro="XDG_CONFIG_HOME=~/.config/nvim NVIM_APPNAME=nvim-astro nvim"
# alias nvim-mine="XDG_CONFIG_HOME=~/.config/nvim NVIM_APPNAME=nvim-mine nvim"
#
# function nvims() {
#   items=("default" "kickstart" "LazyVim" "NvChad" "AstroNvim")
#   config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
#   if [[ -z $config ]]; then
#     echo "Nothing selected"
#     return 0
#   fi
#
#   case $config in
#     "default") alias_to_call="nvim-default" ;;
#     "kickstart") alias_to_call="nvim-kick" ;;
#     "LazyVim") alias_to_call="nvim-lazy" ;;
#     "NvChad") alias_to_call="nvim-nvchad" ;;
#     "AstroNvim") alias_to_call="nvim-astro" ;;
#   esac
#
#   echo "Using config: $alias_to_call"
#   eval $alias_to_call $@
# }
#
#
#
# bindkey -s ^a "nvims\n"
export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH

export DYLD_LIBRARY_PATH="$(brew --prefix)/lib:$DYLD_LIBRARY_PATH"

