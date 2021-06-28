# ------------------------------------------------------------
#
# PowerShell - PATH Environment Variable - Permanent Changes (PowerShell - Path - append new directory to env-var)
#
# ------------------------------------------------------------


# SYSTEM  PATH
#  |--> Permanently add a directory to current local system's PATH  (applied change to all users on current system)
$AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation"; `
$SystemPath = ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment').Path);
If (((${SystemPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
	[System.Environment]::SetEnvironmentVariable("Path","${SystemPath};${AppendPath}",[System.EnvironmentVariableTarget]::Machine);
}


# USER PATH
#  |--> Permanently add a directory to current local user's PATH  (doesn't apply change to other users on current system)
$AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation"; `
$UserPath = ((Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment').Path);
If (((${UserPath}).Split([String][Char]59) | Where-Object { $_ -Eq "${AppendPath}" }).Count -Eq 0) {
	[System.Environment]::SetEnvironmentVariable("Path","${UserPath};${AppendPath}",[System.EnvironmentVariableTarget]::User);
}


# ------------------------------------------------------------

# Show Environment Variables (one-liner)
If(($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $rawUI=$Host.UI.RawUI; $oldSize=$rawUI.BufferSize; $typeName=$oldSize.GetType( ).FullName; $newSize=New-Object $typeName (16384, $oldSize.Height); $rawUI.BufferSize=$newSize; }; Get-ChildItem Env: | Format-List; (${Env:Path}).Split([String][Char]59); 


# Show Environment Variables

# Update the max characters-per-line for the Powershell console by increasing the output buffer size (to see all of \${Env:PATH}, specifically)
If(($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) {
  $rawUI = $Host.UI.RawUI;
  $oldSize = $rawUI.BufferSize;
  $typeName = $oldSize.GetType( ).FullName;
  $newSize = New-Object $typeName (16384, $oldSize.Height);
  $rawUI.BufferSize = $newSize;
}

# Get Environment Variables
Get-ChildItem Env: | Format-List; 

# Get the PATH environment variable, using semi-colon delimitation  -  Note:  [String][Char]59 === ";" (one semicolon)
(${Env:Path}).Split([String][Char]59);


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