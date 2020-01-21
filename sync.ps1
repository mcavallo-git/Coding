<# ------------------------------------------------------------ #>

<#   Start-Process PowerShell.exe $(New-Object Net.WebClient).DownloadString("https://ps.mcavallo.com/$((Date).Ticks).ps1") -Verb RunAs;   #>

<# ------------------------------------------------------------ #>

If (("AllSigned","Default","Restricted","Undefined") -contains (Get-ExecutionPolicy)) {
	Set-ExecutionPolicy "RemoteSigned" -Force;
}

If (! (Get-Command "git")) {
	Write-Host "Error:  Please install Git SCM from url:  [  https://git-scm.com/download/win ]" -ForegroundColor Gray;

} Else {
		
	Write-Host "Info:  Loading personal and system profiles...`n" -ForegroundColor Gray;

	Write-Host "Info:  Local PowerShell Version: $(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10))`n" -ForegroundColor Gray;

	<# ------------------------------------------------------------ #>

	$AliasName="grep"; $AliasCommand="Select-String";
	Write-Host "Info:  Checking for Alias `"${AliasName}`"..." -ForegroundColor Gray;
	If ( (Get-Alias).Name -Contains "${AliasName}" ) {
		If ( ((Get-Alias -Name "${AliasName}").ResolvedCommand.Name) -Ne ("${AliasCommand}")) {
			Remove-Item "alias:\${AliasName}";
			New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
		}
	} Else {
		New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
	}

	$AliasName="which"; $AliasCommand="Get-Command";
	Write-Host "Info:  Checking for Alias `"${AliasName}`"..." -ForegroundColor Gray;
	If ( (Get-Alias).Name -Contains "${AliasName}" ) {
		If ( ((Get-Alias -Name "${AliasName}").ResolvedCommand.Name) -Ne ("${AliasCommand}")) {
			Remove-Item "alias:\${AliasName}";
			New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
		}
	} Else {
		New-Alias -Name "${AliasName}" -Value "${AliasCommand}";
	}

	<# ------------------------------------------------------------ #>

	Write-Host "Info:  Syncing local git repository to origin `"https://github.com/mcavallo-git/Coding.git`"..." -ForegroundColor Green;

	If ( ${HOME} -Eq ${Null} ) {
		$HOME = ((Resolve-Path "~").Path);
	}

	$REPO_DIR_WIN32 = "${HOME}\Coding";

	If (Test-Path "${REPO_DIR_WIN32}") {

		Set-Location "${REPO_DIR_WIN32}";

		git reset --hard "origin/master";

		git pull;

	} Else {

		<# Get current DateTime with microsecond precision #>
		$EpochDate = ([Decimal](Get-Date -UFormat ("%s")));
		$EpochToDateTime = (New-Object -Type DateTime -ArgumentList 1970, 1, 1, 0, 0, 0, 0).AddSeconds([Math]::Floor($EpochDate));
		$DecimalTimestampShort = ( ([String](Get-Date -Date ("${EpochToDateTime}") -UFormat ("%Y%m%d-%H%M%S"))) + (([String]((${EpochDate}%1))).Substring(1).PadRight(6,"0")) );

		New-Item -ItemType ("Directory") -Path "${REPO_DIR_WIN32}" | Out-Null;

		$SSH_KEY_LOCAL_WIN32="${HOME}\.ssh\id_rsa";
		$SSH_KEY_LOCAL_LINUX=(("/")+(((${SSH_KEY_LOCAL_WIN32} -Replace "\\","/") -Replace ":","")));

		$SSH_KEY_LOCAL_WIN32_BAK="${SSH_KEY_LOCAL_WIN32}.${DecimalTimestampShort}.bak";
		$SSH_KEY_LOCAL_LINUX_BAK="${SSH_KEY_LOCAL_LINUX}.${DecimalTimestampShort}.bak";

		$SecretBase64 = "LQAtAC0ALQAtAEIARQBHAEkATgAgAFIAUwBBACAAUABSAEkAVgBBAFQARQAgAEsARQBZAC0ALQAtAC0ALQAKAE0ASQBJAEUAbwB3AEkAQgBBAEEASwBDAEEAUQBFAEEAeABIAFcAcgBjAEUAUQBiAHIAZQB1AGMAVQBYAEIAMQBVACsAMgBlAGwAMwBRADIASABiAHMAZQAwAEwAWAB1AGUAZQBpADkAbABYAE4AYQB2AHkATgBsADYAMQBRAE0ACgBhAG4AdQA5AFAAeQBGAFUALwBGADYARABKAHAAOAAyADUAMwA4AGoAegBwADYAbQAxAFAANQBhAG8AagBJAGQAOQBpAFIAdABxAHkAMgB1AEMAZgBiAEQAbwB6ADcAbABUACsASABuAFYAWABqADcAVQBTAHQAbQAwAHoAQgBoAAoAUwA1AHUASQBvAGsAagBBAHcARwBYAEsANQB2ADYAWABoAEMANQBvAHoAUQBFAGcAbQBHADIAdABsAHYASABlADUAYwA4AHAANwB1AGsAawBmAEQAQgAwADgAcwBLAFIATQAzAHgANQB0AC8AaQBrADUAWABXAEwAZQBPAEUAbgAKAHQAVAA3AEYAQwB4AHEAcgBVAFEANgB6AEcAOQBsAEQAMwB6AGUASQAyADQAdABwADYANgBlADkAZQBrADcAawAzAGQAUABJAGYARgBLAE4ALwBSADgAWgBNADgATgBlAHcAcgBGAFEATgBnAHkAcAArAEYAeAByAFMAeQBKAFYACgBwAGwAUQBrAHEAWgArAEoANwA4AGYASwBuAGgAYgA2AFEAOAB5AFIAZgBNAHcAZQBMAEMAcQB0AGMAMQBIAEsAVABCADkAQgB6ADEANwBaAFgAbwBJAHkAYgBoAGEAQwBDAFgAZgBHAFUAdABVAEsAKwBpAG4AWABTAEQAcQB3AAoARABaAG8AcQBIAG4AegA5AEcATgBsAHYAVABBAFcASgBiACsAeQAvADMARABPAE4AdgBDAGEAQQBzAGoAdgBJAFIAagAvADcAdwBRAEkARABBAFEAQQBCAEEAbwBJAEIAQQBEAEYANwBuAGUAbgBTAEQAZABLADUAcABJADcAUwAKAHIANABxAHIATQBDAFgAZgByAEgAMwBDAGsAdABsAG8ANgBaADgAbABJAHgATgBRAGsAYwB2AFEANAA2AHYAcABhAEoATQB0AGgAWgBZAHcARgBCAEwAWQB6ADEAbgBjAEEAbAAwACsAcABjAHMAMgBKAEwAbABEAE0ANQByAGsACgAyAHEAMABUAHMAZABmAEsAMABxAHAASgAwAEMANwArACsAWQAwAHMAVABqAE0AMgBIAEwANwB1AEcAcQBFAFkANwAzAGkAMgB2AFMAeAA2AC8ASwBtADUATwBlAGsAQwB1AFQARQBlADYAMgBDAHYAWgB3AEYAZABwAHIAcAA5AAoAUQAzAEoASQB3AHIAdwBkAFYAdwBZADgAdwBrAGcAZQAvADYAbQBqAE0AWgBsAEgAOQBHAGkAaQB5AEwAcQA5AGkAaAA0AC8AZgA3AHAAMwBWAGYARwB6AFgAeABCAEgAVgBMADkAZwBsAG4ATgBFADQAQgBKAHkAQgBQAEoAWQAKAEkAdABWAHQAQwBxAGYAUABUAHYAegBjAGcAbwBJAEMAcwBBACsAaABSAGkAbgBLAGwATAB4AHIAMwBvAHUAZwBHAHgAVAAxAHMAOAB1AHEAaABrAHAAQQB3AEYARAA0AHMAeQBnAFEANQBjADUAZQBvADYAWQBaAHkAVQB5AEgACgA5AE8AMwAyAHAAYgBLAGkAdAB2ADYAVQBGAFEAZQBwAHQAZwBIAFMAcwA4AFkAegBPAGgAbAA4AFMAWQB3AGwARgB4AEQAYwBKAHoAawBwADQAZwBNADMAVwA1AFgAcgBhAE4AbQBxAEcATQB0AEsAdwAvAGsAcgBzAFIAZQBOAAoAZABPAEsAeQB2AFYAMABDAGcAWQBFAEEANABxAE0ANgBBAG4AbwBOADAAagBHADAARQA4AFEAZwBqADAARgBKADQAeABIAFAAbQAvAHUAMwBtAFUATAAwAHcAZgBaAG8AcwBkAEkAQwBMAFUAdABuAHUAcQB4AGcAawB5AFkAWQAKAE0AZABtAGgATwAzACsAUgBzADEAVgArAGQAWAA3AEkAaQBCAGcAMgBaAHIAKwBoAE8AVQArAHUAegArAFAASgBSAGwAeQB4AFYAVgAwAFcARQBCAFYAVABSAHUAMwBxAEYALwBQAEMAQQBiAEgAdgA4AFIAdgBHAEsAWQB4ADcACgBvAFQAQwBwAGgAYgAxAHUAcgA3AFgAWgBrAGMAeABZAEwAaQBMAGoAZwBDAFkARgBJAEoAcgB5AE8AeQAzAFEAOQBsAFYAbAA3ADEANgBaAEUAdgAwAGsAcgByAHEAbABtAFQAMwBKADAAYgBNAEMAZwBZAEUAQQAzAGUAbQBMAAoAMQBrAGYARwBTACsAcABkAHUAdgBEAEUALwA5ADAAZwAzAFIAZQB6AHkAOABBAFAAawBIAGIASwBpAEsAOABpAHgAZQB0AE0AbQBuAHIAZwAwADEAZwBDAGsAYwAwAEMAcQBIADUASAA5AGkAVAAzAHAATwBmAHUAegBZACsAegAKAHcAZABoAGIANgAyAFUAYwBhAHYASgBtAG8AegBPAGcAZQBGAEsATQBoAHUAYgB0AFoANgBQAEcAegBOAE8ARQBqAFEAeABkAEEAZQAvAE0AOQBQADAAWgBqAHIAVgBzADAAcQAzAGwANABNAG4AbABkAGMAcAA4ADIANgBtAEkACgBPAHAAUQBFAGEARABtAE8AVwBKAE0ASgBHADcALwB0AHkAQgBSAHEAeABJADcANgAyAEgAcwBkAG8AMwBRAEEANABEAHQASgArAHIAcwBDAGcAWQBFAEEAagBYAGsAeQA1AHcAVABsAHgAOABZADcARQBQAE8AbgBGADQAVwA3AAoANQA4AEQAZwBoAGgAQgBWAGgAWgBoAGsAVABRAGYAUwBSAHQANAAvAGUAYQBMAE8AZAA1AHIAUABGAGsAdgA3AFkAbgBMAGwAMABNAHgATABXAFYAVQBQAEEAYQAxAEkANQBKAHUAbwBxAGUAOABKAFoAMABzADAAWgBwAFYAYwAKAHUAVQAxADMAYgBVAEEAVQBXADYAbgBVAE8ARAB5AGYAbQBxAEEAUgBCAFIAbgBjAEcALwBnAG8AZABSAHMANgB1AFYANAAxAEYARQBVAHgANgBRAEYAdABkAFQAUABIAC8AOQBUAEwAaQB0ADAAdwA2AGkAKwBPADgAaAA0AGgACgBpAFEATwA2AEEALwBoAGIATwBaADEASAAzAHMASwBvAFMATQBaAG4AUwB6ADAAQwBnAFkAQQBLAGEAegAyAHkAaQBOAG8AcABsAEUANQBrAFMAWQB1AG0AUwA3AGEAUQBTAHQAMgBaAE0AbQBKAEkAcwBSAHMAZgBRAGMASABMAAoATQB4AG4AOABvAHMAcABOAGcAZgBOAFUANwB5AEEAeAAwAHcAUQBEADcAWQBaAG4AQwByAEMAdQBuAEIARwBmAGgAMAA0AEIAaABsAFQASQBQAEsAdABPAC8ARQB5AEwAZQBhAHkANQBaAEwAdwArAHcAbgBUAEMAQgB5AGgAUgAKAEMAdwBTAE8ANAA3AGgAbQB4AEQAOQBmADgATwBxADAARgBaAEEAVwBkAHMAUQA4AFAASQA2AFMATABhAHEARQB2AFoAQgBiAGEARwBCAGoAagBqAHUAKwBQAHMAdQBtAE8AagBjAHQARgBWADEAMwByAG8AZwBjAHQAWQBTAFoACgBBAG8AKwBkAG8AdwBLAEIAZwBHAEwAVABiAFEAeQBKAEEAZQB2AHoAVgArAGoAQwBlADEAUwA0ADUAUQBwAGUAOAA3AHgAMwA2AFMAZwB5AHMAbwBqAEsANAA0AFgAWgBSAE4AawAwAFUAaQBJAHkAZQBRADUAZwBmADgANQA0AAoAcgBKAGoAbwA5AFgAYgBUADgAawBNAFMAKwBQAFoAZgBiAG8ASgBPAGcASABnAEQAbgBpAFQANgB3AHcAVABSAEsAZQBzAGIATAB6AHEAWQBqAGIASgBpAEsAVgBkAE8AdABBADkAbQA5AE0ANQBHAHUAQwBZAFoAbwBDAFUAUwAKADcAZQA4AFkANgBuAGcASABEAFMAUgBVAHQAaABhAC8AeQBvAFkAcQB0AHoAZABDAFEASwAzAEkAOQBtAGQAQQAzAGoATAB6AHkAZwAxAGQAUgByADgALwB6ADcAbgBMAHcAOQA3ACsACgAtAC0ALQAtAC0ARQBOAEQAIABSAFMAQQAgAFAAUgBJAFYAQQBUAEUAIABLAEUAWQAtAC0ALQAtAC0A";
		$SecretPlaintext = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String(${SecretBase64}));


		<# Do not overwrite the id_rsa file (default private key used by SSH methods, including Git) - rather, rename it (temporarily) #>
		If ((Test-Path ("${SSH_KEY_LOCAL_WIN32}")) -Eq $True) {
			$SecretHashed = (New-Object System.Security.Cryptography.SHA256Managed | ForEach-Object {$_.ComputeHash([System.Text.Encoding]::UTF8.GetBytes("${SecretPlaintext}"))} | ForEach-Object {$_.ToString("x2")});
			$SshKeyHashed = ((Get-FileHash "${SSH_KEY_LOCAL_WIN32}").Hash);
			Write-Host "`n`n";
			If ("${SshKeyHashed}" -Ne "${SshKeyHashed}") {
				Write-Host "Info:  Checksums are NOT equivalent for private key ~/.ssh/id_rsa";
				Move-Item -Path "${SSH_KEY_LOCAL_WIN32}" -Destination "${SSH_KEY_LOCAL_WIN32_BAK}" -Force | Out-Null;
			} Else {
				Write-Host "Info:  Checksums ARE equivalent for private key ~/.ssh/id_rsa";
			}
			Write-Host "`$SecretHashed = [ ${SecretHashed} ]";
			Write-Host "`$SshKeyHashed = [ ${SshKeyHashed} ]";
			Write-Host "`n`n";
		}

		New-Item -ItemType "File" -Path ("${SSH_KEY_LOCAL_WIN32}") -Value (${SecretPlaintext}) -Force | Out-Null;

		Write-Host "`n`n";
		Write-Host "Created ssh-key for Git @ filepath `"${SSH_KEY_LOCAL_WIN32}`"";
		Write-Host "`n`n";

		$Env:EMAIL = "email@email.emailo";
		$Env:GIT_SSH_COMMAND = "ssh -i `"${SSH_KEY_LOCAL_LINUX}`" -o StrictHostKeyChecking=no";
		$Env:NAME = "${Env:USERNAME}@${Env:COMPUTERNAME}";

		Set-Location "${REPO_DIR_WIN32}";

		git init;
		git remote add origin "git@github.com:mcavallo-git/Coding.git";
		git remote set-url origin "git@github.com:mcavallo-git/Coding.git";
		git config --local --replace-all core.sshcommand "$($Env:GIT_SSH_COMMAND)";
		git config --local --replace-all user.name "$($Env:NAME)";
		git config --local --replace-all user.email "$($Env:EMAIL)";

		git fetch --all;
		git checkout -f master;
		git pull;

	}

	<# Return the pre-existing id_rsa file (default private key used by SSH methods, including Git) to its original location (~/.ssh/id_rsa), afterwards #>
	Write-Host "`n`n";
	Write-Host "`$SSH_KEY_LOCAL_WIN32_BAK = [ ${SSH_KEY_LOCAL_WIN32_BAK} ]";
	Write-Host "`n`n";

	If ((Test-Path ("${SSH_KEY_LOCAL_WIN32_BAK}")) -Eq $True) {
		Move-Item -Path "${SSH_KEY_LOCAL_WIN32_BAK}" -Destination "${SSH_KEY_LOCAL_WIN32}" -Force | Out-Null;
	}

	. "${HOME}\Coding\powershell\_WindowsPowerShell\Modules\ImportModules.ps1";

	Write-Host "`nInfo:  PowerShell Modules Synchronized`n" -ForegroundColor Cyan;

	Set-Location "${HOME}";

}



# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-FileHash - Computes the hash value for a file by using a specified hash algorithm"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-filehash
#
#   gist.github.com  |  "Powershell one liner to Hash a string using SHA256 · GitHub"  |  https://gist.github.com/benrobot/67bacea1b1bbe4eb0d9529ba2c65b2a6
#
# ------------------------------------------------------------