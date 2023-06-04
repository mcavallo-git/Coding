function SyncRegistry {
  Param(

    [Switch]$DisableClearType,  <# Disables 'ClearType' visual effect (to enable, do not pass this parameter #>

    [Switch]$EnableWindowsUpdateActiveHours,  <# Enables Windows Update's 'Active Hours' functionality (to disable, do not pass this parameter ) #>

    [ValidateSet('Ctrl+Shift','Left-Alt+Shift','Thai')]
    [String]$Hotkey_SwitchInputLanguage="",

    [Switch]$SkipPowercfgUpdates,  <# Skips powercfg updates which [ disable hibernation mode, disable sleep mode, and set the monitor idle timeout ] #>

    [String]$UserSID="",   <# Allow user to pass a user SID to modify locally (via HKEY_USERS/[SID]) <-- To acquire a user's SID, open a powershell terminal as that user & run the following command:   (((whoami /user /fo table /nh) -split ' ')[1])  #>

    [Switch]$Verbose

  )
  # ------------------------------------------------------------
  If ($False) { # RUN THIS SCRIPT:

    <# Run SyncRegistry - Update current user's context (HKEY_CURRENT_USER) #>
    PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProtoBak ([System.Net.ServicePointManager]::SecurityProtocol); [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; SV ProgressPreference SilentlyContinue; Clear-DnsClientCache; Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ((Write-Output https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/SyncRegistry/SyncRegistry.psm1)) ).Content) } Catch {}; If (-Not (Get-Command -Name (Write-Output SyncRegistry) -ErrorAction SilentlyContinue)) { Import-Module ([String]::Format((((GV HOME).Value)+(Write-Output \Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\SyncRegistry\SyncRegistry.psm1)), ((GV HOME).Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=((GV ProtoBak).Value); SyncRegistry;') -Verb RunAs -Wait -PassThru | Out-Null;";

    <# Run SyncRegistry - Update target user's context (HKEY_USERS\[SID]) #>
    $MODULE_ARGS="-UserSID $(((whoami /user /fo table /nh) -split ' ')[1];)"; PowerShell -Command "If (GCM pwsh -ErrorAction SilentlyContinue) { SV PS ((GCM pwsh).Source); } Else { SV PS ((GCM powershell).Source); }; Start-Process -Filepath ((GV PS).Value) -ArgumentList ('-Command SV ProtoBak ([System.Net.ServicePointManager]::SecurityProtocol); [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; SV ProgressPreference SilentlyContinue; Clear-DnsClientCache; Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ((Write-Output https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/SyncRegistry/SyncRegistry.psm1)) ).Content) } Catch {}; If (-Not (Get-Command -Name (Write-Output SyncRegistry) -ErrorAction SilentlyContinue)) { Import-Module ([String]::Format((((GV HOME).Value)+(Write-Output \Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\SyncRegistry\SyncRegistry.psm1)), ((GV HOME).Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=((GV ProtoBak).Value); SyncRegistry ${MODULE_ARGS};') -Verb RunAs -Wait -PassThru | Out-Null;";

    # Import-Module "${env:REPOS_DIR}\Coding\powershell\_WindowsPowerShell\Modules\SyncRegistry\SyncRegistry.psm1"; SyncRegistry -UserSID (((whoami /user /fo table /nh) -split ' ')[1]);

  }
  # ------------------------------------------------------------
  #
  # TODO:
  #
  #  - Themes > Desktop Icon Settings > Uncheck all "Desktop icons" options, including "Computer", "User's Files", "Network", "Recycle Bin", & "Control Panel"
  #
  #  - Themes > Desktop Icon Settings > Uncheck "Allow themes to change desktop icons"
  #
  #  - Change system sounds > Set "Sound Scheme" to "No Sounds"
  #
  #  - File Explorer Options > General > Uncheck "Show recently used files in Quick Access"
  #     |--> Key="HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"; Property="ShowRecent"; Type="DWord"; Value=0;
  #
  #  - File Explorer Options > General > Uncheck "Show frequently used folders in Quick Access"
  #     |--> Key="HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer"; Property="ShowFrequent"; Type="DWord"; Value=0;
  #
  # ------------------------------------------------------------

  $EXIT_CODE=0;

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
      $EXIT_CODE=1;
      Write-Output "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n";
    }
  } Else {
    <# Script >> IS << running as Admin - Continue #>

    <# Check if using HKEY_CURRENT_USERS or HKEY_USERS/[SID] #>
    $HKEY_USERS_SID_OR_CURRENT_USER="";
    If ("${UserSID}" -Eq "") {
      $HKEY_USERS_SID_OR_CURRENT_USER="HKEY_CURRENT_USER";
    } Else {
      If ((Test-Path -Path "Registry::HKEY_USERS\${UserSID}") -Eq $True) {
        # VALID UserSID
        $HKEY_USERS_SID_OR_CURRENT_USER="HKEY_USERS\${UserSID}";
      } Else {
        # INVALID UserSID
        $EXIT_CODE=1;
        $HKEY_USERS_SID_OR_CURRENT_USER="";
        Write-Output "`n`nError:  Invalid User SID - No registry key exists at:  `n          Registry::HKEY_USERS\${UserSID}";
        Write-Output "`n`nInfo:   To acquire a user's SID, open a powershell terminal as that user & run the following command:   (((whoami /user /fo table /nh) -split ' ')[1])";
        Write-Output "`n`n";
      }
    }

    If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Output "`n  Verbose:  HKEY_USERS_SID_OR_CURRENT_USER = [ ${HKEY_USERS_SID_OR_CURRENT_USER} ]"; };

    If ($EXIT_CODE -Eq 0) {

      # ------------------------------------------------------------
      # Define any Network Maps which will be required during the runtime
      #  (Registry Root-Keys are actually Network Maps to the "Registry" PSProvider)

      $PSDrives = @();
      $PSDrives += @{ Name=$Null ; PSProvider="Registry"; Root="HKEY_DYN_DATA";         };
      $PSDrives += @{ Name=$Null ; PSProvider="Registry"; Root="HKEY_PERFORMANCE_DATA"; };
      $PSDrives += @{ Name="HKCC"; PSProvider="Registry"; Root="HKEY_CURRENT_CONFIG";   };
      $PSDrives += @{ Name="HKCR"; PSProvider="Registry"; Root="HKEY_CLASSES_ROOT";     };
      $PSDrives += @{ Name="HKCU"; PSProvider="Registry"; Root="HKEY_CURRENT_USER";     };
      $PSDrives += @{ Name="HKLM"; PSProvider="Registry"; Root="HKEY_LOCAL_MACHINE";    };
      $PSDrives += @{ Name="HKU" ; PSProvider="Registry"; Root="HKEY_USERS";            };

      # ------------------------------------------------------------

      $RegEdits = @();

      # Appearance - Enable ClearType
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Desktop";
        Props=@(
          @{
            Description="ClearType - [ 0 ]=Disable, [ 2 ]=Enable ClearType (font smoothing)";
            Name="FontSmoothing";
            Type="String";
            Value=If ($PSBoundParameters.ContainsKey('DisableClearType')) { 0 <# Disabled #> } Else { 2 <# Enabled #> };
            Delete=$False;
          },
          @{
            Description="Font Smoothing - Set smoothing type to [ 0 ]='Font smoothing type could not be determined (Disable)', [ 1 ]='Standard font smoothing', [ 2 ]='ClearType font smoothing'";
            Name="FontSmoothingType";
            Type="DWord";
            Value=If ($PSBoundParameters.ContainsKey('DisableClearType')) { 0 <# Disabled #> } Else { 2 <# Enabled #> };
            Delete=$False;
          }
        )
      };

      # Cortana/Search Settings
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Search";
        Props=@(
          @{
            Description="Cortana/Search Settings - [ 0 ]=Disable, [ 1 ]=Enable Cortana.";
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
            Description="Cortana/Search Settings - [ 0 ]=Disable, [ 1 ]=Enable Cortana's ability to send search-resutls to Bing.com.";
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

      # Date and Time - Timestamp Formats ("Regional Settings")
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\International";
        Props=@(
          @{
            Description="Date and time formats - Long date";
            Name="sLongDate";
            Type="String";
            Value="dddd   dd MMMM, yyyy";
            Delete=$False;
          },
          @{
            Description="Date and time formats - Short date";
            Name="sShortDate";
            Type="String";
            Value="yyyy-MM-dd";
            Delete=$False;
          },
          @{
            Description="Date and time formats - Short time";
            Name="sShortTime";
            Type="String";
            Value="HH:mm";
            Delete=$False;
          },
          @{
            Description="Date and time formats - Long time";
            Name="sTimeFormat";
            Type="String";
            Value="HH:mm:ss";
            Delete=$False;
          },
          @{
            Description="Date and time formats - _____";
            Name="sYearMonth";
            Type="String";
            Value="MMMM yyyy";
            Delete=$False;
          }
        )
      };

      # Date and Time - NTP Synchronization Settings
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\W32Time\Parameters";
        Props=@(
          @{
            Description="Windows Time service tools and settings - 'Type' indicates which peers to accept synchronization from: [NoSync]=The time service does not synchronize with other sources. [NTP]=The time service synchronizes from the servers specified in the NtpServer (default value on stand-alone clients). registry entry. [NT5DS]=The time service synchronizes from the domain hierarchy (default value on domain members). [AllSync]=The time service uses all the available synchronization mechanisms. Citation=[https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings#windows-registry-reference]";
            Name="Type";
            Type="String";
            Value="NTP";
            Delete=$False;
          },
          @{
            Description="Windows Time service tools and settings - 'ServiceMain' is maintained by W32Time. It contains reserved data that is used by the Windows operating system, and any changes to this setting can cause unpredictable results. The default value on domain members is SvchostEntry_W32Time. The default value on stand-alone clients and servers is SvchostEntry_W32Time. Citation=[https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings]";
            Name="ServiceMain";
            Type="String";
            Value="SvchostEntry_W32Time";
            Delete=$False;
          }
        )
      };

      # Desktop/Explorer - Background (Wallpaper) Color
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

      # Desktop/Explorer - Accent Color (customization)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\DWM";
        Props=@(
          @{
            Description="Set the value for option 'Choose your accent color' found under [ Windows 10 Settings > Personalizaiton > Colors > 'Choose your accent color' ]";
            Name="AccentColor";
            Type="DWord";
            Val_Default="";
            Value=[uint32]"0xFFFF4D4D"; <# Hex to Decimal conversion #>
            Delete=$False;
          },
          @{
            Description="Explorer Settings - [ 0 ]=Disable, [ 1 ]=Enable option 'Show accent color on the following surfaces: Title bars'";
            Name="ColorPrevalence";
            Type="DWord";
            Val_Default="";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Aero Peek - [ 0 ]='Disable/Uncheck', [ 1 ]='Enable/Check' the 'Enable Peek' checkbox under windows' Performance Options (SystemPropertiesPerformance.exe). Also enables/disables Aero Peek [ while hovering over taskbar thumbnail live previews ] as well as [ when left-/right-clicking the desktop button at the end of the taskbar ].";
            Name="EnableAeroPeek";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };

      # Desktop/Explorer - Accent Color - Start, taskbar, and action center (customization)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize";
        Props=@(
          @{
            Description="Explorer Settings - [ 0 ]=Disable, [ 1 ]=Enable option 'Show accent color on the following surfaces: Start, taskbar, and action center'";
            Name="ColorPrevalence";
            Type="DWord";
            Val_Default="";
            Value=1;
            Delete=$False;
          }
        )
      };
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent";
        Props=@(
          @{
            Description="Set the value for option 'Choose your accent color' found under [ Windows 10 Settings > Personalizaiton > Colors > 'Choose your accent color' ]";
            Name="AccentColorMenu";
            Type="DWord";
            Val_Default="";
            Value=[uint32]"0xFFFF4D4D"; <# Hex to Decimal conversion #>
            Delete=$False;
          },
          @{
            Description="Set the value for option 'Choose your accent color' found under [ Windows 10 Settings > Personalizaiton > Colors > 'Choose your accent color' ]";
            Name="StartColorMenu";
            Type="DWord";
            Val_Default="";
            Value=[uint32]"0xFFFF3333"; <# Hex to Decimal conversion #>
            Delete=$False;
          }
        )
      };

      # Explorer Settings
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Policies\Microsoft\Windows\Explorer";
        Props=@(
          @{
            Description="Explorer Settings - [ 0 ]=Enable, [ 1 ]=Disable the 'Aero Shake' option in Windows 10 (Part 1/2)";
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
            Description="Explorer Settings - [ 1 ]=Disable, [ 0 ]=Enable the 'Aero Shake' option in Windows 10 (Part 2/2). If disabled, removes the option [ When I grab a window’s title bar and shake it, minimize all other windows ] from Windows Multitasking settings.";
            Name="DisallowShaking";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Aero Peek (while hovering over the bottom-right of screen) - [ 0 ]='Disable/Lock', [ 1 ]='Enable/Unlock' the Windows Taskbar setting 'Use Peek to preview the desktop when you move your mouse to the Show desktop button at the end of the taskbar'";
            Name="DisablePreviewDesktop";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Explorer option 'Hidden files and folders' - Set to [ 0 ]='Show hidden files, folders, and drives', [ 1 ]='Dont show hidden files, folders, or drives'";
            Name="Hidden";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Explorer option 'Hide empty drives' - Set to [ 0 ]='Disable (always show empty drives)', [ 1 ]='Enable (hide empty drives)'.";
            Name="HideDrivesWithNoMedia";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Explorer option 'Hide extensions for known file types' - Set to [ 0 ]='Disable (always show extensions)', [ 1 ]='Enable (hide extensions)'.";
            Name="HideFileExt";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Explorer option 'Hide folder merge conflicts' - Set to [ 0 ]='Disable (always show conflicts)', [ 1 ]='Enable (hide conflicts)'.";
            Name="HideMergeConflicts";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Taskbar Clock - [ 0 ]=Disable, [ 1 ]=Enable displaying of seconds on the system tray clock.";
            Name="ShowSecondsInSystemClock";
            Type="DWord";
            Value=1;
            Delete=$False;
          }
        )
      };

      # Explorer Settings - OneDrive shortcuts (left bar shortcuts)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{018D5C66-4533-4307-9B53-224DE2ED1FE6}";
        Props=@(
          @{
            Description="Explorer Settings - Set Delete=`$True to hide the OneDrive personal (default) cloud icon from the left bar on Windows Explorer - Set Delete=`$False to add said icon back to explorer";
            Name="(Default)";
            Type="String";
            Val_Default="OneDrive - Personal";
            Value="OneDrive - Personal";
            Delete=$False;
          }
        )
      };

      If ($False) {
        # Explorer Settings - OneDrive Enterprise (left bar shortcuts)
        $RegEdits += @{
          Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Desktop\NameSpace\{04271989-C4D2-69E8-C58E-500AB795E1FD}";
          Props=@(
            @{
              Description="Explorer Settings - Set Delete=`$True to hide the 'OneDrive Sharepoint' company-building icon from the left bar on Windows Explorer (shortcut to synced sharepoint directories) - Set Delete=`$False to add said icon back to explorer";
              Name="(Default)";
              Type="String";
              Val_Default="Organization Name";
              Value="Organization Name";
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
              Val_Default="OneDrive - Organization Name";
              Value="OneDrive - Organization Name";
              Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
            }
          )
        };
      }

      # Explorer Settings (cont.)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer";
        Props=@(
          @{
            Description="Explorer Settings - [ 1 ]='Disable/Hide', [ 0 ]='Enable/Show' the right-click context menu option 'Run as different user'";
            Name="HideRunAsVerb";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Microsoft Meet Now - [ 1 ]=Disable, [ 0 ]=Enable the 'Microsoft Meet Now' feature & taskbar icon. Meet Now is part of the Skype communication platform.";
            Name="HideSCAMeetNow";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Reading Pane - Set to [ 1 ]='set the Preview Pane as hidden in File Explorer (and lock/disable the user from enabling it)', [ 0 (or deleted) ]='set the Preview Pane as hidden in File Explorer (but allow the user to enable it)'";
            Name="NoReadingPane";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Windows Explorer - [ 0 (or deleted) ]=Disable, [ 1 ]=Enable setting 'Do not keep history of recently opened documents', e.g. 'Hide the most recently used files list'.";
            Name="NoRecentDocsHistory";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Explorer Settings - [ 0 ]=Disable, [ 1 ]=Enable setting 'Remove Recent Items menu from Start Menu'. When this policy is enabled, applications must not keep MRU lists (for example, in common dialog boxes).";
            Name="NoRecentDocsMenu";
            Type="DWord";
            Value=1;
            Delete=$False;
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer";
        Props=@(
          @{
            Description="Explorer Settings - [ 1 ]='Disable/Hide', [ 0 ]='Enable/Show' the right-click context menu option 'Run as different user'";
            Name="HideRunAsVerb";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Microsoft Meet Now - [ 1 ]=Disable, [ 0 ]=Enable the 'Microsoft Meet Now' feature & taskbar icon. Meet Now is part of the Skype communication platform.";
            Name="HideSCAMeetNow";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Windows Explorer - [ 0 (or deleted) ]=Disable, [ 1 ]=Enable setting 'Do not keep history of recently opened documents', e.g. 'Hide the most recently used files list'.";
            Name="NoRecentDocsHistory";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Explorer Settings - [ 0 ]=Disable, [ 1 ]=Enable setting 'Remove Recent Items menu from Start Menu'. When this policy is enabled, applications must not keep MRU lists (for example, in common dialog boxes).";
            Name="NoRecentDocsMenu";
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

      # Explorer Settings ('Edit' right-click context menu option(s)) (Image file extension (.bmp, .jpeg, .jpg, .png, ...))
      $DefaultPictureEditor="C:\Program Files\paint.net\PaintDotNet.exe";
      If ((Test-Path -Path "${DefaultPictureEditor}") -Eq $True) {
        $RegEdits += @{
          Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\image\shell\edit\command";
          Props=@(
            @{
              Description="Explorer Settings - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has an Image file extension (.bmp, .jpeg, .jpg, .png, ...), then selects the `"Edit`" command from the dropdown context menu.";
              Name="(Default)";
              Type="REG_EXPAND_SZ";
              Val_Default="`"%systemroot%\system32\mspaint.exe`" `"%1`"";
              Value="`"${DefaultPictureEditor}`" `"%1`"";
              Delete=$False;
            }
          )
        };
        $RegEdits += @{
          Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\image\shell\edit\command";
          Props=@(
            @{
              Description="Explorer Settings - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has an Image file extension (.bmp, .jpeg, .jpg, .png, ...), then selects the `"Edit`" command from the dropdown context menu.";
              Name="(Default)";
              Type="REG_EXPAND_SZ";
              Val_Default="`"%systemroot%\system32\mspaint.exe`" `"%1`"";
              Value="`"${DefaultPictureEditor}`" `"%1`"";
              Delete=$False;
            }
          )
        };
      }

      # Explorer Settings ('Edit' right-click context menu option(s)) (.ps1 file extension)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ps1\Shell\Edit";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"Command`") - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a `".ps1`" file extension, then selects the `"Edit`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe`" `"%1`"";
            Value="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Edit' right-click context menu option(s)) (.psd1 file extension)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.psd1\Shell\Edit";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"Command`") - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a `".psd1`" file extension, then selects the `"Edit`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe`" `"%1`"";
            Value="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Edit' right-click context menu option(s)) (.psm1 file extension)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.psm1\Shell\Edit";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"Command`") - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a `".psm1`" file extension, then selects the `"Edit`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\WindowsPowerShell\v1.0\powershell_ise.exe`" `"%1`"";
            Value="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Edit with Notepad++' right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\ANotepad++64";
        Props=@(
          @{
            Description="Explorer Settings - Defines the CLSID referenced when a user right-clicks a file (in Windows Explorer) then selects the `"Edit with Notepad++`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="{B298D29A-A6ED-11DE-BA8C-A68E55D89593}";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('GpgEX' right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\GpgEX";
        Props=@(
          @{
            Description="Explorer Settings - Defines the CLSID referenced when a user right-clicks a file (in Windows Explorer) then selects the `"GpgEX`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="{CCD955E4-5C16-4A33-AFDA-A8947A94946B}";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Include in library' right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\shellex\ContextMenuHandlers\Library Location";
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

      # Explorer Settings ('Microsoft Defender' right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\EPP";
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
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\CLSID\{09A47860-11B0-4DA5-AFA5-26D86198A780}";
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
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shellex\ContextMenuHandlers\EPP";
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
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Drive\shellex\ContextMenuHandlers\EPP";
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

      # Explorer Settings ('Open' right-click context menu option(s)) (PowerShell Script file extension (.ps1))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Microsoft.PowerShellScript.1\Shell\Open\Command";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"Command`") - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a PowerShell Script file extension (.ps1), then selects the `"Open`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Value="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Delete=$False;
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Microsoft.PowerShellScript.1\Shell\Open\Command";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"Command`") - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a PowerShell Script file extension (.ps1), then selects the `"Open`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Value="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Delete=$False;
          }
        )
      };

      # Explorer Settings ('Open' right-click context menu option(s)) (PowerShell Module file extension (.psd1, .psm1, ...))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Microsoft.PowerShellModule.1\Shell\Open\Command";
        Props=@(
          @{
            Description="Explorer Settings - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a PowerShell Module file extension (.psd1, .psm1, ...), then selects the `"Open`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Value="`"C:\Windows\System32\notepad.exe`" `"%1`"";
            Delete=$False;
          }
        )
      };

      # Explorer Settings ('Open With' right-click context menu option(s)) (Excel.exe)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\OpenWithList\Excel.exe";
        Props=@(
          @{
            Description="Explorer Settings - If this property is a blank string '', then add it to the 'Open With' default suggested applications - If this property is set to '(value not set)', then hide it from the 'Open With' default suggested applications";
            Name="(Default)";
            Type="String";
            Val_Default="`(value not set)";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Open With' right-click context menu option(s)) (IExplore.exe)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\OpenWithList\IExplore.exe";
        Props=@(
          @{
            Description="Explorer Settings - If this property is a blank string '', then add it to the 'Open With' default suggested applications - If this property is set to '(value not set)', then hide it from the 'Open With' default suggested applications";
            Name="(Default)";
            Type="String";
            Val_Default="`(value not set)";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Open With' right-click context menu option(s)) (MSPaint.exe)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\OpenWithList\MSPaint.exe";
        Props=@(
          @{
            Description="Explorer Settings - If this property is a blank string '', then add it to the 'Open With' default suggested applications - If this property is set to '(value not set)', then hide it from the 'Open With' default suggested applications";
            Name="(Default)";
            Type="String";
            Val_Default="";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Open With' right-click context menu option(s)) (notepad.exe)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\OpenWithList\notepad.exe";
        Props=@(
          @{
            Description="Explorer Settings - If this property is a blank string '', then add it to the 'Open With' default suggested applications - If this property is set to '(value not set)', then hide it from the 'Open With' default suggested applications";
            Name="(Default)";
            Type="String";
            Val_Default="";
            Value="";
            Delete=$False;
          }
        )
      };

      # Explorer Settings ('Open With' right-click context menu option(s)) (Winword.exe)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\OpenWithList\Winword.exe";
        Props=@(
          @{
            Description="Explorer Settings - If this property is a blank string '', then add it to the 'Open With' default suggested applications - If this property is set to '(value not set)', then hide it from the 'Open With' default suggested applications";
            Name="(Default)";
            Type="String";
            Val_Default="`(value not set)";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Open With' right-click context menu option(s)) (WordPad.exe)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\OpenWithList\WordPad.exe";
        Props=@(
          @{
            Description="Explorer Settings - If this property is a blank string '', then add it to the 'Open With' default suggested applications - If this property is set to '(value not set)', then hide it from the 'Open With' default suggested applications";
            Name="(Default)";
            Type="String";
            Val_Default="`(value not set)";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Open with Code' right-click context menu option(s)) (all file extensions)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Drive\shell\VSCode";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"command`") - Defines the application opened when a user right-clicks a file/directory (in Windows Explorer) then selects the `"Open with Code`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Program Files\Microsoft VS Code\Code.exe`" `"%1`"";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Directory\shell\VSCode";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"command`") - Defines the application opened when a user right-clicks a file/directory (in Windows Explorer) then selects the `"Open with Code`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Program Files\Microsoft VS Code\Code.exe`" `"%V`"";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shell\VSCode";
        Props=@(
          @{
            Description="Explorer Settings (subkey `"command`") - Defines the application opened when a user right-clicks a file/directory (in Windows Explorer) then selects the `"Open with Code`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Program Files\Microsoft VS Code\Code.exe`" `"%1`"";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Pin to Quick access' right-click context menu option(s))
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

      # Explorer Settings ('Run with PowerShell' right-click context menu option(s)) (.ps1 file extension)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ps1\Shell\0";
        Props=@(
          @{
            Description="Explorer Settings - Delete this key to hide the `"Run with PowerShell`" command from the dropdown context menu for files with the `".ps1`" file extension";
            Name="(Default)";
            Type="String";
            Val_Default="";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ps1\Shell\0";
        Props=@(
          @{
            Description="Explorer Settings - Defines the text shown on the right-click context menu for associated file type(s) - when this text is clicked (from the context menu) it will run CLI script contained in the nested `"Command`" registry key's `"(Default)`" property";
            Name="MUIVerb";
            Type="REG_EXPAND_SZ";
            Val_Default="@`"%systemroot%\system32\windowspowershell\v1.0\powershell.exe `",-108";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\SystemFileAssociations\.ps1\Shell\0\Command";
        Props=@(
          @{
            Description="Explorer Settings - Defines the application opened when a user right-clicks a file (in Windows Explorer) which has a `".ps1`" file extension, then selects the `"Run with PowerShell`" command from the dropdown context menu.";
            Name="(Default)";
            Type="String";
            Val_Default="`"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe`" `"-Command`" `"if((Get-ExecutionPolicy ) -ne 'AllSigned') { Set-ExecutionPolicy -Scope Process Bypass }; & '%1'`"";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Explorer Settings ('Send to' right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo";
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

      # Explorer Settings ('Share' right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes\*\shellex\ContextMenuHandlers\ModernSharing";
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

      # Explorer Settings (Blocked right-click context menu option(s))
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked";
        Props=@(
          @{
            Description="Explorer Settings - If this property exists: [ hide 'Cast to Device' context menu option(s) in Windows Explorer's right-click dropdown menu ] - If property is deleted: [ show aforementioned context menu option(s) ]";
            Name="{7AD84985-87B4-4a16-BE58-8B72A5B390F7}";
            Type="String";
            Val_Default="";
            Value="Play to menu";
            Delete=$False;
          },
          @{
            Description="Explorer Settings - If this property exists: [ hide 'Give access to' context menu option(s) in Windows Explorer's right-click dropdown menu ] - If property is deleted: [ show aforementioned context menu option(s) ]";
            Name="{F81E9010-6EA4-11CE-A7FF-00AA003CA9F6}";
            Type="String";
            Val_Default="";
            Value="Play to menu";
            Delete=$False;
          },
          @{
            Description="Explorer Settings - If this property exists: [ hide 'Move to OneDrive' context menu option(s) in Windows Explorer's right-click dropdown menu ] - If property is deleted: [ show aforementioned context menu option(s) ]";
            Name="{CB3D0F55-BC2C-4C1A-85ED-23ED75B5106B}";
            Type="String";
            Val_Default="";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="Explorer Settings - If this property exists: [ hide 'Restore previous versions' context menu option(s) in Windows Explorer's right-click dropdown menu ] - If property is deleted: [ show aforementioned context menu option(s) ]";
            Name="{596AB062-B4D2-4215-9F74-E9109B0A8153}";
            Type="String";
            Val_Default="";
            Value="";
            Delete=$False;
          },
          @{
            Description="Explorer Settings - If this property exists: [ hide 'Troubleshoot compatibility' context menu option(s) in Windows Explorer's right-click dropdown menu ] - If property is deleted: [ show aforementioned context menu option(s) ]";
            Name="{1D27F844-3A1F-4410-85AC-14651078412D}";
            Type="String";
            Val_Default="";
            Value="";
            Delete=$False;
          }
        )
      };

      # Hotkey - Language Switching
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Keyboard Layout\Toggle";
        Props=@(
          @{
            Description="Determines whether a key sequence can be used to shift between input locales";
            Name="Hotkey";
            Type="DWord";
            Value=If ("${Hotkey_SwitchInputLanguage}" -Eq "Ctrl+Shift") { 2 } ElseIf ("${Hotkey_SwitchInputLanguage}" -Eq "Left-Alt+Shift") { 1 } ElseIf ("${Hotkey_SwitchInputLanguage}" -Eq "Thai") { 4 } Else { 3 <# Disabled #> };
            Delete=$False;
          }
        )
      };

      # IPv6
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip6\Parameters";
        Props=@(
          @{
            Description="IPv6 Network Settings - Set IP preference to: [ 32 ]='Prefer IPv4 over IPv6', [ 255 ]='Disable IPv6', [ 16 ]='Disable IPv6 on all nontunnel interfaces', [ 1 ]='Disable IPv6 on all tunnel interfaces', [ 17 ]='Disable IPv6 on all nontunnel interfaces (except the loopback) and on IPv6 tunnel interface'";
            Name="DisabledComponents";
            Type="DWord";
            Value=("255");
            Delete=$False;
          }
        )
      };

      # Keyboard - Filter Keys (Enable/Disable)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Accessibility\Keyboard Response";
        Props=@(
          @{
            Description="Keyboard Settings - [ 126 ]=Enable, [ 122 ]=Disable option [ Allow the shortcut key to start Filter Keys - Press and hold the right Shift key for eight seconds to turn on Filter Keys ].";
            Name="Flags";
            Type="String";
            Value="122";
            Delete=$False;
          }
        )
      };

      # Keyboard - Sticky Keys (Enable/Disable)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Accessibility\StickyKeys";
        Props=@(
          @{
            Description="Keyboard Settings - [ 510 ]=Enable, [ 506 ]=Disable option [ Allow the shortcut key to start Sticky Keys - Press the Shift key five times to turn Sticky Keys on or off ].";
            Name="Flags";
            Type="String";
            Value="506";
            Delete=$False;
          }
        )
      };

      # Keyboard - Toggle Keys (Enable/Disable)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Accessibility\ToggleKeys";
        Props=@(
          @{
            Description="Keyboard Settings - [ 62 ]=Enable, [ 58 ]=Disable option [ Allow the shortcut key to start Toggle Keys Press and hold the Num Lock key for five seconds to turn on Toggle Keys ].";
            Name="Flags";
            Type="String";
            Value="_____";
            Delete=$False;
          }
        )
      };

      # Lock Workstation (Enable/Disable)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System";
        Props=@(
          @{
            Description="Lock Workstation - [ 0 ]=Disable, [ 1 ]=Enable the setting 'Remove Lock Computer'. If you enable this policy setting, users cannot lock the computer from the keyboard using WinKey+L or Ctrl+Alt+Del. If you disable or do not configure this policy setting, users will be able to lock the computer from the keyboard using WinKey+L or Ctrl+Alt+Del.";
            Name="DisableLockWorkstation";
            Type="DWord";
            Value=0;
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
            Description="Multitasking - [ 0 ]=Disable, [ 1 ]=Enable the 'Snap windows' Multitasking feature";
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
            Description="Alt + Tab - Set 'Pressing Alt + Tab shows' to: [ 0 ]='Open windows and all tabs in Edge', [ 1 ]='Open windows and 5 most recent tabs in Edge', [ 2 ]='Open windows and 3 most recent tabs in Edge' or [ 3 ]='Open windows only'.";
            Name="MultiTaskingAltTabFilter";
            Type="DWord";
            Value=3;
            Delete=$False;
          },
          @{
            Description="Snap windows - [ 0 ]=Disable, [ 1 ]=Enable option 'When I resize a snapped window, simultaneously resize any adjacent snapped window'";
            Name="JointResize";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Snap windows - [ 0 ]=Disable, [ 1 ]=Enable option 'When I snap a window, show what I can snap next to it'";
            Name="SnapAssist";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Snap windows - [ 0 ]=Disable, [ 1 ]=Enable option 'When I snap a window, automatically size it to fill available space'";
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
            Description="Background Wallpaper Transparency (during animation) - Set to [ 32 (or 0x20) ]='decent medium dimming effect', [ 48 (or 0x30) ]='heavier dimming effect'.";
            Name="BackgroundDimmingLayer_percent";
            Type="DWord";
            Value=32;
            Delete=$False;
          },
          @{
            Description="Opaque Background between Grid and Wallpaper (during animation) - Set to [ 32 (or 0x20) ]='decent medium dimming effect', [ 48 (or 0x30) ]='heavier dimming effect'.";
            Name="Grid_backgroundPercent";
            Type="DWord";
            Value=32;
            Delete=$False;
          },
          @{
            Description="Mouse Hover Color (over Thumbnails) - Set to [ HEX_COLOR_CODE ]='set mouse hover color to your custom HEX_COLOR_CODE hex color', [ 000000 ]='set mouse hover color to black'.";
            Name="Thumbnail_focus_border_color";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Displayed element(s) (during animation) - Set to [ 1 ]='no program windows will be displayed, only the default desktop wallpaper will be displayed', [ 0 ]='background program windows and icons will be displayed'.";
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
            Description="Background Wallpaper Transparency (during animation) - Set to [ 32 (or 0x20) ]='decent medium dimming effect', [ 48 (or 0x30) ]='heavier dimming effect'.";
            Name="BackgroundDimmingLayer_percent";
            Type="DWord";
            Value=32;
            Delete=$False;
          },
          @{
            Description="Opaque Background between Grid and Wallpaper (during animation) - Set to [ 32 (or 0x20) ]='decent medium dimming effect', [ 48 (or 0x30) ]='heavier dimming effect'.";
            Name="Grid_backgroundPercent";
            Type="DWord";
            Value=32;
            Delete=$False;
          },
          @{
            Description="Mouse Hover Color (over Thumbnails) - Set to [ HEX_COLOR_CODE ]='set mouse hover color to your custom HEX_COLOR_CODE hex color', [ 000000 ]='set mouse hover color to black'.";
            Name="Thumbnail_focus_border_color";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Displayed element(s) (during animation) - Set to [ 1 ]='no program windows will be displayed, only the default desktop wallpaper will be displayed', [ 0 ]='background program windows and icons will be displayed'.";
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
            Description="Background Wallpaper Transparency (during animation) - Set to [ 32 (or 0x20) ]='decent medium dimming effect', [ 48 (or 0x30) ]='heavier dimming effect'.";
            Name="BackgroundDimmingLayer_percent";
            Type="DWord";
            Value=32;
            Delete=$False;
          },
          @{
            Description="Opaque Background between Grid and Wallpaper (during animation) - Set to [ 32 (or 0x20) ]='decent medium dimming effect', [ 48 (or 0x30) ]='heavier dimming effect'.";
            Name="Grid_backgroundPercent";
            Type="DWord";
            Value=32;
            Delete=$False;
          },
          @{
            Description="Mouse Hover Color (over Thumbnails) - Set to [ HEX_COLOR_CODE ]='set mouse hover color to your custom HEX_COLOR_CODE hex color', [ 000000 ]='set mouse hover color to black'.";
            Name="Thumbnail_focus_border_color";
            Type="DWord";
            Value=0;
            Delete=$False;
          },
          @{
            Description="Displayed element(s) (during animation) - Set to [ 1 ]='no program windows will be displayed, only the default desktop wallpaper will be displayed', [ 0 ]='background program windows and icons will be displayed'.";
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
            Description="Multitasking - [ 1 ]=Disable, [ 0 ]=Enable feature 'Show suggestions in your timeline'";
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
            Description="Notification Area - [ 1 ]=Disable, [ 0 ]=Enable option 'Always show all icons in the notification area' (located under 'Windows Settings' -> 'Personalization' -> 'Taskbar' -> 'Select which icons appear on the taskbar'). Note that if this key/property is not set, the default value (defined under HKLM) will be used, instead.";
            Hotfix=$Null;
            Name="EnableAutoTray";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };

      # Office 2013 Settings
      $Office_2013_Key="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Office\15.0";
      If ((Test-Path -Path ("${Office_2013_Key}")) -Eq $True) {
        $RegEdits += @{
          Path="${Office_2013_Key}\Common\General";
          Props=@(
            @{
              Description="Office 2013 Clipboard - [ 2147483648 ]=Disable the Microsoft Office Clipboard entirely. Citation=[https://stackoverflow.com/a/53070256]";
              Hotfix=$Null;
              Name="AcbControl";
              Type="DWord";
              Value=2147483648;
              Delete=$False;
            }
          )
        };
      };

      # Office 2016/2019 Settings
      $Office_2016_2019_Key="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Office\16.0";
      If ((Test-Path -Path ("${Office_2016_2019_Key}")) -Eq $True) {
        $RegEdits += @{
          Path="${Office_2016_2019_Key}\Common";
          Props=@(
            @{
              Description="Office 2016/2019 Telemetry - [ 0 ]=Disable, [ 1 ]=Enable the Customer Experience Improvement Program (CEIP). Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_EnableCustomerExperienceImprovementProgram]";
              Hotfix=$Null;
              Name="QMEnable";
              Type="DWord";
              Value=0;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 LinkedIn - [ 0 ]=Disable, [ 1 ]=Enable LinkedIn features in Office applications. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_AllowLinkedInFeatures]";
              Hotfix=$Null;
              Name="LinkedIn";
              Type="DWord";
              Value=0;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 Telemetry - [ 0 ]=Disable, [ 1 ]=Enable the sending of personal information to Office. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_Sendcustomerdata]";
              Hotfix=$Null;
              Name="SendCustomerData";
              Type="DWord";
              Value=0;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 Theme - Set Office Theme to: [0]=Colorful, [3]=Dark Gray, [4]=Black, [5]=White, [6]=Use system settings. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_DefaultUIThemeUser]";
              Hotfix=$Null;
              Name="UI Theme";
              Type="DWord";
              Value=6;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 Telemetry - [ 0 ]=Disable, [ 1 ]=Enable Microsoft Office Diagnostics. Office Diagnostics enables Microsoft to diagnose system problems by periodically downloading a small file to the computer. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_UpdateReliabilityPolicy]";
              Hotfix=$Null;
              Name="UpdateReliabilityData";
              Type="DWord";
              Value=0;
              Delete=$False;
            }
          )
        };
        $RegEdits += @{
          Path="${Office_2016_2019_Key}\Common\General";
          Props=@(
            @{
              Description="Office 2016/2019 Clipboard - [ 2147483648 ]='Disable the Microsoft Office Clipboard entirely'. [1]=Prevents the Office Clipboard from automatically appearing when multiple Copy commands are performed in any of the Office programs. [0]=Permits the Office Clipboard to appear automatically when multiple Copy commands are performed in Office programs. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_DisableClipboardToolbartriggers , https://stackoverflow.com/a/53070256]";
              Hotfix=$Null;
              Name="AcbControl";
              Type="DWord";
              Value=2147483648;
              Delete=$False;
            }
            @{
              Description="Office 2016/2019 Start Screen - [ 1 ]='Disable the Start Screen in all Office 2016/2019 applications', [ 0 ]='Enable the Start Screen in all Office 2016/2019 applications'. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_DisableOfficeStartGlobal]";
              Hotfix=$Null;
              Name="DisableBootToOfficeStart";
              Type="DWord";
              Value=1;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 First-Run (Backend Flag) - Sets a flag for whether Office has been opened at least once: [1]=True (has been opened at least once), [0]=False (has not been opened at least once)";
              Hotfix=$Null;
              Name="FirstRun";
              Type="DWord";
              Value=0;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 [File-]Save Options - [ 1 ]=Disable, [ 0 ]=Enable option [ Save to Computer by default (located under Options > Save (left tab)) ].";
              Hotfix=$Null;
              Name="PreferCloudSaveLocations";
              Type="DWord";
              Value=0;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 Opt-in Wizard - [ 0 ]=Disable, [ 1 ]=Enable, [2]=(Assume yes to) the Opt-in Wizard the first time a Microsoft Office 2016 application is ran. Citation=[https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_DisableOptinWizard]";
              Hotfix=$Null;
              Name="ShownFirstRunOptin";
              Type="DWord";
              Value=2;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 [File-]Save Options - [ 0 ]=Disable, [ 1 ]=Enable option [ Don't show the Backstage when opening or saving files with keyboard shortcuts (located under Options > Save (left tab)) ].";
              Hotfix=$Null;
              Name="SkipOpenAndSaveAsPlace";
              Type="DWord";
              Value=1;
              Delete=$False;
            },
            @{
              Description="Office 2016/2019 [File-]Save Options - [ 0 ]=Disable, [ 1 ]=Enable option [ Show additional places for saving, even if sign-in may be required (located under Options > Save (left tab)) ].";
              Hotfix=$Null;
              Name="SkyDriveSignInOption";
              Type="DWord";
              Value=0;
              Delete=$False;
            }
          )
        };
        $RegEdits += @{
          Path="${Office_2016_2019_Key}\Outlook\Options\Mail";
          Props=@(
            @{
              Description="Outlook 2016/2019 - Set the limit for (or hide, disable) the 'Recent Items' when adding an attachment";
              Hotfix=$Null;
              Name="MaxAttachmentMenuItems";
              Type="DWord";
              Value=00000000;
              Delete=$False;
            }
          )
        };
      };

      # Office 365 App (~2019+) Settings - Note: Hotkey still applies regardless if app is installed or not
      $Office_365_App_Key="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Classes\ms-officeapp";
      $RegEdits += @{
        Path="${Office_365_App_Key}\Shell\Open\Command";
        Props=@(
          @{
            Description="Office 365 Hotkey - Disable the hotkey which automatically binds to [ Shift + Ctrl + Alt + Windows-Key ] upon installing office on a given device";
            Name="(Default)";
            Type="String";
            Value="rundll32";
            Delete=$False;
          }
        )
      };

      # Windows To Go
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control";
        Props=@(
          @{
            Description="Windows To Go - Enable (1) or Disable (0)";
            Name="PortableOperatingSystem";
            Type="DWord";
            Value=("0");
            Delete=$False;
          }
        )
      };

      # Power Settings
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Power";
        Props=@(
          @{
            Description="Power Settings - [ 0 ]=Disable, [ 1 ]=Enable power option 'Turn on fast start-up'. If disabled, option will be grayed out (deactivated) on the Power Options Control Panel page.";
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
            Description="Power Settings - [ 1 ]=Disable, [ 2 ]=Enable 'advanced power settings'.";
            Hotfix=$Null;
            Name="Attributes";
            Type="DWord";
            Value=2;
            Delete=$False;
          }
        )
      };

      # Power - Shut down/Restart Settings
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\Control Panel\Desktop";
        Props=@(
          @{
            Description="Shut down/Restart Settings - [ 1 ]=Disable, [ 0 ]=Enable the blocker popup 'This App is Preventing Shutdown or Restart' screen when attempting to Shut down or Restart Windows. If the entire key & property are deleted, the option will be Enabled, and will hang while attempting to display apps preventing Windows Shut down/Restart.";
            Name="AutoEndTasks";
            Type="String";
            Value=1;
            Delete=$False;
          }
        )
      };

      # Prefetch
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\PrefetchParameters";
        Props=@(
          @{
            Description="Windows Prefetch Settings: [ 0 ]='Off', [ 1 ]='Application launch prefetching enabled', [ 2 ]='Boot prefetching enabled', [ 3 ]='Applaunch and Boot enabled (Optimal and Default)']";
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

      # SmartScreen for Microsoft Edge, Microsoft Store Apps
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\System";
        Props=@(
          @{
            Description="SmartScreen - Set to [ 0 ]='Turned off. Do not protect users from potential threats and prevent users from turning it on.', [ 1 ]='Turned on. Protect users from potential threats and prevent users from turning it off.', or [ 2 ]='Turned on. Require approval from an administrator before running downloaded unknown software.' ( from https://learn.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen )";
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
            Description="PhishingFilter - Set to [ 0 ]='allow users to bypass (ignore) the Windows Defender SmartScreen warnings about potentially malicious files', [ 1 ]='prevent users from bypassing the warnings, blocking them from downloading of the unverified file(s)' (from https://learn.microsoft.com/en-us/microsoft-edge/deploy/available-policies#prevent-bypassing-windows-defender-smartscreen-prompts-for-files )";
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
            Description="By default, Microsoft Edge allows users to bypass (ignore) the Windows Defender SmartScreen warnings about potentially malicious sites, allowing them to continue to the site. With this policy though, you can configure Microsoft Edge to prevent users from bypassing the warnings, blocking them from continuing to the site (from https://learn.microsoft.com/en-us/microsoft-edge/deploy/available-policies#prevent-bypassing-windows-defender-smartscreen-prompts-for-sites )";
            Name="PreventOverride";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };

      # Splashtop - Configure Streamer (32-bit)
      $Splashtop32_Key = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Splashtop Inc.\Splashtop Remote Server";
      If ((Test-Path -Path ("${Splashtop32_Key}")) -Eq $True) {
        $RegEdits += @{
          Path="${Splashtop32_Key}";
          Props=@(
            @{
              Description="For virtual display to work, you must also run [ C:\Program Files (x86)\Splashtop\Splashtop Remote\Server\Driver\LciDisplay\install_driver.bat ]. Virtual driver for headless machines/laptops with lid closed (64-bit). Adds a 3rd monitor upon connections from remote clients to ensure there's always a monitor to be used remotely instead of just a black screen. [ 0 ]=Off, [ 1 ]=On.";
              Name="VirtualDisplay";
              Type="DWord";
              Value=1;
              Delete=$False;
            }
          )
        };
      };
      # Splashtop - Configure Streamer (64-bit)
      $Splashtop64_Key = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Splashtop Inc.\Splashtop Remote Server";
      If ((Test-Path -Path ("${Splashtop64_Key}")) -Eq $True) {
        $RegEdits += @{
          Path="${Splashtop64_Key}";
          Props=@(
            @{
              Description="For virtual display to work, you must also run [ C:\Program Files (x86)\Splashtop\Splashtop Remote\Server\Driver\LciDisplay\install_driver64.bat ]. Virtual driver for headless machines/laptops with lid closed (64-bit). Adds a 3rd monitor upon connections from remote clients to ensure there's always a monitor to be used remotely instead of just a black screen. [ 0 ]=Off, [ 1 ]=On.";
              Name="VirtualDisplay";
              Type="DWord";
              Value=1;
              Delete=$False;
            }
          )
        };
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
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection";
        Props=@(
          @{
            Description="Requires Windows 10 Enterprise Edition - Changes the level of diagnostic and usage (telemetry) data sent to Microsoft - 0=[Diagnostic data off], 1=[Send required diagnostic data], 2=[Send optional diagnostic data]";
            Name="AllowTelemetry";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };

      # Microsoft Windows Defender - Don't allow Group Policy settings to block the usage of local exclusions list
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender";
        Props=@(
          @{
            Description="Windows Defender - [ 1 ]=Disable, [ 0 ]=Enable the local administrator merge behavior for lists. This policy setting controls whether or not complex list settings configured by a local administrator are merged with Group Policy settings. This setting applies to lists such as threats and Exclusions. If you ENABLE (0) or do not configure this setting, unique items defined in Group Policy and in preference settings configured by the local administrator will be merged into the resulting effective policy. In the case of conflicts, Group policy Settings will override preference settings. If you DISABLE (1) this setting, only items defined by Group Policy will be used in the resulting effective policy. Group Policy settings will override preference settings configured by the local administrator. Reference: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::DisableLocalAdminMerge";
            Name="DisableLocalAdminMerge";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection";
        Props=@(
          @{
            Description="[ 0 ]=Disable, [ 1 ]=Enable Configure local setting override for monitoring file and program activity on your computer. This policy setting configures a local override for the configuration of monitoring for file and program activity on your computer. This setting can only be set by Group Policy. If you ENABLE (1) this setting, the local preference setting will take priority over Group Policy. If you DISABLE (0) or do not configure this setting (DELETED), Group Policy will take priority over the local preference setting. Reference: https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::RealtimeProtection_LocalSettingOverrideDisableOnAccessProtection";
            Name="LocalSettingOverrideDisableOnAccessProtection";
            Type="DWord";
            Value=1;
            Delete=$False;
          }
        )
      };

      # Microsoft MAPS (Enabled/Disabled)
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet";
        Props=@(
          @{
            Description="Microsoft MAPS - [ 0 ]='Disable MAPS', [ 1 ]='Basic MAPS', [ 2 ]='Advanced MAPS' - If you disable or do not configure this setting, you will not join Microsoft Active Protection Service (MAPS). - If you enable this setting, you will join Microsoft Active Protection Service (MAPS) with the membership specified. - Microsoft MAPS is the online community that helps you choose how to respond to potential threats. The community also helps stop the spread of new malicious software infections. You can choose to send basic or additional information about detected software. Additional information helps Microsoft create new security intelligence and help it to protect your computer. This information can include things like location of detected items on your computer if harmful software was removed. The information will be automatically collected and sent. In some instances, personal information might unintentionally be sent to Microsoft. However, Microsoft will not use this information to identify you or contact you. - https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::SpynetReporting";
            Name="SpynetReporting";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };

      # Microsoft MAPS - Sample Submission Settings
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender\Spynet";
        Props=@(
          @{
            Description="Microsoft MAPS telemetry - Set sample submission behaviour (when opt-in for Set MAPS telemetry is set) to [ 0 ]='Automatic sample submission disabled. End-users will always be prompted for samples (default)', [ 1 ]='Most samples will be sent automatically. Files that are likely to contain personal information will still prompt and require additional confirmation', [ 2 ]='All sample submission disabled. Samples will never be sent and end-users will never be prompted', [ 3 ]='All samples will be sent automatically. All files determined to require further analysis will be sent automatically without prompting'. This setting also sets Defender option 'Send file samples when further analysis is required'. - https://admx.help/?Category=Windows_10_2016&Policy=Microsoft.Policies.WindowsDefender::SubmitSamplesConsent";
            Name="SubmitSamplesConsent ";
            Type="DWord";
            Value=2;
            Delete=$False;
          }
        )
      };

      # Screen Saver Settings (Desktop & Logon Screen)
      @(
        "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop",  # Screen Saver Settings @ Desktop (All Users)
        "Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Policies\Microsoft\Windows\Control Panel\Desktop",  # Screen Saver Settings @ Desktop (Current User)
        "Registry::HKEY_USERS\.DEFAULT\Control Panel\Desktop"  # Screen Saver Settings @ Logon Screen
      ) | ForEach-Object {
        $RegEdits += @{
          Path="${_}";
          Props=@(
            @{
              Description="Password protect the screen saver - [ 0 ]=Disable, [ 1 ]=Enable screen saver password protection. Sets option 'On resume, display logon screen' under Screen Saver Settings in the Control Panel. If disabled, password protection cannot be set on any screen saver. If defined, prevents users from changing screen saver password protection setting (grays out aforementioned checkbox). Citation=[https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_ScreenSaverIsSecure]";
              Name="ScreenSaverIsSecure";
              Type="String";
              Value=1;
              Delete=$False;
            },
            @{
              Description="Screen saver timeout (in seconds) - [ 0 (or deleted) ]=Disable, [ 0-599940 ]=Enable & use value as the idle timeout seconds to run the screen saver after - can be set from a minimum of 1 second to a maximum of 86400 seconds (or 24 hours). [ 0 ]=Disable the screen saver. This setting has no effect under any of the following circumstances: If [ the setting is disabled or not configured ], if [ The wait time is set to zero ], if [ the 'Enable Screen Saver' setting is disabled ] or if [ Neither the 'Screen saver executable name' setting nor the Screen Saver dialog of the client computer's Personalization or Display Control Panel specifies a valid existing screen saver program on the client ]. When not configured, whatever wait time is set on the client through the Screen Saver dialog in the Personalization or Display Control Panel is used. The default is 15 minutes. Citation=[https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_ScreenSaverTimeOut]";
              Name="ScreenSaveTimeOut";
              Type="String";
              Value=1200;
              Delete=$False;
            },
            @{
              Description="Enable screen saver - [ 0 ]=Disable [ 1 ]=Enable the screen saver. If enabled, two conditions must also be met before a screen saver will run: First, a valid screen saver on the client is specified through the 'Screen Saver executable name' setting or through Control Panel on the client computer. Second, the screen saver timeout is set to a nonzero value through the setting or Control Panel. If disabled, this setting will also disable the Screen Saver section of the Screen Saver dialog in the Personalization or Display Control Panel. As a result, users cannot change the screen saver options. [Empty/Deleted]=Unconfigured, e.g. this setting has no effect on the system. Also, see the 'Prevent changing Screen Saver' setting. Citation=[https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_EnableScreenSaver]";
              Name="ScreenSaveActive";
              Type="String";
              Value=1;
              Delete=$False;
            },
            @{
              Description="Screen Saver executable name - [  Empty, Deleted,  Invalid Filepath, or invalid/uninstalled .scr ]=Disable, [ Valid .scr File ]=Enable setting 'Force specific screen saver'. If Enabled, setting must be a filepath to a '.scr' screen saver file to use as the screen saver at user desktops. Can either be the basename of an '.scr' typed file located directly within the '%Systemroot%\System32' directory, or a fully qualified path to a '.scr' file. [EMPTY/FILE-NOT-FOUND/UNSET]=Disabled, e.g. Users can select any screen saver - If the specified screen saver is not installed on a computer to which this setting applies, it is equivalent to this setting being disabled. [Notes]=This setting disables the drop-down list of screen savers in the Screen Saver dialog in the Personalization or Display Control Panel, which prevents users from changing the screen saver. The file 'scrnsave.scr' refers to the 'Blank' screen saver option. Citation=[https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_SetScreenSaver]";
              Name="SCRNSAVE.EXE";
              Type="String";
              Value="scrnsave.scr";
              Delete=$False;
            }
          )
        };
      };

      # Windows Update - Block update to Windows 11
      $Windows_CurrentVersion = (Get-ItemProperty -LiteralPath ("Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion") -Name ("DisplayVersion") -EA:0 | Select-Object -ExpandProperty "DisplayVersion" -EA:0);
      If ("${Windows_CurrentVersion}".Length -Eq 0) {
        $Windows_CurrentVersion = "22H2";
      }
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate";
        Props=@(
          @{
            Description="Version of Windows to get updates for";
            Name="ProductVersion";
            Type="String";
            Value="Windows 10";
            Delete=$False;
          },
          @{
            Description="[ 0 ]=Disable, [ 1 ]=Enable option 'only pull updates for a specific type/version of Windows'";
            Name="TargetReleaseVersion";
            Type="DWord";
            Value=1;
            Delete=$False;
          },
          @{
            Description="Set this value to the specific release/version of Windows which you want to get updates for";
            Name="TargetReleaseVersionInfo";
            Type="String";
            Value="${Windows_CurrentVersion}";
            Delete=$False;
          }
        )
      };

      # Windows Update - Active Hours
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings";
        Props=@(
          @{
            Description="Windows Update - [ 0 ]=Disable, [ 1 ]=Enable Windows Update's 'Active Hours' functionality";
            Name="IsActiveHoursEnabled";
            Type="DWord";
            Value=If ($PSBoundParameters.ContainsKey('EnableWindowsUpdateActiveHours')) { 1 <# Enabled #> } Else { 0 <# Disabled #> };
            Delete=$False;
          }
        )
      };

      # Xbox Game Bar - Disable Windows-Key + G Hotkey (by disabling game DVR captures)
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR";
        Props=@(
          @{
            Description="Xbox Game Bar - [ 0 ]=Disable, [ 1 ]=Enable option 'Enable Xbox Game Bar for things like recording game clips, chatting with friends, and receiving game invites. (Some games require Xbox Game Bar for receiving game invites.)' under Win10 Settings > Home > Gaming > Xbox Game Bar";
            Name="AppCaptureEnabled";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };
      $RegEdits += @{
        Path="Registry::${HKEY_USERS_SID_OR_CURRENT_USER}\System\GameConfigStore";
        Props=@(
          @{
            Description="Xbox Game DVR Recordings - [ 0 ]=Disable, [ 1 ]=Enable option 'Record game clips and take screenshots using Game DVR' under Xbox App > Settings > Game DVR";
            Name="GameDVR_Enabled";
            Type="DWord";
            Value=0;
            Delete=$False;
          }
        )
      };

      # Windows Update - Force-pull from Microsoft servers instead of local/WSUS servers
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate";
        Props=@(
          @{
            Description="(self explanatory)";
            Name="AcceptTrustedPublisherCerts";
            Type="DWord";
            Value=1;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="DisableDualScan";
            Type="DWord";
            Value=1;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="DoNotEnforceEnterpriseTLSCertPinningForUpdateDetection";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="FillEmptyContentUrls";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="SetPolicyDrivenUpdateSourceForDriverUpdates";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="SetPolicyDrivenUpdateSourceForFeatureUpdates";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="SetPolicyDrivenUpdateSourceForOtherUpdates";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="SetPolicyDrivenUpdateSourceForQualityUpdates";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="(self explanatory)";
            Name="SetProxyBehaviorForUpdateDetection";
            Type="DWord";
            Value=0;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="WSUS URL";
            Name="UpdateServiceUrl";
            Type="String";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="WSUS Alternate URL";
            Name="UpdateServiceUrlAlternate";
            Type="String";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="HTTP(S) URL of the WSUS server used by Automatic Updates and (by default) API callers. This policy is paired with WUStatusServer; both must be set to the same value in order for them to be valid. ( from https://learn.microsoft.com/de-de/security-updates/windowsupdateservices/18127499 )";
            Name="WUServer";
            Type="String";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          },
          @{
            Description="The HTTP(S) URL of the server to which reporting information will be sent for client computers that use the WSUS server configured by the WUServer key. This policy is paired with WUServer; both must be set to the same value in order for them to be valid. ( from https://learn.microsoft.com/de-de/security-updates/windowsupdateservices/18127499 )";
            Name="WUStatusServer";
            Type="String";
            Value="";
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };
      $RegEdits += @{
        Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU";
        Props=@(
          @{
            Description="Windows Update - [ 0 ]=Disable, [ 1 ]=Enable option 'use a [Automatic Updates] server that is running Software Update Services instead of Windows Update ( from https://learn.microsoft.com/en-us/windows/deployment/update/waas-wu-settings )";
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
            Description="Sets the value (string) for the option named 'Alternate [component installation and repair] source file path' for Group Policy setting 'Specify settings for optional component installation and component repair setting.' located under [ 'gpedit.msc' -> 'Computer Configuration' -> 'Administrative Templates' -> 'System' ]";
            Name="LocalSourcePath";
            Type="ExpandString";
            Value="";
            Delete=$False;
          },
          @{
            Description="Windows Update - Sets option 'Download repair content and optional features directly from Windows Update isntead of Windows Server Update Services (WSUS)' to [ 2 ]=Enabled, [ deleted ]=Disabled for Group Policy setting 'Specify settings for optional component installation and component repair setting.' located under [ 'gpedit.msc' -> 'Computer Configuration' -> 'Administrative Templates' -> 'System' ] ";
            Name="RepairContentServerSource";
            Type="DWord";
            Value=2;
            Delete=$False;
          },
          @{
            Description="Windows Update - Sets option 'Never attempt to download payload from Windows Update' to [ 2 ]='never pull from Windows Update (checked in gpedit)', [ deleted ]='allow pulling from Windows Update (unchecked in gpedit)' for Group Policy setting 'Specify settings for optional component installation and component repair setting.' located under [ 'gpedit.msc' -> 'Computer Configuration' -> 'Administrative Templates' -> 'System' ]";
            Name="UseWindowsUpdate";
            Type="DWord";
            Value=2;
            Delete=$True; <#  !!!  Delete this Property ( deletes entire Key if Name="(Default)" )  !!!  #>
          }
        )
      };

      # Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services!MaxCompressionLevel"; <# Example of Registry Path w/ inline Property name #>

      # ------------------------------------------------------------
      #
      # Power Options
      #

      If (-Not ($PSBoundParameters.ContainsKey('SkipPowercfgUpdates'))) {
        If ( ($Null) -NE (Get-Command "powercfg.exe" -EA:0) ) {
          Write-Output "`n  Power Options";
          # Set idle timeouts to 20 minutes on wall (AC) power
          Write-Output "    |`n    |-->  Setting `"Turn off the display after`" to `"20 minutes`"  (while plugged in)";
          powercfg.exe -setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 1200
          powercfg.exe -setacvalueindex SCHEME_CURRENT SUB_VIDEO VIDEOCONLOCK 1200
          powercfg.exe -x -monitor-timeout-ac 1200
          powercfg.exe -setactive SCHEME_CURRENT
          # Set idle timeouts to 5 minutes on battery (DC) power
          Write-Output "    |`n    |-->  Setting `"Turn off the display after`" to `"5 minutes`"  (while on battery)";
          powercfg.exe -x -monitor-timeout-dc 300
          powercfg.exe -setactive SCHEME_CURRENT
          # Disable Sleep Mode
          Write-Output "    |`n    |-->  Setting `"Put the computer to sleep`" to `"Never`"  (e.g. disable sleep state(s) S1-S3)";
          powercfg.exe -x -standby-timeout-ac 0
          powercfg.exe -x -standby-timeout-dc 0
          powercfg.exe -setactive SCHEME_CURRENT
          # Disable Hibernation
          Write-Output "    |`n    |-->  Setting `"Hibernation`" to `"Disabled`"  (e.g. disable sleep state(s) S4)";
          powercfg.exe -hibernate off
          powercfg.exe -x -hibernate-timeout-ac 0
          powercfg.exe -x -hibernate-timeout-dc 0
          powercfg.exe -setactive SCHEME_CURRENT
          Write-Output "";
        }
      }

      # ------------------------------------------------------------
      #
      # Group-Policy Setting(s)
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
        Write-Output "`n`nThe following property sets the value to for Group Policy (gpedit.msc) titled 'Configure compression for RemoteFX data' to:  [ 0 - 'Do not use an RDP compression algorithm' ],  [ 1 - 'Optimized to use less memory' ],  [ 2 - 'Balances memory and network bandwidth' ],  or  [ 3 - 'Optimized to use less network bandwidth' ]`n`n";
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
      #
      # Disable "Automatic Sample Submission" for Windows Defender (only verified to work on Non-AD joined PCs):
      #   > Open Group Policy Editor -> Administrative Templates -> Windows Components -> Microsoft Defender Antivirus -> MAPS
      #     > DISABLE: "Join Microsoft MAPS"
      #     > ENABLE:  "Configure local setting override for reporting to Microsoft MAPS"
      #     > ENABLE:  "Send file samples when further analysis is required"
      #                  |--> Select dropdown option "Never send" for field "Send file samples when further analysis is required"
      #
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

      $Count_ChangesMade=0;

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
          $EXIT_CODE=1;
          Write-Output "`n`nError:  Insufficient privileges, unable to escalate (e.g. unable to run as admin)`n`n";
        }
      } Else {
        <# Script >> IS << running as Admin - Continue #>

        # ------------------------------------------------------------
        ForEach ($EachRegEdit In $RegEdits) {
          #
          # Root-Keys
          #   |--> Ensure that this registry key's Root-Key has been mapped as a network drive
          #   |--> Mapping this as a network drive grants this script read & write access to said Root-Key's registry values (which would otherwise be inaccessible)
          #

          $EachRegEdit.ChangesMade = $False;

          $EachRegEdit.LogOutput = @();

          $EachRegEdit.LogOutput += ("`n$($EachRegEdit.Path)");

          # Ensure base level references exist (HKCU, HKLM, etc.)
          If (($EachRegEdit.Path).StartsWith("Registry::") -Eq $False) {
            $Each_RegEdit_DriveName=(($EachRegEdit.Path).Split(':\')[0]);
            If ((Test-Path -Path (("${Each_RegEdit_DriveName}:\"))) -Eq $False) {
              $Each_PSDrive_PSProvider=$Null;
              $Each_PSDrive_Root=$Null;
              If ($PSBoundParameters.ContainsKey('Verbose')) { $EachRegEdit.LogOutput += "  |-->  Verbose:  Root-Key `"${Each_RegEdit_DriveName}`" not found"; };
              ForEach ($Each_PSDrive In $PSDrives) {
                If ((($Each_PSDrive.Name) -Ne $Null) -And (($Each_PSDrive.Name) -Eq $Each_RegEdit_DriveName)) {
                  $Each_PSDrive_PSProvider=($Each_PSDrive.PSProvider);
                  $Each_PSDrive_Root=($Each_PSDrive.Root);
                  Break;
                }
              }
              If ($Each_PSDrive_Root -Ne $Null) {
                # Create maps from shorthand registry syntaxes (ex: "HKCU") to their root registry path (ex: "HKEY_CURRENT_USERS")
                If ($PSBoundParameters.ContainsKey('Verbose')) { $EachRegEdit.LogOutput += "  |-->  Verbose:  Adding Session-Based ${Each_PSDrive_PSProvider} Network-Map from drive name `"${Each_RegEdit_DriveName}`" to data store location `"${Each_PSDrive_Root}`""; };
                New-PSDrive -Name "${Each_RegEdit_DriveName}" -PSProvider "${Each_PSDrive_PSProvider}" -Root "${Each_PSDrive_Root}" | Out-Null;
              }
            }
          }

          # ------------------------------
          ForEach ($EachProp In $EachRegEdit.Props) {

            # Check for each Key
            If ((Test-Path -LiteralPath ($EachRegEdit.Path)) -Eq $True) {
              # Key exists
              If ((($EachProp.Delete) -eq $True) -And (($EachProp.Name) -Eq "(Default)")) {
                # Key SHOULD be deleted
                Remove-Item -Force -Recurse -LiteralPath ($EachRegEdit.Path) -Confirm:$False | Out-Null;
                If ((Test-Path -LiteralPath ($EachRegEdit.Path)) -Eq $False) {
                  $Count_ChangesMade++;
                  $EachRegEdit.ChangesMade = $True;
                  $EachRegEdit.LogOutput += "  |-->  !! Deleted this Registry Key";
                  Break; # Since we're removing the registry key, we can skip going over the rest of the current key's properties (since the key itself should no longer exist)
                } Else {
                  $EXIT_CODE=1;
                  $EachRegEdit.LogOutput += "  |-->  !! Error:  Unable to delete this Registry Key";
                }
              }
            } Else {
              # Key doesn't exist (yet)
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
                  $Count_ChangesMade++;
                  $EachRegEdit.ChangesMade = $True;
                  $EachRegEdit.LogOutput += "  |-->  !! Created this Registry Key";
                } Else {
                  $EXIT_CODE=1;
                  $EachRegEdit.LogOutput += "  |-->  !! Error:  Unable to create this Registry Key";
                }
              }
            }

            # Check for each Property
            Try {
              $GetEachItemProp = (Get-ItemPropertyValue -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -ErrorAction ("Stop"));
            } Catch {
              $GetEachItemProp = $Null;
            };

            If ($null -eq $GetEachItemProp) {
              # Property doesn't exist (yet)

              If (($EachProp.Delete) -Eq $False) {

                # Create the Property
                $Count_ChangesMade++;
                $EachRegEdit.ChangesMade = $True;
                $EachRegEdit.LogOutput += "  |-->  !! Adding Property `"$($EachProp.Name)`" w/ type `"$($EachProp.Type)`" and value `"$($EachProp.Value)`"";
                New-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value) | Out-Null;

              } Else {

                # Do nothing to the Property (already deleted)
                If ($PSBoundParameters.ContainsKey('Verbose')) { $EachRegEdit.LogOutput += "  |-->  Skipping Property `"$($EachProp.Name)`" (already deleted)"; };

              }

            } Else {
              # Property exists

              If (($EachProp.Delete) -Eq $True) {
                # Property SHOULD be deleted

                # Delete the Property
                $Count_ChangesMade++;
                $EachRegEdit.ChangesMade = $True;
                $EachRegEdit.LogOutput += "  |-->  !! Deleting Property `"$($EachProp.Name)`"";
                Remove-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -Confirm:$False | Out-Null;

              } Else {
                # Property should NOT be deleted

                $EachProp.LastValue = $GetEachItemProp;

                If (($EachProp.LastValue) -Eq ($EachProp.Value)) {

                  # Do nothing to the Property (already exists with matching type & value)
                  If ($PSBoundParameters.ContainsKey('Verbose')) { $EachRegEdit.LogOutput += "  |-->  Skipping Property `"$($EachProp.Name)`" (already up-to-date)"; };

                } Else {

                  # Update the Property
                  $Count_ChangesMade++;
                  $EachRegEdit.ChangesMade = $True;
                  $EachRegEdit.LogOutput += "  |-->  !! Updating Property `"$($EachProp.Name)`" w/ type `"$($EachProp.Type)`" to value `"$($EachProp.Value)`" (previous value was `"$($EachProp.LastValue)`")";
                  Set-ItemProperty -Force -LiteralPath ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value) | Out-Null;

                }

              }

            }

          }
          # ^-- End of ForEach Property
          # ------------------------------

          If (($EachRegEdit.ChangesMade) -Eq $True) {
            # At least one non-skipped change was made
            Write-Output ($EachRegEdit.LogOutput -join "`n");
          } Else {
            # All keys/properties skipped
            If ($PSBoundParameters.ContainsKey('Verbose')) { Write-Output ($EachRegEdit.LogOutput -join "`n"); };
          }

        }
        # ^-- End of ForEach Key
        # ------------------------------------------------------------

      }

      # If ZERO changes were made, report it
      If (${Count_ChangesMade} -Eq 0) {
        Write-Output "`n  No changes made  -->  Registry is already up-to-date$(If (($PSBoundParameters.ContainsKey('Verbose')) -Eq ($False)) { Write-Output "`n                   -->  For additional info, run using the '-Verbose' argument"; };)";
      }

    }

  }

  Write-Output "`n  Press any key to exit...";
  $KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

  # If errors exist, exit with a non-zero exit code
  If (${EXIT_CODE} -NE 0) {
    Exit ${EXIT_CODE};
  } Else {
    Return;
  }

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
#   admx.help  |  "Disable the Office Start screen for all Office applications"  |  https://admx.help/?Category=Office2016&Policy=office16.Office.Microsoft.Policies.Windows::L_DisableOfficeStartGlobal
#
#   admx.help  |  "Font smoothing"  |  https://admx.help/?Category=ClassicShell&Policy=IvoSoft.Policies.ClassicStartMenu::CSM_FontSmoothing
#
#   admx.help  |  "Join Microsoft Active Protection Service (MAPS)."  |  https://admx.help/?Category=SystemCenterEndpointProtection&Policy=Microsoft.Policies.Antimalware::maps_mapsreporting
#
#   admx.help  |  "Password protect the screen saver"  |  https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_ScreenSaverIsSecure
#
#   admx.help  |  "Screen saver timeout"  |  https://admx.help/?Category=Windows_11_2022&Policy=Microsoft.Policies.ControlPanelDisplay::CPL_Personalization_ScreenSaverTimeOut
#
#   admx.help  |  "Send file samples when further analysis is required."  |  https://admx.help/?Category=SystemCenterEndpointProtection&Policy=Microsoft.Policies.Antimalware::maps_submitsamplesconsent
#
#   answers.microsoft.com  |  "Automatic files - Automatic file downloads"  |  https://answers.microsoft.com/en-us/windows/forum/all/automatic-files/91b91138-0096-4fbc-a3e2-5de5176a6ca5
#
#   answers.microsoft.com  |  "Microsoft Meet Now fouled up my microphone settings - Microsoft Community"  |  https://answers.microsoft.com/en-us/skype/forum/all/microsoft-meet-now-fouled-up-my-microphone/1b6e05a8-b651-4404-89a7-b24c83403c1e
#
#   autohotkey.com  |  "Windows key (#) + letter keeps locking the pc (even if it is not #L)"  |  https://www.autohotkey.com/boards/viewtopic.php?p=46949&sid=490d0a443a7f78557b54c2bfb079350f#p46949
#
#   getadmx.com  |  "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"  |  https://getadmx.com/HKLM/SOFTWARE/Policies/Microsoft/Windows%20NT/Terminal%20Services
#
#   getadmx.com  |  "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"  |  https://getadmx.com/HKCU/Software/Microsoft/Windows/CurrentVersion/Policies/System
#
#   gist.github.com  |  "These settings are designed to allow a user a better exxperience by removing annoyances. This works for Office 2016 and 2019 · GitHub"  |  https://gist.github.com/Carm01/0df027dd1ddc57dd3044ca87565a6194
#
#   jonathanmedd.net  |  "Testing for the Presence of a Registry Key and Value"  |  https://www.jonathanmedd.net/2014/02/testing-for-the-presence-of-a-registry-key-and-value.html
#
#   learn.microsoft.com  |  "[MS-GPPREF]: GlobalFolderOptions element | Microsoft Docs"  |  https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/3c837e92-016e-4148-86e5-b4f0381a757f
#
#   learn.microsoft.com  |  "[MS-GPPREF]: GlobalFolderOptionsVista element | Microsoft Docs"  |  https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/a6ca3a17-1971-4b22-bf3b-e1a5d5c50fca
#
#   learn.microsoft.com  |  "[MS-GPPREF]: StartMenu Inner Element | Microsoft Docs"  |  https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/adf64850-92a6-4131-ab31-906f9a419d2b
#
#   learn.microsoft.com  |  "[MS-GPPREF]: StartMenuVista Inner Element | Microsoft Docs"  |  https://learn.microsoft.com/en-us/openspecs/windows_protocols/ms-gppref/1d9120b4-aa9d-4ea8-89b7-cb64f79b83d5
#
#   learn.microsoft.com  |  "Adhering to System Policy Settings | Microsoft Docs"  |  https://learn.microsoft.com/en-us/previous-versions/windows/desktop/policy/adhering-to-system-policy-settings
#
#   learn.microsoft.com  |  "Configure Automatic Updates in a Non–Active Directory Environment | Microsoft Learn"  |  https://learn.microsoft.com/de-de/security-updates/windowsupdateservices/18127499
#
#   learn.microsoft.com  |  "Configure Windows Defender SmartScreen"  |  https://learn.microsoft.com/en-us/microsoft-edge/deploy/available-policies#configure-windows-defender-smartscreen
#
#   learn.microsoft.com  |  "Disabling Stickey Dialog - Microsoft Q&A"  |  https://learn.microsoft.com/en-us/answers/questions/151522/disabling-stickey-dialog
#
#   learn.microsoft.com  |  "Get-PSProvider - Gets information about the specified PowerShell provider"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-psprovider
#
#   learn.microsoft.com  |  "HKEY_CLASSES_ROOT Key - Win32 apps | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/win32/sysinfo/hkey-classes-root-key
#
#   learn.microsoft.com  |  "Hotkey | Microsoft Learn"  |  https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-2000-server/cc976564(v=technet.10)?redirectedfrom=MSDN
#
#   learn.microsoft.com  |  "Manage connections from Windows 10 and Windows 11 operating system components to Microsoft services - Windows Privacy | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services#1816-feedback--diagnostics
#
#   learn.microsoft.com  |  "Manage connections from Windows 10 operating system components to Microsoft services - Windows Privacy | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/privacy/manage-connections-from-windows-operating-system-components-to-microsoft-services
#
#   learn.microsoft.com  |  "Multimedia Class Scheduler Service - Win32 apps | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/win32/procthread/multimedia-class-scheduler-service
#
#   learn.microsoft.com  |  "New-PSDrive - Creates temporary and persistent mapped network drives"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-psdrive
#
#   learn.microsoft.com  |  "Remove-ItemProperty - Deletes the property and its value from an item"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/remove-itemproperty
#
#   learn.microsoft.com  |  "Run and RunOnce Registry Keys - Windows applications | Microsoft Docs"  |  https://learn.microsoft.com/en-us/windows/win32/setupapi/run-and-runonce-registry-keys
#
#   learn.microsoft.com  |  "Set-ItemProperty - Creates or changes the value of a property of an item"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-itemproperty
#
#   learn.microsoft.com  |  "Windows Time service tools and settings | Microsoft Learn"  |  https://learn.microsoft.com/en-us/windows-server/networking/windows-time-service/windows-time-service-tools-and-settings
#
#   social.msdn.microsoft.com  |  ".NET Framework 3.5 doesn't install. Windows 10.. Error code: 0x800F081F"  |  https://social.msdn.microsoft.com/Forums/en-US/4ea808e7-c503-4f99-9480-aa8e6938be3d
#
#   social.technet.microsoft.com  |  "GPO : runas hide show"  |  https://social.technet.microsoft.com/Forums/en-US/f2889321-7531-4fde-bb28-f5f141c251b6/gpo-runas-hide-show?forum=winserverDS
#
#   ss64.com  |  "Windows 10 registry - How-To: Windows 10 registry - user interface settings - Windows CMD - SS64.com"  |  https://ss64.com/nt/syntax-reghacks.html
#
#   stackoverflow.com  |  "Hex to Decimal Conversion - PowerShell 5 - Stack Overflow"  |  https://stackoverflow.com/a/38567654
#
#   stackoverflow.com  |  "New-Item recursive registry keys"  |  https://stackoverflow.com/a/21770519
#
#   stackoverflow.com  |  "powershell - Changing Windows Time and Date Format - Stack Overflow"  |  https://stackoverflow.com/a/28749587
#
#   stackoverflow.com  |  "Retrieve (Default) Value in Registry key"  |  https://stackoverflow.com/a/31711000
#
#   stackoverflow.com  |  "The IDynamicPropertyCmdletProvider interface is not implemented by this provider"  |  https://stackoverflow.com/a/54237993
#
#   stackoverflow.com  |  "windows - How do you disable the office 2013 clipboard? - Stack Overflow"  |  https://stackoverflow.com/a/53070256
#
#   superuser.com  |  "How do I disable specific windows 10/Office Keyboard Shortcut (CTRL+SHIFT+WIN+ALT+D) - Super User"  |  https://superuser.com/a/1484507
#
#   superuser.com  |  "keyboard shortcuts - How to disable Windows Gamebar mapping? - Super User"  |  https://superuser.com/a/1097169
#
#   superuser.com  |  "My 'Edit' context action when right-clicking a Powershell file has disappeared - Super User"  |  https://superuser.com/a/656681
#
#   superuser.com  |  "powershell - How to get the windows version with command line? - Super User"  |  https://superuser.com/a/1640261
#
#   superuser.com  |  "windows 7 - How to disable sleep mode via CMD? - Super User"  |  https://superuser.com/a/1330613
#
#   superuser.com  |  "windows 10 - Registry keys to change personalization settings? - Super User"  |  https://superuser.com/a/1395560
#
#   support-splashtopbusiness.splashtop.com  |  "What are the Windows Streamer registry settings? – Splashtop Business - Support"  |  https://support-splashtopbusiness.splashtop.com/hc/en-us/articles/360030993692
#
#   support.microsoft.com  |  "Guidance for configuring IPv6 in Windows for advanced users"  |  https://support.microsoft.com/en-us/help/929852/guidance-for-configuring-ipv6-in-windows-for-advanced-users
#
#   support.microsoft.com  |  "How to change the logon screen saver in Windows - Microsoft Support"  |  https://support.microsoft.com/en-us/topic/how-to-change-the-logon-screen-saver-in-windows-ab28d230-ffb9-65f8-74a9-c26c5e00ec73
#
#   winaero.org  |  "Disable Windows Update Active hours in Windows 10"  |  https://winaero.com/disable-windows-update-active-hours-in-windows-10/
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
#   www.askvg.com  |  "[Windows 10 Tip] Disable Data Collection and Telemetry in Windows Defender – AskVG"  |  https://www.askvg.com/windows-10-tip-disable-data-collection-and-telemetry-in-windows-defender/
#
#   www.askvg.com  |  "[Windows 10 Tip] Registry Tweaks to Customize UI of Alt+Tab, Task View and Snap Assistant Screens – AskVG"  |  https://www.askvg.com/windows-10-tip-registry-tweaks-to-customize-ui-of-alttab-task-view-and-snap-assistant-screens/
#
#   www.elevenforum.com  |  "Change Accent Color in Windows 11 Tutorial | Windows 11 Forum"  |  https://www.elevenforum.com/t/change-accent-color-in-windows-11.1146/
#
#   www.ghacks.net  |  "Remove Windows 10 Context Menu bloat - gHacks Tech News"  |  https://www.ghacks.net/2017/07/09/remove-windows-10-context-menu-bloat/
#
#   www.howtogeek.com  |  "How to Make Windows 10’s Taskbar Clock Display Seconds"  |  https://www.howtogeek.com/325096/how-to-make-windows-10s-taskbar-clock-display-seconds/
#
#   www.howtogeek.com  |  "How to Remove the 'Send To' Menu from Windows' Context Menu"  |  https://www.howtogeek.com/howto/windows-vista/disable-the-send-to-folder-on-the-windows-explorer-context-menu/
#
#   www.makeuseof.com  |  "How to Change the Lock Screen and Screen Saver Timeout Settings on Windows"  |  https://www.makeuseof.com/windows-lock-screen-saver-timeout/
#
#   www.microsoft.com  |  "Group Policy Settings Reference for Windows and Windows Server"  |  https://www.microsoft.com/en-us/download/confirmation.aspx?id=25250
#
#   www.reddit.com  |  "Dramatically increased FPS with this guide : RingOfElysium"  |  https://www.reddit.com/r/RingOfElysium/comments/aiwm2r/dramatically_increased_fps_with_this_guide/
#
#   www.reddit.com  |  "The quest for removing the yellow warning sign on the Windows Defender Security Center icon : Windows10"  |  https://www.reddit.com/r/Windows10/comments/6v532u/the_quest_for_removing_the_yellow_warning_sign_on/
#
#   www.techsupportforum.com  |  "[SOLVED] Cleartype command??? does it exist? | Tech Support Forum"  |  https://www.techsupportforum.com/threads/solved-cleartype-command-does-it-exist.332657/
#
#   www.tenforums.com  |  "Add or Remove Scan with Microsoft Defender Context Menu in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/18145-add-remove-scan-microsoft-defender-context-menu-windows-10-a.html
#
#   www.tenforums.com  |  "How to Enable or Disable Aero Shake in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/4417-how-enable-disable-aero-shake-windows-10-a.html
#
#   www.tenforums.com  |  "How to Specify Target Feature Update Version in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/159624-how-specify-target-feature-update-version-windows-10-a.html#6
#
#   www.tenforums.com  |  "Turn On or Off Snap Windows in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/4343-turn-off-snap-windows-windows-10-a.html
#
#   www.thewindowsclub.net  |  "Enable or Disable Game DVR or Game Bar in Windows 11/10"  |  https://www.thewindowsclub.com/enable-disable-game-dvr-windows-10
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
