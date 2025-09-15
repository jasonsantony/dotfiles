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

# ---- History options (interactive only) ----
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
# Jason's toolbox
alias l='ls -lah --color=auto'
alias vim='nvim' # open vim with vi
alias python='python3'
alias pip='pip3'
alias lg='lazygit'
# Dotfile stuff
alias dot='cd ~/dotfiles'
alias dotlg='cd ~/dotfiles && lazygit'
# Better defaults
alias grep='grep --color=auto'
alias neofetch='neofetch --ascii "$HOME/.config/neofetch/nerv.txt" --ascii_distro off'
alias ytmp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" -o "%(title)s.%(ext)s" --merge-output-format mp4'
# Safety first
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
# a e s t h e t i c s
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# ---- System tweaks ----
ulimit -s unlimited 2>/dev/null || true

# ---- FZF shell integration ----
command -v fzf >/dev/null && source <(fzf --zsh)

# ---- Functions ----
# Aerospace window fzf
ff() {
  # Check dependencies
  if ! command -v aerospace >/dev/null 2>&1; then
    echo "Error: 'aerospace' not found in PATH." >&2
    return 1
  fi

  if ! command -v fzf >/dev/null 2>&1; then
    echo "Error: 'fzf' not found in PATH." >&2
    return 1
  fi

  aerospace list-windows --all |
    fzf --bind 'enter:execute(zsh -c "aerospace focus --window-id {1}")+abort'
}

# Volume helper
volume() {
  if [[ -z "$1" ]]; then
    local current muted
    current=$(osascript -e 'output volume of (get volume settings)')
    muted=$(osascript -e 'output muted of (get volume settings)')
    [[ "$muted" == "true" ]] && echo "Volume: ${current}% (muted)" || echo "Volume: ${current}%"
  elif [[ "$1" == "m" ]]; then
    local muted
    muted=$(osascript -e 'output muted of (get volume settings)')
    if [[ "$muted" == "true" ]]; then
      osascript -e "set volume output muted false"
      echo "Unmuted"
    else
      osascript -e "set volume output muted true"
      echo "Muted"
    fi
  elif [[ "$1" =~ ^[0-9]+$ ]] && (($1 >= 0 && $1 <= 100)); then
    osascript -e "set volume output volume $1" -e "set volume output muted false"
    echo "Volume: ${1}%"
  else
    echo "Usage: vol [0-100|m]   (no args → show status, m → toggle mute)"
  fi
}
alias vol='volume'

# ---- Starship ----
eval "$(starship init zsh)"
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

# ---- Homebrew zsh plugins ----
# Autosuggestions
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  bindkey '^ ' autosuggest-accept
  bindkey -r '^E'
  bindkey '^E' end-of-line
fi

# Syntax highlighting (keep near bottom)
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
