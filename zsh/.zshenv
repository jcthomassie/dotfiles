export ZDOTDIR=${${(%):-%N}:A:h}
export DOTS_REPO_ROOT=${ZDOTDIR:h}

unset GIT_EDITOR

# sccache
export SCCACHE_CACHE_SIZE="50G"
if [[ $OSTYPE == darwin* ]]; then
    export SCCACHE_DIR="$HOME/Library/Caches/sccache"
fi
