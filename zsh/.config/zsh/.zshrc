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
# - This is where you put user-facing tweaks (colors, completions, keybinds).
# - Do NOT put global env vars here; those belong in ~/.zshenv or ~/.zprofile.
# ============================

# Ensure parent dirs for tools that won't create them
# Tentatively: Git, Oh My Zsh, Python, Less, Go, npm, IPython, Jupyter
# Rust toolchain is self-managing, no mkdir
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

ZSH_THEME=""
plugins=(git history-substring-search)
source $ZSH/oh-my-zsh.sh

### --- Prompt ---
setopt prompt_subst

# ---- History options (interactive only) ----
bindkey -M viins '^P' up-history
bindkey -M viins '^N' down-history
bindkey -M vicmd '^P' up-history
bindkey -M vicmd '^N' down-history
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
setopt incappendhistory  # write commands immediately
setopt sharehistory      # share across sessions
setopt histignorealldups # drop older duplicates
setopt histreduceblanks  # trim extra spaces
setopt histignorespace   # lines starting with space aren’t saved
mkdir -p -- "${HISTFILE:h}"

# ---- Aliases ----
# General
alias vim='nvim' # use `vi` for classic vim
alias ls='gls -lah --color=auto'
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

# ---- FZF ----
# Shell integration
source <(fzf --zsh)

# ---- Starship ----
eval "$(starship init zsh)"

# ---- Zoxide ----
eval "$(zoxide init --cmd cd zsh)"

# Vi mode
bindkey -v
# Insert mode bindings (like a normal editor)
bindkey -M viins '^H' backward-delete-char # ⌫ backspace
bindkey -M viins '^?' backward-delete-char # ⌫ backspace alt encoding
bindkey -M viins '^[[3~' delete-char       # ⌦ forward delete
# Normal mode bindings (vim-like)
bindkey -M vicmd '^[[3~' delete-char # ⌦ works like 'x'
# Map "jk" in insert mode to Escape
bindkey -M viins 'jk' vi-cmd-mode

# Syntax highlighting (keep near bottom)
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept
bindkey -r '^E'
bindkey '^E' end-of-line

# Autopair
source $(brew --prefix)/share/zsh-autopair/autopair.zsh

# History navigation
bindkey -M viins '^P' history-substring-search-up
bindkey -M viins '^N' history-substring-search-down
bindkey -M vicmd '^P' history-substring-search-up
bindkey -M vicmd '^N' history-substring-search-down
