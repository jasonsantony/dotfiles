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
# Better defaults
alias grep='grep --color=auto'
alias ytmp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" -o "%(title)s.%(ext)s" --merge-output-format mp4'
# Safety first
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
# MacOS defaults
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
alias keyrepeat='defaults write NSGlobalDomain "ApplePressAndHoldEnabled" -bool "false"'
alias keyhold='defaults delete NSGlobalDomain "ApplePressAndHoldEnabled"'

# --- Package init ---
# FZF
source <(fzf --zsh)

# Starship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# Syntax highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Autopair
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

# Vi mode
source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
