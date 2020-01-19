# ------------------------------------------------------------
#
# PowerShell - Clear local Spotify app's cached files
#
# ------------------------------------------------------------

Get-Process | Where-Object { $_.ProcessName -Eq "Spotify" } | Stop-Process -Force;


Get-ChildItem -Path ("${Home}\AppData\Roaming\Spotify") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Name -Like "*-User" } `
| Where-Object { $_.Name -Like "local-files.bnk" } `
| Remove-Item -Force -Recurse;


Remove-Item ("${Home}\AppData\Local\Spotify\Storage") -Force -Recurse;


Remove-Item ("${Home}\AppData\Local\Spotify\Data") -Force -Recurse;


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.spotify.com  |  "Solved: cache - The Spotify Community"  |  https://community.spotify.com/t5/Desktop-Windows/cache/td-p/4722569
#
#		docs.microsoft.com  | "Stop-Process"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/stop-process
#
# ------------------------------------------------------------