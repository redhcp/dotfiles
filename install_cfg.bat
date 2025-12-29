# File: install.bat
:: Batch script to move and install files from dotfiles-main

@echo off
setlocal

REM Set variables
set "DOWNLOADS=%USERPROFILE%\Downloads\dotfiles-main\dotfiles-main"
set "FONTS=%DOWNLOADS%\fonts"
set "POWERSHELL=%DOWNLOADS%\powershell"
set "WALLPAPERS=%DOWNLOADS%\wallpapers"

REM Unzip font archives and copy to Windows Fonts
powershell -Command "Expand-Archive -Path '%FONTS%\hack.zip' -DestinationPath '%FONTS%\hack' -Force"
powershell -Command "Expand-Archive -Path '%FONTS%\mononoki.zip' -DestinationPath '%FONTS%\mononoki' -Force"
powershell -Command "Expand-Archive -Path '%FONTS%\anonymouspro.zip' -DestinationPath '%FONTS%\anonymouspro' -Force"
xcopy "%FONTS%\hack\*" "C:\Windows\Fonts\" /Y /E
xcopy "%FONTS%\mononoki\*" "C:\Windows\Fonts\" /Y /E
xcopy "%FONTS%\anonymouspro\*" "C:\Windows\Fonts\" /Y /E

REM Move PowerShell folder
if not exist "%USERPROFILE%\Documents\PowerShell" mkdir "%USERPROFILE%\Documents\PowerShell"
xcopy "%POWERSHELL%\*" "%USERPROFILE%\Documents\PowerShell\" /Y /E

REM Move wallpapers
if not exist "%USERPROFILE%\Pictures" mkdir "%USERPROFILE%\Pictures"
xcopy "%WALLPAPERS%\" "%USERPROFILE%\Pictures\" /Y /E

echo Done.
pause
