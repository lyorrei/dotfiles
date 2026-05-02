#!/usr/bin/env bash
# Preview helper for lg-pick. Receives repo path as $1.
set -e

repo="$1"
[ -d "$repo/.git" ] || [ -f "$repo/.git" ] || exit 0
cd "$repo"

name=$(basename "$repo")

printf '\n'
printf '   \033[1;35m󰊢 %s\033[0m\n' "$name"
printf '   \033[2;37m%s\033[0m\n' "$repo"
printf '\n'

branch=$(git symbolic-ref --short HEAD 2>/dev/null || git rev-parse --short HEAD 2>/dev/null || echo '?')
printf '   \033[33m\033[0m  on \033[1;36m%s\033[0m' "$branch"

if ahead_behind=$(git rev-list --left-right --count '@{u}...HEAD' 2>/dev/null); then
  behind=$(echo "$ahead_behind" | cut -f1)
  ahead=$(echo "$ahead_behind" | cut -f2)
  [ "$ahead" != '0' ] && printf '   \033[32m↑%s\033[0m' "$ahead"
  [ "$behind" != '0' ] && printf '  \033[31m↓%s\033[0m' "$behind"
fi
printf '\n'

dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')
if [ "$dirty" != '0' ]; then
  printf '   \033[1;31m %s changed\033[0m\n' "$dirty"
else
  printf '   \033[1;32m clean\033[0m\n'
fi

printf '\n   \033[2;35m── recent ─────────────\033[0m\n\n'
git log --color=always -10 \
  --pretty=format:'   %C(yellow)%h  %C(cyan)%<(12,trunc)%ar  %C(reset)%<(60,trunc)%s%C(magenta)%d' 2>/dev/null
printf '\n'
