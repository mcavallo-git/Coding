
#
# Lookup associations for a given file-extenson
#
$FileExtension = ".txt";
$ExtensionProperties = (Get-ItemProperty (("Registry::HKEY_Classes_root\")+(${FileExtension})));
$ExtensionAssociations = @{
	Extension = $ExtensionProperties.PSChildName;
	ContentType = $ExtensionProperties.("Content Type");
	PerceivedType = $ExtensionProperties.PerceivedType;
	FileType = $ExtensionProperties.("(default)");
};
$ExtensionAssociations;

#
#	Citation(s)
#
#		Thanks to StackOverflow user [ Frode F. ] on forum [ https://stackoverflow.com/questions/27645850 ]
#
