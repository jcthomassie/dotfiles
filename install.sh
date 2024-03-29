#!/bin/bash
DOTS_REPO_ROOT="${DOTS_REPO_ROOT:-$HOME/dotfiles}"
YURT_BUILD_FILE="${YURT_BUILD_FILE:-$DOTS_REPO_ROOT/build.yaml}"
YURT_BUILD_URL="https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/build.yaml"
YURT_RELEASE_URL="https://github.com/jcthomassie/yurt/releases/download/v0.6.0"
YURT_REPO_URL="https://github.com/jcthomassie/yurt.git"

download_release() {
    local name="${1:?release target missing}"
    local dir="${2:-/usr/local/bin}"
    local url="$YURT_RELEASE_URL/$name"
    local _pwd=$(pwd)
    cd $dir
    local steps="curl -sOL $url && mv $name 'yurt' && chmod +x 'yurt'"
    if ! [[ -w "." ]]; then
        sudo -- sh -c "$steps"
    else
        sh -c "$steps"
    fi
    cd $_pwd
}

# Install yurt if needed
if ! command -v yurt >/dev/null 2>&1; then
    if [[ "$OSTYPE" == "darwin"* ]]; then
        download_release "yurt-macos"
        xattr -d com.apple.quarantine $(which yurt)
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        download_release "yurt-linux"
    else
        # Install cargo if needed (via rustup)
        if ! command -v cargo >/dev/null 2>&1; then
            curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        fi
        cargo install --git $YURT_REPO_URL
    fi
fi

# TODO: prompt to automatically --clean
# Run yurt install
if [[ -f $YURT_BUILD_FILE ]]; then
    # Prefer local file
    RUST_LOG=yurt yurt --yaml $YURT_BUILD_FILE install
else
    # Use remote otherwise
    RUST_LOG=yurt yurt --yaml-url $YURT_BUILD_URL install
fi
