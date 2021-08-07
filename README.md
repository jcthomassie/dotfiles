# dotfiles

My personal dotfiles and configs for MacOS, AL2, Ubuntu, and Windows.

Bootstrap POSIX systems using:

```shell
curl -fsLS https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/src/install.sh | sh
```

**Note:** Some distros may require using `bash` instead of `sh`

## MacOS

After installation on MacOS, set the iTerm2 profile location:

- Navigate to **General > Preferences**
- Enable **Load preferences from a custom folder or URL**
- Enter `~/dotfiles/.iterm2_profile`

## Windows

Installation is managed with Windows PowerShell and [Chocolatey](https://docs.chocolatey.org/en-us/).

Run Windows PowerShell as administrator and run:

```powershell
Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/jcthomassie/dotfiles/windows/src/install.ps1'))
```
