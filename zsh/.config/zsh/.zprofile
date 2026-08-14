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
