# Get the OS version
$osVersion = (Get-WmiObject -Class Win32_OperatingSystem).Caption

# Check if the OS version is Windows 10 Home
if ($osVersion -eq "Microsoft Windows 10 Home Single Language") {
    # Apply the script
    Get-ChildItem @(
        "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientTools-Package*.mum",
        "$env:SystemRoot\servicing\Packages\Microsoft-Windows-GroupPolicy-ClientExtensions-Package*.mum"
    ) | ForEach-Object { dism.exe /online /norestart /add-package:"$_" }
} else {
    # Report the actual name of OS version
    Write-Output "The OS version is $osVersion. GPEdit.msc is already present on the system."
}
