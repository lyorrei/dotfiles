#!/usr/bin/env bash
set -e

dir="${1:-$PWD}"
name="nvim-$(basename "$dir")-$(printf %s "$dir" | shasum | cut -c1-6)"

exec tmux new-session -A -s "$name" -c "$dir" nvim
