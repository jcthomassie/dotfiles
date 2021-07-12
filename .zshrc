export PATH="$HOME/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export HOMEBREW_BREWFILE="$HOME/.brewfile"

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=yellow
ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=white,underline
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"

plugins=(
    brew
    colorize
    git
    osx
    pip
    python
    zsh-autosuggestions
    zsh-syntax-highlighting
)

test -e "$ZSH/oh-my-zsh.sh" && source "$ZSH/oh-my-zsh.sh"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Amazon specific config
if [ $USER = "thomajl" ]
    export PATH="/usr/local/opt/curl/bin:$HOME/.toolbox/bin:/usr/local/bin/mwinit:$PATH"
    export CLOUD_DESK_DNS="thomajl-clouddesk.aka.corp.amazon.com"
    export LOCAL_WORKSPACE="/Users/thomajl/workplace"
    export CLOUD_WORKSPACE="/home/thomajl/workplace"

    alias auth="kinit && mwinit -o"
    alias bb="brazil-build"
    alias bba="brazil-build apollo-pkg"
    alias bball="brc --allPackages"
    alias bbb="brc --allPackages brazil-build"
    alias bbr="brc brazil-build"
    alias bbra="bbr apollo-pkg"
    alias brc="brazil-recursive-cmd"
    alias bre="brazil-runtime-exec"
    alias bws="brazil ws"
    alias bwscreate="bws create -n"
    alias bwsuse="bws use -p"
    alias cdsk="midway && ssh ${CLOUD_DESK}"
    alias nds="ninja-dev-sync"
    alias nds-add="ninja-dev-sync-add"
fi

alias cls="clear"
alias zshconfig="code -n -w ~/.zshrc && source ~/.zshrc"
alias zcfg=zshconfig
>>>>>>> baa62e1 (Add work config)
