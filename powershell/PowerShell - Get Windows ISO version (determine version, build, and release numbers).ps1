# ------------------------------------------------------------
#
# PowerShell - Get Windows ISO version (determine version, build, and release numbers)
#
# ------------------------------------------------------------
If ($False) { # RUN THIS SCRIPT:

$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/PowerShell%20-%20Get%20Windows%20ISO%20version%20%28determine%20version%2c%20build%2c%20and%20release%20numbers%29.ps1') ).Content) } Catch {};

}
# ------------------------------------------------------------

### !!! REQUIRES ADMIN PRIVILEGES !!! ###

If ($True) {

  $ISO_Fullpath = "${HOME}\Desktop\Windows.iso";

  $DebugMode = $False;
  # $DebugMode = $True;

  # Determine if the iso file is already mounted
  $Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter);

  # If iso file is not already mounted, then mount it now
  If ($null -eq (Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume)) {
    Mount-DiskImage -ImagePath ("${ISO_FullPath}") | Out-Null;
    Start-Sleep -Seconds (1);
  }

  # Get the mounted iso file's drive letter
  $Mounted_DriveLetter = ((Get-DiskImage -ImagePath "${ISO_FullPath}" | Get-Volume).DriveLetter);

  If (([String]::IsNullOrEmpty("${Mounted_DriveLetter}")) -Eq $True) {

    # Error(s) mounting ISO file
    Write-Output "Error:  Unable to mount ISO file `"${ISO_FullPath}`"";

  } Else {

    # ISO file mounted successfully
    Write-Output "Info:  Located ISO file `"${ISO_FullPath}`" mounted to drive letter `"${Mounted_DriveLetter}`"";

    $Regex_DISM_ErrorCount = "^Error\s*: (.+)";
    $Regex_DISM_Indexes = "^Index : .+";
    $Regex_DISM_WinName = "^Name : (.+)";
    $Regex_DISM_WinVersion = "^Version : (.+)";
    $Regex_DISM_WinBuild = "^ServicePack Build\s*: (.+)";

    # Locate the wimfile
    $Install_Esd_MountPath = ("${Mounted_DriveLetter}:\sources\install.esd");
    $Install_Wim_MountPath = ("${Mounted_DriveLetter}:\sources\install.wim");
    If (Test-Path -PathType "Leaf" -Path ("${Install_Wim_MountPath}")) {
      $Wimfile_MountPath = "${Install_Wim_MountPath}";
    } Else {
      $Wimfile_MountPath = "${Install_Esd_MountPath}";
    }

    # Get the version # of Windows (stored within the sources/install.* file (wim))
    $DISM_Info = (DISM /Get-WimInfo /WimFile:${Wimfile_MountPath}); $EXIT_CODE_DISM=([int]${EXIT_CODE_DISM}+([int](!${?})));

    $DISM_ErrorsExist = ([Regex]::Match("$(${DISM_Info} -match ${Regex_DISM_ErrorCount})","${Regex_DISM_ErrorCount}").Success);

    If ($True -Eq ${DebugMode}) {
      Write-Output "`${DISM_Info}:";
      Write-Output "= = = =";
      ${DISM_Info};
      Write-Output "= = = =";
      Write-Output "`${DISM_ErrorsExist} = [ ${DISM_ErrorsExist} ]";
    }

    If ((${EXIT_CODE_DISM} -NE 0) -Or (${DISM_ErrorsExist} -Eq $True)) {

      Write-Output "Error: Unable to get info using DISM - Error message:";
      Write-Output "------------------------------";
      ${DISM_Info};
      Write-Output "------------------------------";

    } Else {

      $DISM_Indexes_String = ([Regex]::Match("$(${DISM_Info} -match ${Regex_DISM_Indexes})","${Regex_DISM_Indexes}").Captures.Groups[0].Value);
      $DISM_Indexes_Arr = (${DISM_Indexes_String}.Split("Index : ") | Where-Object { "" -NE "${_}" });

      Write-Output "------------------------------";
      Write-Output "";
      Write-Output "  Filepath:  ${ISO_FullPath}";
      Write-Output "";
      Write-Output "- - - -";

      ${DISM_Indexes_Arr} | ForEach-Object {

        $Each_DISM_Index = "${_}";

        $Each_DISM_Args = @("/Get-WimInfo","/WimFile:${Wimfile_MountPath}","/Index:$([int](${Each_DISM_Index}))");
        $Each_DISM_Index_Info=(DISM ${Each_DISM_Args}); $EXIT_CODE_DISM=([int]${EXIT_CODE_DISM}+([int](!${?})));
        $Each_DISM_Name = ([Regex]::Match("$(${Each_DISM_Index_Info} -match ${Regex_DISM_WinName})","${Regex_DISM_WinName}").Captures.Groups[1].Value);
        $Each_DISM_Version = ([Regex]::Match("$(${Each_DISM_Index_Info} -match ${Regex_DISM_WinVersion})","${Regex_DISM_WinVersion}").Captures.Groups[1].Value);
        $Each_DISM_Build = ([Regex]::Match("$(${Each_DISM_Index_Info} -match ${Regex_DISM_WinBuild})","${Regex_DISM_WinBuild}").Captures.Groups[1].Value);

        If ($True -Eq ${DebugMode}) {
          Write-Output "Command:  DISM /Get-WimInfo /WimFile:${Wimfile_MountPath} /Index:${Each_DISM_Index}";
          Write-Output "`${Each_DISM_Index_Info}:";
          Write-Output "= = = =";
          ${Each_DISM_Index_Info};
          Write-Output "= = = =";
          Write-Output "`${Each_DISM_Name} = [ ${Each_DISM_Name} ]";
          Write-Output "`${Each_DISM_Version} = [ ${Each_DISM_Version} ]";
          Write-Output "`${Each_DISM_Build} = [ ${Each_DISM_Build} ]";
        }

        Write-Output "";
        Write-Output "  Index:    ${Each_DISM_Index}";
        Write-Output "";
        Write-Output "  Name:     ${Each_DISM_Name}";
        Write-Output "";
        Write-Output "  Semver:   ${Each_DISM_Version}.${Each_DISM_Build}";
        Write-Output "";
        Write-Output "- - - -";

      }
      Write-Output "";
      Write-Output "------------------------------";

      Write-Output "";

    }

    # Unmount the iso file
    Get-DiskImage -ImagePath "${ISO_FullPath}" | Dismount-DiskImage | Out-Null;

  }

}


# ------------------------------------------------------------
#
# Citation(s)
#
#   answers.microsoft.com  |  "How to identify windows version and OS build of any windows disc image - Microsoft Community"  |  https://answers.microsoft.com/en-us/windows/forum/all/how-to-identify-windows-version-and-os-build-of/f8f8fe67-9554-4e63-a4d3-87f5dd58184e
#
#   docs.microsoft.com  |  "Get-Volume (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-volume
#
#   docs.microsoft.com  |  "Get-DiskImage (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/get-diskimage
#
#   docs.microsoft.com  |  "Mount-DiskImage (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/mount-diskimage
#
#   docs.microsoft.com  |  "Dismount-DiskImage (Storage) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/storage/dismount-diskimage
#
# ------------------------------------------------------------