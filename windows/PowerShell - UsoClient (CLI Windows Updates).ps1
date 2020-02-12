
# Check for Windows Updates
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartScan") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# Download any available Windows Updates
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartDownload") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# Install downloaded Windows Updates
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartInstall") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# Refresh settings if any changes were made
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("RefreshSettings") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# May ask for user input and/or open dialogues to show progress or report errors
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("StartInteractiveScan") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# Restart device to finish installation of Windows Updates
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("RestartDevice") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# Combined scan, download, and install Windows Updates
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("ScanInstallWait") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# Resume update installation on boot
Start-Process -Filepath ("C:\Windows\system32\UsoClient.exe") -ArgumentList ("ResumeUpdate") -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------
#
# Citation(s)
#
#   omgdebugging.com  |  "Command Line Equivalent of wuauclt in Windows 10 / Windows Server 2016"  |  https://omgdebugging.com/2017/10/09/command-line-equivalent-of-wuauclt-in-windows-10-windows-server-2016/
#
#   superuser.com  |  "How to force Windows Server 2016 to check for updates - Super User"  |  https://superuser.com/a/1352500
#
#   www.thewindowsclub.com  |  "What is UsoClient.exe in Windows 10"  |  https://www.thewindowsclub.com/usoclient-exe-windows-10
#
# ------------------------------------------------------------