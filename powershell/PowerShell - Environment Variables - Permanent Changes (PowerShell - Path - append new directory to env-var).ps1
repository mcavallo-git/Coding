# ------------------------------------------------------------

# Show all PATH items (to the console)
(${Env:Path}).Split(';');


# Get the current Environment "Path" Directories (Combined System + User Dirs) & store them in the variable $EnvPath
$EnvPath = (${Env:Path}).Split(';');


# Search the PATH for results matching a given string
(${Env:Path}).Split(';') | Select-String 'git'; <# Non-exact matching #>
(${Env:Path}).Split(';') | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" } | ForEach-Object { $_ }; <# Exact matching #>
((${Env:Path}).Split(';') | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" }).Count; <# Count the number of pre-existing exact matches #>


# Aappend to  > >  USER environment variable  < <  Permanently add a directory to the user's path (doesn't apply to other users on the same system)
$AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation"; `
$UserPath = ((Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment').Path);
if (((${Env:Path}).Split(';') | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" }).Count -Eq 0) {
	[System.Environment]::SetEnvironmentVariable("Path","${UserPath};${AppendPath}",[System.EnvironmentVariableTarget]::User);
}


# Append to  > >  SYSTEM environment variable  < <  Permanently add a directory to the system path (applies to all users on the same system)
$AppendPath = "C:\Program Files (x86)\VMware\VMware Workstation"; `
$SystemPath = ((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment').Path);
if (((${Env:Path}).Split(';') | Where-Object { $_ -Eq "C:\Program Files\Git\cmd" }).Count -Eq 0) {
	[System.Environment]::SetEnvironmentVariable("Path","${SystemPath};${AppendPath}",[System.EnvironmentVariableTarget]::Machine);
}


# ------------------------------------------------------------
# 
# PERMANENTLY modify user/system environment variables in Windows
# 

# PERMANENTLY  modify  USER  environment variable, "PATH"
$ADD_PATH = "C:\Program Files (x86)\VMware\VMware Workstation"; `
[System.Environment]::SetEnvironmentVariable(
	"Path",
	(((Get-ItemProperty -Path 'Registry::HKEY_CURRENT_USER\Environment').Path)+(";${ADD_PATH}")),
	[System.EnvironmentVariableTarget]::User
);


# PERMANENTLY  modify  SYSTEM  environment variable, "PATH"
$ADD_PATH = "C:\Program Files (x86)\VMware\VMware Workstation"; `
[System.Environment]::SetEnvironmentVariable(
	"Path",
	(((Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment').Path)+(";${ADD_PATH}")),
	[System.EnvironmentVariableTarget]::Machine
);



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