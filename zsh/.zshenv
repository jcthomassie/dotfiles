export DOTS_REPO_ROOT=$HOME/dotfiles
export ZDOTDIR=$DOTS_REPO_ROOT/zsh
export EDITOR=code
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
fi
