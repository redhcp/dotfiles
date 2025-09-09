#Import-Module oh-my-posh
Import-Module -Name Terminal-Icons
Import-Module -Name PoshGram
oh-my-posh init pwsh --config "$env:USERPROFILE\Documents\WindowsPowerShell\lightgreen.omp.json" | Invoke-Expression

#history
Set-PSReadLineOption -MaximumHistoryCount 20000
$env:PSReadlineHistorySavePath = "$env:USERPROFILE\Documents\WindowsPowerShell\history.txt"
Set-PSReadlineOption -HistorySaveStyle SaveIncrementally

#terminal
Import-Module PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -EditMode Windows

Set-alias susp "$env:USERPROFILE\Documents\WindowsPowerShell\suspend.bat"
Set-alias c clear
Set-Alias grep findstr
set-Alias ytmusic "$env:USERPROFILE\Documents\WindowsPowerShell\ytmusic.ps1"
set-Alias ytmusicplist "$env:USERPROFILE\Documents\WindowsPowerShell\ytmusicplist.ps1"
set-Alias ytvideo "$env:USERPROFILE\Documents\WindowsPowerShell\ytvideo.ps1"
set-Alias ytvideoplist "$env:USERPROFILE\Documents\WindowsPowerShell\ytvideoplist.ps1"
set-alias grep="grep --color=auto"
set-alias dcb="docker-compose build"
set-alias dcd="docker-compose down"
set-alias dcps="docker-compose ps"
set-alias dcu="docker-compose up"
set-alias dcupd="docker-compose up -d"
set-alias dps="docker ps"


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
#chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
