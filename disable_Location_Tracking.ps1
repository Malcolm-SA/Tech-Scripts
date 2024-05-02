# Set registry value to Deny under CapabilityAccessManager\ConsentStore\location
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" -Name "Value" -Value "Deny"

# Set SensorPermissionState to 0 under Sensor\Overrides
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" -Name "SensorPermissionState" -Value 0

# Set Status to 0 under lfsvc\Service\Configuration
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" -Name "Status" -Value 0

# Set AutoUpdateEnabled to 0 under SYSTEM\Maps
Set-ItemProperty -Path "HKLM:\SYSTEM\Maps" -Name "AutoUpdateEnabled" -Value 0

Write-Output "Registry settings updated successfully. Consent Store location disabled, Sensor Overides enabled, Map updates disabled"
