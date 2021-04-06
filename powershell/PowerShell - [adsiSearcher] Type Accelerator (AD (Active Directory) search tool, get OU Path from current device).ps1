# ------------------------------------------------------------
#
# PowerShell - [adsiSearcher] Type Accelerator
#		AD (Active Directory) search tool, get OU Path from current device
#


# Get Current Windows Device's OU Path
If ($True) {
	$filter = "(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))";
	([adsisearcher]$filter).FindOne().Properties.distinguishedname;
}

# Get Current Windows Device's OU Path (one-liner)
(([adsiSearcher]("(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))")).FindOne().Properties.distinguishedname);


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Use the PowerShell [adsiSearcher] Type Accelerator to Search Active Directory | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/use-the-powershell-adsisearcher-type-accelerator-to-search-active-directory/
#
#   stackoverflow.com  |  "active directory - Get current computer's distinguished name in powershell without using the ActiveDirectory module - Stack Overflow"  |  https://stackoverflow.com/a/11146959
#
# ------------------------------------------------------------