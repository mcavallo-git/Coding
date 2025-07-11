# ------------------------------------------------------------
#
# PowerShell - Environment Variables (get/set)
#
# ------------------------------------------------------------

#
# List all environment variables
#

gci env:;  # Shorthand

Get-ChildItem -Path 'Env:\';  # Longhand


#
# List all environment variables  (split by source)
#
If ((gcm printenv -EA:0) -And (gcm sort -EA:0)) { Write-Output ---` printenv` ---; printenv | sort -u; } Else { If (($Host.UI.RawUI) -And (-Not (gcm uname -EA:0))) { $rawUI=$Host.UI.RawUI; $oldSize=$rawUI.BufferSize; $typeName=$oldSize.GetType( ).FullName; $newSize=New-Object $typeName (16384, $oldSize.Height); $rawUI.BufferSize=$newSize; }; Write-Output ---` env:*` ---; Get-ChildItem env: | Format-Table -AutoSize; If ($Null -NE ${env:Path}) { Write-Output ---` env:PATH` ---; (${env:Path}).Split([String][Char]59) | Sort-Object; }; };  Write-Output ----------------; <# List all environment variables (one-liner) #>


# List System environment variables
Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment";


# List User environment variables
Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment";


# ------------------------------------------------------------
#
# Get the value of one, specific environment variable
#

(Get-Content -Path 'env:\USERPROFILE');  # Longhand - Method 1
(gc env:\USERPROFILE);  # Shorthand - Method 1


((Get-ChildItem -Path 'env:\USERPROFILE').Value);  # Longhand - Method 2
((gci env:\USERPROFILE).Value);  # Shorthand - Method 2



# ------------------------------
#
# System Environment Variables
#  |--> Applies change to all users on current system
#


#   env:HELM_EXPERIMENTAL_OCI   (System)
If ($True) {
  $Env_Name = "HELM_EXPERIMENTAL_OCI";
  $Env_Value = "1";
  Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::Machine);
}

#   env:ISO_DIR   (System)
If ($True) {
  $Env_Name = "ISO_DIR";
  $Env_Value = "C:\ISO";
  If (Test-Path -PathType "Container" -Path ("${Env_Value}")) {
    # Directory must exist
    Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
    [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::Machine);
  }
}

#   env:NG_CLI_ANALYTICS   (System)
If ($True) {
  $Env_Name = "NG_CLI_ANALYTICS";
  $Env_Value = "ci";
  Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::Machine);
}


