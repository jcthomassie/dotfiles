# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"

plugins=(
    brew
    colorize
    git
    osx
    zsh-autosuggestions
    zsh-completions
    zsh-syntax-highlighting
)

test -e "$ZSH/oh-my-zsh.sh" && source "$ZSH/oh-my-zsh.sh"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Amazon specific config
if [ $USER = "thomajl" ]; then
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
    alias bws-sync="bws sync --md"
    alias bws-pull="bball git pull --rebase --autostash"
    alias bws-update="bws-sync && bws-pull"
    alias bws-rebuild="bball 'brazil-build clean && brazil-build release'"
    alias cdsk="midway && ssh ${CLOUD_DESK_DNS}"
    alias nds-add="ninja-dev-sync-add"
    alias nds="ninja-dev-sync"
fi

alias cls="clear"
alias zshconfig="code -n -w ~/.zshrc && source ~/.zshrc"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
