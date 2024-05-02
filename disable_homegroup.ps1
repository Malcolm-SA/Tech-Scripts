# Disable HomeGroup-related services if they exist

$listenerService = Get-Service -Name HomeGroupListener -ErrorAction SilentlyContinue
if ($listenerService -ne $null) {
    Set-Service -Name HomeGroupListener -StartupType Manual
    Write-Output "Service 'HomeGroupListener' set to Manual startup type."
} else {
    Write-Output "Service 'HomeGroupListener' not found. Skipping..."
}

$providerService = Get-Service -Name HomeGroupProvider -ErrorAction SilentlyContinue
if ($providerService -ne $null) {
    Set-Service -Name HomeGroupProvider -StartupType Manual
    Write-Output "Service 'HomeGroupProvider,' set to Manual startup type."
} else {
    Write-Output "Service 'HomeGroupProvider' not found. Skipping..."
}
