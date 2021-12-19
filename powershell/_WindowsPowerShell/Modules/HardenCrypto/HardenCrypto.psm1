# ------------------------------------------------------------
#
#	PowerShell - HardenCrypto
#		|
#		|--> Description:  PowerShell script that enforces security protocols & cipher suites used during web transactions (calls to port-443/HTTPS network locations)
#		|
#		|--> Example(s):  HardenCrypto -DryRun;
#
#		                  HardenCrypto -SkipConfirmation;
#
#		                  <# Strong #> HardenCrypto -SkipConfirmation -AllowProtocols @("TLS 1.2") -AllowCiphers @("AES 128/128","AES 256/256","Triple DES 168") -DH_KeySize (4096);
#
#		                  <# Medium #> HardenCrypto -SkipConfirmation -AllowProtocols @("TLS 1.1","TLS 1.2") -AllowCiphers @("AES 128/128","AES 256/256","Triple DES 168") -DH_KeySize (3072);
#
#		                  <# Medium-Weak #> HardenCrypto -SkipConfirmation -AllowProtocols @("SSL 3.0","TLS 1.0","TLS 1.1","TLS 1.2") -AllowCiphers @("AES 128/128","AES 256/256","Triple DES 168") -DH_KeySize (2048);
#
#		                  <# Weak #> HardenCrypto -SkipConfirmation -AllowProtocols @("SSL 3.0","TLS 1.0","TLS 1.1","TLS 1.2") -AllowCiphers @("DES 56/56","NULL","RC2 128/128","RC2 40/128","RC2 56/128","RC4 128/128","RC4 40/128","RC4 56/128","RC4 64/128","AES 128/128","AES 256/256","Triple DES 168") -DH_KeySize (1024) -WeakenDotNet;
#
# ------------------------------------------------------------

