#!/bin/bash
# Claude Code statusline - mirrors p10k rainbow style

input=$(cat)

# Extract fields from JSON
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')
current_dir=$(echo "$input" | jq -r '.workspace.current_dir // ""')
context_pct=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Shorten directory with tilde for home
short_dir="${current_dir/#$HOME/\~}"

# Git branch (if in repo)
git_branch=""
if [ -n "$current_dir" ] && [ -d "$current_dir/.git" ] || git -C "$current_dir" rev-parse --git-dir >/dev/null 2>&1; then
    git_branch=$(git -C "$current_dir" branch --show-current 2>/dev/null)
fi

# Kube context (shortened - last segment)
kube_ctx=""
if command -v kubectl &>/dev/null; then
    kube_ctx=$(kubectl config current-context 2>/dev/null | awk -F/ '{print $NF}')
fi

# AWS profile
aws_profile=${AWS_PROFILE:-}

# Nerd font glyphs
icon_branch=$'\uf126'
icon_kube=$'\u2388'
icon_aws=$'\uf270'
bubble_left=$'\ue0b6'
bubble_right=$'\ue0b4'

# Colors (256-color)
esc=$'\033'
reset=$'\033[0m'

# Bubble helper: bubble "bg" "fg" "content"
bubble() {
    local bg=$1 fg=$2 content=$3
    echo -n "${esc}[38;5;${bg}m${bubble_left}${esc}[48;5;${bg}m${esc}[38;5;${fg}m${content}${esc}[0m${esc}[38;5;${bg}m${bubble_right}${reset}"
}

# Group 1: dir + git (blue bg=4, white fg=254)
group1="${esc}[38;5;254m${short_dir}"
[ -n "$git_branch" ] && group1+=" ${icon_branch} ${git_branch}"

# Group 2: kube + aws (magenta bg=5, white fg=7)
group2=""
[ -n "$kube_ctx" ] && group2+="${icon_kube} ${kube_ctx}"
[ -n "$kube_ctx" ] && [ -n "$aws_profile" ] && group2+=" "
[ -n "$aws_profile" ] && group2+="${icon_aws} ${aws_profile}"

# Group 3: model + context
# Bubble bg color (atom one dark): green <70%, yellow 70-94%, red 95%+
if [ "$context_pct" -ge 95 ]; then
    ctx_bg="168"  # red (#e06c75)
elif [ "$context_pct" -ge 70 ]; then
    ctx_bg="180"  # yellow (#e5c07b)
else
    ctx_bg="114"  # green (#98c379)
fi
group3="${model} • ${context_pct}%"

# Build output
output=""
# Group 1 bubble (custom colors inside)
output+="${esc}[38;5;4m${bubble_left}${esc}[48;5;4m ${group1} ${esc}[0m${esc}[38;5;4m${bubble_right}${reset}"
[ -n "$group2" ] && output+=" $(bubble 5 7 " ${group2} ")"
# Group 3 bubble (bg color based on context %)
output+=" ${esc}[38;5;${ctx_bg}m${bubble_left}${esc}[48;5;${ctx_bg}m${esc}[38;5;0m ${group3} ${esc}[0m${esc}[38;5;${ctx_bg}m${bubble_right}${reset}"

echo "$output"
