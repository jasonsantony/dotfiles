# ============================
# ~/.config/zsh/.zprofile
# ----------------------------
# This file is sourced only by *login shells* (the first shell you get
# when you log in, or when Terminal.app is set to "login shell").
#
# Purpose:
# - Set up environment that should apply once per login session
#   (e.g. PATH, LANG, EDITOR).
#
# Notes:
# - Runs before ~/.zshrc, but only once at login.
# - Good place for system-wide env setup, not per-interactive tweaks.
# ============================

# Terminal editor defaults
export EDITOR="nvim"
export VISUAL="nvim"

# Initialize Homebrew (Apple Silicon)
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# --- WE LOVE THE XDG BASE DIRECTORY SPECIFICATION ---

# XDG base dirs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-$HOME/.cache}"
export XDG_DATA_HOME="${XDG_DATA_HOME:-$HOME/.local/share}"
export XDG_STATE_HOME="${XDG_STATE_HOME:-$HOME/.local/state}"

# Git global config path
export GIT_CONFIG_GLOBAL="${GIT_CONFIG_GLOBAL:-$XDG_CONFIG_HOME/git/config}"

# Make zsh load the rest of its configs from ~/.config/zsh
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
# Disable macOS Zsh sessions: use XDG STATE
export SHELL_SESSIONS_DISABLE=1

# Build path for zsh compdump
export ZSH_COMPDUMP="${ZSH_COMPDUMP:-$XDG_CACHE_HOME/zsh/zcompdump}"

# Oh My Zsh
export ZSH="$ZDOTDIR/ohmyzsh"

# Starship config
export STARSHIP_CONFIG="${STARSHIP_CONFIG:-$XDG_CONFIG_HOME/starship/starship.toml}"

# History files
export PYTHONHISTFILE="$XDG_STATE_HOME/python/history" # persistent state
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"     # ephemeral-ish

# Rust toolchain (XDG-friendly)
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"
export PATH="$CARGO_HOME/bin:$PATH"

# Go toolchain (XDG-friendly)
export GOPATH="${GOPATH:-$XDG_DATA_HOME/go}"
export PATH="$GOPATH/bin:$PATH"

# Node / npm (not XDG by default)
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export NPM_CONFIG_CACHE="$XDG_CACHE_HOME/npm"
export NPM_CONFIG_PREFIX="$XDG_DATA_HOME/npm"
export PATH="$NPM_CONFIG_PREFIX/bin:$PATH"

# IPython (falls back to ~/.ipython if unset)
export IPYTHONDIR="$XDG_CONFIG_HOME/ipython"

# Jupyter (also falls back to ~/.jupyter if unset)
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME/jupyter"
export JUPYTER_DATA_DIR="$XDG_DATA_HOME/jupyter"
export JUPYTER_RUNTIME_DIR="$XDG_STATE_HOME/jupyter/runtime"

# Parent dirs for tools that won't create them
# Tentatively: Git, Oh My Zsh, Python, Less, Go, npm, IPython, Jupyter
mkdir -p -- \
  "$XDG_CONFIG_HOME/git" \
  "$XDG_CACHE_HOME/zsh" \
  "$XDG_CONFIG_HOME/starship" \
  "$XDG_STATE_HOME/python" \
  "$XDG_CACHE_HOME/less" \
  "$GOPATH" \
  "$GOPATH/bin" \
  "$XDG_CONFIG_HOME/npm" \
  "$XDG_CACHE_HOME/npm" \
  "$XDG_DATA_HOME/npm" \
  "$XDG_CONFIG_HOME/ipython" \
  "$XDG_CONFIG_HOME/jupyter" \
  "$XDG_DATA_HOME/jupyter" \
  "$JUPYTER_RUNTIME_DIR"
