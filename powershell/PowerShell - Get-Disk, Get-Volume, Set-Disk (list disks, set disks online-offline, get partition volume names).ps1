# ------------------------------------------------------------
# PowerShell - Get-Disk, Get-Volume, Set-Disk (list disks, set disks online-offline, get partition volume names)
# ------------------------------------------------------------

<# Example: Find offline disks, put them online, optimize any with the name "Windows" through DISM, then take them back offline #>

${DISM_Disk}=((Get-Disk | Where-Object { $_.OperationalStatus -Eq "Offline" }).Number); <# Get the disk numbers (assumed to be newly-attached) #>

${DISM_Disk} | ForEach-Object { Set-Disk -Number ($_) -IsOffline ($False); }; <# Set offline disk(s) to online #>

${DISM_Volume}=((Get-Volume | Where-Object { ($_.FileSystemLabel -Eq "Windows") -And (-Not (@("C","D") -Contains $_.DriveLetter)) }).DriveLetter); Start-Process -Filepath ("C:\Windows\System32\Dism.exe") -ArgumentList (@("/image:${DISM_Volume}:\","/optimize-image","/boot")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue"); <# Optimize image through DISM #>

${DISM_Disk} | ForEach-Object { Set-Disk -Number ($_) -IsOffline ($True); }; <# Set originally-offline disk(s) back to offline #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Disk (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-disk?view=windowsserver2019-ps
#
#   docs.microsoft.com  |  "Get-Volume (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-volume?view=windowsserver2019-ps
#
#   docs.microsoft.com  |  "Set-Disk (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/set-disk?view=windowsserver2019-ps
#
# ------------------------------------------------------------