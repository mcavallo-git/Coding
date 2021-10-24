function SyncRegistry {
	Param(

		[String]$UserSID=""   <# Allow user to pass a user SID to modify locally (via HKEY_USERS/[UserSID]) <-- To acquire a user's SID, open a powershell terminal as that user & run the following command:   (((whoami /user /fo table /nh) -split ' ')[1])  #>

	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/SyncRegistry/SyncRegistry.psm1') ).Content) } Catch {}; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; If (-Not (Get-Command -Name 'SyncRegistry' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\SyncRegistry\SyncRegistry.psm1', ((Get-Variable -Name 'HOME').Value))); };
		SyncRegistry;

		# SyncRegistry -UserSID (((whoami /user /fo table /nh) -split ' ')[1]);

	}
	# ------------------------------------------------------------

	# If ((RunningAsAdministrator) -Ne ($True)) {
	# 	PrivilegeEscalation -Command ("SyncRegistry") {
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


		<# Check if using HKEY_CURRENT_USERS or HKEY_USERS/[SID] #>
		$HKEY_USERS_SID_OR_CURRENT_USER="";
		If ("${UserSID}" -Eq "") {
			$HKEY_USERS_SID_OR_CURRENT_USER="HKEY_CURRENT_USER";
		} ElseIf ((Test-Path -Path "Registry::HKEY_USERS\${UserSID}") -Eq $True) {
			$HKEY_USERS_SID_OR_CURRENT_USER="HKEY_USERS\${UserSID}";
		} Else {
			Write-Output "`n`nError:  Invalid User SID - No registry key exists at:  `n          Registry::HKEY_USERS\${UserSID}";
			Write-Output "`n`nInfo:   To acquire a user's SID, open a powershell terminal as that user & run the following command:   (((whoami /user /fo table /nh) -split ' ')[1])";
			Write-Output "`n`n";
			Start-Sleep -Seconds (30);
			Exit 1;
		}


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
		$PSDrives += @{ Name="HKLM"; PSProvider="Registry"; Root="HKEY_LOCAL_MACHINE";    };
		$PSDrives += @{ Name="HKCC"; PSProvider="Registry"; Root="HKEY_CURRENT_CONFIG";   };
		$PSDrives += @{ Name="HKCR"; PSProvider="Registry"; Root="HKEY_CLASSES_ROOT";     };
		$PSDrives += @{ Name="HKU" ; PSProvider="Registry"; Root="HKEY_USERS";            };
		$PSDrives += @{ Name="HKCU"; PSProvider="Registry"; Root="HKEY_CURRENT_USER";     };
		$PSDrives += @{ Name=$Null ; PSProvider="Registry"; Root="HKEY_PERFORMANCE_DATA"; };
		$PSDrives += @{ Name=$Null ; PSProvider="Registry"; Root="HKEY_DYN_DATA";         };


		# ------------------------------------------------------------

		$RegEdits = @();


		# Cortana/Search Settings
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Search";
			Props=@(
				@{
					Description="Cortana/Search Settings - Set to [ 0 ] to Disable, [ 1 ] to Enable Cortana.";
					Name="AllowCortana";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description=$Null;
					Name="AllowSearchToUseLocation";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Cortana/Search Settings - Set to [ 0 ] to Disable, [ 1 ] to Enable Cortana's ability to send search-resutls to Bing.com.";
					Hotfix="Enabling fixes a bug where Cortana eats 30-40% CPU resources (KB4512941).";
					Name="BingSearchEnabled";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description=$Null;
					Name="CortanaConsent";
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
					Name="AllowSearchToUseLocation";
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
					Description=$Null;
					Name="CortanaConsent";
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


		# DateTimes
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters";
			Props=@(
				@{
					Description="DateTimes - Sets the clock to use NTP";
					Name="Type";
					Type="String";
					Value="NTP";
					Delete=$False;
				},
				@{
					Description="DateTimes - $?";
					Name="ServiceMain";
					Type="String";
					Value="SvchostEntry_W32Time";
					Delete=$False;
				}
			)
		};


		# Desktop Background Color
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Colors";
			Props=@(
				@{
					Description="Defines a user's desktop background color using space-delimited R G B syntax (such as '255 255 255' for white, '255 0 0' for red, '0 255 0' for green, and '0 0 255' for blue)";
					Name="Background";
					Type="String";
					Value="34 34 34";
					Delete=$False;
				}
			)
		};

		# Explorer Settings
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Policies\Microsoft\Windows\Explorer";
			Props=@(
				@{
					Description="Explorer Settings - Set to [ 0 ] to Enable, [ 1 ] to Disable `"Aero Shake`" in Windows 10 (Part 1/2)";
					Name="NoWindowMinimizingShortcuts";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
			Props=@(
				@{
					Description="Explorer Settings - Set to [ 0 ] to Enable, [ 1 ] to Disable `"Aero Shake`" in Windows 10 (Part 2/2)";
					Name="DisallowShaking";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Setting to [ 0 ] selects `"Show hidden files, folders, and drives`", setting to [ 1 ] selects `"Don't show hidden files, folders, or drives`"";
					Name="Hidden";
					Type="String";
					Value="SHOW";
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
				},
				@{
					Description="Show or hide seconds on the system tray clock. 0=[Hide], 1=[Show]";
					Name="ShowSecondsInSystemClock";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}";
			Props=@(
				@{
					Description="Explorer Settings - Set Delete=`$True to hide the OneDrive personal (default) cloud icon from the left bar on Windows Explorer - Set Delete=`$False to add said icon back to explorer";
					Name="(Default)";
					Type="String";
					Val_Default="OneDrive - Personal";
					Value="OneDrive - Personal";
					Delete=$True;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-69E8-C58E-500AB795E1FD}";
			Props=@(
				@{
					Description="Explorer Settings - Set Delete=`$True to hide the 'OneDrive Sharepoint' company-building icon from the left bar on Windows Explorer (shortcut to synced sharepoint directories) - Set Delete=`$False to add said icon back to explorer";
					Name="(Default)";
					Type="String";
					Val_Default="Getac Video";
					Value="Getac Video";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-439F-9D0E-BE7D32FDF154}";
			Props=@(
				@{
					Description="Explorer Settings - Set Delete=`$True to hide the 'OneDrive Enterprise' individual's icon from the left bar on Windows Explorer - Set Delete=`$False to add said icon back to explorer";
					Name="(Default)";
					Type="String";
					Val_Default="OneDrive - Getac Video";
					Value="OneDrive - Getac Video";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Explorer Settings ('OneDrive' context menu option(s))
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Troubleshoot compatibility' context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ creating this property ]. Disable (show the context menu option(s)) by [ deleting this property ]";
					Name="{1D27F844-3A1F-4410-85AC-14651078412D}";
					Type="String";
					Val_Default="";
					Value="";
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Enable [ hiding of 'Restore previous versions' context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ creating this property ]. Disable (show the context menu option(s)) by [ deleting this property ]";
					Name="{596AB062-B4D2-4215-9F74-E9109B0A8153}";
					Type="String";
					Val_Default="";
					Value="";
					Delete=$False;
				},
				@{
					Description="Explorer Settings - Enable [ hiding of 'Cast to Device' context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ creating this property ]. Disable (show the context menu option(s)) by [ deleting this property ]";
					Name="{7AD84985-87B4-4a16-BE58-8B72A5B390F7}";
					Type="String";
					Val_Default="";
					Value="Play to menu";
					Delete=$False;
				},
				# @{
				# 	Description="Explorer Settings - Enable [ hiding of 'OneDrive' context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ creating this property ]. Disable (show the context menu option(s)) by [ deleting this property ]";
				# 	Name="{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}";
				# 	Type="String";
				# 	Val_Default="";
				# 	Value="";
				# 	Delete=$False;
				# },
				@{
					Description="Explorer Settings - Enable [ hiding of 'Give access to' context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ creating this property ]. Disable (show the context menu option(s)) by [ deleting this property ]";
					Name="{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}";
					Type="String";
					Val_Default="";
					Value="Play to menu";
					Delete=$False;
				}
			)
		};


		# Explorer Settings ('Microsoft Defender' context menu option(s))
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\EPP";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Scan with Microsoft Defender...' (pt. 1/4) context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ creating this key ]";
					Name="(Default)";
					Type="String";
					Val_Default="{09A47860-11B0-4DA5-AFA5-26D86198A780}";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Scan with Microsoft Defender...' (pt. 2/4) context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ creating this key ]";
					Name="(Default)";
					Type="String";
					Val_Default="";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\EPP";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Scan with Microsoft Defender...' (pt. 3/4) context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ creating this key ]";
					Name="(Default)";
					Type="String";
					Val_Default="{09A47860-11B0-4DA5-AFA5-26D86198A780}";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\EPP";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Scan with Microsoft Defender...' (pt. 4/4) context menu option(s) in Windows Explorer's right-click dropdown menu ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ creating this key ]";
					Name="(Default)";
					Type="String";
					Val_Default="{09A47860-11B0-4DA5-AFA5-26D86198A780}";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Explorer Settings ('Share' context menu option(s))
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\ModernSharing";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Share' context menu option(s) when right-clicking files/folders in Windows Explorer ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ creating this key ]";
					Name="(Default)";
					Type="String";
					Val_Default="";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Explorer Settings ('Send to' context menu option(s))
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Send to' context menu option(s) when right-clicking files/folders in Windows Explorer ] by [ setting this property's value to blank ]. Disable (show the context menu option(s)) by [ setting this key to its default value ]";
					Name="(Default)";
					Type="String";
					Val_Default="{7BA4C740-9E81-11CF-99D3-00AA004AE837}";
					Value="";
					Delete=$False;
				}
			)
		};


		# Explorer Settings ('Include in library' context menu option(s))
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\Folder\shellex\ContextMenuHandlers\Library Location";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Include in library' context menu option(s) when right-clicking files/folders in Windows Explorer ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ setting this key to its default value ]";
					Name="(Default)";
					Type="String";
					Val_Default="{3DAD6C5D-2167-4CAE-9914-F99E41C12CFA}";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Explorer Settings ('Pin to Quick access' context menu option(s))
		$RegEdits += @{
			Path="Registry::HKEY_CLASSES_ROOT\Folder\shell\pintohome";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Pin to Quick access' (pt. 1/2) context menu option(s) when right-clicking files/folders in Windows Explorer ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ setting this key to its default value ]";
					Name="(Default)";
					Type="String";
					Val_Default="";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shell\pintohome";
			Props=@(
				@{
					Description="Explorer Settings - Enable [ hiding of 'Pin to Quick access' (pt. 2/2) context menu option(s) when right-clicking files/folders in Windows Explorer ] by [ deleting this key ]. Disable (show the context menu option(s)) by [ setting this key to its default value ]";
					Name="(Default)";
					Type="String";
					Val_Default="";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Explorer Settings (cont.)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer";
			Props=@(
				@{
					Description="Explorer Settings - When this policy is enabled, applications must not keep MRU lists (for example, in common dialog boxes)";
					Name="NoRecentDocsMenu";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Set to [ 0 ] to Enable, [ 1 ] to Disable the [ Run as different user ] right-click option";
					Name="HideRunAsVerb";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Set to [ 1 ] to [ set the Preview Pane as hidden in File Explorer (and lock/disable the user from enabling it) ]. Set to [ 0 ] or [ deleted ] to [ set the Preview Pane as hidden in File Explorer (but allow the user to enable it) ]";
					Name="NoReadingPane";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Set to [ DELETED ] to Enable, [ 1 ] to Disable the 'most recently used files list' feature";
					Name="NoRecentDocsHistory";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer";
			Props=@(
				@{
					Description="Explorer Settings - When this policy is enabled, applications must not keep MRU lists (for example, in common dialog boxes)";
					Name="NoRecentDocsMenu";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Set to [ 0 ] to Enable, [ 1 ] to Disable the 'Run as different user' right-click option";
					Name="HideRunAsVerb";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Set to [ DELETED ] to Enable, [ 1 ] to Disable the 'most recently used files list' feature";
					Name="NoRecentDocsHistory";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Comdlg32";
			Props=@(
				@{
					Description="Explorer Settings - When this policy is set, applications that provide their own file or open dialog boxes must remove any equivalent functionality to the places bar. Applications that use the common dialog box library will comply with this policy";
					Name="NoPlacesBar";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Explorer Settings - When this policy is set, applications that provide their own file or open dialog boxes must not display an MRU (Most Recently Used) list in these dialog boxes. Applications that use the common dialog box library will comply with this policy";
					Name="NoFileMru";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_USERS\.Default\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU";
			Props=@(
				@{
					Description="Delete the list of MRU (Most Recently Used) items";
					Name="(Default)";
					# Type="REG_SZ";
					Type="String";
					Value="";
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
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

		# IPv6
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters";
			Props=@(
				@{
					Description="IPv6 Network Settings -->  [ 32 = 'Prefer IPv4 over IPv6' ], [ 255 = 'Disable IPv6' ], [ 16 = 'disable IPv6 on all nontunnel interfaces' ], [ 1 = 'disable IPv6 on all tunnel interfaces' ], [ 17 = 'disable IPv6 on all nontunnel interfaces (except the loopback) and on IPv6 tunnel interface' ]";
					Name="DisabledComponents";
					Type="DWord";
					Value=("255");
					Delete=$False;
				}
			)
		};


		# Lock Workstation (Enable/Disable)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System";
			Props=@(
				@{
					Description="Set this value to [ 0 ] to Enable, [ 1 ] to Disable `"Lock Workstation`" in Windows (hotkey: WinKey + L )";
					Name="DisableLockWorkstation";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Multimedia - Gaming Priority
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile";
			Props=@(
				@{
					Description="Determines the percentage of CPU resources that should be guaranteed to low-priority tasks (Defaults to 20). Rounds up to the nearest value of 10. A value of 0 is also treated as 10.";
					Name="SystemResponsiveness";
					Type="DWord";
					Val_Default=("20");
					Val_Gaming=("1");
					Value=("20");
					Delete=$False;
				}
			)
		};


		# Multimedia - System Responsiveness
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games";
			Props=@(
				@{
					Description="The GPU priority. The range of values is 0-31. This priority is not yet used.";
					Name="GPU Priority";
					Type="DWord";
					Val_Default=("8");
					Val_Gaming=("8");
					Value=("8");
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				},
				@{
					Description="The task priority. The range of values is 1 (low) to 8 (high). For tasks with a Scheduling Category of High, this value is always treated as 2.";
					Name="Priority";
					Type="DWord";
					Val_Default=("2");
					Val_Gaming=("6");
					Value=("2");
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				},
				@{
					Description="The scheduling category. This value can be set to High, Medium, or Low.";
					Name="Scheduling Category";
					Type="String";
					Val_Default=("Medium");
					Val_Gaming=("High");
					Value=("Medium");
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				},
				@{
					Description="The scheduled I/O priority. This value can be set to Idle, Low, Normal, or High. This value is not used.";
					Name="SFIO Priority";
					Type="String";
					Val_Default=("Normal");
					Val_Gaming=("High");
					Value=("Normal");
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Multitasking - Snap windows (half-screen left/right snapping of windows)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Desktop";
			Props=@(
				@{
					Description="Set to [ 0 ] to Disable, [ 1 ] to Enable the Multitasking feature [ Snap windows ]";
					Name="WindowArrangementActive";
					Type="String";
					Value=1;
					Delete=$False;
				}
			)
		};
		# Multitasking - Snap windows (cont.)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced";
			Props=@(
				@{
					Description="Set Snap option 'When I resize a snapped window, simultaneously resize any adjacent snapped window' to [ 0 = disabled ], [ 1 = enabled ]";
					Name="JointResize";
					Type="DWord";
					Value=1;
					Delete=$False;
				},
				@{
					Description="Set Alt + Tab option 'Pressing Alt + Tab shows' to [ 0 = Open windows and all tabs in Edge ], [ 1 = Open windows and 5 most recent tabs in Edge ], [ 2 = Open windows and 3 most recent tabs in Edge ], [ 3 = Open windows only]";
					Name="MultiTaskingAltTabFilter";
					Type="DWord";
					Value=3;
					Delete=$False;
				},
				@{
					Description="Set Snap option 'When I snap a window, show what I can snap next to it' to [ 0 = disabled ], [ 1 = enabled ]";
					Name="SnapAssist";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Set Snap option 'When I snap a window, automatically size it to fill available space' to [ 0 = disabled ], [ 1 = enabled ]";
					Name="SnapFill";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Multitasking - Task view (thumbnail grid layout & wallpaper dimming customization)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultitaskingView\AllUpView";
			Props=@(
				@{
					Description="Changes the transparency level of the background wallpaper behind current view. Set to [ 20 ] for a decent medium dimming effect, or [ 30 ] for a heavier dimming effect";
					Name="BackgroundDimmingLayer_percent";
					Type="DWord";
					Value=32;
					Delete=$False;
				},
				@{
					Description="Changes the transparency level of the main grid containing thumbnails. Set to [ 20 ] for a decent medium dimming effect, or [ 30 ] for a heavier dimming effect";
					Name="Grid_backgroundPercent";
					Type="DWord";
					Value=32;
					Delete=$False;
				},
				@{
					Description="Changes the hover color when you hover the mouse cursor over thumbnails. Set to [ HEX_COLOR_CODE ] to match your desired hover color, or [ 000000 ] for black";
					Name="Thumbnail_focus_border_color";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Setting to [ 1 = no program windows will be displayed, only the default desktop wallpaper will be displayed ], [ 0 = background program windows and icons will be displayed ]";
					Name="Wallpaper";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Multitasking - Alt+Tab view (thumbnail grid layout & wallpaper dimming customization)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultitaskingView\AltTabViewHost";
			Props=@(
				@{
					Description="Changes the transparency level of the background wallpaper behind current view. Set to [ 20 ] for a decent medium dimming effect, or [ 30 ] for a heavier dimming effect";
					Name="BackgroundDimmingLayer_percent";
					Type="DWord";
					Value=32;
					Delete=$False;
				},
				@{
					Description="Changes the transparency level of the main grid containing thumbnails. Set to [ 20 ] for a decent medium dimming effect, or [ 30 ] for a heavier dimming effect";
					Name="Grid_backgroundPercent";
					Type="DWord";
					Value=32;
					Delete=$False;
				},
				@{
					Description="Changes the hover color when you hover the mouse cursor over thumbnails. Set to [ HEX_COLOR_CODE ] to match your desired hover color, or [ 000000 ] for black";
					Name="Thumbnail_focus_border_color";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Setting to [ 1 = no program windows will be displayed, only the default desktop wallpaper will be displayed ], [ 0 = background program windows and icons will be displayed ]";
					Name="Wallpaper";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Multitasking - Snap Assist view (thumbnail grid layout & wallpaper dimming customization)
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MultitaskingView\SnapAssistView";
			Props=@(
				@{
					Description="Changes the transparency level of the background wallpaper behind current view. Set to [ 20 ] for a decent medium dimming effect, or [ 30 ] for a heavier dimming effect";
					Name="BackgroundDimmingLayer_percent";
					Type="DWord";
					Value=32;
					Delete=$False;
				},
				@{
					Description="Changes the transparency level of the main grid containing thumbnails. Set to [ 20 ] for a decent medium dimming effect, or [ 30 ] for a heavier dimming effect";
					Name="Grid_backgroundPercent";
					Type="DWord";
					Value=32;
					Delete=$False;
				},
				@{
					Description="Changes the hover color when you hover the mouse cursor over thumbnails. Set to [ HEX_COLOR_CODE ] to match your desired hover color, or [ 000000 ] for black";
					Name="Thumbnail_focus_border_color";
					Type="DWord";
					Value=0;
					Delete=$False;
				},
				@{
					Description="Setting to [ 1 = no program windows will be displayed, only the default desktop wallpaper will be displayed ], [ 0 = background program windows and icons will be displayed ]";
					Name="Wallpaper";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Multitasking - Timeline
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager";
			Props=@(
				@{
					Description="Set to [ 0 ] to Enable, [ 1 ] to Disable the Multitasking feature [ Timeline - Show suggestions in your timeline ]";
					Name="SubscribedContent-353698Enabled";
					Type="String";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Notification Area Icons
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer";
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


		# Office 2013 Settings - Excel
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Office\15.0\Common\General";
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


		# Office 2016 Settings - Excel
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Office\16.0\Common\General";
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
		# Office 2016 Settings - Outlook
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Office\16.0\Outlook\Options\Mail";
			Props=@(
				@{
					Description="Office 2016 Settings - Outlook - Set the limit for (or hide, disable) the 'Recent Items' when adding an attachment";
					Hotfix=$Null;
					Name="MaxAttachmentMenuItems";
					Type="DWord";
					Value=00000000;
					Delete=$False;
				}
			)
		};


		# Office (Windows 10 Application, ~2019+) Settings
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Classes\ms-officeapp\Shell\Open\Command";
			Props=@(
				@{
					Description="Microsoft Office (Windows 10 Application) - Disable the hotkey which automatically binds to [ Shift + Ctrl + Alt + Windows-Key ] upon installing office on a given device";
					Name="(Default)";
					Type="String";
					Value="rundll32";
					Delete=$False;
				}
			)
		};


		# Power Settings
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power";
			Props=@(
				@{
					Description="Power Settings - Set to [ 0 ] to Disable, [ 1 ] to Enable 'fast startup'.";
					Hotfix=$Null;
					Name="HiberbootEnabled";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Power\PowerSettings\238C9FA8-0AAD-41ED-83F4-97BE242C8F20\7bc4a2f9-d8fc-4469-b07b-33eb785aaca0";
			Props=@(
				@{
					Description="Power Settings - Set to [2] to Enable 'advanced power settings', [1] to Disable 'advanced power settings'.";
					Hotfix=$Null;
					Name="Attributes";
					Type="DWord";
					Value=2;
					Delete=$False;
				}
			)
		};


		# Prefetch
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters";
			Props=@(
				@{
					Description="Windows Prefetch Settings:  0=[Off], 1=[Application launch prefetching enabled], 2=[Boot prefetching enabled], 3=[Applaunch and Boot enabled (Optimal and Default)]";
					Name="EnablePrefetcher";
					Type="DWord";
					Value=("0");
					Delete=$False;
				}
			)
		};


		# Processor resource designations
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\PriorityControl";
			Props=@(
				@{
					Description="This default value specifies the priority to give to the application running in the foreground. 0=[Foreground and background applications equally responsive], 1=[Foreground application more responsive than background], 2=[Best foreground application response time]";
					Name="Win32PrioritySeparation";
					Type="DWord";
					Value=("0");
					Delete=$False;
				}
			)
		};


		# Shutdown/Restart Settings
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Desktop";
			Props=@(
				@{
					Description="Set to [ 0 ] to Enable, [ 1 ] to Disable the [ This App is Preventing Shutdown or Restart ] screen, which appears while attempting Shutdown/Restart the machine while certain inspecific applications are running - Remove this key/val to show this screen, instead";
					Name="AutoEndTasks";
					Type="String";
					Value=1;
					Delete=$False;
				}
			)
		};


		# Mouse - Cursor/Pointer Appearance
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Cursors";
			Props=@(
				@{
					Description="Set the mouse cursor's appearance - Can be any of [ Magnified, Windows Black (extra large), Windows Black (large), Windows Black, Windows Default (extra large), Windows Default (large), Windows Default, Windows Inverted (extra large), Windows Inverted (large), Windows Inverted, Windows Standard (extra large), Windows Standard (large), Blank (uses the pointer scheme '(None)') ]";
					Name="(Default)";
					Type="String";
					Value="Windows Black (extra large)";
					Delete=$False;
				}
			)
		};


		# Mouse - Set Sensitivity
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Mouse";
			Props=@(
				@{
					Description="Set the mouse sensitivity between a minimum of [ 1 ] and a maximum of [ 20 ] (affects DPI calculations for current mouse)";
					Name="MouseSensitivity";
					Type="String";
					Value=10;
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


		# Taskbar - Hide News & Interests
		$RegEdits += @{
			Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Feeds";
			Props=@(
				@{
					Description="News & Interests on Taskbar in Windows 10 (Show/Hide). Set to [ 0 ] for 'Show icon and text (Default)', set to [ 1 ] for 'Show icon only', set to [ 2 ] for 'Turn off'.";
					Name="ShellFeedsTaskbarViewMode";
					Type="DWord";
					Value=2;
					Delete=$False;
				}
			)
		};


		# Telemetry - Disable (as much as possible)  -  https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.DataCollection::AllowTelemetry
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows\DataCollection";
			Props=@(
				@{
					Description="Requires Windows 10 Enterprise Edition - Changes the level of diagnostic and usage (telemetry) data sent to Microsoft - 0=[Diagnostic data off], 1=[Send required diagnostic data], 2=[Send optional diagnostic data]",
					Name="AllowTelemetry";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Windows/Microsoft Defender - Don't allow Group Policy settings to block the usage of local exclusions list
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection";
			Props=@(
				@{
					Description="0=[DISABLED], 1=[ENABLED] - Configure local setting override for monitoring file and program activity on your computer. This policy setting configures a local override for the configuration of monitoring for file and program activity on your computer. This setting can only be set by Group Policy. If you ENABLE (1) this setting, the local preference setting will take priority over Group Policy. If you DISABLE (0) or do not configure this setting (DELETED), Group Policy will take priority over the local preference setting. Reference: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::RealtimeProtection_LocalSettingOverrideDisableOnAccessProtection";
					Name="LocalSettingOverrideDisableOnAccessProtection";
					Type="DWord";
					Value=1;
					Delete=$False;
				}
			)
		};
		$RegEdits += @{
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender";
			Props=@(
				@{
					Description="0=[ENABLED], 1=[DISABLED] - Configure local administrator merge behavior for lists. This policy setting controls whether or not complex list settings configured by a local administrator are merged with Group Policy settings. This setting applies to lists such as threats and Exclusions. If you ENABLE (0) or do not configure this setting, unique items defined in Group Policy and in preference settings configured by the local administrator will be merged into the resulting effective policy. In the case of conflicts, Group policy Settings will override preference settings. If you DISABLE (1) this setting, only items defined by Group Policy will be used in the resulting effective policy. Group Policy settings will override preference settings configured by the local administrator. Reference: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::DisableLocalAdminMerge";
					Name="DisableLocalAdminMerge";
					Type="DWord";
					Value=0;
					Delete=$False;
				}
			)
		};


		# Windows Update - Force-pull from Windows instead of local server
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
			Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Servicing";
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
					Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
				}
			)
		};


		# Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services!MaxCompressionLevel"; <# Example of Registry Path w/ inline Property name #>


		# ------------------------------------------------------------
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


		# $HKLM_Path="SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services";  # <-- https://getadmx.com/?Category=Windows_10_2016&Policy=Microsoft.Policies.TerminalServer::TS_SERVER_WDDM_GRAPHICS_DRIVER
		# $Name="fEnableWddmDriver";
		# $Type="DWord";
		# [UInt32]$Value = 0x00000000;
		# Write-Output "";
		# Write-Output "The following property sets the value to for Group Policy (gpedit.msc) titled 'Use WDDM graphics display driver for Remote Desktop Connections' to:  [ 0 (Disabled) - 'If you disable this policy setting, Remote Desktop Connections will NOT use WDDM graphics display driver. In this case, the Remote Desktop Connections will use XDDM graphics display driver.' ],  [ 1 (Enabled) - 'If you enable or do not configure this policy setting, Remote Desktop Connections will use WDDM graphics display driver.' ]";
		# Write-Output "`n";
		# Set-PolicyFileEntry -Path ("${Env:SystemRoot}\System32\GroupPolicy\Machine\Registry.pol") -Key ("${HKLM_Path}") -ValueName ("${Name}") -Data (${Value}) -Type ("${Type}");


		# ------------------------------------------------------------
		# Environment-specific registry settings
		#
		If ( $False ) {

			# VMware vSphere Client Cached-Connections
			$RegEdits += @{
				Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\VMware\VMware Infrastructure Client\Preferences";
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
				Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Policies\Microsoft\CloudFiles\BlockedApps\*";
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
				Write-Output "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n";
			}
		} Else {
			<# Script >> IS << running as Admin - Continue #>

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

					If ($GetEachItemProp -Eq $Null) {

						If (($EachProp.Delete) -Eq $False) {

							# Create the Property
							Write-Output "  |-->  !! Adding Property `"$($EachProp.Name)`" w/ type `"$($EachProp.Type)`" and value `"$($EachProp.Value)`"";
							New-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) | Out-Null;

						} Else {

							# Do nothing to the Property (already deleted)
							Write-Output "  |-->  Skipping Property `"$($EachProp.Name)`" (already deleted)";

						}

					} Else {  # Property exists

						If (($EachProp.Delete) -Eq $False) {  # Property should NOT be deleted

							$EachProp.LastValue = $GetEachItemProp;

							If (($EachProp.LastValue) -Eq ($EachProp.Value)) {

								# Do nothing to the Property (already exists with matching type & value)
								Write-Output "  |-->  Skipping Property `"$($EachProp.Name)`" (already up-to-date)";

							} Else {

								# Update the Property
								Write-Output "  |-->  !! Updating Property `"$($EachProp.Name)`" w/ type `"$($EachProp.Type)`" to have value `"$($EachProp.Value)`" instead of (previous) value `"$($EachProp.LastValue)`"";
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
								Write-Output "  |-->  !! Deleting Property `"$($EachProp.Name)`"";
								Remove-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -Confirm:$False | Out-Null;

							}

						}

					}

				}

			}

		}

	}

	Write-Output "`n`n  Press any key to exit...";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "SyncRegistry" -ErrorAction "SilentlyContinue";
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
#   answers.microsoft.com  |  "Automatic files - Automatic file downloads"  |  https://answers.microsoft.com/en-us/windows/forum/all/automatic-files/91b91138-0096-4fbc-a3e2-5de5176a6ca5
#
#   autohotkey.com  |  "Windows key (#) + letter keeps locking the pc (even if it is not #L)"  |  https://www.autohotkey.com/boards/viewtopic.php?p=46949&sid=490d0a443a7f78557b54c2bfb079350f#p46949
#
#   docs.microsoft.com  |  "[MS-GPPREF]: GlobalFolderOptions element | Microsoft Docs"  |  https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/3c837e92-016e-4148-86e5-b4f0381a757f
#
#   docs.microsoft.com  |  "[MS-GPPREF]: GlobalFolderOptionsVista element | Microsoft Docs"  |  https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/a6ca3a17-1971-4b22-bf3b-e1a5d5c50fca
#
#   docs.microsoft.com  |  "[MS-GPPREF]: StartMenu Inner Element | Microsoft Docs"  |  https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/adf64850-92a6-4131-ab31-906f9a419d2b
#
#   docs.microsoft.com  |  "[MS-GPPREF]: StartMenuVista Inner Element | Microsoft Docs"  |  https://docs.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/1d9120b4-aa9d-4ea8-89b7-cb64f79b83d5
#
#   docs.microsoft.com  |  "Adhering to System Policy Settings | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/desktop/policy/adhering-to-system-policy-settings
#
#   docs.microsoft.com  |  "Configure Windows Defender SmartScreen"  |  https://docs.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen
#
#   docs.microsoft.com  |  "Get-PSProvider - Gets information about the specified PowerShell provider"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psprovider
#
#   docs.microsoft.com  |  "Manage connections from Windows 10 and Windows 11 operating system components to Microsoft services - Windows Privacy | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services#1816-feedback--diagnostics
#
#   docs.microsoft.com  |  "Multimedia Class Scheduler Service - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service
#
#   docs.microsoft.com  |  "New-PSDrive - Creates temporary and persistent mapped network drives"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive
#
#   docs.microsoft.com  |  "Remove-ItemProperty - Deletes the property and its value from an item"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty
#
#   docs.microsoft.com  |  "Run and RunOnce Registry Keys - Windows applications | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/setupapi/run-and-runonce-registry-keys
#
#   docs.microsoft.com  |  "Set-ItemProperty - Creates or changes the value of a property of an item"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty
#
#   docs.microsoft.com  |  "Manage connections from Windows 10 operating system components to Microsoft services - Windows Privacy | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services
#
#   getadmx.com  |  "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"  |  https://getadmx.com/HKLM/SOFTWARE/Policies/Microsoft/Windows%20NT/Terminal%20Services
#
#   getadmx.com  |  "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"  |  https://getadmx.com/HKCU/Software/Microsoft/Windows/CurrentVersion/Policies/System
#
#   jonathanmedd.net  |  "Testing for the Presence of a Registry Key and Value"  |  https://www.jonathanmedd.net/2014/02/testing-for-the-presence-of-a-registry-key-and-value.html
#
#   social.msdn.microsoft.com  |  ".NET Framework 3.5 doesn't install. Windows 10.. Error code: 0x800F081F"  |  https://social.msdn.microsoft.com/Forums/en-US/4ea808e7-c503-4f99-9480-aa8e6938be3d
#
#   social.technet.microsoft.com  |  "GPO : runas hide show"  |  https://social.technet.microsoft.com/Forums/en-US/f2889321-7531-4fde-bb28-f5f141c251b6/gpo-runas-hide-show?forum=winserverDS
#
#   ss64.com  |  "Windows 10 registry - How-To: Windows 10 registry - user interface settings - Windows CMD - SS64.com"  |  https://ss64.com/nt/syntax-reghacks.html
#
#   stackoverflow.com  |  "New-Item recursive registry keys"  |  https://stackoverflow.com/a/21770519
#
#   stackoverflow.com  |  "Retrieve (Default) Value in Registry key"  |  https://stackoverflow.com/a/31711000
#
#   stackoverflow.com  |  "The IDynamicPropertyCmdletProvider interface is not implemented by this provider"  |  https://stackoverflow.com/a/54237993
#
#   superuser.com  |  "How do I disable specific windows 10/Office Keyboard Shortcut (CTRL+SHIFT+WIN+ALT+D) - Super User"  |  https://superuser.com/a/1484507
#
#   support.microsoft.com  |  "Guidance for configuring IPv6 in Windows for advanced users"  |  https://support.microsoft.com/en-us/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users
#
#   winaero.com  |  "How To Remove Pin to Quick Access Context Menu in Windows 10"  |  https://winaero.com/remove-pin-quick-access-menu-windows-10/
#
#   winaero.com  |  "Remove Include in Library Context Menu in Windows 10"  |  https://winaero.com/remove-include-library-windows-10/
#
#   winaero.com  |  "Remove OneDrive Context Menu in Windows 10"  |  https://winaero.com/remove-onedrive-context-menu-windows-10/
#
#   winaero.com  |  "Remove Restore Previous Versions Context Menu in Windows 10"  |  https://winaero.com/remove-previous-versions-windows-10/
#
#   winbuzzer.com  |  "Windows 10: How to Disable/Enable Prefetch and Superfetch - WinBuzzer"  |  https://winbuzzer.com/2020/03/14/windows-10-how-to-disable-enable-prefetch-and-superfetch-xcxwbt/
#
#   windows.tips.net  |  "Understanding Registry Value Data Types"  |  https://windows.tips.net/T013035_Understanding_Registry_Value_Data_Types.html
#
#   www.askvg.org  |  "[Windows 10 Tip] Registry Tweaks to Customize UI of Alt+Tab, Task View and Snap Assistant Screens – AskVG"  |  https://www.askvg.com/windows-10-tip-registry-tweaks-to-customize-ui-of-alttab-task-view-and-snap-assistant-screens/
#
#   www.ghacks.net  |  "Remove Windows 10 Context Menu bloat - gHacks Tech News"  |  https://www.ghacks.net/2017/07/09/remove-windows-10-context-menu-bloat/
#
#   www.howtogeek.com  |  "How to Make Windows 10’s Taskbar Clock Display Seconds"  |  https://www.howtogeek.com/325096/how-to-make-windows-10s-taskbar-clock-display-seconds/
#
#   www.howtogeek.com  |  "How to Remove the 'Send To' Menu from Windows' Context Menu"  |  https://www.howtogeek.com/howto/windows-vista/disable-the-send-to-folder-on-the-windows-explorer-context-menu/
#
#   www.microsoft.com  |  "Group Policy Settings Reference for Windows and Windows Server"  |  https://www.microsoft.com/en-us/download/confirmation.aspx?id=25250
#
#   www.reddit.com  |  "Dramatically increased FPS with this guide : RingOfElysium"  |  https://www.reddit.com/r/RingOfElysium/comments/aiwm2r/dramatically_increased_fps_with_this_guide/
#
#   www.tenforums.com  |  "Add or Remove Scan with Microsoft Defender Context Menu in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/18145-add-remove-scan-microsoft-defender-context-menu-windows-10-a.html
#
#   www.tenforums.com  |  "How to Enable or Disable Aero Shake in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/4417-how-enable-disable-aero-shake-windows-10-a.html
#
#   www.tenforums.com  |  "Turn On or Off Snap Windows in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/4343-turn-off-snap-windows-windows-10-a.html
#
#   www.thewindowsclub.net  |  "Enable or Disable News and Interests on Taskbar in Windows 10"  |  https://www.thewindowsclub.com/enable-or-disable-news-and-interests-on-taskbar
#
#   www.thewindowsclub.net  |  "Processor Scheduling in Windows 10 for better performance"  |  https://www.thewindowsclub.com/processor-scheduling-in-windows-7-8
#
#   www.windows-security.org  |  "Configure compression for RemoteFX data | Windows security encyclopedia"  |  https://www.windows-security.org/e1ff617ad228f804ca6ac298beee92a1/configure-compression-for-remotefx-data
#
#   www.winhelponline.com  |  "Change the Default Image Editor Linked to Edit command in Right-click Menu for Image Files"  |  https://www.winhelponline.com/blog/change-default-image-editor-edit-command-right-click-image/
#
# ------------------------------------------------------------