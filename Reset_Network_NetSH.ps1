﻿
    Write-Host "Resetting Network with netsh"

    # Reset WinSock catalog to a clean state
    Start-Process -NoNewWindow -FilePath "netsh" -ArgumentList "winsock", "reset"
    # Resets WinHTTP proxy setting to DIRECT
    Start-Process -NoNewWindow -FilePath "netsh" -ArgumentList "winhttp", "reset", "proxy"
    # Removes all user configured IP settings
    Start-Process -NoNewWindow -FilePath "netsh" -ArgumentList "int", "ip", "reset"

    Write-Host "Process complete. Please reboot your computer."