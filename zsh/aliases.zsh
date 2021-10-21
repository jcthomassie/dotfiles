#!/bin/zsh
alias cls="clear"
alias dots="code $DOTS_REPO_ROOT"
alias glog="git log --oneline --decorate --graph"
alias zshrc="code -n -w $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"
alias zshrel="zsh_reload"

# Handle Ubuntu batcat -> bat
if type "batcat" > /dev/null; then
    alias bat="batcat"
fi

# Use exa if available
if type "exa" > /dev/null; then
    alias ls="exa"
    alias la="exa -a"
    alias ll="exa -la"
    alias lt="exa -T --level 2"
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
alias cls="clear"
alias glog="git log --oneline --decorate --graph"
alias zshrc="code -n -w $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"
alias zshrel="zsh_reload"
alias dots="code $DOTS_REPO_ROOT"

# Amazon specific config
if [ $USER = "thomajl" ]; then
    alias auth="mwinit -o -s"
    alias ada-token="ada cred print | grep_json SessionToken"
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
    alias nds="ninja-dev-sync"
fi
