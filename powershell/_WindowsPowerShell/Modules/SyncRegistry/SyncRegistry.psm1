function SyncRegistry {
	Param(
	)

	If ((RunningAsAdministrator) -Ne ($True)) {

		PrivilegeEscalation -Command ("SyncRegistry");
	
	} Else {

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

		# Explorer Settings
		$RegEdits += @{
			Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer";
			Props=@(
				@{
					Description="Enables (0) or Disables (1) `"Aero Shake`" in Windows 10.";
					Name="NoWindowMinimizingShortcuts"; 
					Type="DWord";
					Value=1;
				}
			)
		};

		# Stop Windows from making sure all apps close when Shutting-Down/Restarting/etc. (Disables the 'This App is Preventing Shutdown or Restart' screen before Shutdown/Restart)
		$RegEdits += @{
			Path = "HKCU:\Control Panel\Desktop";
			Props=@(
				@{
					Description="Disables(1) the 'This App is Preventing Shutdown or Restart' screen, which appears while attempting Shutdown/Restart the machine while certain inspecific applications are running - Remove this key/val to show this screen, instead";
					Name="AutoEndTasks"; 
					Type="String";
					Value=1;
				}
			)
		};

		$DefaultPictureEditor="C:\Program Files\paint.net\PaintDotNet.exe";
		If ((Test-Path -Path "${DefaultPictureEditor}") -Eq $True) {
			# Set default application to use when user clicks "Edit" after right-clicking an image-file in Explorer
			#   |--> Explorer -> Image-File (.png, .jpg, ...) -> Right-Click -> Edit -> Opens app held in [v THIS v] RegEdit Key/Val
			$RegEdits += @{
				Path = "HKCR:\SystemFileAssociations\image\shell\edit\command";
				Props=@(
					@{
						Description="Defines the application opened when a user right-clicks an Image file (in Windows Explorer) and selects the `"Edit`" command.";
						Name="(Default)"; 
						Type="REG_EXPAND_SZ";
						Val_Default="`"%systemroot%\system32\mspaint.exe`" `"%1`"";
						Value=(("`"")+(${DefaultPictureEditor})+("`" `"%1`""));
					}
				)
			};
		}

		# Search / Cortana Settings
		$RegEdits += @{
			Path="HKCU:\Software\Microsoft\Windows\CurrentVersion\Search";
			Props=@(
				@{
					Description="Enables (1) or Disables (0) Cortana's ability to send search-resutls to Bing.com.";
					Hotfix="Setting BingSearchEnabled to Value=1 fixes a bug in KB4512941: Cortana constantly eating 30-40% CPU (processing resources), even while idling.";
					Name="BingSearchEnabled";
					Type="DWord";
					Value=1;
				},
				@{
					Description=$Null;
					Name="AllowSearchToUseLocation";
					Type="DWord";
					Value=0;
				}
			)
		};

		# Search / Cortana Settings
		$RegEdits += @{
			Path="HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search";
			Props=@(
				@{
					Description=$Null;
					Name="AllowCortana";
					Type="DWord";
					Value=0;
				},
				@{
					Description=$Null;
					Name="ConnectedSearchUseWeb";
					Type="DWord";
					Value=0;
				},
				@{
					Description=$Null;
					Name="ConnectedSearchUseWebOverMeteredConnections";
					Type="DWord";
					Value=0;
				},
				@{
					Description=$Null;
					Name="DisableWebSearch";
					Type="DWord";
					Value=1;
				}
			)
		};

		# ------------------------------------------------------------
		
		If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
			#
			# Current session does not have Admin-Rights (required)
			#   |--> Re-run this script as admin (if current user is not an admin, request admin credentials)
			#
			Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
			Exit;

		} Else {
			#
			# 		New-Item --> Can be used to create new registry keys (assuming the current powershell session is running with elevated privileges)
			#
			#			Set-ItemProperty --> Can be used to create new registry values (DWord 32-bit, etc.)
			#

			Foreach ($EachRegEdit In $RegEdits) {
				#
				# Root-Keys
				#   |--> Ensure that this registry key's Root-Key has been mapped as a network drive
				#   |--> Mapping this as a network drive grants this script read & write access to said Root-Key's registry values (which would otherwise be inaccessible)
				#
				$Each_RegEdit_DriveName=(($EachRegEdit.Path).Split(':\')[0]);
				If ((Test-Path -Path (("")+(${Each_RegEdit_DriveName})+(":\"))) -Eq $False) {
					$Each_PSDrive_PSProvider=$Null;
					$Each_PSDrive_Root=$Null;
					Write-Host "`n`n  Info: Root-Key `"${Each_RegEdit_DriveName}`" not found" -ForegroundColor Yellow;
					Foreach ($Each_PSDrive In $PSDrives) {
						If ((($Each_PSDrive.Name) -Ne $Null) -And (($Each_PSDrive.Name) -eq $Each_RegEdit_DriveName)) {
							$Each_PSDrive_PSProvider=($Each_PSDrive.PSProvider);
							$Each_PSDrive_Root=($Each_PSDrive.Root);
							Break;
						}
					}
					If ($Each_PSDrive_Root -Ne $Null) {
						Write-Host "   |`n   |--> Adding Session-Based ${Each_PSDrive_PSProvider} Network-Map from drive name `"${Each_RegEdit_DriveName}`" to data store location `"${Each_PSDrive_Root}`"" -ForegroundColor "DarkGray";
						New-PSDrive -Name "${Each_RegEdit_DriveName}" -PSProvider "${Each_PSDrive_PSProvider}" -Root "${Each_PSDrive_Root}" | Out-Null;
					}
				}
				
				If ((Test-Path -Path ($EachRegEdit.Path)) -eq $True) {
					# Skip creating registry key if it already exists
					Write-Host (("`n`n  Found Key `"")+($EachRegEdit.Path)+("`"")) -ForegroundColor DarkGray; # (Already up to date)
				} Else {
					# Create missing key in the registry
					Write-Host (("`n`n  Creating Key `"")+($EachRegEdit.Path)+("`" ")) -ForegroundColor Green;
					New-Item -Path ($EachRegEdit.Path);
				}

				Foreach ($EachProp In $EachRegEdit.Props) {

					# Check for each key-property
					# Write-Host (("`n`n  Checking for `"")+($EachRegEdit.Path)+("`" --> `"$($EachProp.Name)`"...`n`n"));
					$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';
					$GetEachItemProp = Get-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name);
					$last_exit_code = If($?){0}Else{1};
					$ErrorActionPreference = $Revertable_ErrorActionPreference;
					$EchoDetails = "";
					If ((${EachProp}.Description) -Ne $Null) { $EchoDetails += "`n         v`nDescription: $(${EachProp}.Description)"; }
					If ((${EachProp}.Hotfix) -Ne $Null) { $EchoDetails += "`n         v`nHotfix: $(${EachProp}.Hotfix)"; }


					If ($last_exit_code -eq 0) {

						$EachProp.LastValue = $GetEachItemProp.($EachProp.Name);

						If (($EachProp.LastValue) -eq ($EachProp.Value)) {
							# Existing key-property found with correct value (Already up to date)
							Write-Host "   |`n   |--> Found Property `"$($EachProp.Name)`" with correct Value of [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "DarkGray";

						} Else {
							# Modify the value of an existing property on an existing registry key
							Write-Host "   |`n   |--> Updating Property `"$($EachProp.Name)`" from Value [ $($EachProp.LastValue) ] to Value [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "Yellow";
							Set-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value);

						}
					} Else {
						# Add the missing property to the Registry Key
						Write-Host "   |`n   |--> Adding Property `"$($EachProp.Name)`" with Value [ $($EachProp.Value) ] ${EchoDetails}" -ForegroundColor "Yellow";
						New-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value);
						Write-Host " `n`n";

					}

				}

			}

		}
	}

	Write-Host -NoNewLine "`n`n  Press any key to exit..." -BackgroundColor Black -ForegroundColor Magenta;
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

}
Export-ModuleMember -Function "SyncRegistry";
# Install-Module -Name "SyncRegistry"


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Set-ItemProperty - Creates or changes the value of a property of an item"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty
#
#   docs.microsoft.com  |  "Get-PSProvider - Gets information about the specified PowerShell provider"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psprovider
#
#   docs.microsoft.com  |  "New-PSDrive - Creates temporary and persistent mapped network drives"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive
#
#   stackoverflow.com  |  "Retrieve (Default) Value in Registry key"  |  https://stackoverflow.com/a/31711000
#
#   winhelponline.com  |  "Change the Default Image Editor Linked to Edit command in Right-click Menu for Image Files"  |  https://www.winhelponline.com/blog/change-default-image-editor-edit-command-right-click-image/
#
# ------------------------------------------------------------