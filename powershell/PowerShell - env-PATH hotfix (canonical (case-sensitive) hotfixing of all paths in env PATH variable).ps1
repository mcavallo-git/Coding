# ------------------------------------------------------------
#
# PowerShell - env-PATH hotfix (canonical (case-sensitive) hotfixing of all paths in env PATH variable)
#
# ------------------------------------------------------------

If ($True) {

If ($True) {
	<# SYSTEM PATH - Resolve all filepaths to their canonical filepaths (resolve upper/lower case filepaths to whatever the exact case-sensitive filepath) #>
	$SystemPath=(Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment") -Name ("Path"));
	$EnvVars_BackupPath="$([System.IO.Path]::GetFullPath(${env:TEMP}))\env-PATH.system.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz').bak.txt";
	Set-Content -Path "${EnvVars_BackupPath}" -Value "${SystemPath}";
	Write-Host "Backed up the SYSTEM-scoped environment variable PATH to `"${EnvVars_BackupPath}`"";
	$ResolvedArr=@();
	$UpdatePath = $False;
	((${SystemPath}).Split([String][Char]59)) | Sort-Object -Unique | Where-Object { "${_}" -NE ""; <# Ignore blank paths - e.g. if PATH starts with ";" #> } | ForEach-Object {
		$Path_NonCanonical=([System.IO.Path]::GetFullPath("${_}"));
		If ((Test-Path "${Path_NonCanonical}") -Eq $False) {
			$Path_Canonical="${Path_NonCanonical}";
		} Else {
			$Path_Canonical=(Get-ChildItem -Path ($Path_NonCanonical.TrimEnd('\')).Replace("\","\*") | Where FullName -IEQ ($Path_NonCanonical.TrimEnd('\')) | Select -ExpandProperty FullName);
			If ("${Path_Canonical}" -Eq "") {
				$Path_Canonical="${Path_NonCanonical}";
			} ElseIf (${Path_NonCanonical}[-1] -Eq "\") {
				$Path_Canonical += "\";
			}
			If (-Not ("${Path_NonCanonical}" -CEq "${Path_Canonical}")) {
				$UpdatePath = $True;
			}
		}
		$ResolvedArr+="${Path_Canonical}";
	}
	If (${UpdatePath} -Eq $True) {
		$Updated_RegistryProp=(${ResolvedArr} -join ";");
		Set-ItemProperty -Force -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment") -Name ("Path") -Value ("${Updated_RegistryProp}");
		[System.Environment]::SetEnvironmentVariable("Path","${Updated_RegistryProp}",[System.EnvironmentVariableTarget]::Machine);
	}
}

If ($True) {
	<# USER PATH - Resolve all filepaths to their canonical filepaths (resolve upper/lower case filepaths to whatever the exact case-sensitive filepath) #>
	$UserPath=(Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_CURRENT_USER\Environment") -Name ("Path"));
	$EnvVars_BackupPath="$([System.IO.Path]::GetFullPath(${env:TEMP}))\env-PATH.user.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz').bak.txt";
	Set-Content -Path "${EnvVars_BackupPath}" -Value "${UserPath}";
	Write-Host "Backed up the USER-scoped environment variable PATH to `"${EnvVars_BackupPath}`"";
	$ResolvedArr=@();
	$UpdatePath = $False;
	((${UserPath}).Split([String][Char]59)) | Sort-Object -Unique | Where-Object { "${_}" -NE ""; <# Ignore blank paths - e.g. if PATH starts with ";" #> } | ForEach-Object {
		$Path_NonCanonical=([System.IO.Path]::GetFullPath("${_}"));
		If ((Test-Path "${Path_NonCanonical}") -Eq $False) {
			$Path_Canonical="${Path_NonCanonical}";
		} Else {
			$Path_Canonical=(Get-ChildItem -Path ($Path_NonCanonical.TrimEnd('\')).Replace("\","\*") | Where FullName -IEQ ($Path_NonCanonical.TrimEnd('\')) | Select -ExpandProperty FullName);
			If ("${Path_Canonical}" -Eq "") {
				$Path_Canonical="${Path_NonCanonical}";
			} ElseIf (${Path_NonCanonical}[-1] -Eq "\") {
				$Path_Canonical += "\";
			}
			If (-Not ("${Path_NonCanonical}" -CEq "${Path_Canonical}")) {
				$UpdatePath = $True;
			}
		}
		$ResolvedArr+="${Path_Canonical}";
	}
	If (${UpdatePath} -Eq $True) {
		$Updated_RegistryProp=(${ResolvedArr} -join ";");
		Set-ItemProperty -Force -LiteralPath ("Registry::HKEY_CURRENT_USER\Environment") -Name ("Path") -Value ("${Updated_RegistryProp}");
		[System.Environment]::SetEnvironmentVariable("Path","${Updated_RegistryProp}",[System.EnvironmentVariableTarget]::User);
	}
}

}


# ------------------------------------------------------------

# Example of why we need to hotfix/clean the PATH:

# ${PATH} contains:
# /mnt/c/windows/system32
# /mnt/c/WINDOWS/system32
# /mnt/c/Windows/system32

# What it actually is:
# /mnt/c/Windows/System32
#   ^-- Messes with WSL case sensitive paths, badly



# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "How do I get a path with the correct (canonical) case in PowerShell? - Stack Overflow"  |  https://stackoverflow.com/a/42213654
#
# ------------------------------------------------------------