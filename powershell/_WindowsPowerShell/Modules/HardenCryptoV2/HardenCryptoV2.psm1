function HardenCryptoV2 {
	Param(
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/HardenCryptoV2/HardenCryptoV2.psm1') ).Content) } Catch {}; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; If (-Not (Get-Command -Name 'HardenCryptoV2' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\HardenCryptoV2\HardenCryptoV2.psm1', ((Get-Variable -Name 'HOME').Value))); };
		HardenCryptoV2;


	}
	# ------------------------------------------------------------

	# If ((RunningAsAdministrator) -Ne ($True)) {
	# 	PrivilegeEscalation -Command ("HardenCryptoV2") {
	# } Else {

	<# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator) #>
	$RunningAsAdmin = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"));
	If ($RunningAsAdmin -Eq $False) {
		<# Script is >> NOT << running as admin  -->  Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator) #>
		$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]$_).InvokeGet('AdsPath')});
		$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
		$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
		If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
			$CommandString = $MyInvocation.MyCommand.Name;
			$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -$_"; If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[$_])`""; } };
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;
		} Else {
			Write-Output "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n";
		}
	} Else {
		<# Script >> IS << running as Admin - Continue #>


		# ------------------------------------------------------------
		# TO-DO
		#
		#   Power Settings  -->  Monitor Off after 30-min
		#   Power Settings  -->  Never Sleep
		#   Screen Saver  -->  Activate  [ Blank-Screensaver ("None" option) ]  after  [ 20-min ]
		#
		#

		# ------------------------------------------------------------
		# Define any Network Maps which will be required during the runtime
		#  (Registry Root-Keys are actually Network Maps to the "Registry" PSProvider)

		$PSDrives = @();

		$PSDrives += @{
			Name="HKLM";
			PSProvider="Registry";
			Root="HKEY_LOCAL_MACHINE";
		};

		$PSDrives += @{
			Name="HKCC";
			PSProvider="Registry";
			Root="HKEY_CURRENT_CONFIG";
		};

		$PSDrives += @{
			Name="HKCR";
			PSProvider="Registry";
			Root="HKEY_CLASSES_ROOT";
		};

		$PSDrives += @{
			Name="HKU";
			PSProvider="Registry";
			Root="HKEY_USERS";
		};

		$PSDrives += @{
			Name="HKCU";
			PSProvider="Registry";
			Root="HKEY_CURRENT_USER";
		};

		$PSDrives += @{
			Name=$Null;
			PSProvider="Registry";
			Root="HKEY_PERFORMANCE_DATA";
		};

		$PSDrives += @{
			Name=$Null;
			PSProvider="Registry";
			Root="HKEY_DYN_DATA";
		};


		# ------------------------------------------------------------

		$RegEdits = @();

		#------------------------------------------------------------
		#
		#  HTTPS PROTOCOLS
		#
		
		$HTTPS_Protocols=@();
		$HTTPS_Protocols+=@{ ProtocolName="SSL 2.0"; Enabled=0; };
		$HTTPS_Protocols+=@{ ProtocolName="SSL 3.0"; Enabled=0; };
		$HTTPS_Protocols+=@{ ProtocolName="TLS 1.0"; Enabled=0; };
		$HTTPS_Protocols+=@{ ProtocolName="TLS 1.1"; Enabled=1; };
		$HTTPS_Protocols+=@{ ProtocolName="TLS 1.2"; Enabled=1; };

		${HTTPS_Protocols} | ForEach-Object {
			<# Setup enabled/disabled HTTPS Protocols #>
			$ProtocolName=(${_}.ProtocolName);
			$Enabled=([int](${_}.Enabled));
			$DisabledByDefault=([int](-not (${Enabled})));
			<# [Protocols] Server-Side #>
			$RegEdits += @{
				Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\${ProtocolName}\Server";
				Props=@(
					@{
						Description="${ProtocolName} - Protocol (HTTPS), server-side - affects incoming connections to local IIS/FTP/etc. services - Set to [ 0 ] to disable, [ 1 ] to enable.";
						Name="Enabled";
						Type="DWord";
						Value=${Enabled};
						Delete=$False;
					},
					@{
						Description="${ProtocolName} - Protocol (HTTPS), server-side - affects incoming connections to local IIS/FTP/etc. services - Set to [ 1 ] to disable-by-default, [ 0 ] to enable-by-default.";
						Name="DisabledByDefault";
						Type="DWord";
						Value=${DisabledByDefault};
						Delete=$False;
					}
				)
			};
			<# [Protocols] Client-Side #>
			$RegEdits += @{
				Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client";
				Props=@(
					@{
						Description="${ProtocolName} - Protocol (HTTPS), client-side - affects a multitude of outgoing connections, including powershell invoke-webrequest/etc. calls - Set to [ 0 ] to disable, [ 1 ] to enable.";
						Name="Enabled";
						Type="DWord";
						Value=${Enabled};
						Delete=$False;
					},
					@{
						Description="${ProtocolName} - Protocol (HTTPS), client-side - affects a multitude of outgoing connections, including powershell invoke-webrequest/etc. calls - Set to [ 1 ] to disable-by-default, [ 0 ] to enable-by-default.";
						Name="DisabledByDefault";
						Type="DWord";
						Value=${DisabledByDefault};
						Delete=$False;
					}
				)
			};
		}

		<# [Protocols] Client-Side #>
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client";
			Props=@(
				@{
					Description="${ProtocolName} - Protocol (HTTPS), client-side - affects a multitude of outgoing connections, including powershell invoke-webrequest/etc. calls - Set to [ 0 ] to disable, [ 1 ] to enable.";
					Name="Enabled";
					Type="DWord";
					Value=${Enabled};
					Delete=$False;
				},
				@{
					Description="${ProtocolName} - Protocol (HTTPS), client-side - affects a multitude of outgoing connections, including powershell invoke-webrequest/etc. calls - Set to [ 1 ] to disable-by-default, [ 0 ] to enable-by-default.";
					Name="DisabledByDefault";
					Type="DWord";
					Value=${DisabledByDefault};
					Delete=$False;
				}
			)
		};
