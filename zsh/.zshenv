# ============================
# ~/.zshenv
# ----------------------------
# This file is sourced by *every* zsh that starts
# (login, interactive, script, etc.).
#
# Notes:
# - Does {x} really need to be run for every zsh?
#   Including *scripts*???
# ============================

# --- Point zsh to other configs
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
export ZDOTDIR="${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}"
