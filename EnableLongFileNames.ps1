#Enable Long File Names
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -NAME "LongPathsEnabled" -Value 1