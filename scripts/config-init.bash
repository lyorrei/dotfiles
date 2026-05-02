#!/usr/bin/env bash
git clone --bare git@github.com:lyorrei/dotfiles.git $HOME/.dotfiles
# define config alias locally since the dotfiles
# aren't installed on the system yet
function config {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
# create a directory to backup existing dotfiles to
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:lyorrei/dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi
# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no

# Symlink lazygit config from ~/.config/lazygit (tracked) into the
# location lazygit reads on macOS, so customCommands work out of the box.
if [[ "$OSTYPE" == darwin* ]]; then
  lg_dir="$HOME/Library/Application Support/lazygit"
  lg_link="$lg_dir/config.yml"
  lg_target="$HOME/.config/lazygit/config.yml"
  mkdir -p "$lg_dir"
  if [ -e "$lg_link" ] && [ ! -L "$lg_link" ]; then
    mv "$lg_link" "$lg_link.backup"
    echo "Backed up existing lazygit config to $lg_link.backup"
  fi
  ln -sfn "$lg_target" "$lg_link"
  echo "Linked lazygit config: $lg_link -> $lg_target"
fi
