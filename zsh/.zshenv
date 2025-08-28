# ============================
# ~/.zshenv
# ----------------------------
# This file is sourced by *every* zsh, no matter how it's started
# (login, interactive, script, etc.).
#
# Notes:
# - Keep this file minimal and fast. It's loaded even when running zsh scripts.
# - Do NOT put aliases, functions, or interactive settings here.
# ============================

# XDG base dirs (fallbacks so we don't overwrite existing values)
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Make zsh load the rest of its configs from ~/.config/zsh
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"

# Homebrew (Apple Silicon macOS) — official, idempotent
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Tool-specific env that should exist for all shells
export PYTHONHISTFILE="$XDG_STATE_HOME/python/history"   # persistent state
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"       # ephemeral-ish

# Rust toolchain (XDG-friendly)
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
if [[ -r "$CARGO_HOME/env" ]]; then
  # This sets RUSTUP variables and may add completion helpers
  . "$CARGO_HOME/env"
fi


# Git global config path
export GIT_CONFIG_GLOBAL="${GIT_CONFIG_GLOBAL:-$XDG_CONFIG_HOME/git/config}"

