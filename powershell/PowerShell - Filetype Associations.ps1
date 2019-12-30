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


Set-Content -NoNewline -Path ("$($Env:ProgramFiles)\Microsoft VS Code\VSCode-Workspace.bat") -Value (Get-Content -Path ("$($Env:USERPROFILE)\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"));


$FileExtension=".log";
# $OpenExtensionWith='"C:\Program Files\Microsoft VS Code\Code.exe" "%1"';
# $OpenExtensionWith="`"$($Env:ProgramFiles)\Microsoft VS Code\Code.exe`" `"$($Env:USERPROFILE)\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";
# $OpenExtensionWith="`"%ProgramFiles%\Microsoft VS Code\Code.exe`" --user-data-dir=`"%APPDATA%\Code`" `"%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";
# $OpenExtensionWith="`"%USERPROFILE%\Documents\GitHub\cloud-infrastructure\.vscode\github.code-workspace`" `"%1`"";
$OpenExtensionWith="`"%ProgramFiles%\Microsoft VS Code\VSCode-Workspace.bat`" --user-data-dir=`"%APPDATA%\Code`" `"%1`"";

$RegEdit_Key="HKCR:\${FileExtension}\shell\open\command";

If ((Test-Path -Path ("HKCR")) -Eq $False) {
	Write-Host "Calling  [ New-PSDrive -Name (`"HKCR`") -PSProvider (`"Registry`") -Root (`"HKEY_CLASSES_ROOT`") | Out-Null; ]";
	New-PSDrive -Name ("HKCR") -PSProvider ("Registry") -Root ("HKEY_CLASSES_ROOT") | Out-Null;
}

Write-Host "Calling  [ New-Item -Path ($($RegEdit_Key)) -Force; ]";
New-Item -Path ($RegEdit_Key) -Force; # Note: The -Force is used to create any/all missing parent registry keys

Write-Host "Calling  [ New-ItemProperty -Path ($($RegEdit_Key)) -Name (`"(Default)`") -PropertyType (`"String`") -Value ($($OpenExtensionWith)) -Force; ]";
New-ItemProperty -Path ($RegEdit_Key) -Name ("(Default)") -PropertyType ("String") -Value ($OpenExtensionWith) -Force;

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

Write-Host "`n`n";

$max_keys = 3; `
$i=0; `
Get-ChildItem -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts" `
| ForEach-Object {
	$i++;
	If ($i -le $max_keys) {
		Write-Host "`n------------------------------------------------------------";
		Write-Host (("Registry Key:  ")+($_.Name));
		Write-Host (("ValueCount:    ")+($_.ValueCount));
		Write-Host (("SubKeyCount:   ")+($_.SubKeyCount));
		Write-Host (("GetType():     ")+($_.GetType()));
		Write-Host -NoNewLine ("Show `"$_`":  "); Show "$_";
		If ($_.OpenWithProgids -ne $Null) {
			Write-Host "`$_.OpenWithProgids: "; $_.OpenWithProgids;
			If ($_.OpenWithProgids.ProgId -ne $Null) {
				Write-Host "`$_.OpenWithProgids.ProgId: "; $_.OpenWithProgids.ProgId;
			}
		}
	}
}

# ------------------------------------------------------------

$max_keys = 3; `
$i=0; `
Get-ChildItem -Path "Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts" `
| ForEach-Object {
	$i++;
	If ($i -le $max_keys) {
		Show $_;
	}
}

# ------------------------------------------------------------

(Get-ItemProperty 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\mailto\UserChoice' -Name ProgId).ProgID

Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice' -name ProgId IE.HTTP
Set-ItemProperty 'HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\https\UserChoice' -name ProgId IE.HTTPS


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