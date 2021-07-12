export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="agnoster"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ccat="pygmentize -g -O style=colorful,linenos=1"
alias zshconfig="code -n -w ~/.zshrc"

source /home/jthom/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
