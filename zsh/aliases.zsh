#!/bin/zsh
alias reload="exec zsh -l"
alias dots="${EDITOR:-nvim} $DOTS_REPO_ROOT && reload"

# Handle Ubuntu batcat -> bat
if type "batcat" > /dev/null; then
    alias bat="batcat"
fi

# Use eza if available
if type "eza" > /dev/null; then
    alias ls="eza"
    alias la="eza -a"
    alias ll="eza -l"
    alias lt="eza -T --git-ignore --level 2"
else
    if [[ $OSTYPE == darwin* ]]; then
        alias ls="ls -G"
    else
        alias ls="ls --color=auto"
    fi
    alias la="ls -AFh"
    alias ld="ls -d -- */ .*/"
    alias ll="ls -lAFh"
fi

if ! type "wezterm" > /dev/null && type "flatpak" > /dev/null; then
    alias wezterm='flatpak run org.wezfurlong.wezterm'
fi

if [[ "$TERM" == "wezterm" ]]; then
  alias ssh="TERM=xterm-256color ssh"
fi

