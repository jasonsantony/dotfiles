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

# ---- Oh My Zsh ----
export ZSH="$HOME/.oh-my-zsh"

# Use XDG cache for OMZ + completion
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/oh-my-zsh"
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

# Ensure caches exist
mkdir -p "$ZSH_CACHE_DIR" "${ZSH_COMPDUMP:h}" "$XDG_CACHE_HOME/zsh"

# Theme + plugins
ZSH_THEME="robbyrussell"
plugins=(git)

# Load OMZ (runs compinit using $ZSH_COMPDUMP)
source "$ZSH/oh-my-zsh.sh"

# Speed: compile compdump when updated
if [[ -s "$ZSH_COMPDUMP" && (! -s "${ZSH_COMPDUMP}.zwc" || "$ZSH_COMPDUMP" -nt "${ZSH_COMPDUMP}.zwc") ]]; then
  zcompile "$ZSH_COMPDUMP"
fi

# ---- History (interactive only) ----
export HISTFILE="$XDG_STATE_HOME/zsh/history"
export HISTSIZE=10000
export SAVEHIST=10000
mkdir -p "${HISTFILE:h}"

setopt incappendhistory  # write commands immediately
setopt sharehistory      # share across sessions
setopt histignorealldups # drop older duplicates
setopt histreduceblanks  # trim extra spaces
setopt histignorespace   # lines starting with space aren’t saved

# ---- Aliases / functions ----
alias python=python3
alias pip=pip3
alias c='cursor'
alias lg='lazygit'
alias todo='taskell'
alias cp='cp -i'
alias rm='rm -i'
alias mv='mv -i'
alias q='exit'
alias grep='grep --color=auto'
alias dotfiles='cd ~/dotfiles'
alias root='cd /'
alias neofetch='neofetch --ascii "$HOME/.config/neofetch/nerv.txt" --ascii_distro off'
alias ytmp4='yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]" -o "%(title)s.%(ext)s" --merge-output-format mp4'
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

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

# ---- System tweaks ----
ulimit -s unlimited 2>/dev/null || true

# ---- FZF shell integration ----
source <(fzf --zsh)

# ---- Autosuggestions ----
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

# ---- Syntax highlighting (keep near the end) ----
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
