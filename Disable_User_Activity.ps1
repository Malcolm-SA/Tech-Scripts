
# Open the registry key
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\System"

# Check if the registry key exists, if not, create it
if (!(Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}
$Name1 = "EnableActivityFeeds"
$Name2 = "PublishUserActivities"
$Name3 = "UploadUserActivities"

# Set the registry values
#"EnableActivityFeed"
#"PublishUserActivities"
#"UploadUserActivities"

Set-ItemProperty -Path $registryPath -Name $Name1 -Value 0 -Type DWord
Set-ItemProperty -Path $registryPath -Name $Name2 -Value 0 -Type DWord
Set-ItemProperty -Path $registryPath -Name $Name3 -Value 0 -Type DWord

Write-Output "$Name1, Set to Disabled","$Name2, Set to Disabled","$Name3, Set to Disabled"
