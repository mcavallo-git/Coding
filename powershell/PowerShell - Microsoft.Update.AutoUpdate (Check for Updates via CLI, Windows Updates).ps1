<# ------------------------------------------------------------ #>
<#                                                              #>
<#    Install required roles & features for IIS (Web) Server    #>
<#                                                              #>
<# ------------------------------------------------------------ #>
If ($False) { <# RUN THIS SCRIPT REMOTELY #>


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/PowerShell%20-%20Microsoft.Update.AutoUpdate%20(Check%20for%20Updates%20via%20CLI%2C%20Windows%20Updates).ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------
If ($True) {


<# Create a "Windows Updates" shortcut on the desktop #> $Filepath_NewShortcut = "${Home}\Desktop\Check for Updates.lnk"; $NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Filepath_NewShortcut}"); $NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"); $NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`""); $NewShortcut.WorkingDirectory=(""); $NewShortcut.Save(); <# Run the shortcut as Admin #> $Bytes_NewShortcut = [System.IO.File]::ReadAllBytes("${Filepath_NewShortcut}"); $Bytes_NewShortcut[0x15] = ($Bytes_NewShortcut[0x15] -bor 0x20); [System.IO.File]::WriteAllBytes("${Filepath_NewShortcut}", ${Bytes_NewShortcut}); <# Run the shortcut #> Invoke-Item -Path ("${Filepath_NewShortcut}");


}
# ------------------------------------------------------------
If ($False) {

<# (ALL EXCEPT INSTALL NOW) #>

<# Windows Updates - Open, Check-for, and Download "Windows Updates" (let user select the "Install Now" button) #>
Start-Process -Filepath ("C:\Windows\explorer.exe") -ArgumentList (@("ms-settings:windowsupdate")); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());

<# Create a "Windows Updates" shortcut on the desktop & run it #> $Filepath_NewShortcut = "${Home}\Desktop\Check for Updates.lnk"; $NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Filepath_NewShortcut}"); $NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"); $NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`""); $NewShortcut.WorkingDirectory=(""); $NewShortcut.Save(); <# Run the shortcut as Admin #> $Bytes_NewShortcut = [System.IO.File]::ReadAllBytes("${Filepath_NewShortcut}"); $Bytes_NewShortcut[0x15] = ($Bytes_NewShortcut[0x15] -bor 0x20); [System.IO.File]::WriteAllBytes("${Filepath_NewShortcut}", ${Bytes_NewShortcut}); <# Run the shortcut #> Invoke-Item -Path ("${Filepath_NewShortcut}");

}
# ------------------------------------------------------------
If ($False) {

<# Windows Updates - Just do check-for + download available "Windows Updates" #>
((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());

<# Windows Updates - Just open "Windows Updates" #>
Start-Process -Filepath ("C:\Windows\explorer.exe") -ArgumentList (@("ms-settings:windowsupdate"));

}
# ------------------------------------------------------------
If ($False) {

<# Clear out cached Windows Updates #> Get-Service | Where-Object { $_.DisplayName -Eq 'Windows Update' } | ForEach-Object { Write-Host "Stopping `"$($_.DisplayName)`"..."; $_ | Stop-Service; }; If (Test-Path ("C:\Windows\SoftwareDistribution\Download")) { Move-Item -Path ("C:\Windows\SoftwareDistribution\Download") -Destination ("${Env:APPDATA}\SoftwareDistribution-Download.$(Get-Date -UFormat '%Y%m%d-%H%M%S').bak") -Force; }; Get-Service | Where-Object { $_.DisplayName -Eq 'Windows Update' } | ForEach-Object { Write-Host "Starting `"$($_.DisplayName)`"..."; $_ | Start-Service; }; <# Check-for & Download available Windows Updates #> ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());


}
# ------------------------------------------------------------
If ($False) {

# Inspect Auto-Update Settings for Windows Update

((New-Object -ComObject Microsoft.Update.AutoUpdate).Settings());


}
# ------------------------------------------------------------
If ($False) {

# TO-BE-TESTED --> "To Install all downloaded Updates and restart the computer if required" (from michlstechblog.info)

If ($True) {
	$oInstaller=(New-Object -ComObject Microsoft.Update.Session).CreateUpdateInstaller();
	$aUpdates=New-Object -ComObject Microsoft.Update.UpdateColl;
	((New-Object -ComObject Microsoft.Update.Session).CreateupdateSearcher().Search("IsAssigned=1 and IsHidden=0 and IsInstalled=0 and Type='Software'")).Updates|%{
			if(!$_.EulaAccepted){$_.EulaAccepted=$true};
			[void]$aUpdates.Add($_);
	}
	$oInstaller.ForceQuiet=$true;
	$oInstaller.Updates=$aUpdates;
	if($oInstaller.Updates.count -ge 1){
		write-host "Installing " $oInstaller.Updates.count "Updates";
		if($oInstaller.Install().RebootRequired){Restart-Computer};
	} else {
		write-host "No updates detected";
	}
}


}
# ------------------------------------------------------------
If ($False) {

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


}
# ------------------------------------------------------------
If ($False) {

# Deprecated - Using wuauclt.exe

wuauclt.exe /updatenow


}
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Invoke-Item (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/invoke-item?view=powershell-5.1
#
#   docs.microsoft.com  |  "Launch the Windows Settings app - UWP applications | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/uwp/launch-resume/launch-settings-app
#
#   michlstechblog.info  |  "Windows 10: Trigger detecting updates from command line"  |  https://michlstechblog.info/blog/windows-10-trigger-detecting-updates-from-command-line/
#
#   omgdebugging.com  |  "Command Line Equivalent of wuauclt in Windows 10 / Windows Server 2016"  |  https://omgdebugging.com/2017/10/09/command-line-equivalent-of-wuauclt-in-windows-10-windows-server-2016/
#
#   superuser.com  |  "command line - Can I get more information on what Windows Update is doing? - Super User"  |  https://superuser.com/a/1186355
#
#   superuser.com  |  "How to force Windows Server 2016 to check for updates - Super User"  |  https://superuser.com/a/1352500
#
#   www.thewindowsclub.com  |  "What is UsoClient.exe in Windows 10"  |  https://www.thewindowsclub.com/usoclient-exe-windows-10
#
#   www.windows-commandline.com  |  "Run command for Windows update"  |  https://www.windows-commandline.com/run-command-for-windows-update/
#
# ------------------------------------------------------------