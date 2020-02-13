# ------------------------------------------------------------


<# Check-for & Download available Windows Updates #> ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());


<# Clear out cached Windows Updates #> Get-Service | Where-Object { $_.DisplayName -Eq 'Windows Update' } | ForEach-Object { Write-Host "Stopping `"$($_.DisplayName)`"..."; $_ | Stop-Service; }; If (Test-Path ("C:\Windows\SoftwareDistribution\Download")) { Move-Item -Path ("C:\Windows\SoftwareDistribution\Download") -Destination ("${Env:APPDATA}\SoftwareDistribution-Download.$(Get-Date -UFormat '%Y%m%d-%H%M%S').bak") -Force; }; Get-Service | Where-Object { $_.DisplayName -Eq 'Windows Update' } | ForEach-Object { Write-Host "Starting `"$($_.DisplayName)`"..."; $_ | Start-Service; }; <# Check-for & Download available Windows Updates #> ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());



# ------------------------------------------------------------

# Inspect Auto-Update Settings for Windows Update
# ((New-Object -ComObject Microsoft.Update.AutoUpdate).Settings());

# ------------------------------------------------------------


# Deprecated? --> Using UsoClient.exe

# Refresh settings if any changes were made
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("RefreshSettings") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe RefreshSettings


# Restart device to finish installation of Windows Updates
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("RestartDevice") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe RestartDevice


# Resume update installation on boot
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("ResumeUpdate") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe ResumeUpdate


# Download any available Windows Updates
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartDownload") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe StartDownload


# Install downloaded Windows Updates
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartInstall") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe StartInstall


# May ask for user input and/or open dialogues to show progress or report errors
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartInteractiveScan") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe StartInteractiveScan


# Combined scan, download, and install Windows Updates
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("ScanInstallWait") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe ScanInstallWait


# Check for Windows Updates
# Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartScan") -Verb ("RunAs") -Wait -ErrorAction ("SilentlyContinue");
UsoClient.exe StartScan


# ------------------------------------------------------------
# Deprecated - Using wuauclt.exe

# wuauclt.exe /updatenow


# ------------------------------------------------------------
#
# Citation(s)
#
#   omgdebugging.com  |  "Command Line Equivalent of wuauclt in Windows 10 / Windows Server 2016"  |  https://omgdebugging.com/2017/10/09/command-line-equivalent-of-wuauclt-in-windows-10-windows-server-2016/
#
#   superuser.com  |  "command line - Can I get more information on what Windows Update is doing? - Super User"  |  https://superuser.com/a/1186355
#
#   superuser.com  |  "How to force Windows Server 2016 to check for updates - Super User"  |  https://superuser.com/a/1352500
#
#   www.thewindowsclub.com  |  "What is UsoClient.exe in Windows 10"  |  https://www.thewindowsclub.com/usoclient-exe-windows-10
#
# ------------------------------------------------------------