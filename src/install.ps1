#Requires -RunAsAdministrator
Set-ExecutionPolicy Bypass -Scope Process -Force

$RUN_LOCATION = Get-Location
$DF_REPO_ROOT = "$HOME\dotfiles"

# Install chocolatey
if ( -Not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install packages
choco install -y git
choco install -y gh
choco install -y vim
choco install -y vscode
choco install -y microsoft-windows-terminal
choco install -y wsl2
choco install -y wsl-ubuntu-2004
choco install -y oh-my-posh
choco install -y poshgit
choco install -y bat
choco install -y delta
choco install -y miniconda3 --params="'/AddToPath:1'"

choco install -y 1password
choco install -y google-backup-and-sync
choco install -y googlechrome
choco install -y reaper
choco install -y spotify
choco install -y steam

# Clone dotfiles repo
if ( Test-Path -Path $DF_REPO_ROOT\.git ) {
    Write-Output "Using dotfile repo: $DF_REPO_ROOT"
} else {
    Write-Output "Cloning dotfile repo..."
    git clone https://github.com/jcthomassie/dotfiles.git $DF_REPO_ROOT
    Set-Location -Path $DF_REPO_ROOT
    Write-Output "Initializing submodules..."
    git submodule update --init --recursive
    Set-Location $RUN_LOCATION
}

# Link files
cmd /c mklink $HOME\.gitconfig $DF_REPO_ROOT\.gitconfig
cmd /c mklink $HOME\.gitconfig.local $DF_REPO_ROOT\.gitconfig.local
cmd /c mklink $HOME\.gitignore_global $DF_REPO_ROOT\.gitignore_global
cmd /c mklink $DF_REPO_ROOT\.gitconfig.local "$DF_REPO_ROOT\.gitconfig.local##default"
