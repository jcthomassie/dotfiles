#!/bin/sh
RUN_LOCATION=$(pwd)

DF_REPO_ROOT=${DF_REPO_ROOT:-"$HOME/dotfiles"}
DF_REPO_URL="https://github.com/jcthomassie/dotfiles.git"
DF_OS=$(uname -s)
DF_USER=$USER
DF_LINUX_DISTRO=""
DF_LOCAL_SEP="##"
DF_LOCAL_SUFFIXES=(
    "user.$DF_USER"
    "os.$DF_OS"
    "default"
)

_get_linux_distro () {
    for p in /etc/{os,lsb,redhat}-release; do
        if [ -f $p ]; then
            . $p
            DF_LINUX_DISTRO=$NAME
            return
        fi
    done
}

_install_macos () {
    echo "Setting up OSX..."
    # install homebrew if it's missing
    if ! command -v brew >/dev/null 2>&1; then
        echo "Installing homebrew..."
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    fi
    # download brewfile if needed
    if [[ -f "$DF_REPO_ROOT/.brewfile" ]]; then
        brew bundle --file "$DF_REPO_ROOT/.brewfile"
    else
        echo "Downloading brewfile..."
        curl -fsLS "https://raw.githubusercontent.com/jcthomassie/dotfiles/master/.brewfile" | brew bundle --file=/dev/stdin
    fi
    brew analytics off
}

_install_ubuntu () {
    echo "Setting up Ubuntu..."
    sudo apt-get update -y
    sudo apt-get install -y zsh git bat cargo
    cargo install git-delta
}

_install_al2 () {
    echo "Setting up AL2..."
    sudo yum update -y
    sudo yum install -y zsh git
}

_fetch_dotfiles () {
    # Clone dotfiles
    if [ ! -d $DF_REPO_ROOT/.git ]; then
        git clone $DF_REPO_URL $DF_REPO_ROOT
    else
        echo "Using dotfile repo: $DF_REPO_ROOT"
    fi
    # Init submodules
    cd $DF_REPO_ROOT
    echo "Initializing submodules..."
    git submodule update --init --recursive
    cd $RUN_LOCATION
}

_create_link () {
    local SOURCE="$1"
    local TARGET="$2"

    # Check target
    if [[ -h $TARGET ]]; then
        local SOURCE_CUR=$(readlink $TARGET)
        if [ $SOURCE = $SOURCE_CUR ]; then
            return
        fi
        echo "ERROR: link points elsewhere: $TARGET@$SOURCE_CUR"
    elif [[ -f $TARGET ]]; then
        echo "ERROR: link target is a file: $TARGET"
    else
        echo "Linking ${TARGET}@${SOURCE}"
        ln -s $SOURCE $TARGET
    fi
}

_install_dotfiles () {
    echo "Installing dotfiles..."
    # Create external system links
    _create_link $DF_REPO_ROOT/.zsh/.zshenv $HOME/.zshenv
    _create_link $DF_REPO_ROOT/.gitconfig $HOME/.gitconfig
    _create_link $DF_REPO_ROOT/.gitconfig.local $HOME/.gitconfig.local
    _create_link $DF_REPO_ROOT/.gitignore_global $HOME/.gitignore_global

    # Create internal system specific links
    for base in "$( find $DF_REPO_ROOT -name "*${DF_LOCAL_SEP}*" | sed "s/${DF_LOCAL_SEP}.*//" | uniq )"; do
        for suffix in "${DF_LOCAL_SUFFIXES[@]}"; do
            local SOURCE="${base}${DF_LOCAL_SEP}${suffix}"
            if [[ -f $SOURCE ]]; then
                _create_link $SOURCE $base
                break
            fi
        done
    done
}

# ====================================================================
# MAIN
# ====================================================================

install () {
    case $OSTYPE in
        darwin*)
            _install_macos
            ;;
        linux*)
            _get_linux_distro
            case $DF_LINUX_DISTRO in
                "Amazon Linux"*)
                    _install_al2
                    ;;
                "Ubuntu")
                    _install_ubuntu
                    ;;
            esac
            ;;
    esac

    # Set shell
    if [[ ! $SHELL = */zsh ]]; then
        chsh -s $(which zsh)
    fi

    _fetch_dotfiles
    _install_dotfiles
}

install "$@"
