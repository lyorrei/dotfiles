#!/usr/bin/env bash
set -e

if [ -z "$(git diff --cached --name-only)" ]; then
  echo "No staged changes. Stage files first (space)."
  sleep 1.5
  exit 1
fi

branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "")
recent=$(git log -30 --no-merges --pretty=format:"%s" 2>/dev/null || echo "")
diff=$(git diff --cached)

prompt="You are writing a git commit message for this repository. Match the existing style of the recent commits below (language, tone, scope usage, ticket prefixes, length, formality). Default to Conventional Commits (feat/fix/chore/docs/refactor/test/style/perf/build/ci) only if the recent commits use it. Rules: subject under 72 chars, imperative mood, no trailing period. If the diff is small and single-purpose, output ONLY the subject line. If complex, add a blank line then a short body (bullets when listing changes). Current branch: ${branch}. Output the commit message and nothing else - no quotes, no explanation, no markdown fences."

input=$(printf "STYLE REFERENCE - recent commits:\n%s\n\nSTAGED DIFF:\n%s\n" "$recent" "$diff")

echo " Asking Claude for a commit message..."
msg=$(printf "%s" "$input" | claude -p "$prompt")

if [ -z "$msg" ]; then
  echo "Claude returned an empty message."
  sleep 1.5
  exit 1
fi

tmpfile=$(mktemp -t lazygit-ai-commit.XXXXXX)
trap 'rm -f "$tmpfile"' EXIT
printf "%s\n" "$msg" > "$tmpfile"

editor="${GIT_EDITOR:-${VISUAL:-${EDITOR:-vim}}}"
$editor "$tmpfile"

# Strip blank lines at end and check non-empty
final=$(sed -e '/^[[:space:]]*$/d' -e '/^#/d' "$tmpfile")
if [ -z "$final" ]; then
  echo "Aborting: empty commit message."
  exit 1
fi

if git commit -F "$tmpfile"; then
  echo
  echo "✓ Committed."
  sleep 0.6
else
  echo
  echo "✗ Commit failed. Press Enter."
  read -r _
  exit 1
fi
