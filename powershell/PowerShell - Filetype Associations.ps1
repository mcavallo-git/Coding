# ------------------------------------------------------------
#
# PowerShell
#   File Extension handling in Windows 10
#
# ------------------------------------------------------------
#
# RUN THIS SCRIPT (VIA POWERSHELL):
#
#   . "$($Env:USERPROFILE)\Documents\GitHub\Coding\powershell\PowerShell - Filetype Associations.ps1"
#
#
# ------------------------------------------------------------
If ($False) { # EXPORT CURRENT SETTINGS

cd %USERPROFILE%\Desktop
Dism /Online /Export-DefaultAppAssociations:AppAssoc.xml
Notepad AppAssoc.xml

}
# ------------------------------------------------------------


CMD /C 'MKLINK "%ProgramFiles%\Microsoft VS Code\bin\VSCode-Workspace.vbs" "%USERPROFILE%\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs"'

If (Test-Path "$($Env:ProgramFiles)\Microsoft VS Code\bin\VSCode-Workspace.bat") {
Remove-Item -Path ("$($Env:ProgramFiles)\Microsoft VS Code\bin\VSCode-Workspace.bat") -Force;
}


$FileExt=".log";

# $OpenExtensionWith='"C:\Program Files\Microsoft VS Code\Code.exe" "%1"'; # Open w/ VS Code, always

# $OpenExtensionWith="`"$($Env:ProgramFiles)\Microsoft VS Code\Code.exe`" `"$($Env:USERPROFILE)\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";

# $OpenExtensionWith="`"%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";

# $OpenExtensionWith="`"%ProgramFiles%\Microsoft VS Code\bin\VSCode-Workspace.bat`" `"%1`"";

$OpenExtensionWith="`"%ProgramFiles%\Microsoft VS Code\bin\VSCode-Workspace.vbs`" `"%1`"";

$UserSid = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});


### NEED (MAYBE?) TO CREATE EXTENSION IN  [ HKEY_LOCAL_MACHINE\SOFTWARE\Classes ] --> Note: that it seems to be populated from HKCR  (as-of 20191230-074934)


### HKEY_CLASSES_ROOT
$HKCR_Key="Registry::HKEY_CLASSES_ROOT\${FileExt}\shell\open\command";
New-Item -Path ($HKCR_Key) -Force; # Note: The -Force is used to create any/all missing parent registry keys
New-ItemProperty -Path ($HKCR_Key) -Name ("(Default)") -PropertyType ("String") -Value ($OpenExtensionWith) -Force;


### NEED TO DELETE EXTENSION IN  [ Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts ]


### NEED TO DELETE EXTENSION IN  [ Registry::HKEY_USERS\${UserSid}\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts ]
### NEED TO POSSIBLY-INSTEAD, UPDATE PROPERTY @  [ Registry::HKEY_USERS\${UserSid}\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\${FileExt}\OpenWithList ]  --> Property "a" to hold value "xyz.bat" "%1"


### HKEY_USERS
$HKU_Classes_Key="Registry::HKEY_USERS\${UserSid}_Classes\${FileExt}_auto_file\shell\open\command";
New-Item -Path ($HKU_Classes_Key) -Force; # Note: The -Force is used to create any/all missing parent registry keys
New-ItemProperty -Path ($HKU_Classes_Key) -Name ("(Default)") -PropertyType ("String") -Value ($OpenExtensionWith) -Force;

$HKU_Key="Registry::HKEY_USERS\${UserSid}\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\${FileExt}\OpenWithList";
New-Item -Path ($HKU_Key) -Force; # Note: The -Force is used to create any/all missing parent registry keys
New-ItemProperty -Path ($HKU_Key) -Name ("a") -PropertyType ("String") -Value ($OpenExtensionWith) -Force;
New-ItemProperty -Path ($HKU_Key) -Name ("MRUList") -PropertyType ("String") -Value ("a") -Force;


Exit 0;





# ------------------------------------------------------------
#
# PowerShell
#   File Extension handling in Windows 10
#
#                                MCavallo, 2019-06-20_13-20-50
# ------------------------------------------------------------

# Get User-SID (Security Identifier) for current user
$UserSid = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});

# Get some info regarding current environment
$LogSettingsToDesktop = $False;
If ($LogSettingsToDesktop -Ne $False) {
	$CMD="assoc";  $OUT="${Env:USERPROFILE}\Desktop\cmd.${CMD}.log"; cmd /c "${CMD} > ${OUT} & ${OUT}"; # ASSOC --> .ext=fileType
	$CMD="ftype";  $OUT="${Env:USERPROFILE}\Desktop\cmd.${CMD}.log"; cmd /c "${CMD} > ${OUT} & ${OUT}"; # FTYPE --> fileType=openCommandString
	$CMD="whoami"; $OUT="${Env:USERPROFILE}\Desktop\cmd.${CMD}.log"; cmd /c "${CMD} /ALL > ${OUT} & ${OUT}";
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
$UserSid = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }}); `
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
#		blogs.technet.microsoft.com  |  "Windows 8: Associate a file Type or protocol with a specific app using GPO (e.g:default mail client for MailTo protocol) – Behind Windows Setup & Deployment"  |  https://blogs.technet.microsoft.com/mrmlcgn/2013/02/26/windows-8-associate-a-file-type-or-protocol-with-a-specific-app-using-gpo-e-gdefault-mail-client-for-mailto-protocol/
#
#		docs.microsoft.com  |  "RegistryKey Class"  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey
#
#		stackoverflow.com  |  "Get file type description for file extensions"  |  https://stackoverflow.com/a/27646804
#
#		superuser.com  |  "How to associate a file with a program in Windows via CMD [duplicate]"  |  https://superuser.com/a/362080
#
# ------------------------------------------------------------