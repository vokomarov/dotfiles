#!/bin/bash

# Read JSON input once
input=$(cat)

# Extract current directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Extract context percentage
ctx_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# "// empty" produces no output when rate_limits is absent
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
WEEK=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
FIVE_H_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
WEEK_RESET=$(echo "$input" | jq -r '.rate_limits.seven_day.resets_at // empty')

time_left() {
  local reset_at="$1"
  [ -z "$reset_at" ] && return
  local diff_s
  diff_s=$(( reset_at - $(date +%s) ))
  [ "$diff_s" -le 0 ] && return
  local d=$(( diff_s / 86400 ))
  local h=$(( (diff_s % 86400) / 3600 ))
  local m=$(( (diff_s % 3600) / 60 ))
  local result=""
  [ "$d" -gt 0 ] && result="${d}d"
  [ "$h" -gt 0 ] && result="${result:+$result }${h}h"
  [ "$m" -gt 0 ] && result="${result:+$result }${m}m"
  [ -n "$result" ] && printf " [%s]" "$result"
}

rate_color() {
  local pct
  pct=$(printf '%.0f' "$1")
  if [ "$pct" -ge 90 ]; then
    printf '\033[01;31m'
  elif [ "$pct" -ge 70 ]; then
    printf '\033[01;33m'
  else
    printf '\033[01;32m'
  fi
}

# Git information
if git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1; then
  # Get repo name (just the directory name)
  repo_name=$(basename "$cwd")

  # Color the context percentage based on usage
  if [ "$ctx_pct" -ge 60 ]; then
    ctx_color='\033[01;31m' # red
  elif [ "$ctx_pct" -ge 40 ]; then
    ctx_color='\033[01;33m' # yellow
  else
    ctx_color='\033[01;32m' # green
  fi

  LIMITS=""
  if [ -n "$FIVE_H" ]; then
    LIMITS="5h: $(rate_color "$FIVE_H")$(printf '%.0f' "$FIVE_H")%\033[00m$(time_left "$FIVE_H_RESET")"
  fi
  if [ -n "$WEEK" ]; then
    LIMITS="${LIMITS:+$LIMITS }| 7d: $(rate_color "$WEEK")$(printf '%.0f' "$WEEK")%\033[00m$(time_left "$WEEK_RESET")"
  fi

  printf '\033[01;36m%s\033[00m | ctx: %b%s%%\033[00m | %b' \
    "$repo_name" "$ctx_color" "$ctx_pct" "$LIMITS"
else
  LIMITS=""
  [ -n "$FIVE_H" ] && LIMITS="5h: $(printf '%.0f' "$FIVE_H")%$(time_left "$FIVE_H_RESET")"
  [ -n "$WEEK" ] && LIMITS="${LIMITS:+$LIMITS }7d: $(printf '%.0f' "$WEEK")%$(time_left "$WEEK_RESET")"

  printf '\033[01;36m%s\033[00m | ctx: %s%% | %s' "$cwd" "$ctx_pct" "$LIMITS"
fi
