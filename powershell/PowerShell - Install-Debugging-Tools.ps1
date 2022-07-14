# ------------------------------------------------------------
#
# Windows - Disable IPv6 via the Registry
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT REMOTELY


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Install-Debugging-Tools.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------
If ($True) {
<# Create a "Windows Updates" shortcut on the desktop #> $Filepath_NewShortcut = "${Home}\Desktop\Check for Updates.lnk"; $NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Filepath_NewShortcut}"); $NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"); $NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`""); $NewShortcut.WorkingDirectory=(""); $NewShortcut.Save(); <# Run the shortcut as Admin #> $Bytes_NewShortcut = [System.IO.File]::ReadAllBytes("${Filepath_NewShortcut}"); $Bytes_NewShortcut[0x15] = ($Bytes_NewShortcut[0x15] -bor 0x20); [System.IO.File]::WriteAllBytes("${Filepath_NewShortcut}", ${Bytes_NewShortcut});
}
# ------------------------------------------------------------
If ($True) {
	<# Temporarily force TLS 1.2 as the default networking security protocol for external downloads #>
	$ProtoBak=([System.Net.ServicePointManager]::SecurityProtocol);
	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12
	Clear-DnsClientCache;
	If ($null -eq (Get-Command "choco" -ErrorAction "SilentlyContinue")) {
		<# Install Chocolatey -  Chocolatey is a software management automation tool for Windows that wraps installers, executables, zips, and scripts into compiled packages #>
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	}
	If ((Get-Command "choco" -ErrorAction "SilentlyContinue") -NE $Null) {
		Start-Process -Filepath ("choco") -ArgumentList (@("feature","enable","-n=allowGlobalConfirmation")) -NoNewWindow -Wait -PassThru;
		Write-Output "`n`nInstalling VMware Tools..."; Start-Process -Filepath ("choco") -ArgumentList (@("install","vmware-tools")) -NoNewWindow -Wait -PassThru;
		Write-Output "`n`nInstalling Mozilla Firefox..."; Start-Process -Filepath ("choco") -ArgumentList (@("install","firefox")) -NoNewWindow -Wait -PassThru;
		Write-Output "`n`nInstalling Visual Studio Code..."; Start-Process -Filepath ("choco") -ArgumentList (@("install","vscode.install")) -NoNewWindow -Wait -PassThru;
	}
	<# Restore the previously-defined networking security protocol #>
	[System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	<# Check for pending reboot #>
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	CheckPendingRestart;
}

