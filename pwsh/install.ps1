#Requires -RunAsAdministrator
Set-ExecutionPolicy Bypass -Scope Process -Force

$DOTS_REPO_ROOT = "$HOME\dotfiles"
$YURT_BUILD_FILE = "$DOTS_REPO_ROOT\build.yaml"
$YURT_BUILD_URL = "https://raw.githubusercontent.com/jcthomassie/dotfiles/HEAD/build.yaml"
$YURT_REPO_URL = "https://github.com/jcthomassie/yurt.git"

# Install chocolatey
if ( -Not (Get-Command choco.exe -ErrorAction SilentlyContinue)) {
    Invoke-Expression((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Install packages
choco install -y gh
choco install -y git
choco install -y vim
choco install -y rustup.install
choco install -y starship

choco install -y 1password
choco install -y googlechrome
choco install -y google-drive-file-stream
choco install -y microsoft-windows-terminal
choco install -y reaper
choco install -y spotify
choco install -y steam
choco install -y vscode

# TODO: download pre-built release instead
# Install yurt if needed
if ( -Not (Get-Command yurt.exe -ErrorAction SilentlyContinue)) {
    cargo install --git $YURT_REPO_URL
}

# TODO: prompt to automatically --clean
# Run yurt install
if ( Test-Path -Path $YURT_BUILD_FILE ) {
    # Prefer local file
    yurt --yaml $YURT_BUILD_FILE --log "debug" install
}
else {
    # Use remote otherwise
    yurt --yaml-url $YURT_BUILD_URL --log "debug" install
}
