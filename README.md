# Dotfiles repo

Tutorial followed: https://mjones44.medium.com/storing-dotfiles-in-a-git-repository-53f765c0005d

## Quick install

```bash
curl https://raw.githubusercontent.com/lyorrei/dotfiles/main/scripts/config-init.bash | bash
```

## Manual install

```bash
#!/usr/bin/env bash
git clone --bare https://github.com/lyorrei/dotfiles.git $HOME/.dotfiles
# define config alias locally since the dotfiles
# aren't installed on the system yet
function config {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}
# create a directory to backup existing dotfiles to
mkdir -p .dotfiles-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out dotfiles from https://github.com/lyorrei/dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi
# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no

# macOS only: lazygit reads its config from ~/Library/Application Support/lazygit
# but the tracked file lives at ~/.config/lazygit/config.yml. Symlink them.
if [[ "$OSTYPE" == darwin* ]]; then
  mkdir -p "$HOME/Library/Application Support/lazygit"
  ln -sfn "$HOME/.config/lazygit/config.yml" \
          "$HOME/Library/Application Support/lazygit/config.yml"
fi
```

## What you get

- **zsh** — oh-my-zsh + zsh-autosuggestions, starship, zoxide, fzf, mise, aliases for `claude`, `lazygit`, dotfiles `config`, etc.
- **tmux** — catppuccin theme, custom statusline, and a `prefix + g` popup that lists every child `.git` repo under the current pane and opens lazygit on the chosen one (preview shows branch, ahead/behind, dirty status, recent commits).
- **lazygit** — `Ctrl+A` in the files panel pipes the staged diff and recent commits to `claude -p` to draft a commit message in the repo's existing style, then opens `$EDITOR` for review.
- **nvim** — LazyVim-based config under `.config/nvim-lyo`.
- **kitty**, **aerospace**, **skhd**, **yabai** — terminal and tiling window manager configs (Catppuccin Mocha across the board).

## External dependencies

The configs assume the following CLIs are on `$PATH`. Install whatever you don't already have:

- `tmux`, `lazygit`, `fzf`, `fd`, `zoxide`, `starship`, `mise`
- `claude` (Anthropic CLI) — required for the lazygit AI commit binding
- `gh` — used by the `gpr` alias
- `nvim`
