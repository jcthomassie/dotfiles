export DF_REPO_ROOT=$HOME/dotfiles
export ZDOTDIR=$DF_REPO_ROOT/.zsh
export EDITOR=code
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
