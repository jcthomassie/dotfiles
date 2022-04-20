# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="$PATH:$HOME/.cargo/bin"
export YURT_BUILD_FILE="$DOTS_REPO_ROOT/build.yaml"
export ZSH_CACHE_DIR="$HOME/.cache"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
export ZSH_HISTORY="$HOME/.zsh_history"
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
# Include scripts if installed
if [[ -d "$HOME/scripts/bin" ]]; then
  export PATH="$HOME/scripts/bin:$PATH"
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

HISTFILE="$ZSH_HISTORY"
HISTSIZE=1000000
SAVEHIST=1000000
setopt BANG_HIST              # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY       # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS       # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS   # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_SPACE      # Don't record an entry starting with a space.
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.
setopt HIST_SAVE_NO_DUPS      # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS     # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY            # Don't execute immediately upon history expansion.
setopt HIST_BEEP              # Beep when accessing nonexistent history.

# Specify plugins
plugins=(
  zsh-syntax-highlighting
  zsh-autosuggestions
  zsh-completions
)

# Load plugins
type "pyenv" > /dev/null && eval "$(pyenv init -)"
type "rbenv" > /dev/null && eval "$(rbenv init -)"
type "zoxide" > /dev/null && eval "$(zoxide init zsh)"
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
COMPDIR="$ZDOTDIR/completions"
FUNCDIR="$ZDOTDIR/functions"
fpath=( $COMPDIR $FUNCDIR $fpath )
autoload -U $COMPDIR/*(.:t)
autoload -U $FUNCDIR/*(.:t)
autoload -U colors && colors
autoload -U compinit && compinit -i -d "${ZSH_COMPDUMP}"
