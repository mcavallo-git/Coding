# ------------------------------------------------------------
#
# PowerShell - [adsi] & [adsiSearcher] type accelerators (Active Directory (AD) search tools - get OU path, AD group memberships)
#
# ------------------------------------------------------------

#
# Get current Windows Device's OU path  ([adsiSearcher])
#
$AD_OU_Path=(([adsiSearcher]("(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))")).FindOne().Properties.distinguishedname);
$AD_OU_Path;

#
# Get current Windows User's AD group-memberships  ([adsi] + [adsiSearcher])
#
$AD_OU_Path = (([adsiSearcher]("(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))")).FindOne().Properties.distinguishedname);
$AD_Group = [adsi]"LDAP://$AD_OU_Path";
$AD_Group.Member | ForEach-Object { $Searcher = [adsiSearcher]"(distinguishedname=$_)"; $Searcher.FindOne().Properties; };


# ------------------------------------------------------------
#
# Citation(s)
#
#   alkanesolutions.co.uk  |  "The Difference Between ADSI and ADSISearcher | Alkane"  |  https://www.alkanesolutions.co.uk/2021/02/25/the-difference-between-adsi-and-adsisearcher/
#
#   devblogs.microsoft.com  |  "Use the PowerShell [adsiSearcher] Type Accelerator to Search Active Directory | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/use-the-powershell-adsisearcher-type-accelerator-to-search-active-directory/
#
#   stackoverflow.com  |  "active directory - Get current computer's distinguished name in powershell without using the ActiveDirectory module - Stack Overflow"  |  https://stackoverflow.com/a/11146959
#
#   stackoverflow.com  |  "Getting AD Group Membership ADSI using PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/45353275
#
# ------------------------------------------------------------