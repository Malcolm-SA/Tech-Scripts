# Set ConsentPromptBehaviorAdmin to 0 under Policies\System
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" -Name "ConsentPromptBehaviorAdmin" -Value 0

Write-Output "ConsentPromptBehaviorAdmin set to 0 successfully."
