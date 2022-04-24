[Environment]::SetEnvironmentVariable("YURT_BUILD_FILE", "$HOME\dotfiles\build.yaml")
[Environment]::SetEnvironmentVariable("STARSHIP_CONFIG", "$HOME\dotfiles\pwsh\.starship.toml")
[Environment]::SetEnvironmentVariable("RUST_LOG", "yurt")
[Environment]::SetEnvironmentVariable("EDITOR", "code")
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+A -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key Ctrl+E -Function EndOfLine

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

# Customizations
# Import-Module -Name Terminal-Icons
Invoke-Expression (&zoxide init --hook prompt powershell | Out-String)
Invoke-Expression (&starship init powershell)
