# PowerShell Profile
# =============================================================================

# --- 1. Modules Imports ---
Import-Module -Name Terminal-Icons
Import-Module -Name PoshGram
Import-Module -Name PSReadLine

# --- 2. Prompt Configuration (Oh-My-Posh) ---
$ThemePath = "$HOME\Documents\WindowsPowerShell\lightgreen.omp.json"
if (Test-Path $ThemePath) {
    oh-my-posh init pwsh --config $ThemePath | Invoke-Expression
}
# --- 3. PSReadLine & History Configuration ---
Set-PSReadLineOption -MaximumHistoryCount 20000
Set-PSReadLineOption -HistorySaveStyle SaveIncrementally
$env:PSReadlineHistorySavePath = "$HOME\Documents\WindowsPowerShell\history.txt"
# Map Up/Down arrows to filter history based on current input
try {
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
} catch {
    Write-Warning "PSReadLine not loaded, keybindings skipped."
}


Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

# --- 4. Custom Functions ---
function ll { Get-ChildItem -Verbose }
function gpath { pwd | Set-Clipboard }
function mkcd { param($dir) mkdir $dir -Force | Out-Null; cd $dir }
function shutdowns { shutdown -s -t 0 }
function restart { shutdown -r -t 0 }
function ll { Get-ChildItem -Verbose }
function ls { Get-ChildItem -Color }
# --- Git Shortcodes ---
Set-Alias -Name g -Value git
function gs { git status -sb }
function ga { git add . }
function gc { param($m) git commit -m $m }
# 'mip': Get Local IP Address (IPv4)
function mip {
    Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object { $_.InterfaceAlias -notlike "*Loopback*" } |
        Select-Object -ExpandProperty IPAddress
}
# 'myip': Get Public IP Address
function myip {
    (Invoke-WebRequest -Uri "http://ipecho.net/plain" -UseBasicParsing).Content.Trim()
}
# 'ports': List listening ports and owning processes
function ports {
    Get-NetTCPConnection -State Listen |
        Select-Object LocalAddress, LocalPort, OwningProcess, @{Name="Process"; Expression={(Get-Process -Id $_.OwningProcess).ProcessName}} |
        Format-Table -AutoSize
}
# --- 5. Aliases ---
Set-Alias -Name c -Value Clear-Host
Set-Alias -Name grep -Value findstr
$ScriptDir = "$HOME\Documents\WindowsPowerShell"
Set-Alias -Name susp -Value "$ScriptDir\suspend.bat"
Set-Alias -Name hibe -Value "$ScriptDir\hibernate.bat"

Set-Alias -Name .. -Value "cd .."
Set-Alias -Name ... -Value "cd ..\.."

Set-Alias -Name ytmusic -Value "$ScriptDir\ytmusic.ps1"
Set-Alias -Name ytmusicplist -Value "$ScriptDir\ytmusicplist.ps1"
Set-Alias -Name ytvideo -Value "$ScriptDir\ytvideo.ps1"
Set-Alias -Name ytvideoplist -Value "$ScriptDir\ytvideoplist.ps1"
Set-Alias -Name ytvideoH -Value "$ScriptDir\ytvideoH.ps1"
Set-Alias -Name ytvideoplistH -Value "$ScriptDir\ytvideoplistH.ps1"

# --- 6. Argument Completers ---
# AWS Completer
Register-ArgumentCompleter -Native -CommandName aws -ScriptBlock {
    param($commandName, $wordToComplete, $cursorPosition)
    $env:COMP_LINE = $wordToComplete
    if ($env:COMP_LINE.Length -lt $cursorPosition) {
        $env:COMP_LINE = $env:COMP_LINE + " "
    }
    $env:COMP_POINT = $cursorPosition
    aws_completer.exe | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
    Remove-Item Env:\COMP_LINE
    Remove-Item Env:\COMP_POINT
}
# Chocolatey Profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
