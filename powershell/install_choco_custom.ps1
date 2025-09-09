
#add permission execute powershell
Set-Executionpolicy unrestricted -Force;

Set-ExecutionPolicy Bypass -Scope Process -Force; `
  iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco upgrade chocolatey #upgrade choco

#choco list  # view list installed apps

#Install APPS

choco install microsoft-windows-terminal
choco install oh-my-posh 24.19.0
choco install 7zip
choco install clamwin
choco install cpu-z
choco install googlechrome
choco install chromium
choco install brave
# choco install firefox
choco install bitwarden-chrome
# choco install winrar
choco install zoom
choco install ffmpeg
choco install sublimetext3.app
choco install vnc-viewer
choco install yt-dlp
# choco install notepadplusplus
choco install vscode
choco install git.install
# choco install github-desktop
choco install MobaXTerm
# choco install virtualbox
# choco install docker-desktop
# choco install grafana
choco install python 3.12.10
choco install python3 3.13.5
choco install vlc
choco install notion
choco install slack
choco install discord
# choco install resilio-sync-home
# choco install teamviewer
# choco install veracrypt
# choco install putty
# choco install treesizefree
# choco install cpu-z
# choco install dotnetfx
