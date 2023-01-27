if [ -d "/home/linuxbrew" ]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew";
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar";
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew";
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}";
    export MANPATH="/home/linuxbrew/.linuxbrew/share/man:${MANPATH}:";
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH}";
fi

if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

if [ -d "$HOME/.local/share/coursier/bin" ]; then
    export PATH=$PATH:$HOME/.local/share/coursier/bin
fi

if [ -f "$HOME/.cargo/env" ]; then
    . "$HOME/.cargo/env"
    export RUST_LOG=yurt
fi
