function SyncRegistry {
	Param(
	)

	If ((RunningAsAdministrator) -Ne ($True)) {

		PrivilegeEscalation -Command ("SyncRegistry");
	
	} Else {

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


		# Cortana/Search Settings
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search";
			Props=@(
				@{
					Description="Cortana/Search Settings - Set to [ 1 ] to Enable or [ 0 ] to Disable Cortana's ability to send search-resutls to Bing.com.";
					Hotfix="Enabling fixes a bug where Cortana eats 30-40% CPU resources (KB4512941).";
					Name="BingSearchEnabled";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description=$Null;
					Name="AllowSearchToUseLocation";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Cortana/Search Settings (cont.)
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search";
			Props=@(
				@{
					Description="Cortana/Search Settings - TODO";
					Name="AllowCortana";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - TODO";
					Name="ConnectedSearchUseWeb";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - TODO";
					Name="ConnectedSearchUseWebOverMeteredConnections";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - TODO";
					Name="DisableWebSearch";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Explorer Settings
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer";
			Props=@(
				@{
					Description="Explorer Settings - Set to [ 1 ] to Disable or [ 0 ] to Enable `"Aero Shake`" in Windows 10";
					Name="NoWindowMinimizingShortcuts"; 
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
			Props=@(
				@{
					Description="Explorer Settings - Setting to [ 0 ] selects `"Show hidden files, folders, and drives`", setting to [ 1 ] selects `"Don't show hidden files, folders, or drives`"";
					Name="Hidden"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Check [ 1 ] or Uncheck [ 0 ] option `"Hide empty drives`"";
					Name="HideDrivesWithNoMedia"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Check [ 1 ] or Uncheck [ 0 ] option `"Hide extensions for known file types`"";
					Name="HideFileExt"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Check [ 1 ] or Uncheck [ 0 ] option `"Hide folder merge conflicts`"";
					Name="HideMergeConflicts"; 
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}";
			Props=@(
				@{
					Description="Explorer Settings - Set this value to [ DELETED ] to hide the 'Onedrive' Icon from Windows Explorer, [ CREATED ] to add the 'OneDrive' icon";
					Name="(Default)"; 
					Type="REG_SZ";
					Val_Default="OneDrive";
					Value="OneDrive";
					Delete=$True; <# ! Delete this Property ! #>
				}
			)
		};


		# Explorer Settings (cont.)
		$DefaultPictureEditor="C:\Program Files\paint.net\PaintDotNet.exe";
		If ((Test-Path -Path "${DefaultPictureEditor}") -Eq $True) {
			# Set default application to use when user clicks "Edit" after right-clicking an image-file in Explorer
			#   |--> Explorer -> Image-File (.png, .jpg, ...) -> Right-Click -> Edit -> Opens app held in [v THIS v] RegEdit Key/Val
			$RegEdits += @{
				Path="Registry::HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\edit\command";
				Props=@(
					@{
						Description="Explorer Settings - Defines the application opened when a user right-clicks an Image file (in Windows Explorer) and selects the `"Edit`" command.";
						Name="(Default)"; 
						Type="REG_EXPAND_SZ";
						Val_Default="`"%systemroot%\system32\mspaint.exe`" `"%1`"";
						Value=(("`"")+(${DefaultPictureEditor})+("`" `"%1`""));
						Delete=$False;
					}
				)
			};
		}


		# Lock Workstation (Enable/Disable)
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System";
			Props=@(
				@{
					Description="Set this value to [ 1 ] to disable `"Lock Workstation`" in Windows (hotkey: WinKey + L )";
					Name="DisableLockWorkstation";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};

		# Multitasking - Snap windows (half-screen left/right snapping of windows)
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Control Panel\Desktop";
			Props=@(
				@{
					Description="Set to [ 1 ] to Disable, [ 0 ] to Enable the Multitasking feature [ Snap windows ]";
					Name="WindowArrangementActive"; 
					Type="String";
					Value=1;
					Delete=$False;
				}
			)
		};
		# Multitasking - Snap windows (cont.)
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
			Props=@(
				@{
					Description="Set to [ 1 ] to Disable, [ 0 ] to Enable the Snap feature [ When I snap a window, automatically size it to fill available space ]";
					Name="SnapFill"; 
					Type="String";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Set to [ 1 ] to Disable, [ 0 ] to Enable the Snap feature [ When I snap a window, show what I can snap next to it ]";
					Name="SnapAssist"; 
					Type="String";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Set to [ 1 ] to Disable, [ 0 ] to Enable the Snap feature [ When I resize a snapped window, simultaneously resize any adjacent snapped window ]";
					Name="JointResize"; 
					Type="String";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Multitasking - Timeline
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager";
			Props=@(
				@{
					Description="Set to [ 1 ] to Disable, [ 0 ] to Enable the Multitasking feature [ Timeline - Show suggestions in your timeline ]";
					Name="SubscribedContent-353698Enabled"; 
					Type="String";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Notification Area Icons
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer";
			Props=@(
				@{
					Description="System Tray - Set this value to [ 0 ] to show all icons, [ 1 ] to hide inactive icons (note: the default for this is set under HKLM)";
					Hotfix=$Null;
					Name="EnableAutoTray";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Office 2013 Settings
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\15.0\Common\General";
			Props=@(
				@{
					Description="Office 2013 Settings - Set to [ 2147483648 ] to Disable Microsoft Office Clipboard (Excel-Only?)";
					Hotfix=$Null;
					Name="AcbControl";
					Type="DWord";
					Value=2147483648;
					Delete=$False;
				}
			)
		};


		# Office 2016 Settings
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Software\Microsoft\Office\16.0\Common\General";
			Props=@(
				@{
					Description="Office 2016 Settings - Set to [ 2147483648 ] to Disable Microsoft Office Clipboard (Excel-Only?)";
					Hotfix=$Null;
					Name="AcbControl";
					Type="DWord";
					Value=2147483648;
					Delete=$False;
				}
			)
		};


		# Power Settings
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0";
			Props=@(
				@{
					Description="Power Settings - Set to [2] to enable 'advanced power settings', [1] to disable 'advanced power settings'.";
					Hotfix=$Null;
					Name="Attributes";
					Type="DWord";
					Value=2;
					Delete=$False;
				}
			)
		};


		# Shutdown/Restart Settings
		$RegEdits += @{
			Path="Registry::HKEY_CURRENT_USER\Control Panel\Desktop";
			Props=@(
				@{
					Description="Set to [ 1 ] to Disable, [ 0 ] to Enable the [ This App is Preventing Shutdown or Restart ] screen, which appears while attempting Shutdown/Restart the machine while certain inspecific applications are running - Remove this key/val to show this screen, instead";
					Name="AutoEndTasks"; 
					Type="String";
					Value=1;
					Delete=$False;
				}
			)
		};


		# SmartScreen for Microsoft Edge, Microsoft Store Apps
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System";
			Props=@(
				@{
					Description="Set this value to [ 0 ] to turn off SmartScreen, [ 1 ] to give user a warning before running downloaded unknown software, [ 2 ] to require approval from an administrator before running downloaded unknown software ( from https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen )";
					Name="EnableSmartScreen";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter";
			Props=@(
				@{
					Description="Set this value to [ 0 ] to allow users to bypass (ignore) the Windows Defender SmartScreen warnings about potentially malicious files, [ 1 ] to prevent users from bypassing the warnings, blocking them from downloading of the unverified file(s) (from https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#prevent-bypassing-windows-defender-smartscreen-prompts-for-files )";
					Name="PreventOverrideAppRepUnknown";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter";
			Props=@(
				@{
					Description="By default, Microsoft Edge allows users to bypass (ignore) the Windows Defender SmartScreen warnings about potentially malicious sites, allowing them to continue to the site. With this policy though, you can configure Microsoft Edge to prevent users from bypassing the warnings, blocking them from continuing to the site (from https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#prevent-bypassing-windows-defender-smartscreen-prompts-for-sites )";
					Name="PreventOverride";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Windows Update - Force-pull from Windows instaed of local server
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU";
			Props=@(
				@{
					Description="Set this value to [ 1 ] to configure Automatic Updates to use a server that is running Software Update Services instead of Windows Update ( from https://docs.microsoft.com/en-us/windows/deployment/update/waas-wu-settings )";
					Name="UseWUServer";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\Servicing";
			Props=@(
				@{
					Description="Sets the value (string) for the option named [ Alternate source file path ] under Group-Policy [ 'Computer Configuration' -> 'Administrative Templates' -> 'System' -> 'Specify settings for optional component installation and component repair setting.'";
					Name="LocalSourcePath";
					Type="ExpandString";
					Value="";
					Delete=$False;
				},
				@{
					Description="Sets the value (checkbox, check=2, unchecked=delete-the-key) for the option named [ Download repair content and optional features directly from Windows Update isntead of Windows Server Update Services (WSUS) ] under Group-Policy [ 'Computer Configuration' -> 'Administrative Templates' -> 'System' -> 'Specify settings for optional component installation and component repair setting.'";
					Name="RepairContentServerSource";
					Type="DWord";
					Value=2;
					Delete=$False;
				},
				@{
					Description="Sets the value to [ 2 ] to 'never pull from Windows Update (checked in gpedit)', [ deleted ] to 'allow pulling from Windows Update (unchecked in gpedit)' for the option named [ Never attempt to download payload from Windows Update ] under Group-Policy [ 'Computer Configuration' -> 'Administrative Templates' -> 'System' -> 'Specify settings for optional component installation and component repair setting.'";
					Name="UseWindowsUpdate";
					Type="DWord";
					Value=2;
					Delete=$True; <# ! Delete this Property ! #>
				}
			)
		};


		# ------------------------------------------------------------
		# Environment-specific registry settings
		#
		If ( $False ) {

			# VMware vSphere Client Cached-Connections
			$RegEdits += @{
				Path="Registry::HKEY_CURRENT_USER\Software\VMware\VMware Infrastructure Client\Preferences";
				Props=@(
					@{
						Description="Defines the vSphere Client's [ IP address/ Name ] cached connection-urls";
						Name="RecentConnections"; 
						Type="String";
						Value="";
						Delete=$False;
					}
				)
			};

			# VMware vSphere Client Cached-Connections
			$RegEdits += @{
				Path="Registry::HKEY_CURRENT_USER\Software\Policies\Microsoft\CloudFiles\BlockedApps\*";
				Props=@(
					@{
						Description="Blocks (1) or Unblocks (0) Apps from being able to trigger the OneDrive's `"Files On-Demand`" feature";
						Name="Enabled"; 
						Type="DWord";
						Value=1;
						Delete=$False;
					}
				)
			};

		}


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
				Write-Host "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n" -BackgroundColor Black -ForegroundColor Yellow;
			}
		} Else {
			<# Script >> IS << running as Admin - Continue #>

			Foreach ($EachRegEdit In $RegEdits) {
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
						Write-Host "`nInfo:  Root-Key `"${Each_RegEdit_DriveName}`" not found" -ForegroundColor Yellow;
						Foreach ($Each_PSDrive In $PSDrives) {
							If ((($Each_PSDrive.Name) -Ne $Null) -And (($Each_PSDrive.Name) -Eq $Each_RegEdit_DriveName)) {
								$Each_PSDrive_PSProvider=($Each_PSDrive.PSProvider);
								$Each_PSDrive_Root=($Each_PSDrive.Root);
								Break;
							}
						}
						If ($Each_PSDrive_Root -Ne $Null) {
							Write-Host "  |-->  Adding Session-Based ${Each_PSDrive_PSProvider} Network-Map from drive name `"${Each_RegEdit_DriveName}`" to data store location `"${Each_PSDrive_Root}`"" -ForegroundColor "Yellow";
							New-PSDrive -Name "${Each_RegEdit_DriveName}" -PSProvider "${Each_PSDrive_PSProvider}" -Root "${Each_PSDrive_Root}" | Out-Null;
						}
					}
				}

				Write-Host (("`n")+($EachRegEdit.Path)+("")) -ForegroundColor "Green";
				Foreach ($EachProp In $EachRegEdit.Props) {

					# Check for each Key - If not found, then create it (unless it is to-be-deleted)
					If (((Test-Path -Path ($EachRegEdit.Path)) -Eq $False) -And (($EachProp.Delete) -eq $False)) {
						#
						# New-Item -Force
						#   |--> Upside - Creates ALL parent registry keys
						#   |--> Downside - DELETES all properties & child-keys if key already exists
						#   |--> Takeaway - Always use  [ Test-Path ... ]  to verify registry keys don't exist before using  [ New-Item -Force ... ]  to create the key
						#
						New-Item -Force -Path ($EachRegEdit.Path) | Out-Null;
						If ((Test-Path -Path ($EachRegEdit.Path)) -Eq $True) {
							Write-Host (("  |-->  Created Key")) -ForegroundColor "Green";
						}
					}

					# # Check for each Property
					Try {
						$GetEachItemProp = (Get-ItemPropertyValue -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -ErrorAction ("Stop"));
					} Catch {
						$GetEachItemProp = $Null;
					};

					$EchoDetails = "";

					If ($GetEachItemProp -NE $Null) { # Registry-Key-Property exists

						If (($EachProp.Delete) -Eq $False) { # Property should NOT be deleted

							$EachProp.LastValue = $GetEachItemProp;
								
							If (($EachProp.LastValue) -Eq ($EachProp.Value)) {

								# Do nothing to the Property (already exists with matching type & value)
								Write-Host "  |-->  Skipping Property `"$($EachProp.Name)`" (already up-to-date w/ type `"$($EachProp.Type)`" and value `"$($EachProp.Value)`" ) ${EchoDetails}" -ForegroundColor "DarkGray";

							} Else {

								# Update the Property
								Write-Host "  |-->  Updating Property `"$($EachProp.Name)`" (w/ type `"$($EachProp.Type)`" to have value `"$($EachProp.Value)`" instead of (previous) value `"$($EachProp.LastValue)`" ) ${EchoDetails}" -ForegroundColor "Yellow";
								Set-ItemProperty -Force -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value) | Out-Null;

							}

						} Else { # Property (or Key) SHOULD be deleted

							If (($EachProp.Name) -Eq "(Default)") {

								# Delete the Registry-Key
								Remove-Item -Force -Path ($EachRegEdit.Path) | Out-Null;
								If ((Test-Path -Path ($EachRegEdit.Path)) -Eq $False) {
									Write-Host (("  |-->  Deleted Key")) -ForegroundColor "Magenta";
									Break; # Since we're removing the registry key, we can skip going over the rest of the current key's properties (since the key itself should no longer exist)
								}

							} Else {

								# Delete the Property
								Write-Host "  |-->  Deleting Property `"$($EachProp.Name)`" ${EchoDetails}" -ForegroundColor "Magenta";
								Remove-ItemProperty -Force -Path ($EachRegEdit.Path) -Name ($EachProp.Name) | Out-Null;

							}

						}

					} Else { # Registry-Key-Property does NOT exist

						If (($EachProp.Delete) -Eq $False) {

							# Create the Property
							Write-Host "  |-->  Adding Property `"$($EachProp.Name)`" (w/ type `"$($EachProp.Type)`" and value `"$($EachProp.Value)`" ) ${EchoDetails}" -ForegroundColor "Yellow";
							New-ItemProperty -Force -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) | Out-Null;

						} Else {

							# Do nothing to the Property (already deleted)
							Write-Host "  |-->  Skipping Property `"$($EachProp.Name)`" (already deleted) ${EchoDetails}" -ForegroundColor "DarkGray";

						}

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
#   answers.microsoft.com  |  "Automatic files - Automatic file downloads"  |  https://answers.microsoft.com/en-us/windows/forum/all/automatic-files/91b91138-0096-4fbc-a3e2-5de5176a6ca5
#
#   autohotkey.com  |  "Windows key (#) + letter keeps locking the pc (even if it is not #L)"  |  https://www.autohotkey.com/boards/viewtopic.php?p=46949&sid=490d0a443a7f78557b54c2bfb079350f#p46949
#
#   docs.microsoft.com  |  "Configure Windows Defender SmartScreen"  |  https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen
#
#   docs.microsoft.com  |  "Get-PSProvider - Gets information about the specified PowerShell provider"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psprovider
#
#   docs.microsoft.com  |  "New-PSDrive - Creates temporary and persistent mapped network drives"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive
#
#   docs.microsoft.com  |  "Remove-ItemProperty - Deletes the property and its value from an item"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty
#
#   docs.microsoft.com  |  "Set-ItemProperty - Creates or changes the value of a property of an item"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty
#
#   getadmx.com  |  "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"  |  https://getadmx.com/HKCU/Software/Microsoft/Windows/CurrentVersion/Policies/System
#
#   jonathanmedd.net  |  "Testing for the Presence of a Registry Key and Value"  |  https://www.jonathanmedd.net/2014/02/testing-for-the-presence-of-a-registry-key-and-value.html
#
#   microsoft.com  |  "Group Policy Settings Reference for Windows and Windows Server"  |  https://www.microsoft.com/en-us/download/confirmation.aspx?id=25250
#
#   social.msdn.microsoft.com  |  ".NET Framework 3.5 doesn't install. Windows 10.. Error code: 0x800F081F"  |  https://social.msdn.microsoft.com/Forums/en-US/4ea808e7-c503-4f99-9480-aa8e6938be3d
#
#   ss64.com  |  "Windows 10 registry - How-To: Windows 10 registry - user interface settings - Windows CMD - SS64.com"  |  https://ss64.com/nt/syntax-reghacks.html
#
#   stackoverflow.com  |  "New-Item recursive registry keys"  |  https://stackoverflow.com/a/21770519
#
#   stackoverflow.com  |  "Retrieve (Default) Value in Registry key"  |  https://stackoverflow.com/a/31711000
#
#   stackoverflow.com  |  "The IDynamicPropertyCmdletProvider interface is not implemented by this provider"  |  https://stackoverflow.com/a/54237993
#
#   windows.tips.net  |  "Understanding Registry Value Data Types"  |  https://windows.tips.net/T013035_Understanding_Registry_Value_Data_Types.html
#
#   www.tenforums.com  |  "Turn On or Off Snap Windows in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/4343-turn-off-snap-windows-windows-10-a.html
#
#   www.winhelponline.com  |  "Change the Default Image Editor Linked to Edit command in Right-click Menu for Image Files"  |  https://www.winhelponline.com/blog/change-default-image-editor-edit-command-right-click-image/
#
# ------------------------------------------------------------