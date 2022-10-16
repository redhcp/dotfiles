#install fonts & wallpapers

cd "C:\"
cd $env:HOMEPATH\Downloads
Get-ChildItem dotfiles-main.zip | Expand-Archive 
#install fonts
cd .\dotfiles-main\dotfiles-main\fonts
Get-ChildItem hack.zip | Expand-Archive -Force -Verbose
Get-ChildItem mononoki.zip | Expand-Archive -Force -Verbose
Get-ChildItem anonymouspro.zip | Expand-Archive -Verbose
Copy-Item -Path "$env:USERPROFILE\Downloads\dotfiles-main\dotfiles-main\fonts\mononoki\mononoki\*" "C:\Windows\Fonts\" -Force -Verbose
Copy-Item -Path "$env:USERPROFILE\Downloads\dotfiles-main\dotfiles-main\fonts\hack\hack\*" "C:\Windows\Fonts\" -Force -Verbose
Copy-Item -Path "$env:USERPROFILE\Downloads\dotfiles-main\dotfiles-main\fonts\anonymouspro\anonymouspro\*" "C:\Windows\Fonts\" -Force -Verbose
#install wallpapers
Copy-Item -path "$env:USERPROFILE\Downloads\dotfiles-main\dotfiles-main\wallpapers\*" -Destination "$env:USERPROFILE\Pictures\Saved Pictures\" -Force -Verbose