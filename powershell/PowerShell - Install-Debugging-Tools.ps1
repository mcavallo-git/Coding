# ------------------------------------------------------------
#
# Windows - Disable IPv6 via the Registry
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT REMOTELY


$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/PowerShell%20-%20Install-Debugging-Tools.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;


}
# ------------------------------------------------------------
If ($True) {
	<# Windows Updates (Create a shortcut on the desktop) - Open, Check-for, and Download "Windows Updates" (let user select the "Install Now" button) #>
	$NewShortcut = (New-Object -ComObject WScript.Shell).CreateShortcut("${Home}\Desktop\Check for Updates.lnk"); $NewShortcut.TargetPath=("C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe"); $NewShortcut.Arguments=("-Command `"Start-Process -Filepath ('C:\Windows\explorer.exe') -ArgumentList (@('ms-settings:windowsupdate')); ((New-Object -ComObject Microsoft.Update.AutoUpdate).DetectNow());`""); $NewShortcut.WorkingDirectory=(""); $NewShortcut.Save();
}
# ------------------------------------------------------------
If ($True) {
	<# Temporarily force TLS 1.2 as the default networking security protocol for external downloads #>
	$ProtoBak=([System.Net.ServicePointManager]::SecurityProtocol);
	[Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12
	Clear-DnsClientCache;
	If ((Get-Command "choco" -ErrorAction "SilentlyContinue") -Eq $Null) {
		<# Install Chocolatey -  Chocolatey is a software management automation tool for Windows that wraps installers, executables, zips, and scripts into compiled packages #>
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
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
	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [Net.ServicePointManager]::SecurityProtocol=[Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	CheckPendingRestart;
}

