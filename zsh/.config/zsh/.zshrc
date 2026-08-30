# ============================
# ~/.config/zsh/.zshrc
# ----------------------------
# This file is sourced by *interactive shells* (any shell with a prompt).
#
# Purpose:
# - Customize your shell experience (prompt, aliases, plugins, functions).
# - Load frameworks like Oh My Zsh.
#
# Notes:
# - This is where to put user-facing tweaks (colors, completions, keybinds).
# - Try not to put global env vars here.
# - Interactive-specific env vars are fine.
# ============================

source $ZSH/oh-my-zsh.sh

setopt prompt_subst

# --- Interactive history options ---
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt incappendhistory  # write commands immediately
setopt sharehistory      # share across sessions
setopt histignorealldups # drop older duplicates
setopt histreduceblanks  # trim extra spaces
setopt histignorespace   # lines starting with space aren’t saved
mkdir -p "${HISTFILE:h}"

# --- Aliases ---
# General
alias home='cd; clear'
alias vim='nvim'
alias python='python3'
alias pip='pip3'
alias lg='lazygit'
# Dotfile stuff
alias dot='cd ~/dotfiles'
alias dotlg='cd ~/dotfiles && lazygit'
# MacOS defaults
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias keyrepeat='defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"'
alias keyhold='defaults delete NSGlobalDomain "ApplePressAndHoldEnabled"'
alias nodock='defaults write com.apple.dock "autohide-delay" -float "100.0" && killall Dock'
alias dock='defaults write com.apple.dock "autohide-delay" -float "0.2" && killall Dock'

# --- Package init ---
# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Yazi
function y() {
	local tmp cwd; tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd" || builtin true
	command rm -f -- "$tmp"
}

# Homebrew zsh niceties
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
