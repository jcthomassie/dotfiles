# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$HOME/bin:$PATH"
export HOMEBREW_BREWFILE="$HOME/.brewfile"
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"

# Amazon specific config
if [ $USER = "thomajl" ]; then
    export PATH="/usr/local/opt/curl/bin:$HOME/.toolbox/bin:/usr/local/bin/mwinit:$PATH"
    export CLOUD_DESK_DNS="thomajl-clouddesk.aka.corp.amazon.com"
    export LOCAL_WORKSPACE="/Users/thomajl/workplace"
    export CLOUD_WORKSPACE="/home/thomajl/workplace"
fi

autoload -U colors && colors
autoload -Uz compinit && compinit -i

# Plugin customization
HYPHEN_INSENSITIVE="true"

typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=yellow
ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Initialize plugins
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source $ZDOTDIR/.p10k.zsh
source $ZDOTDIR/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-completions/zsh-completions.plugin.zsh
source $ZDOTDIR/.zsh_aliases
