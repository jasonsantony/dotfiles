#!/usr/bin/env bash
# cycle-workspace-windows.sh
# -----------------------------------------------------------------------------
# Cycle through **all windows** (tiled + floating) in the CURRENT workspace.
# • Forward (default): ./cycle-workspace-windows.sh
# • Backward:          ./cycle-workspace-windows.sh prev
#
# Works on macOS's Bash 3.2 (no mapfile, no negative array indices).
# After focusing the next/prev window, we ALSO trigger a HazeOver dimming
# refresh via AppleScript — useful when AeroSpace itself sometimes skips the
# accessibility event that HazeOver listens for.
# -----------------------------------------------------------------------------
set -euo pipefail

# ─── Direction ────────────────────────────────────────────────────────────────

direction="next"
if [[ $# -ge 1 ]]; then
    case "$1" in
    prev | previous | back | reverse | -r) direction="prev" ;;
    esac
fi

# ─── State directory ─────────────────────────────────────────────────────────
state_dir="/tmp/aerospace-window-cycle"
mkdir -p "$state_dir"

# ─── Helper: read command output into array (Bash 3.2 compatible) ────────────
read_into_array() {
    local __name="$1"
    shift
    local __out
    __out=$("$@") || return 1
    eval "${__name}=()"
    local __line
    while IFS= read -r __line; do
        [[ -n "$__line" ]] && eval "${__name}+=(\"$__line\")"
    done <<<"$__out"
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

# ─── Restore last ID or seed with current focus -----------------------------
last_id=""
if [[ -f "$state_file" ]]; then
    tmp=$(cat "$state_file")
    if printf '%s\n' "${win_ids[@]}" | grep -qx "$tmp"; then
        last_id="$tmp"
    fi
fi

# Seed with currently focused ID if first run
if [[ -z "$last_id" ]]; then
    current_id=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null || true)
    if printf '%s\n' "${win_ids[@]}" | grep -qx "$current_id"; then
        last_id="$current_id"
    fi
fi

# ─── Select next / prev ------------------------------------------------------
select_next() {
    local _first="$1"
    shift
    local _arr=("$@")
    local _candidate="$_first"
    if [[ -n "$last_id" ]]; then
        for id in "${_arr[@]}"; do
            if [[ $id -gt $last_id ]]; then
                _candidate=$id
                break
            fi
        done
    fi
    printf '%s' "$_candidate"
}

select_prev() {
    local _last_default="$1"
    shift
    local _arr=("$@")
    local _candidate="$_last_default"
    if [[ -n "$last_id" ]]; then
        for ((idx = ${#_arr[@]} - 1; idx >= 0; idx--)); do
            id="${_arr[$idx]}"
            if [[ $id -lt $last_id ]]; then
                _candidate=$id
                break
            fi
        done
    fi
    printf '%s' "$_candidate"
}

first_elem="${win_ids[0]}"
last_elem="${win_ids[$((${#win_ids[@]} - 1))]}"

target_id=""
if [[ "$direction" == "prev" ]]; then
    target_id=$(select_prev "$last_elem" "${win_ids[@]}")
else
    target_id=$(select_next "$first_elem" "${win_ids[@]}")
fi

# ─── Focus and remember ------------------------------------------------------
if [[ -n "$target_id" ]]; then
    # Record the window that is focused *before* we change anything.
    before_id=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null || true)

    aerospace focus --window-id "$target_id"

    # Give macOS a few milliseconds to propagate focus; 40 ms is typically enough.
    sleep 0.04
    after_id=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null || true)

    # Only store state if the focus actually changed; this prevents the "first
    # press does nothing" issue when AeroSpace refuses or fails to change focus.
    if [[ "$after_id" != "$before_id" && -n "$after_id" ]]; then
        echo "$after_id" >"$state_file"
    fi

    # Always trigger HazeOver refresh regardless of success; harmless if nothing
    # changed, but helpful when focus *did* move.
    /usr/bin/osascript -e 'tell application "HazeOver" to updateDimming' &>/dev/null &
fi
