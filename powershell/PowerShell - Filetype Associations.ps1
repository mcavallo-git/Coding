# ------------------------------------------------------------
#
# PowerShell
#   File Extension handling in Windows 10
#
#                                MCavallo, 20191230-035659
# ------------------------------------------------------------
#
#
# . "$($Env:USERPROFILE)\Documents\GitHub\Coding\powershell\PowerShell - Filetype Associations.ps1"
#
#
# ------------------------------------------------------------


Set-Content -Path ("$($Env:ProgramFiles)\Microsoft VS Code\VSCode-Workspace.bat") -Value (Get-Content -Path ("$($Env:USERPROFILE)\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"));


$FileExtension=".log";

# $OpenExtensionWith='"C:\Program Files\Microsoft VS Code\Code.exe" "%1"'; # Open w/ VS Code, always

# $OpenExtensionWith="`"$($Env:ProgramFiles)\Microsoft VS Code\Code.exe`" `"$($Env:USERPROFILE)\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";

# $OpenExtensionWith="`"%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";

$OpenExtensionWith="`"%ProgramFiles%\Microsoft VS Code\VSCode-Workspace.bat`" `"%1`"";

$UserSid = (&{If(Get-Command "WHOAMI" -ErrorAction "SilentlyContinue") { (WHOAMI /USER /FO TABLE /NH).Split(" ")[1] } Else { $Null }});

### NEED TO DELETE EXTENSION IN  [ Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts ]

### NEED TO DELETE EXTENSION IN  [ Registry::HKEY_USERS\${UserSid}\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts ]

### NEED (MAYBE?) TO CREATE EXTENSION IN  [ HKEY_LOCAL_MACHINE\SOFTWARE\Classes ] --> Note: that it seems to be populated from HKCR  (as-of 20191230-074934)

### Create key/properties in  [ Registry::HKEY_CLASSES_ROOT\${FileExtension}\shell\open\command ]
$HKCR_Key="Registry::HKEY_CLASSES_ROOT\${FileExtension}\shell\open\command";
Write-Host "Calling  [ New-Item -Path ($($HKCR_Key)) -Force; ]";
New-Item -Path ($HKCR_Key) -Force; # Note: The -Force is used to create any/all missing parent registry keys
Write-Host "Calling  [ New-ItemProperty -Path ($($HKCR_Key)) -Name (`"(Default)`") -PropertyType (`"String`") -Value ($($OpenExtensionWith)) -Force; ]";
New-ItemProperty -Path ($HKCR_Key) -Name ("(Default)") -PropertyType ("String") -Value ($OpenExtensionWith) -Force;


Exit 0;

# ------------------------------------------------------------
#
# PowerShell
#   File Extension handling in Windows 10
#
#                                MCavallo, 2019-06-20_13-20-50
# ------------------------------------------------------------

# Get User-SID (Security Identifier) for current user
$UserSid = (&{If(Get-Command "WHOAMI" -ErrorAction "SilentlyContinue") { (WHOAMI /USER /FO TABLE /NH).Split(" ")[1] } Else { $Null }});

# Get some info regarding current environment
$LogSettingsToDesktop = $False;
If ($LogSettingsToDesktop -Ne $False) {
	$CMD="ASSOC";  $OUT="${Env:USERPROFILE}\Desktop\cmd.${CMD}.log"; cmd /c "${CMD} > ${OUT} & ${OUT}"; # ASSOC --> .ext=fileType
	$CMD="FTYPE";  $OUT="${Env:USERPROFILE}\Desktop\cmd.${CMD}.log"; cmd /c "${CMD} > ${OUT} & ${OUT}"; # FTYPE --> fileType=openCommandString
	$CMD="WHOAMI"; $OUT="${Env:USERPROFILE}\Desktop\cmd.${CMD}.log"; cmd /c "${CMD} /ALL > ${OUT} & ${OUT}";
}

$Registry_StartupApps="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run";
$Registry_UserSidList="HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList";

$Registry_FileExtensions_A="HKEY_CLASSES_ROOT";
$Registry_FileExtensions_B="HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts";

# ------------------------------------------------------------
### HKEY_LOCAL_MACHINE
$max_keys = 3; `
$i=0; `
Get-ChildItem -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Classes" `
| ForEach-Object {
	$i++;
	If ($i -le $max_keys) {
		Show $_ -NoMethods -NoProperties;
	}
}


# ------------------------------------------------------------
### HKEY_CURRENT_USER
$max_keys = 3; `
$i=0; `
Get-ChildItem -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts" `
| ForEach-Object {
	$i++;
	If ($i -le $max_keys) {
		Show $_ -NoMethods -NoProperties;
	}
}


# ------------------------------------------------------------
### HKEY_USERS

$max_keys = 3; `
$i=0; `
$UserSid = (&{If(Get-Command "WHOAMI" -ErrorAction "SilentlyContinue") { (WHOAMI /USER /FO TABLE /NH).Split(" ")[1] } Else { $Null }}); `
Get-ChildItem -Path "Registry::HKEY_USERS\${UserSid}\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts" `
| ForEach-Object {
	$i++;
	If ($i -le $max_keys) {
		Show $_ -NoMethods -NoProperties;
	}
}


# ------------------------------------------------------------

(Get-ItemProperty 'Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\mailto\UserChoice' -Name ProgId).ProgID

Set-ItemProperty 'Registry::HKEY_CURRENT_USER\\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice' -name ProgId IE.HTTP

Set-ItemProperty 'Registry::HKEY_CURRENT_USER\\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice' -name ProgId IE.HTTPS


Write-Host "`n`n";

Type.GetType("System.Type").GetProperties();
Type.GetType("Microsoft.Win32.RegistryKey").GetProperties();


# ------------------------------------------------------------

# Write-Host -NoNewLine "`n`nPress any key to exit...";
# $KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
# Exit 0;


# ------------------------------------------------------------
#
# Note(s)
#
#		- Registry Key Class "Microsoft.Win32.RegistryKey"
#
# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "RegistryKey Class"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey
#
#		stackoverflow.com  |  "Get file type description for file extensions"  |  https://stackoverflow.com/a/27646804
#
#		superuser.com  |  "How to associate a file with a program in Windows via CMD [duplicate]"  |  https://superuser.com/a/362080
#
# ------------------------------------------------------------