function HardenCrypto {
	Param(

		[String[]]$AllowProtocols=@("TLS 1.1","TLS 1.2"),  <# @("SSL 2.0","SSL 3.0","TLS 1.0","TLS 1.1","TLS 1.2") #>

		[String[]]$AllowCiphers=@("AES 128/128","AES 256/256","Triple DES 168"),  <# @("DES 56/56","NULL","RC2 128/128","RC2 40/128","RC2 56/128","RC4 128/128","RC4 40/128","RC4 56/128","RC4 64/128","AES 128/128","AES 256/256","Triple DES 168") #>

		[ValidateSet(512, 1024,2048,3072,4096)]
		[Int]$DH_KeySize=3072, <# Diffie-Hellman Key Size #>

		[Switch]$DryRun,

		[Switch]$WeakenDotNet,

		[Switch]$SkipConfirmation

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue';	Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/HardenCrypto/HardenCrypto.psm1') ).Content);
		HardenCrypto -DryRun;

	}

	<# Check whether-or-not the current PowerShell session is running with elevated privileges (as Administrator) #>
	$RunningAsAdmin = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"));
	If ($RunningAsAdmin -Eq $False) {
		<# Script is >> NOT << running as admin  -->  Check whether-or-not the current user is able to escalate their own PowerShell terminal to run with elevated privileges (as Administrator) #>
		$LocalAdmins = (([ADSI]"WinNT://./Administrators").psbase.Invoke('Members') | % {([ADSI]${_}).InvokeGet('AdsPath')});
		$CurrentUser = (([Security.Principal.WindowsPrincipal]([Security.Principal.WindowsIdentity]::GetCurrent())).Identities.Name);
		$CurrentUserWinNT = ("WinNT://$($CurrentUser.Replace("\","/"))");
		If (($LocalAdmins.Contains($CurrentUser)) -Or ($LocalAdmins.Contains($CurrentUserWinNT))) {
			$CommandString = $MyInvocation.MyCommand.Name;
			$PSBoundParameters.Keys | ForEach-Object { $CommandString += " -${_}"; If (@('String','Integer','Double').Contains($($PSBoundParameters[${_}]).GetType().Name)) { $CommandString += " `"$($PSBoundParameters[${_}])`""; } };
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;
		} Else {
			Write-Output "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n";
		}
	} Else {
		<# Script >> IS << running as Admin - Continue #>

		# ------------------------------------------------------------
		#
		# DoLogging  (Sub-Module)
		#  |
		#  |--> Log a message along with a timestamp to target logfile
		#
		Function DoLogging {
			Param([String]$LogFile="",[String]$Text="",[String]$Level="INFO",[String]$BackgroundColor="",[String]$ForegroundColor="",[Switch]$NoNewLine);
			$Timestamp_Decimal=$([String](Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffzzz'));
			$OutString="[${Timestamp_Decimal} ${Level} $($MyInvocation.MyCommand.Name)] ${Text}";
			$WriteHost_Args = @();
			If ($PSBoundParameters.ContainsKey('NoNewLine') -Eq $True) { $WriteHost_Args += "-NoNewLine "; };
			If ($PSBoundParameters.ContainsKey('BackgroundColor') -Eq $True) { $WriteHost_Args += "-BackgroundColor `"${BackgroundColor}`" "; };
			If ($PSBoundParameters.ContainsKey('ForegroundColor') -Eq $True) { $WriteHost_Args += "-ForegroundColor `"${ForegroundColor}`" "; };
			$WriteHost_Args += "${OutString}";
			Write-Host ${WriteHost_Args};
			Write-Output "${OutString}" | Out-File -Width 16384 -Append "${LogFile}";
		};

		# ------------------------------------------------------------

		<# Setup Logfile #>
		$Start_Timestamp=(Get-Date -Format "yyyyMMddTHHmmsszz");
		$LogDir="${Env:TEMP}\HardenCrypto";
		$LogFile="${LogDir}\LogFile_${Start_Timestamp}.log";
		If ((Test-Path -Path ("${LogDir}")) -Eq ($False)) {
			New-Item -ItemType "Directory" -Path ("${LogDir}") | Out-Null;
		}

		<# Show header text in console & logfile #>
		DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";
		DoLogging -LogFile "${LogFile}" -Text "HardenCrypto - Update HTTPS Protocols & Cipher Suites";
		DoLogging -LogFile "${LogFile}" -Text "Logfile: [ ${LogFile} ]";

		# ------------------------------
		# Dry Run (enabled/disabled)
		$RunMode_DryRun = $False;
		$Note_Prepend = "!! ";
		$Note_Append  = "";
		If ($PSBoundParameters.ContainsKey('DryRun') -Eq $True) {
			$RunMode_DryRun = $True;
			$Note_Prepend = "";
			$Note_Append  = " (NOT APPLIED - Dry Run)";
			DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";
			DoLogging -LogFile "${LogFile}" -Text "            > > > RUNNING IN DRY RUN MODE < < <             "; 
			DoLogging -LogFile "${LogFile}" -Text "            NO CHANGES WILL BE MADE TO REGISTRY             "; 
			# Start-Sleep -Seconds 3;
		}
		DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";

		# ------------------------------
		# Skip Confirmation Checks/Gates (enabled/disabled)
		$RunMode_SkipConfirm = $False;
		If ($PSBoundParameters.ContainsKey('SkipConfirmation') -Eq $True) {
			$RunMode_SkipConfirm = $True;
		} ElseIf (${RunMode_DryRun} -Eq $True) {
			$RunMode_SkipConfirm = $True;
		}

		# ------------------------------
		#
		# User Confirmation - Gate A
		#  |
		#  |--> Confirm via "Are you sure ... ? Press [KEY] to continue" (where KEY is randomly generated)
		#  |
		#  |--> Skip Gate / Auto-confirm via -SkipConfirmation
		#

		$Confirmation_GateA="Confirm: Do you want to harden the cryptography of this device to require incoming/outgoing web requests to use only protocols [ $(${AllowProtocols} -join ', ' ) ]?";

		If (${RunMode_SkipConfirm} -Eq $False) {
			$ConfirmKeyList = "abcdefghijklmopqrstuvwxyz"; # removed 'n'
			$GateA_ConfirmCharacter = (Get-Random -InputObject ([char[]]$ConfirmKeyList));
			DoLogging -LogFile "${LogFile}" -Text "";
			DoLogging -LogFile "${LogFile}" -Text "You may skip confirmation requests (e.g. automatically confirm them) using argument `"-SkipConfirmation`"";
			DoLogging -LogFile "${LogFile}" -Text "";
			DoLogging -LogFile "${LogFile}" -Text "${Confirmation_GateA}" -BackgroundColor "Black" -ForegroundColor "Yellow";
			DoLogging -LogFile "${LogFile}" -Text "";
			DoLogging -NoNewLine -LogFile "${LogFile}" -Text "Confirm: Press the `"" -ForegroundColor "Yellow";
			DoLogging -NoNewLine -LogFile "${LogFile}" -Text "${GateA_ConfirmCharacter}" -ForegroundColor "Green";
			DoLogging -NoNewLine -LogFile "${LogFile}" -Text "`" key to confirm and continue:  " -ForegroundColor "Yellow";
			$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); DoLogging -LogFile "${LogFile}" -Text "UserKeyPress.Character = [ $(${UserKeyPress}.Character) ]";
			$UserConfirmed_GateA = ((${UserKeyPress}.Character) -Eq (${GateA_ConfirmCharacter}));
			If (${UserConfirmed_GateA} -Eq $True) {
				DoLogging -LogFile "${LogFile}" -Text "Info:  User confirmation successful (expected keypress `"${GateA_ConfirmCharacter}`", received (matching) keypress `"$(${UserKeyPress}.Character)`")";
			} Else {
				DoLogging -LogFile "${LogFile}" -Text "Error: User confirmation failed (expected keypress `"${GateA_ConfirmCharacter}`", received keypress `"$(${UserKeyPress}.Character)`")";
			}
		} Else {
			DoLogging -LogFile "${LogFile}" -Text "Skipping (auto-accepting) confirmation message [ ${Confirmation_GateA} ]";
		}


		<# Check Skips and/or User Confirmation Gate(s) #>
		If ((${RunMode_SkipConfirm} -Eq $True) -Or (${UserConfirmed_GateA} -Eq $True)) {

			# ------------------------------------------------------------

			$RegEdits = @();

			# ------------------------------------------------------------
			#
			#  HTTPS Protocols
			#

			$Protos=@{};

			$All_Protocols = @();

			${All_Protocols} += @("SSL 2.0");
			${All_Protocols} += @("SSL 3.0");
			${All_Protocols} += @("TLS 1.0");
			${All_Protocols} += @("TLS 1.1");
			${All_Protocols} += @("TLS 1.2");

			${All_Protocols} | ForEach-Object {
				$Protos["${_}"] = If (${AllowProtocols}.Contains("${_}")) { $True; } Else { $False; };
			}


			# ------------------------------
			#
			#  HTTPS Protocols (DEPRECATED OSes ONLY - Win7/Server2012 & Earlier) --> WinHTTP - Add support for TLS 1.2
			#   |
			#   |--> Only required for earlier versions of Windows (Windows 7 / Windows Server 2012 & earlier) - Windows 8.1, Windows Server 2012 R2, Windows 10, Windows Server 2016, and later versions of Windows natively support TLS 1.2 for client-server communications over WinHTTP
			#   |
			#   |--> !!! Reboot is required to apply Registry changes (old OSes only - Windows 7 / Windows Server 2012 & earlier)
			#   |
			#   |--> Enable these settings on all clients running earlier versions of Windows BEFORE enabling TLS 1.2 and disabling the older protocols on the Configuration Manager servers. Otherwise, you can inadvertently orphan them
			#   |
			#   |--> More info @ [ https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#bkmk_winhttp ]
			#
			$RegEdits += @{
				Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp";
				Delete=$False;
				Props=@(
					@{
						Description="WinHTTP DefaultSecureProtocols setting - Note that the Configuration Manager supports the most secure protocol that Windows negotiates between both devices - Set to [ 0xA00 to only allow TLS 1.1/1.2 ], [ 0x0A0 to allow SSL 3.0 & TLS 1.0 ], or [ 0xAA0 to allow SSL 3.0 & TLS 1.0/1.1/1.2 (other two options combined) ]";
						Name="DefaultSecureProtocols";
						Type="DWord";
						Value=( $(If ($Protos["SSL 2.0"] -Or $Protos["SSL 3.0"] -Or $Protos["TLS 1.0"]) { 0x0A0 } Else { 0x000 }) -bor $(If ($Protos["TLS 1.1"] -Or $Protos["TLS 1.2"]) { 0xA00 } Else { 0x000 }) );
						Delete=$False;
					}
				)
			};
			$RegEdits += @{
				Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Internet Settings\WinHttp";
				Delete=$False;
				Props=@(
					@{
						Description="WinHTTP DefaultSecureProtocols setting - Note that the Configuration Manager supports the most secure protocol that Windows negotiates between both devices - Set to [ 0xA00 to only allow TLS 1.1/1.2 ], [ 0x0A0 to allow SSL 3.0 & TLS 1.0 ], or [ 0xAA0 to allow SSL 3.0 & TLS 1.0/1.1/1.2 (other two options combined) ]";
						Name="DefaultSecureProtocols";
						Type="DWord";
						Value=( $(If ($Protos["SSL 2.0"] -Or $Protos["SSL 3.0"] -Or $Protos["TLS 1.0"]) { 0x0A0 } Else { 0x000 }) -bor $(If ($Protos["TLS 1.1"] -Or $Protos["TLS 1.2"]) { 0xA00 } Else { 0x000 }) );
						Delete=$False;
					}
				)
			};


			# ------------------------------
			#
			#  HTTPS Protocols - Update protocols used for incoming requests (IIS Servers) & outgoing requests (all else), alike
			#

			<# [Protocols] Enable/Disable each HTTPS Protocol from both Client & Server perspectives #>
			$Protos.Keys | ForEach-Object {
				$ProtocolName=(${_});
				$Each_Enabled=([int]($Protos[${_}]));
				$Each_DisabledByDefault=([int](-not (${Each_Enabled})));
				<# [Protocols] Server-Side #>
				$RegEdits += @{
					Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\${ProtocolName}\Server";
					Delete=$False;
					Props=@(
						@{
							Description="${ProtocolName} - Protocol (HTTPS), server-side - affects incoming connections to local IIS/FTP/etc. services - Set to [ 0 ] to disable, [ 1 ] to enable.";
							Name="Enabled";
							Type="DWord";
							Value=${Each_Enabled};
							Delete=$False;
						},
						@{
							Description="${ProtocolName} - Protocol (HTTPS), server-side - affects incoming connections to local IIS/FTP/etc. services - Set to [ 1 ] to disable-by-default, [ 0 ] to enable-by-default.";
							Name="DisabledByDefault";
							Type="DWord";
							Value=${Each_DisabledByDefault};
							Delete=$False;
						}
					)
				};
				<# [Protocols] Client-Side #>
				$RegEdits += @{
					Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\${ProtocolName}\Client";
					Delete=$False;
					Props=@(
						@{
							Description="${ProtocolName} - Protocol (HTTPS), client-side - affects a multitude of outgoing connections, including powershell invoke-webrequest/etc. calls - Set to [ 0 ] to disable, [ 1 ] to enable.";
							Name="Enabled";
							Type="DWord";
							Value=${Each_Enabled};
							Delete=$False;
						},
						@{
							Description="${ProtocolName} - Protocol (HTTPS), client-side - affects a multitude of outgoing connections, including powershell invoke-webrequest/etc. calls - Set to [ 1 ] to disable-by-default, [ 0 ] to enable-by-default.";
							Name="DisabledByDefault";
							Type="DWord";
							Value=${Each_DisabledByDefault};
							Delete=$False;
						}
					)
				};
			}


			#------------------------------------------------------------
			#
			#  HTTPS Cipher Suites
			#

			$CipherSuites=@();

			$All_Ciphers=@();
			${All_Ciphers} += "DES 56/56";
			${All_Ciphers} += "NULL";
			${All_Ciphers} += "RC2 128/128";
			${All_Ciphers} += "RC2 40/128";
			${All_Ciphers} += "RC2 56/128";
			${All_Ciphers} += "RC4 128/128";
			${All_Ciphers} += "RC4 40/128";
			${All_Ciphers} += "RC4 56/128";
			${All_Ciphers} += "RC4 64/128";
			${All_Ciphers} += "AES 128/128";
			${All_Ciphers} += "AES 256/256";
			${All_Ciphers} += "Triple DES 168";

			${All_Ciphers} | ForEach-Object {
				$CipherSuites += @{
					CipherName = "${_}";
					Enabled = If (${AllowCiphers}.Contains("${_}")) { $True; } Else { $False; };
				};
			}

			<# [Ciphers] Enable/Disable each HTTPS Cipher Suite #>
			$CipherSuites | ForEach-Object {
				$Each_Name=(${_}.CipherName);
				$Each_Enabled=([int](${_}.Enabled));
				$RegEdits += @{
					Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\${Each_Name}";
					Delete=$False;
					Props=@(
						@{
							Description="${Each_Name} - Cipher Suite (HTTPS) - Set to [ 0 ] to disable, [ 1 ] to enable.";
							Name="Enabled";
							Type="DWord";
							Value=${Each_Enabled};
							Delete=$False;
						}
					)
				};
			}

			# ------------------------------------------------------------

			<# [Algorithms] Diffie-Hellman #>
			$RegEdits += @{
				Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman";
				Delete=$False;
				Props=@(
					@{
						Description="Diffie-Hellman key size (in bits - the higher it is, the more secure the encryption is with outgoing data, but the longer it will take the server to encrypt it as well)";
						Name="ClientMinKeyBitLength";
						Type="DWord";
						Value=${DH_KeySize};
						Delete=$False;
					}
				)
			};


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
				If (${RunMode_DryRun} -Eq $False) {
					Install-Module -Name ("PolicyFileEditor") -Scope ("CurrentUser") -Force;
					$HKLM_Path="SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services";  # <-- View exhaustive list of terminal services group policies (and their associated registry keys) https://getadmx.com/HKLM/SOFTWARE/Policies/Microsoft/Windows%20NT/Terminal%20Services
					$Name="MaxCompressionLevel";
					$Type="DWord";
					[UInt32]$Value = 0x00000002;
					If ($False) {
						DoLogging -LogFile "${LogFile}" -Text "";
						DoLogging -LogFile "${LogFile}" -Text "The following property sets the value to for Group Policy (gpedit.msc) titled 'Configure compression for RemoteFX data' to:  [ 0 - 'Do not use an RDP compression algorithm' ],  [ 1 - 'Optimized to use less memory' ],  [ 2 - 'Balances memory and network bandwidth' ],  or  [ 3 - 'Optimized to use less network bandwidth' ]";
						DoLogging -LogFile "${LogFile}" -Text "";
					}
					Set-PolicyFileEntry -Path ("${Env:SystemRoot}\System32\GroupPolicy\Machine\Registry.pol") -Key ("${HKLM_Path}") -ValueName ("${Name}") -Data (${Value}) -Type ("${Type}");
				}
			}


			# ------------------------------------------------------------
			#
			# Registry Paths
			#  |
			#  |--> Define any Network Maps which will be required during the runtime
			#  |
			#  |--> Note: Registry Root-Keys are actually Network Maps to the "Registry" PSProvider
			#

			$PSDrives = @();
			$PSDrives += @{ Name="HKLM"; PSProvider="Registry"; Root="HKEY_LOCAL_MACHINE";    };
			$PSDrives += @{ Name="HKCC"; PSProvider="Registry"; Root="HKEY_CURRENT_CONFIG";   };
			$PSDrives += @{ Name="HKCR"; PSProvider="Registry"; Root="HKEY_CLASSES_ROOT";     };
			$PSDrives += @{ Name="HKU" ; PSProvider="Registry"; Root="HKEY_USERS";            };
			$PSDrives += @{ Name="HKCU"; PSProvider="Registry"; Root="HKEY_CURRENT_USER";     };
			$PSDrives += @{ Name=$Null ; PSProvider="Registry"; Root="HKEY_PERFORMANCE_DATA"; };
			$PSDrives += @{ Name=$Null ; PSProvider="Registry"; Root="HKEY_DYN_DATA";         };

			# ------------------------------------------------------------
			#
			#	ForEach loop to apply Registry Changes
			#
			ForEach ($Each_RegEdit In $RegEdits) {

				DoLogging -LogFile "${LogFile}" -Text "";
				DoLogging -LogFile "${LogFile}" -Text "$(${Each_RegEdit}.Path)";

				# ------------------------------
				#
				# Root-Keys
				#   |--> Ensure that this registry key's Root-Key has been mapped as a network drive
				#   |--> Mapping this as a network drive grants this script read & write access to said Root-Key's registry values (which would otherwise be inaccessible)
				#
				If ((${Each_RegEdit}.Path).StartsWith("Registry::") -Eq $False) {
					$Each_RegEdit_DriveName=((${Each_RegEdit}.Path).Split(':\')[0]);
					If ((Test-Path -Path (("${Each_RegEdit_DriveName}:\"))) -Eq $False) {
						$Each_PSDrive_PSProvider=$Null;
						$Each_PSDrive_Root=$Null;
						DoLogging -LogFile "${LogFile}" -Text "";
						DoLogging -LogFile "${LogFile}" -Text "Info:  Root-Key `"${Each_RegEdit_DriveName}`" not found";
						ForEach ($Each_PSDrive In $PSDrives) {
							If ((($Each_PSDrive.Name) -Ne $Null) -And (($Each_PSDrive.Name) -Eq $Each_RegEdit_DriveName)) {
								$Each_PSDrive_PSProvider=($Each_PSDrive.PSProvider);
								$Each_PSDrive_Root=($Each_PSDrive.Root);
								Break;
							}
						}
						If ($Each_PSDrive_Root -Ne $Null) {
							DoLogging -LogFile "${LogFile}" -Text "  |-->  Adding Session-Based ${Each_PSDrive_PSProvider} Network-Map from drive name `"${Each_RegEdit_DriveName}`" to data store location `"${Each_PSDrive_Root}`"";
							If (${RunMode_DryRun} -Eq $False) {
								New-PSDrive -Name "${Each_RegEdit_DriveName}" -PSProvider "${Each_PSDrive_PSProvider}" -Root "${Each_PSDrive_Root}" | Out-Null;
							}
						}
					}
				}


				# ------------------------------------------------------------

				If ((${Each_RegEdit}.Delete) -Eq $True) {

					# Key SHOULD be deleted

					# Check for the key
					If ((Test-Path -LiteralPath (${Each_RegEdit}.Path)) -Eq $False) { # Key doesn't exist

							DoLogging -LogFile "${LogFile}" -Text "  |-->  Skipping deletion of key (already deleted)";

					} Else { # Key Exists

						# Delete the key
						DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Deleting Key${Note_Append}";
						If (${RunMode_DryRun} -Eq $False) {
							Remove-Item -Force -Recurse -LiteralPath (${Each_RegEdit}.Path) -Confirm:$False | Out-Null;
							If ((Test-Path -LiteralPath (${Each_RegEdit}.Path)) -Eq $False) {
								DoLogging -LogFile "${LogFile}" -Text "  |-->  Deleted Key";
								Break; # Since we're removing the registry key, we can skip going over the rest of the current key's properties (since the key itself should no longer exist)
							}
						}

					}

				} Else { # ------------------------------------------------------------

					# Key is NOT to be deleted

					# Check for the key
					If ((Test-Path -LiteralPath (${Each_RegEdit}.Path)) -Eq $False) { # Key doesn't exist

						# Create the key
						If ((${Each_RegEdit}.Path).Contains("\")) {

							# Iteratively break apart the registry key (to be created) into its parent registry keys (handles forward slashes in key names)
							$KeysToCreate=@("$(${Each_RegEdit}.Path)");
							While ((${KeysToCreate}[-1]).Contains("\")) {
								$KeysToCreate+=("$(${KeysToCreate}[-1])" -replace "\\$(("$(${KeysToCreate}[-1])" -split "\\")[-1])$","");
							};

							# Iteratively create all parent registry keys (handles forward slashes in key names)
							For ($i=(${KeysToCreate}.Count - 3); $i -GE 0; $i-- ) { <# Only traverse to the third to lowest item (i=2 and higher)  #>

								$Each_Child_Key = ((${KeysToCreate}[$i] -split "\\")[-1]);
								$Each_Parent_Key = ((${KeysToCreate}[$i] -split "\\")[-2]);
								$Each_Root_Key = (${KeysToCreate}[$i] -replace "\\$((${KeysToCreate}[$i] -split "\\")[-2])\\$((${KeysToCreate}[$i] -split "\\")[-1])$","");

								If ((Test-Path -LiteralPath (${KeysToCreate}[$i])) -Eq $False) { # Key doesn't exist

									DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Creating Key [ $(${KeysToCreate}[$i]) ]${Note_Append}";
									If (${RunMode_DryRun} -Eq $False) {
										#
										# Registry Key Name w/ Forward Slashes ("/") - Workaround SubKey-Creation Method
										#  |
										#  |--> Required to avoid an issue where [ New-Item ] interprets forward slashes as backslashes ("\") (in either the -Path or -Name values given to it)
										#  |
										#  |--> This causes it to create two keys instead of one (with one nested underneath the other), with their names split at the forward slash character
										#  |
										#  |--> E.g. Calling [ New-Item -Force -Path  "...\RC4 64/128" ] will create a parent key named "...\RC4 64", then create a child key named "128" underneath of said parent key (Instead of creating a key with a forward slash in the name at "...\RC4 64/128")
										#
										$RegistryKey=((Get-Item -Path "${Each_Root_Key}").OpenSubKey("${Each_Parent_Key}", $True));
										$RegistryKey.CreateSubKey("${Each_Child_Key}") | Out-Null;  <# Workaround for creating registry keys with forward-slashes in their name #>
										$RegistryKey.Close() | Out-Null;

										If ((Test-Path -LiteralPath (${KeysToCreate}[$i])) -Eq $True) {
											DoLogging -LogFile "${LogFile}" -Text "  |-->  Created Key";
										}
									}

								} <# Else {

									DoLogging -LogFile "${LogFile}" -Text "  |-->  Skipping creation of key [ $(${KeysToCreate}[$i]) ] (already exists)";

								} #>

							}

						} Else {

							# Bulk create all parent keys (in one fell swoop) (does NOT handle forward slashes in key names)
							DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Creating Key${Note_Append}";
							If (${RunMode_DryRun} -Eq $False) {
								#
								# New-Item -Force
								#   |--> Upside to "-Force" - Creates ALL parent registry keys
								#   |--> Downside to "-Force" - DELETES all properties & child-keys if key already exists
								#     |--> Takeaway - Always use  [ Test-Path ... ]  to verify registry keys don't exist before using  [ New-Item -Force ... ]  to create the key
								#
								New-Item -Force -Path (${Each_RegEdit}.Path) | Out-Null;
								If ((Test-Path -LiteralPath (${Each_RegEdit}.Path)) -Eq $True) {
									DoLogging -LogFile "${LogFile}" -Text "  |-->  Created Key";
								}
							}

						}
					}

					# Create/Update/Delete the Registry Key's Properties
					ForEach ($Each_Prop In $Each_RegEdit.Props) {

						# Check for each Property
						Try {
							$GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${Each_RegEdit}.Path) -Name (${Each_Prop}.Name) -ErrorAction ("Stop"));
						} Catch {
							$GetEachItemProp = $Null;
						};

						If ($GetEachItemProp -NE $Null) {  # Property exists

							If ((${Each_Prop}.Delete) -Eq $False) {  # Property should NOT be deleted

								${Each_Prop}.LastValue = $GetEachItemProp;

								If ((${Each_Prop}.LastValue) -Eq (${Each_Prop}.Value)) {

									# Do nothing to the Property (already exists with matching type & value)
									DoLogging -LogFile "${LogFile}" -Text "  |-->  Skipping Property `"$(${Each_Prop}.Name)`" (already has required value of [ $(${Each_Prop}.LastValue) ])";

								} Else {

									# Update the Property
									DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Updating Property `"$(${Each_Prop}.Name)`" w/ type `"$(${Each_Prop}.Type)`" to have value `"$(${Each_Prop}.Value)`" instead of (previous) value `"$(${Each_Prop}.LastValue)`"${Note_Append}";
									If (${RunMode_DryRun} -Eq $False) {
										Set-ItemProperty -Force -LiteralPath (${Each_RegEdit}.Path) -Name (${Each_Prop}.Name) -Value (${Each_Prop}.Value) | Out-Null;
									}

								}

							} Else { # Property (or Key) SHOULD be deleted

								If ((${Each_Prop}.Name) -Eq "(Default)") {

									# Delete the Key
									DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Deleting Key${Note_Append}";
									If (${RunMode_DryRun} -Eq $False) {
										Remove-Item -Force -Recurse -LiteralPath (${Each_RegEdit}.Path) -Confirm:$False | Out-Null;
										If ((Test-Path -LiteralPath (${Each_RegEdit}.Path)) -Eq $False) {
											DoLogging -LogFile "${LogFile}" -Text "  |-->  Deleted Key";
											Break; # Since we're removing the registry key, we can skip going over the rest of the current key's properties (since the key itself should no longer exist)
										}
									}

								} Else {

									# Delete the Property
									DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Deleting Property `"$(${Each_Prop}.Name)`"${Note_Append}";
									If (${RunMode_DryRun} -Eq $False) {
										Remove-ItemProperty -Force -LiteralPath (${Each_RegEdit}.Path) -Name (${Each_Prop}.Name) -Confirm:$False | Out-Null;
									}

								}

							}

						} Else {  # Property does NOT exist

							If ((${Each_Prop}.Delete) -Eq $False) {

								# Create the Property
								DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Adding Property `"$(${Each_Prop}.Name)`" w/ type `"$(${Each_Prop}.Type)`" and value `"$(${Each_Prop}.Value)`"${Note_Append}";
								If (${RunMode_DryRun} -Eq $False) {
									New-ItemProperty -Force -LiteralPath (${Each_RegEdit}.Path) -Name (${Each_Prop}.Name) -PropertyType (${Each_Prop}.Type) -Value (${Each_Prop}.Value) | Out-Null;
								}

							} Else {

								# Do nothing to the Property (already deleted)
								DoLogging -LogFile "${LogFile}" -Text "  |-->  Skipping Property `"$(${Each_Prop}.Name)`" (already deleted)";

							}

						}

					}

				}

			}

			DoLogging -LogFile "${LogFile}" -Text "";
			DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";


			# ------------------------------------------------------------
			#
			# .NET Framework v4 - Simplify protocol-management (by handing off control to OS) & Enforce strong cryptography
			#   |
			#   |--> Creating these keys forces any version of .NET 4.x below 4.6.2 to use strong crypto instead of allowing SSL 3.0 by default
			#   |
			#   |--> https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#configure-for-strong-cryptography
			#

			$RegEdits = @();

			<# Note: Methods which update registry keys such as  [ New-ItemProperty ... ]  often only update the 64bit registry (by default) #>
			<# Note: The third argument passed to the '.SetValue()' method, here, defines the value for 'RegistryValueKind', which defines the 'type' of the registry property - A value of '4' creates/sets a 'DWORD' typed property #>

			<# RegistryValueKind - https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registryvaluekind #>
			$RegistryValueKind = @{};
			$RegistryValueKind["None"] = @{ID=-1; Description="No data type."; RegType=""; };
			$RegistryValueKind["QWord"] = @{ID=11; Description="A 64-bit binary number"; RegType="REG_QWORD"; };
			$RegistryValueKind["DWord"] = @{ID=4; Description="A 32-bit binary number"; RegType="REG_DWORD"; };
			$RegistryValueKind["Binary"] = @{ID=3; Description="Binary data in any form"; RegType="REG_BINARY"; };
			$RegistryValueKind["String"] = @{ID=1; Description="A null-terminated string"; RegType="REG_SZ"; };
			$RegistryValueKind["Unknown"] = @{ID=0; Description="An unsupported registry data type. Use this value to specify that the SetValue(String, Object) method should determine the appropriate registry data type when storing a name/value pair."; RegType=""; };
			$RegistryValueKind["MultiString"] = @{ID=7; Description="An array of null-terminated strings, terminated by two null characters."; RegType="REG_MULTI_SZ"; };
			$RegistryValueKind["ExpandString"] = @{ID=2; Description="A null-terminated string"; RegType="REG_EXPAND_SZ"; };

			<# Build a path to target the registry key .NET Framework's registry key #>
			$DotNet_HKLM_Searches=@();
			$DotNet_HKLM_Searches+="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\.NETFramework\v*";
			$DotNet_HKLM_Searches+="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\.NETFramework\v*";

			# ------------------------------
			# Skip Confirmation Checks/Gates (enabled/disabled)
			$DotNet_SecureVal = 1;
			If ($PSBoundParameters.ContainsKey('WeakenDotNet') -Eq $True) {
				$DotNet_SecureVal = 0;
			}

			<# Search for installed versions of .NET Framework #>
			${DotNet_HKLM_Searches} | ForEach-Object {
				$Each_HKLM_Search="${_}";
				((Get-Item -Path "${Each_HKLM_Search}").PSChildName) | ForEach-Object {
					<# Enforce strong encryption methodologies across all local .NET Framework installations #>
					$RegEdits += @{
						Path=(("${Each_HKLM_Search}" -replace "\\v\*","")+("\${_}"));
						Delete=$False;
						Props=@(
							@{
								Description="The SchUseStrongCrypto setting allows .NET to use TLS 1.1 and TLS 1.2. Set the SchUseStrongCrypto registry setting to DWORD:00000001 - This value disables the RC4 stream cipher and requires a restart. For more information about this setting, see Microsoft Security Advisory 296038 @ [ https://docs.microsoft.com/en-us/security-updates/SecurityAdvisories/2015/2960358 ].";
								Name="SchUseStrongCrypto";
								Type="DWord";
								Value=${DotNet_SecureVal};
								Delete=$False;
							},
							@{
								Description="The SystemDefaultTlsVersions setting allows .NET to use the OS configuration. For more information, see TLS best practices with the .NET Framework @ [ https://docs.microsoft.com/en-us/dotnet/framework/network-programming/tls ]";
								Name="SystemDefaultTlsVersions";
								Type="DWord";
								Value=${DotNet_SecureVal};
								Delete=$False;
							}
						)
					};
				}
			}


			<# Update the 64-bit registry && the 32-bit registry entry for each item #>
			ForEach ($Each_RegistryView In @([Microsoft.Win32.RegistryView]::Registry32, [Microsoft.Win32.RegistryView]::Registry64)) {

				<# Open a stream to the specific registry (32-/64-bit) #>
				$Registry_HKLM = ([Microsoft.Win32.RegistryKey]::OpenBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, ${Each_RegistryView}));
				ForEach ($Each_RegEdit In $RegEdits) {

					<# Retrieve the specified subkey w/ write access (arg2: $True=write-access, $False=read-only) #>
					$Each_RegEdit.RelPath=("$(${Each_RegEdit}.Path)" -replace "^((?!\\).)+\\","");
					DoLogging -LogFile "${LogFile}" -Text "";
					DoLogging -LogFile "${LogFile}" -Text "${Each_RegistryView}::HKEY_LOCAL_MACHINE\$($Each_RegEdit.RelPath)";
					$Each_SubKey = $Registry_HKLM.OpenSubKey("$(${Each_RegEdit}.RelPath)", $True);

					ForEach (${Each_Prop} In ${Each_RegEdit}.Props) {

						${Each_Prop}.LastValue = (${Each_SubKey}.GetValue("$(${Each_Prop}.Name)"));

						If ((${Each_Prop}.LastValue) -Eq (${Each_Prop}.Value)) {

							<# Do nothing to the Property (already exists with matching type & value) #>
							DoLogging -LogFile "${LogFile}" -Text "  |-->  Skipping Property `"$(${Each_Prop}.Name)`" (already has required value of [ $(${Each_Prop}.LastValue) ])";

						} Else {

							If ("$(${Each_Prop}.LastValue)".Trim() -Eq "") {
								${Each_Prop}.LastValue = "(NULL)";
							}

							<# Update the Property #>
							DoLogging -LogFile "${LogFile}" -Text "  |-->  ${Note_Prepend}Updating Property `"$(${Each_Prop}.Name)`" w/ type `"$(${Each_Prop}.Type)`" to have value `"$(${Each_Prop}.Value)`" instead of (previous) value `"$(${Each_Prop}.LastValue)`"${Note_Append}";
							If (${RunMode_DryRun} -Eq $False) {
								${Each_SubKey}.SetValue(${Each_Prop}.Name, ${Each_Prop}.Value, ${RegistryValueKind}[(${Each_Prop}.Type)]["ID"]);
							}

						}

					}

					<# Close the key & flush any updated contents therein to the disk #>
					${Each_SubKey}.Close();

				}

			}

			DoLogging -LogFile "${LogFile}" -Text "";
			DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";


		}


	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "HardenCrypto" -ErrorAction "SilentlyContinue";
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
#   community.spiceworks.com  |  "Set Registry Key To 'Full Control' For .\USERS - PowerShell - Spiceworks"  |  https://community.spiceworks.com/topic/1517671-set-registry-key-to-full-control-for-users
#
#   docs.microsoft.com  |  "How to enable Transport Layer Security (TLS) 1.2 on clients - Configuration Manager | Microsoft Docs"  |  https://docs.microsoft.com/en-us/mem/configmgr/core/plan-design/security/enable-tls-1-2-client#configure-for-strong-cryptography
#
#   docs.microsoft.com  |  "Managing SSL/TLS Protocols and Cipher Suites for AD FS | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/identity/ad-fs/operations/manage-ssl-protocols-in-ad-fs#using-powershell
#
#   docs.microsoft.com  |  "Protocols in TLS/SSL (Schannel SSP) - Implements versions of the TLS, DTLS and SSL protocols"  |  https://docs.microsoft.com/en-us/windows/win32/secauthn/protocols-in-tls-ssl--schannel-ssp-
#
#   docs.microsoft.com  |  "RegistryKey.Close Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.close
#
#   docs.microsoft.com  |  "RegistryKey.GetValue Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.getvalue
#
#   docs.microsoft.com  |  "RegistryKey.OpenBaseKey(RegistryHive, RegistryView) Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.openbasekey
#
#   docs.microsoft.com  |  "RegistryKey.OpenSubKey Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.opensubkey
#
#   docs.microsoft.com  |  "RegistryKey.SetAccessControl(RegistrySecurity) Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.setaccesscontrol
#
#   docs.microsoft.com  |  "RegistryKey.SetValue Method (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey.setvalue
#
#   docs.microsoft.com  |  "RegistryValueKind Enum (Microsoft.Win32) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registryvaluekind
#
#   docs.microsoft.com  |  "Restrict cryptographic algorithms and protocols - Windows Server | Microsoft Docs"  |  https://docs.microsoft.com/en-us/troubleshoot/windows-server/windows-security/restrict-cryptographic-algorithms-protocols-schannel
#
#   docs.microsoft.com  |  "ServicePointManager.SecurityProtocol Property (System.Net) - Gets/Sets the security protocol used by the ServicePoint objects managed by the ServicePointManager object"  |  https://docs.microsoft.com/en-us/dotnet/api/system.net.servicepointmanager.securityprotocol
#
#   docs.microsoft.com  |  "Solving the TLS 1.0 Problem - Security documentation | Microsoft Docs"  |  https://docs.microsoft.com/en-us/security/solving-tls1-problem
#
#   docs.microsoft.com  |  "Transport Layer Security (TLS) registry settings | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows-server/security/tls/tls-registry-settings#tls-12
#
#   docs.microsoft.com  |  "Transport Layer Security (TLS) best practices with the .NET Framework | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/framework/network-programming/tls
#
#   johnlouros.com  |  "Enabling strong cryptography for all .Net applications | John Louros"  |  https://johnlouros.com/blog/enabling-strong-cryptography-for-all-dot-net-applications
#
#   powershellpainrelief.blogspot.com  |  "Powershell - Pain Relief by R.T.Edwards: Powershell: Working With The Registry Part 2"  |  https://powershellpainrelief.blogspot.com/2014/07/powershell-working-with-registry-part-2.html
#
#   stackoverflow.com  |  "How to access the 64-bit registry from a 32-bit Powershell instance? - Stack Overflow"  |  https://stackoverflow.com/a/19381092
#
#   stackoverflow.com  |  "webclient - Powershell Setting Security Protocol to Tls 1.2 - Stack Overflow"  |  https://stackoverflow.com/a/41674736
#
#   stackoverflow.com  |  "windows - How to create a registry entry with a forward slash in the name - Stack Overflow"  |  https://stackoverflow.com/a/18259930
#
#   support.nartac.com  |  "What registry keys does IIS Crypto modify? - Nartac Software"  |  https://support.nartac.com/article/16-what-registry-keys-does-iis-crypto-modify
#
# ------------------------------------------------------------