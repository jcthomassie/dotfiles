# dotfiles

My personal dotfiles and configs.

Bootstrap POSIX systems using:

```shell
curl -fsLS https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/zsh/install.sh | bash
```

## Windows

Installation is managed with Windows PowerShell and [Chocolatey](https://docs.chocolatey.org/en-us/).

Run Windows PowerShell as administrator and run:

```powershell
Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/pwsh/install.ps1'))
```
