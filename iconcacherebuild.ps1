# Rebuild Icon Cache
Write-Host "Rebuilding Icon Cache..."

$iconCachePath = "$env:SystemRoot\system32\ie4uinit.exe"
$iconCacheArguments = "-show"
$iconCacheProcess = Start-Process -FilePath $iconCachePath -ArgumentList $iconCacheArguments -NoNewWindow -PassThru
$iconCacheProcess.WaitForExit()

Write-Host "Icon Cache Rebuilt."
Start-Sleep -Seconds 2

# Rebuild Thumbnail Cache
Write-Host "Rebuilding Thumbnail Cache..."

$thumbnailCachePath = "cmd.exe"
$thumbnailCacheArguments = "/c, del /f /s /q /a %LocalAppData%\Microsoft\Windows\Explorer\thumbcache_*.db"
$thumbnailCacheProcess = Start-Process -FilePath $thumbnailCachePath -ArgumentList $thumbnailCacheArguments -NoNewWindow -PassThru
$thumbnailCacheProcess.WaitForExit()

Write-Host "Thumbnail Cache Rebuilt."
Start-Sleep -Seconds 2
