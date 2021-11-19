# ------------------------------------------------------------
#
# PowerShell - CanonicalPathUpdater
#   |
#   |--> Description:
#          - Updates local PATH environment variables (System & User) to match the case-sensitive directory names of all filepaths held in the PATH.
#          - Does not modify any non-existent filepaths in the PATH env var (since there is no canonical path for a non-existent directory)
#
# ------------------------------------------------------------
Function CanonicalPathUpdater() {
	Param(
		[Switch]$AlwaysGetHelp,
		[Switch]$NoGetHelp,
		[Switch]$NoMethods,
		[Switch]$NoOther,
		[Switch]$NoProperties,
		[Switch]$NoRegistry,
		[Switch]$NoValue,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CanonicalPathUpdater/CanonicalPathUpdater.psm1') ).Content) } Catch {}; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		CanonicalPathUpdater @{"a"="b";"c"="d";};

	}

	# $MyInvocation.MyCommand.Name

	<# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator) #>
	$RunningAsAdmin = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"));
	If ($RunningAsAdmin -Eq $False) {
		# ------------------------------
		# NOT running as Admin --> Rerun as admin

	} Else {

		# ------------------------------
		# IS running as Admin --> Canonicalize all PATH env vars

		If ($True) {
			<# SYSTEM PATH - Resolve all filepaths to their canonical filepaths (resolve upper/lower case filepaths to whatever the exact case-sensitive filepath) #>
			$SystemPath=(Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment") -Name ("Path"));
			$EnvVars_BackupPath="$([System.IO.Path]::GetFullPath(${env:TEMP}))\env-PATH.system.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz').bak.txt";
			Set-Content -Path "${EnvVars_BackupPath}" -Value "${SystemPath}";
			Write-Host "Backed up the SYSTEM-scoped environment variable PATH to `"${EnvVars_BackupPath}`"";
			$ResolvedArr=@();
			$UpdatePath = $False;
			((${SystemPath}).Split([String][Char]59)) | Sort-Object -Unique | ForEach-Object {
				If ("${_}" -Eq "") { <# Blank PATH item(s) - e.g. if PATH item is simply a semicolon ";" #>
					$UpdatePath = $True;
				} Else {
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
			}
			If (${UpdatePath} -Eq $True) {
				$Updated_RegistryProp=(${ResolvedArr} -join ";");
				Set-ItemProperty -Force -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment") -Name ("Path") -Value ("${Updated_RegistryProp}");
				[System.Environment]::SetEnvironmentVariable("Path","${Updated_RegistryProp}",[System.EnvironmentVariableTarget]::Machine);
			}
		}

		If ($True) {
			<# USER PATH (Admin User) - Resolve all filepaths to their canonical filepaths (resolve upper/lower case filepaths to whatever the exact case-sensitive filepath) #>
			$UserPath=(Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_CURRENT_USER\Environment") -Name ("Path"));
			$EnvVars_BackupPath="$([System.IO.Path]::GetFullPath(${env:TEMP}))\env-PATH.user.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz').bak.txt";
			Set-Content -Path "${EnvVars_BackupPath}" -Value "${UserPath}";
			Write-Host "Backed up the USER-scoped environment variable PATH to `"${EnvVars_BackupPath}`"";
			$ResolvedArr=@();
			$UpdatePath = $False;
			((${UserPath}).Split([String][Char]59)) | Sort-Object -Unique | ForEach-Object {
				If ("${_}" -Eq "") { <# Blank PATH item(s) - e.g. if PATH item is simply a semicolon ";" #>
					$UpdatePath = $True;
				} Else {
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
			}
			If (${UpdatePath} -Eq $True) {
				$Updated_RegistryProp=(${ResolvedArr} -join ";");
				Set-ItemProperty -Force -LiteralPath ("Registry::HKEY_CURRENT_USER\Environment") -Name ("Path") -Value ("${Updated_RegistryProp}");
				[System.Environment]::SetEnvironmentVariable("Path","${Updated_RegistryProp}",[System.EnvironmentVariableTarget]::User);
			}
		}

		If ($True) {
			<# USER PATH (NON-Admin User) - Resolve all filepaths to their canonical filepaths (resolve upper/lower case filepaths to whatever the exact case-sensitive filepath) #>
			# ------------------------------
			$NonAdmin_UserSID=((Get-CimInstance -ClassName "Win32_UserAccount" -Filter "Name='$((((Get-CimInstance -ClassName "Win32_ComputerSystem").UserName).Split("\"))[1])' and Domain='$((Get-CimInstance -ClassName "Win32_ComputerSystem").DNSHostName)'").SID);
			# $NonAdmin_UserPath=(Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_CURRENT_USER\Environment") -Name ("Path"));
			$NonAdmin_UserPath=(Get-ItemPropertyValue -LiteralPath ("Registry::HKEY_USERS\${NonAdmin_UserSID}\Environment") -Name ("Path"));
			# ------------------------------
			$EnvVars_BackupPath="$([System.IO.Path]::GetFullPath(${env:TEMP}))\env-PATH.user.$(Get-Date -Format 'yyyyMMddTHHmmss.ffffffzz').bak.txt";
			Set-Content -Path "${EnvVars_BackupPath}" -Value "${NonAdmin_UserPath}";
			Write-Host "Backed up the USER-scoped environment variable PATH to `"${EnvVars_BackupPath}`"";
			$ResolvedArr=@();
			$UpdatePath = $False;
			((${NonAdmin_UserPath}).Split([String][Char]59)) | Sort-Object -Unique | ForEach-Object {
				If ("${_}" -Eq "") { <# Blank PATH item(s) - e.g. if PATH item is simply a semicolon ";" #>
					$UpdatePath = $True;
				} Else {
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
			}
			If (${UpdatePath} -Eq $True) {
				$Updated_RegistryProp=(${ResolvedArr} -join ";");
				Set-ItemProperty -Force -LiteralPath ("Registry::HKEY_USERS\${NonAdmin_UserSID}\Environment") -Name ("Path") -Value ("${Updated_RegistryProp}");
				# [System.Environment]::SetEnvironmentVariable("Path","${Updated_RegistryProp}",[System.EnvironmentVariableTarget]::User);
			}
		}

	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "CanonicalPathUpdater";
}


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Member"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-member?view=powershell-6
#
#   powershellexplained.com  |  "Powershell: Everything you wanted to know about arrays"  |  https://powershellexplained.com/2018-10-15-Powershell-arrays-Everything-you-wanted-to-know/#write-output--noenumerate
#
#   stackoverflow.com  |  "Searching for UUIDs in text with regex"  |  https://stackoverflow.com/a/6640851
#
# ------------------------------------------------------------