# Define the registry paths and values
$registryPaths = @{
    "HKCU:\System\GameConfigStore" = @{
        "GameDVR_FSEBehavior" = 2
        "GameDVR_Enabled" = 0
        "GameDVR_DXGIHonorFSEWindowsCompatible" = 1
        "GameDVR_HonorUserFSEBehaviorMode" = 1
        "GameDVR_EFSEFeatureFlags" = 0
    }
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR" = @{
        "AllowGameDVR" = 0
    }
}

# Iterate over each registry path
foreach ($registryPath in $registryPaths.Keys) {
    # Check if the registry path exists, if not, create it
    if (!(Test-Path $registryPath)) {
        New-Item -Path $registryPath -Force | Out-Null
    }

    # Iterate over each value in the current registry path
    foreach ($value in $registryPaths[$registryPath].Keys) {
        # Check if the value is already set, if not, set it
        if ((Get-ItemProperty -Path $registryPath -Name $value -ErrorAction SilentlyContinue) -eq $null) {
            Set-ItemProperty -Path $registryPath -Name $value -Value $registryPaths[$registryPath][$value] -Type DWord
        }
    }
}

Write-Output "Game DVR Policies, Set to disabled"