#!/usr/bin/env bash
set -e

root="${1:-$PWD}"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

STATE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/lg-pick"
STATE_FILE="$STATE_DIR/recent"
mkdir -p "$STATE_DIR"
touch "$STATE_FILE"

# Catppuccin Mocha
FZF_THEME="
  --color=bg+:#1e1e2e,bg:-1,spinner:#f5e0dc,hl:#f38ba8
  --color=fg:#cdd6f4,header:#f38ba8,info:#6c7086,pointer:#cba6f7
  --color=marker:#b4befe,fg+:#f5e0dc,prompt:#cba6f7,hl+:#f38ba8
  --color=border:#45475a,gutter:-1,separator:#45475a,scrollbar:#45475a
  --color=preview-fg:#cdd6f4,preview-bg:-1
"

# List repos ordered by recency (recents from STATE_FILE first, then alpha for the rest)
list_repos() {
  local all_file
  all_file=$(mktemp)
  fd -H -t d -d 3 '^\.git$' "$root" --prune 2>/dev/null \
    | xargs -n1 dirname \
    | sed "s|^$root/||" \
    | sort > "$all_file"

  awk '
    NR == FNR { avail[$0] = 1; next }
    ($0 in avail) && !($0 in seen) { print; seen[$0] = 1 }
    END {
      for (r in avail) if (!(r in seen)) print r | "sort"
    }
  ' "$all_file" "$STATE_FILE"

  rm -f "$all_file"
}

bump_recent() {
  local repo="$1"
  local tmp
  tmp=$(mktemp)
  printf '%s\n' "$repo" > "$tmp"
  grep -vxF -- "$repo" "$STATE_FILE" >> "$tmp" 2>/dev/null || true
  head -n 100 "$tmp" > "$STATE_FILE"
  rm -f "$tmp"
}

query=''
while true; do
  result=$(list_repos \
    | fzf \
        --print-query \
        --query="$query" \
        --prompt='󰊢  ' \
        --pointer='▌ ' \
        --info=inline:'  ·  ' \
        --header='' \
        --no-separator \
        --border=none \
        --padding=1,3 \
        --margin=0 \
        --preview-window='right,55%,border-left,wrap' \
        --preview="$SCRIPT_DIR/lg-preview.sh '$root/{}'" \
        --preview-label=' preview ' \
        --preview-label-pos=3 \
        --height=100% \
        --reverse \
        --no-scrollbar \
        --no-sort \
        --ansi \
        $FZF_THEME) || exit 0

  query=$(printf '%s\n' "$result" | sed -n '1p')
  repo=$(printf '%s\n' "$result" | sed -n '2p')

  [ -n "$repo" ] || exit 0
  bump_recent "$repo"
  lazygit -p "$root/$repo" || true
done
