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

# Git global config path
export GIT_CONFIG_GLOBAL="${GIT_CONFIG_GLOBAL:-$XDG_CONFIG_HOME/git/config}"

# Make zsh load the rest of its configs from ~/.config/zsh
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
# Disable macOS Zsh sessions: use XDG STATE
export SHELL_SESSIONS_DISABLE=1

# Oh My Zsh location (XDG-friendly)
export ZSH="$XDG_DATA_HOME/oh-my-zsh"
# Use XDG cache for OMZ + completion
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

# History files
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
export PYTHONHISTFILE="$XDG_STATE_HOME/python/history" # persistent state
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"     # ephemeral-ish

# Homebrew clangd
if command -v brew >/dev/null 2>&1; then
  export PATH="$(brew --prefix llvm)/bin:$PATH"
fi

# Rust toolchain (XDG-friendly)
# No mkdir needed; self-managing
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

# Ensure parent dirs for tools that won't create them
# Tentatively: Git, Oh My Zsh, Python, Less, Go, npm, IPython, Jupyter
mkdir -p -- \
  "$XDG_CONFIG_HOME/git" \
  "$ZSH" \
  "$ZSH_CACHE_DIR" \
  "${ZSH_COMPDUMP:h}" \
  "$XDG_CACHE_HOME/zsh" \
  "${HISTFILE:h}" \
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
