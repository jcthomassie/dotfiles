# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:$HOME/.cargo/bin"
export DF_COMPLETIONS="$ZDOTDIR/completions"
export DF_FUNCTIONS="$ZDOTDIR/functions"
export ZSH_CACHE_DIR="$HOME/.cache"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
export HOMEBREW_BREWFILE="$DF_REPO_ROOT/.brewfile"
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="no=00:fi=00:di=01;36:ln=00;35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;31"
# Amazon specific variables
if [ $USER = "thomajl" ]; then
  export PATH="/usr/local/opt/curl/bin:$HOME/.toolbox/bin:/usr/local/bin/mwinit:$PATH"
  export CLOUD_DESK_DNS="thomajl-clouddesk.aka.corp.amazon.com"
  export LOCAL_WORKSPACE="/Users/thomajl/workplace"
  export CLOUD_WORKSPACE="/home/thomajl/workplace"
  export AWS_DEFAULT_REGION="us-east-1"
fi

# Customize plugins
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=yellow
ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Specify plugins
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)

# Load plugins
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
for plugin ($plugins); do
  fpath=( $ZDOTDIR/plugins/$plugin $fpath )
  source $ZDOTDIR/plugins/$plugin/$plugin.plugin.zsh
done

# Load customizations
source $ZDOTDIR/.p10k.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/completion.zsh

# Load functions and completions
fpath=( $DF_COMPLETIONS $DF_FUNCTIONS $fpath )
autoload -U $fpath[1]/*(.:t)
autoload -U $fpath[2]/*(.:t)
autoload -U colors && colors
autoload -U compinit && compinit -i -d "${ZSH_COMPDUMP}"
