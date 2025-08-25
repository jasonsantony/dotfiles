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

# PATH for login shells
export PATH="/opt/homebrew/bin:$PATH"

# terminal editor defaults (vim for quick edits / CLI tools)
export EDITOR="vim"
export VISUAL="vim"

# locale (optional)
export LANG="en_US.UTF-8"

