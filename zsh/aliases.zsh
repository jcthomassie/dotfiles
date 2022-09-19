#!/bin/zsh
alias reload="exec zsh -l"
alias dots="$EDITOR $DOTS_REPO_ROOT && reload"

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

# Use exa if available
if type "exa" > /dev/null; then
    alias ls="exa"
    alias la="exa -a"
    alias ll="exa -l"
    alias lt="exa -T --git-ignore --level 2"
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

# Amazon specific config
if [ $USER = "thomajl" ]; then
    alias auth="(klist -s || kinit) && midway"
    alias bb="brazil-build"
    alias bba="brazil-build apollo-pkg"
    alias bball="brc --allPackages"
    alias bbb="brc --allPackages brazil-build"
    alias bbr="brc brazil-build"
    alias bbra="bbr apollo-pkg"
    alias brc="brazil-recursive-cmd"
    alias bre="brazil-runtime-exec"
    alias bws="brazil ws"
    alias bws-sync="bws sync --md"
    alias bws-pull="bball git pull --rebase --autostash"
    alias bws-update="bws-sync && bws-pull"
    alias bws-rebuild="bball 'brazil-build clean && brazil-build release'"
    alias cdsk="midway && ssh ${CLOUD_DESK_DNS}"
    alias cdsk-tunnel="midway && ssh -L 8157:localhost:8157 ${CLOUD_DESK_DNS} -N"
    alias nds="ninja-dev-sync"
    alias sam="brazil-build-tool-exec sam"
    alias sbt='sbt -java-home $(brazil-path tooldirect.jdk)'
fi
