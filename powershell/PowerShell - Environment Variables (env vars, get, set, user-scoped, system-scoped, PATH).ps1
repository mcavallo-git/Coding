# ------------------------------------------------------------
#
# PowerShell - Environment Variables (get/set)
#
# ------------------------------------------------------------

#
# Quickly list all environment variables
#

gci env:


#
# Verbosely list all environment variables (one-liner)
#

Write-Output ---` env:*` ---; If(($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $rawUI=$Host.UI.RawUI; $oldSize=$rawUI.BufferSize; $typeName=$oldSize.GetType( ).FullName; $newSize=New-Object $typeName (16384, $oldSize.Height); $rawUI.BufferSize=$newSize; }; Get-ChildItem env: | Format-Table -AutoSize; Write-Output ---` env:PATH` ---; (${env:Path}).Split([String][Char]59) | Sort-Object; Write-Output ----------------; <# List all environment variables (one-liner) #>


# ------------------------------------------------------------
#
#   env:REPOS_DIR   (USER-SCOPED)
#

If ($True) {
  $Env_Name = "REPOS_DIR";
  $Env_Value = "${HOME}\Documents\GitHub";
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::User);
}


# ------------------------------------------------------------
#
#   env:WSLENV   (USER-SCOPED)
#

If ($True) {
  $Env_Name = "WSLENV";
  $Env_Value = "HELM_EXPERIMENTAL_OCI:NG_CLI_ANALYTICS:REPOS_DIR/up:TEMP/up:TMP/up";
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::User);
}


# ------------------------------
#
# System  -  env:HELM_EXPERIMENTAL_OCI
#  |--> Applies change to all users on current system
#

If ($True) {
  $Env_Name = "HELM_EXPERIMENTAL_OCI";
  $Env_Value = "1";
  Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::Machine);
}


# ------------------------------
#
# System  -  env:NG_CLI_ANALYTICS
#  |--> Applies change to all users on current system
#

If ($True) {
  $Env_Name = "NG_CLI_ANALYTICS";
  $Env_Value = "false";
  Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "${Env_Name}" -Value "${Env_Value}";
  [System.Environment]::SetEnvironmentVariable("${Env_Name}","${Env_Value}",[System.EnvironmentVariableTarget]::Machine);
}


# ------------------------------
#
# System  -  env:PATH
#  |--> Permanently adds a directory to current system's PATH (if not already on current PATH variable)
#  |--> Applies change to all users on current system
#

If ($True) {
  $AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation";
  $SystemPath = ((Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment").Path);
  If (((${SystemPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
    Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "Path" -Value "${SystemPath};${AppendPath}";
    [System.Environment]::SetEnvironmentVariable("Path","${SystemPath};${AppendPath}",[System.EnvironmentVariableTarget]::Machine);
  }
}


#
# User  -  env:PATH
#  |--> Permanently adds a directory to current user's PATH (if not already on current PATH variable)
#

If ($True) {
  $AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation";
  $UserPath = ((Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment").Path);
  If (((${UserPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
    Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "Path" -Value "${UserPath};${AppendPath}";
    [System.Environment]::SetEnvironmentVariable("Path","${UserPath};${AppendPath}",[System.EnvironmentVariableTarget]::User);
  }
}

# ------------------------------------------------------------
# ============================================================
# ------------------------------------------------------------

#
# List the combined PATH components from both [ SYSTEM ], [ USER ], and anywhere else that gets added into the PATH environment variable scope
#

(${Env:Path}).Split([String][Char]59); <# List all items in the current PATH (combined User + System + other) #>


#
# Check the PATH for results matching a given string
#

(${Env:Path}).Split([String][Char]59) | Select-String 'git'; <# Non-exact matching #>

(${Env:Path}).Split([String][Char]59) | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" } | ForEach-Object { $_ }; <# Exact matching #>

((${Env:Path}).Split([String][Char]59) | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" }).Count; <# Count the number of pre-existing exact matches #>


#
# Temporarily modify session environment variables in Windows
#

$Env:Path = "C:\Trash";  # Temporarily REPLACES existing path

$Env:Path += ";C:\Program Files (x86)\VMware\VMware Workstation";  # Temporarily APPENDS TO existing path


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
# ------------------------------------------------------------