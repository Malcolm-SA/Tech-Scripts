# Check if AllowWiFiHotSpotReporting key exists, if not, create it
if (-not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Force | Out-Null
}

# Set Value to 0 under AllowWiFiHotSpotReporting
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" -Name "Value" -Value 0

# Set Value to 0 under AllowAutoConnectToWiFiSenseHotspots
Set-ItemProperty -Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" -Name "Value" -Value 0

Write-Output "Wifi Hotspot reporting & Connections to WifiSenseHotspots disabled."
