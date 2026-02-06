# Dotfiles

Personal dotfiles managed with [yurt](https://github.com/jcthomassie/yurt), a declarative dotfiles manager. Try `yurt help` or `yurt show` for more information.

## Machines

- **Laptop**: M4 MacBook Pro (macOS)
- **Desktop**: Fedora Workstation 43 (GNOME)

## Structure

- `build.yaml` - Yurt config: packages, symlinks, and platform-specific setup
- `zsh/` - Zsh config with plugins as git submodules (powerlevel10k, fzf-tab, etc.)
- `nvim/` - Neovim config
- `git/` - Git config and global gitignore
- `ssh/` - SSH config with platform/user-specific includes
- `wezterm/` - WezTerm terminal config
- `yazi/` - Yazi file manager config
- `claude/` - Claude Code settings

## Installation

```sh
./install.sh
```

This installs yurt if needed, then runs `yurt install` to apply `build.yaml`.
