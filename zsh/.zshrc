# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH_CACHE_DIR="$HOME/.cache"
export ZSH_COMPDUMP="$ZSH_CACHE_DIR/.zcompdump"
export ZSH_HISTORY="$HOME/.zsh_history"
export YURT_BUILD_FILE="$DOTS_REPO_ROOT/build.yaml"
export CLICOLOR=1
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS="no=00:fi=00:di=01;36:ln=00;35:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;31"

# Customize coloring
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[alias]=fg=cyan
ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,bold
ZSH_HIGHLIGHT_STYLES[globbing]=fg=yellow
ZSH_HIGHLIGHT_STYLES[path]=fg=white,underline,bold
ZSH_HIGHLIGHT_STYLES[path_prefix]=fg=white,underline
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=yellow
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# Customize history
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

# Load plugins
type "rbenv" > /dev/null && eval "$(rbenv init -)"
type "zoxide" > /dev/null && eval "$(zoxide init zsh --hook prompt)"
type "direnv" > /dev/null && eval "$(direnv hook zsh)"
source $ZDOTDIR/plugins/powerlevel10k/powerlevel10k.zsh-theme
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/plugins/zsh-completions/zsh-completions.plugin.zsh
fpath=( $ZDOTDIR/plugins/zsh-completions/src $fpath )

# Load customizations
source $ZDOTDIR/.p10k.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/completion.zsh

# Load completions
COMPDIR="$ZDOTDIR/completions"
fpath=( $COMPDIR $fpath )
autoload -U $COMPDIR/*(.:t)
autoload -U colors && colors
autoload -U compinit && compinit -i -d "${ZSH_COMPDUMP}"

# fzf-tab (must load after compinit)
source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
zstyle ':fzf-tab:complete:*' fzf-preview 'bat --color=always --style=numbers --line-range=:100 $realpath 2>/dev/null || eza --color=always --icons $realpath 2>/dev/null || echo $realpath'
zstyle ':fzf-tab:*' fzf-flags --height=15

bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# fzf configuration
export FZF_DEFAULT_OPTS="
  --height=15
  --layout=reverse
  --border=rounded
  --margin=0,1
  --prompt='  '
  --pointer='▶'
  --marker='✓'
  --info=inline-right
"
export FZF_CTRL_T_OPTS="
  --preview 'bat --color=always --style=numbers --line-range=:200 {} 2>/dev/null || eza --color=always --icons -la {} 2>/dev/null'
  --preview-window=right:50%:wrap
  --bind='ctrl-/:toggle-preview'
"

# Define hooks
_VENV_ROOT=".venv"
_VENV_PARENT=""
python_venv() {
  if [[ -d $_VENV_ROOT ]]; then
    _VENV_PARENT=$PWD
    source $_VENV_ROOT/bin/activate > /dev/null 2>&1
  elif ! ([[ $PWD == $_VENV_PARENT* ]] && [[ -d $_VENV_PARENT ]]); then
    _VENV_PARENT=""
    deactivate > /dev/null 2>&1
  fi
}
python_venv

add-zsh-hook chpwd python_venv

TRAPWINCH() {
  zle && zle reset-prompt
}

# fzf keybindings
[[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
[[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source $ZDOTDIR/plugins/fzf-git.sh/fzf-git.sh

# Custom fzf history widget with delete support (overrides default Ctrl+R)
fzf-history-widget() {
  fc -W
  local hfile="$HISTFILE"
  local reverse_cmd=$( (( $+commands[tac] )) && echo "tac" || echo "tail -r" )
  local clip_cmd=$( [[ "$OSTYPE" == darwin* ]] && echo "pbcopy" || echo "xclip -selection clipboard" )
  # LC_ALL=C ensures sed treats input as raw bytes (fixes BSD sed "illegal byte sequence" on macOS)
  local hist_cmd="LC_ALL=C sed -n 's/^: [0-9]*:[0-9]*;//p' \"$hfile\" | $reverse_cmd"
  local selected
  local bold=$'\x1b[1m' dim=$'\x1b[2m' reset=$'\x1b[0m'
  selected=$(eval "$hist_cmd" | fzf \
    --scheme=history \
    --border-label=' HISTORY ' \
    --border-label-pos=3 \
    --footer="${bold}Enter${reset}${dim}: select${reset}  ${bold}^D${reset}${dim}: delete${reset}  ${bold}^Y${reset}${dim}: copy${reset}  ${bold}^/${reset}${dim}: preview${reset}" \
    --preview='echo {}' \
    --preview-window='down,3,wrap,hidden' \
    --bind='ctrl-/:toggle-preview' \
    --bind="ctrl-d:execute-silent(
      hf=\"$hfile\"
      cmd={}
      LC_ALL=C grep -vF \";\$cmd\" \"\$hf\" > \"\$hf.tmp\" && mv \"\$hf.tmp\" \"\$hf\"
    )+reload($hist_cmd)" \
    --bind="ctrl-y:execute-silent(echo -n {} | $clip_cmd)+abort")
  fc -R
  if [[ -n "$selected" ]]; then
    BUFFER="$selected"
    CURSOR=$#BUFFER
  fi
  zle reset-prompt
}
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget

# Google Cloud SDK (gcloud)
if [[ -d "$HOME/.local/share/google-cloud-sdk" ]]; then
  source "$HOME/.local/share/google-cloud-sdk/path.zsh.inc"
  source "$HOME/.local/share/google-cloud-sdk/completion.zsh.inc"
fi