#   env:PATH   (System)
If ($True) {
  # ------------------------------
  # Add a directory to current system's PATH (if not already incluided)
  $AppendPath = "${env:ProgramFiles(x86)}\VMware\VMware Workstation";
  $SystemPath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" | Select-Object -ExpandProperty 'Path');
  If (($False) -NE (Test-Path -Path ("${AppendPath}"))) {
    # Directory must exist
    If (((${SystemPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
      # Directory must not already exist in the PATH environment variable
      Write-Host "Info:  Appending `"${AppendPath}`" onto the System `"PATH`"...";
      Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "Path" -Value "${SystemPath};${AppendPath}";
      [System.Environment]::SetEnvironmentVariable("Path","${SystemPath};${AppendPath}",[System.EnvironmentVariableTarget]::Machine);
    }
  }
}


#   env:PSModulePath   (System)  - PowerShell Modules Source
If ($True) {
  # ------------------------------
  # Add a directory to current system's PSModulePath (if not already incluided)
  $Append_PSModulePath = "${env:REPOS_DIR}\Coding\powershell\_WindowsPowerShell\Modules";
  $System_PSModulePath = (Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" | Select-Object -ExpandProperty 'PSModulePath');
  If (($False) -NE (Test-Path -Path ("${Append_PSModulePath}"))) {
    # Directory must exist
    If (((${System_PSModulePath}).Split([String][Char]59) | Where-Object { $_ -Eq "${Append_PSModulePath}" }).Count -Eq 0) {
      # Directory must not already exist in the PSModulePath environment variable
      Write-Host "Info:  Appending `"${Append_PSModulePath}`" onto the System `"PSModulePath`"...";
      Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name 'PSModulePath' -Value "${System_PSModulePath};${Append_PSModulePath}";
      [System.Environment]::SetEnvironmentVariable('PSModulePath',"${System_PSModulePath};${Append_PSModulePath}",[System.EnvironmentVariableTarget]::Machine);
    }
  }
}


#   env:REPOS_DIR   (System)
If ($True) {
  $Env_Name = "REPOS_DIR";
  $Env_Value = "C:\ISO\Repos";
  If (Test-Path -PathType "Container" -Path ("${Env_Value}")) {
    # Directory must exist
    Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
    [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::Machine);
  }
}


# ------------------------------------------------------------
#
# User Environment Variables
#  |--> Saved to the environment behind the current user (running the commands)
#


#   env:REPOS_DIR   (User)
If ($True) {
  $Env_Name = "REPOS_DIR";
  $Env_Value = "${HOME}\Documents\GitHub";
  If (Test-Path -PathType "Container" -Path ("${Env_Value}")) {
    # Directory must exist
    Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
    [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::User);
  }
}


#   env:WSLENV   (User)
If ($True) {
  $Env_Name = "WSLENV";
  $Env_Value = "HELM_EXPERIMENTAL_OCI:NG_CLI_ANALYTICS:ProgramFiles/up:REPOS_DIR/up:TEMP/up:TMP/up:USERPROFILE/up:windir/up";
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::User);
}


#   env:PATH   (User)
If ($True) {
  $AppendPath = "${env:ProgramFiles(x86)}\VMware\VMware Workstation";
  $UserPath = ((Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment").Path);
  If (Test-Path -PathType "Container" -Path ("${AppendPath}")) {
    # Directory must exist
    If (((${UserPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
      # Directory must not already exist in the PATH environment variable
      Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "Path" -Value "${UserPath};${AppendPath}";
      [System.Environment]::SetEnvironmentVariable("Path","${UserPath};${AppendPath}",[System.EnvironmentVariableTarget]::User);
    }
  }
}


# ------------------------------------------------------------
#
# env:PATH  (User)
#  |--> Permanently adds a directory to current user's PATH
#  |--> Doesn't apply change to other users on current system
#  |--> Change persists through machine/session restarts
#

If ($True) {
  $User_Env_PATH_Appends_Arr = @();
  $User_Env_PATH_Appends_Arr += @("C:\ISO\PATH";);
  $User_Env_PATH_Appends_Arr += @("${env:REPOS_DIR}\cloud-infrastructure\usr\local\bin");  # For docker_* scripts
  $User_Env_PATH_Appends_Arr += @("${env:REPOS_DIR}\cloud-infrastructure\usr\local\sbin"); # For install_* scripts
  $User_Env_PATH_Appends_Arr | ForEach-Object {
    $AppendPath=(${_});
    If (Test-Path -PathType "Container" -Path ("${AppendPath}")) {
      # Directory must exist
      $UserPath = ((Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment").Path);
      If (((${UserPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
        # Directory must not already exist in the PATH environment variable
        Write-Host "`"${AppendPath}`"";
        Write-Host "   |--> Info:  Appending filepath to the User=scoped PATH environment variable `${env:PATH}...";
        Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "Path" -Value "${UserPath};${AppendPath}";
        [System.Environment]::SetEnvironmentVariable("Path","${UserPath};${AppendPath}",[System.EnvironmentVariableTarget]::User);
      } Else {
        Write-Host "`"${AppendPath}`"";
        Write-Host "   |--> (Skipped)  Filepath already exists on the User=scoped PATH environment variable `${env:PATH}";
      }
    }
  }
}


# ------------------------------------------------------------

If ($False) {

  # ------------------------------
  #
  # List the combined PATH components from both [ SYSTEM ], [ USER ], and anywhere else that gets added into the PATH environment variable scope
  #

  (${Env:Path}).Split([String][Char]59); <# List all items in the current PATH (combined User + System + other) #>

  # ------------------------------
  #
  # Check the PATH for results matching a given string
  #

  (${Env:Path}).Split([String][Char]59) | Select-String 'git'; <# Non-exact matching #>

  (${Env:Path}).Split([String][Char]59) | Where-Object { $_ -Eq "${env:ProgramFiles}\Git\cmd" } | ForEach-Object { $_ }; <# Exact matching #>

  ((${Env:Path}).Split([String][Char]59) | Where-Object { $_ -Eq "${env:ProgramFiles}\Git\cmd" }).Count; <# Count the number of pre-existing exact matches #>

  # ------------------------------
  #
  # Temporarily modify session environment variables in Windows
  #

  $Env:Path = "C:\Trash";  # Temporarily REPLACES existing path

  $Env:Path += ";${env:ProgramFiles(x86)}\VMware\VMware Workstation";  # Temporarily APPENDS TO existing path

  # ------------------------------

}

# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Share Environment Vars between WSL and Windows - Windows Command Line"  |  https://devblogs.microsoft.com/commandline/share-environment-vars-between-wsl-and-windows/
#
#   docs.microsoft.com  |  "Working across file systems | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/wsl/filesystems
#
#   docs.microsoft.com  |  "SetEnvironmentVariable function (winbase.h) - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-setenvironmentvariable
#
#   stackoverflow.com  |  "Setting Windows PowerShell environment variables"  |  https://stackoverflow.com/a/2571200
#
#   www.tutorialspoint.com  |  "How to get environment variable value using PowerShell?"  |  https://www.tutorialspoint.com/how-to-get-environment-variable-value-using-powershell
#
# ------------------------------------------------------------