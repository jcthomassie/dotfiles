#!/bin/sh
DF_REPO_ROOT="${DF_REPO_ROOT:-$HOME/dotfiles}"
YURT_BUILD_FILE="${YURT_BUILD_FILE:-$DF_REPO_ROOT/build.yaml}"
YURT_BUILD_URL="https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/build.yaml"
YURT_RELEASE_URL=""
YURT_REPO_URL="https://github.com/jcthomassie/yurt.git"

# Install yurt if needed
if ! command -v yurt >/dev/null 2>&1; then
    # Download yurt binary release if available
    # TODO: get release binaries when supported

    # Install cargo if needed (via rustup)
    if ! command -v cargo >/dev/null 2>&1; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
    cargo install --git $YURT_REPO_URL
fi

# Run yurt install
if [[ -f $YURT_BUILD_FILE ]]; then
    # Prefer local file
    yurt install --yaml $YURT_BUILD_FILE
else
    # Use remote otherwise
    yurt install --yaml-url $YURT_BUILD_URL
fi
