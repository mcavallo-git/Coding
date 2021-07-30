# ------------------------------------------------------------
#
# PowerShell - PATH Environment Variable - Permanent Changes (PowerShell - Path - append new directory to env-var)
#
# ------------------------------------------------------------

# Get Environment Variables (one-liner)
Write-Output ---` env:*` ---; If(($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $rawUI=$Host.UI.RawUI; $oldSize=$rawUI.BufferSize; $typeName=$oldSize.GetType( ).FullName; $newSize=New-Object $typeName (16384, $oldSize.Height); $rawUI.BufferSize=$newSize; }; Get-ChildItem env: | Format-Table -AutoSize; Write-Output ---` env:PATH` ---; (${env:Path}).Split([String][Char]59) | Sort-Object; Write-Output ----------------;


# ------------------------------------------------------------

# Set Environment Variables


#
# SYSTEM PATH
#  |--> Permanently adds a directory to current system's PATH
#  |--> Applies change to all users on current system
#  |--> Change persists through machine/session restarts
#
$AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation";
$SystemPath = ((Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment").Path);
If (((${SystemPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
  Set-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment" -Name "Path" -Value "${SystemPath};${AppendPath}";
  [System.Environment]::SetEnvironmentVariable("Path","${SystemPath};${AppendPath}",[System.EnvironmentVariableTarget]::Machine);
}


#
# USER PATH
#  |--> Permanently adds a directory to current user's PATH
#  |--> Doesn't apply change to other users on current system
#  |--> Change persists through machine/session restarts
#
$AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation";
$UserPath = ((Get-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment").Path);
If (((${UserPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
  Set-ItemProperty -Path "Registry::HKEY_CURRENT_USER\Environment" -Name "Path" -Value "${UserPath};${AppendPath}";
  [System.Environment]::SetEnvironmentVariable("Path","${UserPath};${AppendPath}",[System.EnvironmentVariableTarget]::User);
}


# ------------------------------------------------------------
#
# Output all PATH components to the console
#
(${Env:Path}).Split([String][Char]59);


# Get the current Environment "Path" Directories (Combined System + User Dirs) & store them in the variable $EnvPath
$EnvPath = (${Env:Path}).Split([String][Char]59);


# Search the PATH for results matching a given string
(${Env:Path}).Split([String][Char]59) | Select-String 'git'; <# Non-exact matching #>
(${Env:Path}).Split([String][Char]59) | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" } | ForEach-Object { $_ }; <# Exact matching #>
((${Env:Path}).Split([String][Char]59) | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" }).Count; <# Count the number of pre-existing exact matches #>


# ------------------------------------------------------------
# 
# TEMPORARILY modify session environment variables in Windows
# 

$Env:Path = "C:\Trash";  # Temporarily REPLACES existing path
$Env:Path += ";C:\Program Files (x86)\VMware\VMware Workstation";  # Temporarily APPENDS TO existing path


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "SetEnvironmentVariable function (winbase.h) - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-setenvironmentvariable
#
#   stackoverflow.com  |  "Setting Windows PowerShell environment variables"  |  https://stackoverflow.com/a/2571200
#
# ------------------------------------------------------------