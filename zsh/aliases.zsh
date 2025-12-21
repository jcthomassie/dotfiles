#!/bin/zsh
alias reload="exec zsh -l"
alias dots="${EDITOR:-nvim} $DOTS_REPO_ROOT && reload"

# Git
alias ga="git add"
alias gb="git branch"
alias gba="git branch --all"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gcan="git commit --amend --no-edit"
alias gd="git diff"
alias gdp="git diff HEAD^"
alias gf="git fetch"
alias gfa="git fetch --all"
alias gfp="git fetch --prune"
alias gl="git log"
alias glog="git log --oneline --decorate --graph"
alias gm="git merge"
alias gp="git pull"
alias gpa="git pull --autostash"
alias gpr="git pull --rebase"
alias gpra="git pull --rebase --autostash"
alias gr="git rebase"
alias gri="git rebase -i"
alias gs="git status"
alias gt="git tag"

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

