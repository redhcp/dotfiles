# The script scans the entire AppEvents registry looking for any event configured to play four specific Windows sound files.
Clear-Host

$media = "C:\Windows\Media"

# Target sound files to detect
$targets = @(
    "Windows Critical Stop.wav",
    "Windows Ding.wav",
    "Windows Exclamation.wav",
    "Windows Background.wav",
    "Windows Error.wav",
    "Windows Exclamation.wav"
)

# Full absolute paths
$fullTargets = $targets | ForEach-Object { Join-Path $media $_ }

# Map for restoring original sound assignments
$restoreMap = @{
    "Windows Critical Stop.wav"   = "Windows Critical Stop.wav"
    "Windows Ding.wav"            = "Windows Ding.wav"
    "Windows Exclamation.wav"     = "Windows Exclamation.wav"
    "Windows Background.wav"      = "Windows Background.wav"
    "Windows Exclamation.wav"     = "Windows Exclamation.wav"
    "Windows Error.wav"           = "Windows Error.wav"

}

# Root registry path of all AppEvents
$root = "HKCU:\AppEvents\Schemes\Apps"

Write-Host "Scanning for configurations using the target sounds..." -ForegroundColor Cyan

$found = @()

# Traverse the entire AppEvents tree
Get-ChildItem $root -Recurse | ForEach-Object {
    $keyPath = $_.PsPath

    # Attempt to read the (Default) value
    $value = (Get-ItemProperty -Path $keyPath -Name "(Default)" -ErrorAction SilentlyContinue)."(Default)"

    # If the value matches a target sound, collect it
    if ($value -and ($fullTargets -contains $value)) {
        $found += [PSCustomObject]@{
            RegistryKey = $keyPath
            Sound       = Split-Path $value -Leaf
        }
    }
}

# Display detected entries
if ($found.Count -eq 0) {
    Write-Host "No configuration is using those sounds." -ForegroundColor Green
} else {
    Write-Host "`nEvents using the target sounds:" -ForegroundColor Yellow
    $i = 1
    $found | ForEach-Object {
        Write-Host ("$i) " + $_.RegistryKey + "    --> " + $_.Sound)
        $i++
    }
}

# User menu
Write-Host "`nSelect an option:"
Write-Host "1) Mute all detected events"
Write-Host "7) Restore original sounds"
Write-Host "0) Exit"
$choice = Read-Host "Option"

switch ($choice) {

    "1" {
        Write-Host "Muting..." -ForegroundColor Cyan

        # Clear (Default) value for all detected keys
        foreach ($item in $found) {
            Set-ItemProperty -Path $item.RegistryKey -Name "(Default)" -Value ""
        }

        Write-Host "Done. All detected events have been muted." -ForegroundColor Green
    }

    "7" {
        Write-Host "Restoring original sounds..." -ForegroundColor Cyan

        # Restore each detected event to its original .wav file
        foreach ($item in $found) {
            $soundName = $item.Sound
            if ($restoreMap.ContainsKey($soundName)) {
                $original = Join-Path $media $restoreMap[$soundName]
                Set-ItemProperty -Path $item.RegistryKey -Name "(Default)" -Value $original
            }
        }

        Write-Host "Restoration complete. Sounds have been restored." -ForegroundColor Green
    }

    default {
        Write-Host "Exiting." -ForegroundColor DarkGray
    }
}
