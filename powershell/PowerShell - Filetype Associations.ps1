
#
# Lookup associations for a given file-extenson
#

$FileExtension = ".ahk";
$ExtensionProperties = (Get-ItemProperty (("Registry::HKEY_Classes_root\")+(${FileExtension})));
$ExtensionAssociations = @{
	Extension = $ExtensionProperties.PSChildName;
	ContentType = $ExtensionProperties.("Content Type");
	PerceivedType = $ExtensionProperties.PerceivedType;
	FileType = $ExtensionProperties.("(default)");
};
$ExtensionAssociations;

Write-Host -NoNewLine "`n`nPress any key to exit...";
$KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Exit 0;




# IN-PROGRESS:

# Resolve all file-extensions to their relative file-types
cmd /c assoc | more > %USERPROFILE%\Desktop\assoc.more.log;

Get-ChildItem -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts" | Select-Object {
	$_ | Format-List;
}




#
#	Citation(s)
#
#		Thanks to StackExchange user [ Frode F. ] on forum [ https://stackoverflow.com/questions/27645850 ]
#
#		Thanks to StackExchange user [ Keltari ] on forum [ https://superuser.com/questions/362063 ]
#
