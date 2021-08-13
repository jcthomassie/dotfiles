# dotfiles

My personal dotfiles and configs for MacOS, AL2, Ubuntu, and Windows.

Bootstrap POSIX systems using:

```shell
curl -fsLS https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/zsh/install.sh | bash
```

## MacOS

After installation on MacOS, set the iTerm2 profile location:

- Navigate to **General > Preferences**
- Enable **Load preferences from a custom folder or URL**
- Enter `~/dotfiles/macos`

Also install iterm2 shell integration in the home directory.

## Windows

Installation is managed with Windows PowerShell and [Chocolatey](https://docs.chocolatey.org/en-us/).

Run Windows PowerShell as administrator and run:

```powershell
Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/pwsh/install.ps1'))
```
