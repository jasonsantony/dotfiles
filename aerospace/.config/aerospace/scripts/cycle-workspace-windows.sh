#!/usr/bin/env bash
# cycle-workspace-windows.sh
# -----------------------------------------------------------------------------
# Cycle through **all windows** (tiled + floating) in the CURRENT workspace.
# • Forward (default): ./cycle-workspace-windows.sh
# • Backward:          ./cycle-workspace-windows.sh prev
#
# Works on macOS's Bash 3.2 (no mapfile, no negative array indices).
# -----------------------------------------------------------------------------
set -euo pipefail

# ─── Direction ────────────────────────────────────────────────────────────────

direction="next"
if [[ $# -ge 1 ]]; then
  case "$1" in
    prev|previous|back|reverse|-r) direction="prev" ;;
  esac
fi

# ─── State directory ─────────────────────────────────────────────────────────
state_dir="/tmp/aerospace-window-cycle"
mkdir -p "$state_dir"

# ─── Helper: read command output into array (Bash 3.2 compatible) ────────────
read_into_array() {
  local __name="$1"; shift
  local __out
  __out=$("$@") || return 1
  eval "${__name}=()"
  local __line
  while IFS= read -r __line; do
    [[ -n "$__line" ]] && eval "${__name}+=(\"$__line\")"
  done <<< "$__out"
}

# ─── Clean up orphaned state files -------------------------------------------
read_into_array live_ws aerospace list-workspaces --all --format '%{workspace}'
for f in "$state_dir"/*; do
  [[ -e $f ]] || continue
  ws_id=$(basename "$f")
  if ! printf '%s\n' "${live_ws[@]}" | grep -qx "$ws_id"; then
    rm -f "$f"
  fi
done

# ─── Identify focused workspace ---------------------------------------------
focused_ws=$(aerospace list-workspaces --focused --format '%{workspace}')
state_file="$state_dir/$focused_ws"

# ─── Collect ALL window IDs in focused workspace ----------------------------
read_into_array win_ids aerospace list-windows --workspace focused --format '%{window-id}'
IFS=$'\n' win_ids=($(printf '%s\n' "${win_ids[@]}" | sort -n))

# Exit if no windows
if [[ ${#win_ids[@]} -eq 0 ]]; then
  rm -f "$state_file" 2>/dev/null || true
  exit 0
fi

# ─── Restore last ID if valid ------------------------------------------------
last_id=""
if [[ -f "$state_file" ]]; then
  tmp=$(cat "$state_file")
  if printf '%s\n' "${win_ids[@]}" | grep -qx "$tmp"; then
    last_id="$tmp"
  fi
fi

# ─── Select next / prev ------------------------------------------------------
select_next() {
  local _first="$1"; shift
  local _arr=("$@")
  local _candidate="$_first"
  if [[ -n "$last_id" ]]; then
    for id in "${_arr[@]}"; do
      if [[ $id -gt $last_id ]]; then
        _candidate=$id; break
      fi
    done
  fi
  printf '%s' "$_candidate"
}

select_prev() {
  local _last_default="$1"; shift
  local _arr=("$@")
  local _candidate="$_last_default"
  if [[ -n "$last_id" ]]; then
    for ((idx=${#_arr[@]}-1; idx>=0; idx--)); do
      id="${_arr[$idx]}"
      if [[ $id -lt $last_id ]]; then
        _candidate=$id; break
      fi
    done
  fi
  printf '%s' "$_candidate"
}

first_elem="${win_ids[0]}"
last_index=$(( ${#win_ids[@]} - 1 ))
last_elem="${win_ids[$last_index]}"

if [[ "$direction" == "prev" ]]; then
  target_id=$(select_prev "$last_elem" "${win_ids[@]}")
else
  target_id=$(select_next "$first_elem" "${win_ids[@]}")
fi

# ─── Focus and remember ------------------------------------------------------
if [[ -n "$target_id" ]]; then
  aerospace focus --window-id "$target_id"
  echo "$target_id" > "$state_file"
fi
