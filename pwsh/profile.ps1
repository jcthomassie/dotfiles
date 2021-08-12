[Environment]::SetEnvironmentVariable("YURT_BUILD_FILE", "$HOME\dotfiles\build.yaml")
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Ctrl+A -Function BeginningOfLine
Set-PSReadlineKeyHandler -Key Ctrl+E -Function EndOfLine

# Customizations
Import-Module -Name Terminal-Icons
Import-Module posh-git
Set-Theme Paradox
$ThemeSettings.Colors.DriveForegroundColor = [ConsoleColor]::Blue
$ThemeSettings.Colors.PromptBackgroundColor = [ConsoleColor]::Blue
$ThemeSettings.Colors.PromptHighlightColor = [ConsoleColor]::Blue

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
