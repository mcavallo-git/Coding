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

$max_keys = 5; 
$i=0;
Get-ChildItem -Path "Registry::${Registry_FileExtensions_B}" `
| ForEach-Object {

	$i++;

	If ($i -le $max_keys) {

		Write-Host "`n------------------------------------------------------------";
		Write-Host ($_.GetType());
		Write-Host (("Registry Path:  ")+($_.Name));
		Write-Host (("SubKeyCount:")+($_.SubKeyCount)+(", ")+("ValueCount:")+($_.ValueCount));
		Write-Host "`$_ Properties: "; $_ | Format-List -Property *;
		If ($_.OpenWithProgids -ne $Null) {
			Write-Host "`$_.OpenWithProgids: "; $_.OpenWithProgids;
		}

	}
}

Write-Host "`n------------------------------------------------------------";

Write-Host "`n`n";


# $FileExtension = ".ahk";
# $ExtensionProperties = (Get-ItemProperty (("Registry::HKEY_CLASSES_ROOT\")+(${FileExtension})));
# $ExtensionAssociations = @{
# 	Extension = $ExtensionProperties.PSChildName;
# 	ContentType = $ExtensionProperties.("Content Type");
# 	PerceivedType = $ExtensionProperties.PerceivedType;
# 	FileType = $ExtensionProperties.("(default)");
# };
# $ExtensionAssociations;


# Write-Host -NoNewLine "`n`nPress any key to exit...";
# $KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
# Exit 0;


# ------------------------------------------------------------
#
# Note(s)
#
#		- Registry keys are of type [ Microsoft.Win32.RegistryKey ]
#
# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  https://docs.microsoft.com/en-us/dotnet/api/microsoft.win32.registrykey
#
#		stackoverflow.com  |  https://stackoverflow.com/questions/27645850  |  Thanks to StackExchange user [ Frode F. ]
#
#		superuser.com  |  https://superuser.com/questions/362063  |  Thanks to StackExchange user [ Keltari ]
#
# ------------------------------------------------------------