New-ItemProperty -Force -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman") -Name ("ClientMinKeyBitLength") -PropertyType ("DWord") -Value ("3072") | Out-Null;


		#------------------------------------------------------------
		#
		#  HTTPS CIPHERS
		#

		$HTTPS_Ciphers=@();
		<# [Ciphers] Disable weak ciphers (cont.) #>
		$HTTPS_Ciphers+=@{ CipherName="DES 56/56";      Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="NULL";           Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC2 128/128";    Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC2 40/128";     Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC2 56/128";     Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC4 128/128";    Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC4 40/128";     Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC4 56/128";     Enabled=0; };
		$HTTPS_Ciphers+=@{ CipherName="RC4 64/128";     Enabled=0; };
		<# [Ciphers] Enable strong ciphers #>
		$HTTPS_Ciphers+=@{ CipherName="AES 128/128";    Enabled=1; };
		$HTTPS_Ciphers+=@{ CipherName="AES 256/256";    Enabled=1; };
		$HTTPS_Ciphers+=@{ CipherName="Triple DES 168"; Enabled=1; };

		# ------------------------------

		$DoUpdates_OutsideOfLoop=$False;

		<# Setup the parent registry key (to setup ciphers within) just once, then continue referencing it #>
		If (${DoUpdates_OutsideOfLoop} -Eq $True) {
			New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers';
			$RegistryKey_Ciphers = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\').OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $True));
			${HTTPS_Ciphers} | ForEach-Object {
				$RegistryKey_Ciphers.CreateSubKey(${_}.CipherName); <# Workaround for creating registry keys with forward-slashes in their name #>
			};
			$RegistryKey_Ciphers.Close();
		}
		<# [Ciphers] Enable/Disable each HTTPS Ciphers #>
		${HTTPS_Ciphers} | ForEach-Object {
			$CipherName=(${_}.CipherName);
			$Enabled=([int](${_}.Enabled));
			If (${DoUpdates_OutsideOfLoop} -Eq $True) {
				New-ItemProperty -Force -Path "Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\${CipherName}" -Name 'Enabled' -Value ${Enabled} -PropertyType 'DWord';
			} Else {
				$RegEdits += @{
					Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\${CipherName}";
					Props=@(
						@{
							Description="${CipherName} - Cipher Suite (HTTPS) - Set to [ 0 ] to disable, [ 1 ] to enable.";
							Name="Enabled";
							Type="DWord";
							Value=${Enabled};
							Delete=$False;
						}
					)
				};
			}
		}

		# ------------------------------

		# If ($False) {
		# 	<# [Ciphers] Disable weak ciphers #>
		# 	New-Item -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers';
		# 	$RegistryKey = ((Get-Item -Path 'Registry::HKEY_LOCAL_MACHINE\').OpenSubKey('SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers', $True));
		# 	$RegistryKey.CreateSubKey('AES 128/128');    <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('AES 256/256');    <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('DES 56/56');      <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('NULL');           <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC2 128/128');    <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC2 40/128');     <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC2 56/128');     <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC4 128/128');    <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC4 40/128');     <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC4 56/128');     <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('RC4 64/128');     <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.CreateSubKey('Triple DES 168'); <# Workaround for creating registry keys with forward-slashes in their name #>
		# 	$RegistryKey.Close();
		# 	<# [Ciphers] Disable weak ciphers (cont.) #>
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56/56' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\NULL' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 40/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64/128' -Name 'Enabled' -Value 0 -PropertyType 'DWORD';
		# 	<# [Ciphers] Enable strong ciphers (cont.) #>
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128/128' -Name 'Enabled' -Value 1 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256/256' -Name 'Enabled' -Value 1 -PropertyType 'DWORD';
		# 	New-ItemProperty -Force -Path 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168' -Name 'Enabled' -Value 1 -PropertyType 'DWORD';
		# }


		# ------------------------------------------------------------
		#
		# Group-Policy Setting(s)
		#
		#
		# EXPLANATION - WHY REGISTRY EDITS DON'T AFFECT GROUP POLICIES (GPEDIT.MSC)
		#  |
		#  |--> The registry only shows a read-only copy of the settings in the Group Policy Editor (gpedit.msc)
		#  |
		#  |--> The values held in the registry at a given point in time are calculated from the combined group policies applied to the workstation & user (and possibly domain) at any given point in time (and from any given user-reference)
		#  |
		#  |--> The source of these values is controlled not by setting the registry keys, but by using Group Policy specific commands to set the values which gpedit.msc pulls from, locally
		#
		If ($False) {
			Install-Module -Name ("PolicyFileEditor") -Scope ("CurrentUser") -Force;
			$HKLM_Path="SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services";  # <-- View exhaustive list of terminal services group policies (and their associated registry keys) https://getadmx.com/HKLM/SOFTWARE/Policies/Microsoft/Windows%20NT/Terminal%20Services
			$Name="MaxCompressionLevel";
			$Type="DWord";
			[UInt32]$Value = 0x00000002;
			If ($False) {
				Write-Output "";
				Write-Output "The following property sets the value to for Group Policy (gpedit.msc) titled 'Configure compression for RemoteFX data' to:  [ 0 - 'Do not use an RDP compression algorithm' ],  [ 1 - 'Optimized to use less memory' ],  [ 2 - 'Balances memory and network bandwidth' ],  or  [ 3 - 'Optimized to use less network bandwidth' ]";
				Write-Output "`n";
			}
			Set-PolicyFileEntry -Path ("${Env:SystemRoot}\System32\GroupPolicy\Machine\Registry.pol") -Key ("${HKLM_Path}") -ValueName ("${Name}") -Data (${Value}) -Type ("${Type}");
		}


		# ------------------------------------------------------------

		ForEach ($EachRegEdit In $RegEdits) {
			#
			# Root-Keys
			#   |--> Ensure that this registry key's Root-Key has been mapped as a network drive
			#   |--> Mapping this as a network drive grants this script read & write access to said Root-Key's registry values (which would otherwise be inaccessible)
			#
			If (($EachRegEdit.Path).StartsWith("Registry::") -Eq $False) {
				$Each_RegEdit_DriveName=(($EachRegEdit.Path).Split(':\')[0]);
				If ((Test-Path -Path (("")+(${Each_RegEdit_DriveName})+(":\"))) -Eq $False) {
					$Each_PSDrive_PSProvider=$Null;
					$Each_PSDrive_Root=$Null;
					Write-Output "`nInfo:  Root-Key `"${Each_RegEdit_DriveName}`" not found";
					ForEach ($Each_PSDrive In $PSDrives) {
						If ((($Each_PSDrive.Name) -Ne $Null) -And (($Each_PSDrive.Name) -Eq $Each_RegEdit_DriveName)) {
							$Each_PSDrive_PSProvider=($Each_PSDrive.PSProvider);
							$Each_PSDrive_Root=($Each_PSDrive.Root);
							Break;
						}
					}
					If ($Each_PSDrive_Root -Ne $Null) {
						Write-Output "  |-->  Adding Session-Based ${Each_PSDrive_PSProvider} Network-Map from drive name `"${Each_RegEdit_DriveName}`" to data store location `"${Each_PSDrive_Root}`"";
						New-PSDrive -Name "${Each_RegEdit_DriveName}" -PSProvider "${Each_PSDrive_PSProvider}" -Root "${Each_PSDrive_Root}" | Out-Null;
					}
				}
			}

			Write-Output ("`n$($EachRegEdit.Path)");
			ForEach ($EachProp In $EachRegEdit.Props) {

				# Check for each Key
				If ((Test-Path -LiteralPath ($EachRegEdit.Path)) -Eq $False) { # Key doesn't exist (yet)
					If (($EachProp.Delete) -eq $False) {  # Property isn't to-be-deleted
						# Create the key
						#
						# New-Item -Force
						#   |--> Upside - Creates ALL parent registry keys
						#   |--> Downside - DELETES all properties & child-keys if key already exists
						#   |--> Takeaway - Always use  [ Test-Path ... ]  to verify registry keys don't exist before using  [ New-Item -Force ... ]  to create the key
						#
						New-Item -Force -Path ($EachRegEdit.Path) | Out-Null;
						If ((Test-Path -LiteralPath ($EachRegEdit.Path)) -Eq $True) {
							Write-Output (("  |-->  !! Created this Registry Key"));
						}
					}
				}

				# Check for each Property
				Try {
					$GetEachItemProp = (Get-ItemPropertyValue -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -ErrorAction ("Stop"));
				} Catch {
					$GetEachItemProp = $Null;
				};

				$EchoDetails = "";

				If ($GetEachItemProp -NE $Null) {  # Property exists

					If (($EachProp.Delete) -Eq $False) {  # Property should NOT be deleted

						$EachProp.LastValue = $GetEachItemProp;
							
						If (($EachProp.LastValue) -Eq ($EachProp.Value)) {

							# Do nothing to the Property (already exists with matching type & value)
							Write-Output "  |-->  Skipping Property `"$($EachProp.Name)`" (already up-to-date) ${EchoDetails}";

						} Else {

							# Update the Property
							Write-Output "  |-->  !! Updating Property `"$($EachProp.Name)`" (w/ type `"$($EachProp.Type)`" to have value `"$($EachProp.Value)`" instead of (previous) value `"$($EachProp.LastValue)`" ) ${EchoDetails}";
							Set-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value) | Out-Null;

						}

					} Else { # Property (or Key) SHOULD be deleted

						If (($EachProp.Name) -Eq "(Default)") {

							# Delete the Registry-Key
							Remove-Item -Force -Recurse -LiteralPath ($EachRegEdit.Path) -Confirm:$False | Out-Null;
							If ((Test-Path -LiteralPath ($EachRegEdit.Path)) -Eq $False) {
								Write-Output "  |-->  !! Deleted Key";
								Break; # Since we're removing the registry key, we can skip going over the rest of the current key's properties (since the key itself should no longer exist)
							}

						} Else {

							# Delete the Property
							Write-Output "  |-->  !! Deleting Property `"$($EachProp.Name)`" ${EchoDetails}";
							Remove-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -Confirm:$False | Out-Null;

						}

					}

				} Else {  # Property does NOT exist

					If (($EachProp.Delete) -Eq $False) {

						# Create the Property
						Write-Output "  |-->  !! Adding Property `"$($EachProp.Name)`" (w/ type `"$($EachProp.Type)`" and value `"$($EachProp.Value)`" ) ${EchoDetails}";
						New-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) | Out-Null;

					} Else {

						# Do nothing to the Property (already deleted)
						Write-Output "  |-->  Skipping Property `"$($EachProp.Name)`" (already deleted) ${EchoDetails}";

					}

				}

			}

		}


	}

	Write-Output "`n`n  Press any key to exit...";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "HardenCryptoV2" -ErrorAction "SilentlyContinue";
}


# ------------------------------------------------------------
#
# Note: Registry Value Data-Types
#
#    REG_SZ         |  A null-terminated string
#    REG_BINARY     |  Binary data
#    REG_DWORD      |  A 32-bit number
#    REG_QWORD      |  A 64-bit number
#    REG_MULTI_SZ   |  A sequence of null-terminated strings, terminated by a null value
#    REG_EXPAND_SZ  |  A null-terminated string that contains unexpanded references to environment variables (like %PATH%)
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Transport Layer Security (TLS) registry settings | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/security/tls/tls-registry-settings#tls-12
#
# ------------------------------------------------------------