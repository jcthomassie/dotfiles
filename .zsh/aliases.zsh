if [[ $OSTYPE == darwin* ]]; then
    alias ls="ls -G"
else
    alias ls="ls --color=auto"
fi
# Handle Ubuntu batcat -> bat
if type "batcat" > /dev/null; then
    alias bat="batcat"
fi

alias la="ls -AFh"
alias ld="ls -d -- */ .*/"
alias ll="ls -lAFh"
alias cls="clear"
alias glog="git log --oneline --decorate --graph"
alias zshrc="code -n -w $ZDOTDIR/.zshrc && source $ZDOTDIR/.zshrc"
alias zshrel="zsh_reload"
alias dots="code $DF_REPO_ROOT"

# Amazon specific config
if [ $USER = "thomajl" ]; then
    alias auth="kinit && mwinit -o"
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
