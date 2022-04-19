export ZDOTDIR=${${(%):-%N}:A:h}
export DOTS_REPO_ROOT=${ZDOTDIR:h}
export EDITOR=code
if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
    export RUST_LOG=yurt
fi
