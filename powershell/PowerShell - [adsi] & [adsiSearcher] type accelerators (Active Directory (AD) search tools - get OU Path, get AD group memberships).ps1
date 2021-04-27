# ------------------------------------------------------------
#
# PowerShell - [adsi] & [adsiSearcher] type accelerators (Active Directory (AD) search tools - get OU Path, get AD group memberships)
#


# Get current Windows Device's OU path
$AD_OU_Path=(([adsiSearcher]("(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))")).FindOne().Properties.distinguishedname);
$AD_OU_Path;


# Get current Windows User's AD group-memberships
$AD_OU_Path = (([adsiSearcher]("(&(objectCategory=computer)(objectClass=computer)(cn=$env:COMPUTERNAME))")).FindOne().Properties.distinguishedname); 
$AD_Group = [adsi]"LDAP://$AD_OU_Path"; 
$AD_Group.Member | ForEach-Object { $Searcher = [adsiSearcher]"(distinguishedname=$_)"; $Searcher.FindOne().Properties; }; 


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Use the PowerShell [adsiSearcher] Type Accelerator to Search Active Directory | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/use-the-powershell-adsisearcher-type-accelerator-to-search-active-directory/
#
#   stackoverflow.com  |  "active directory - Get current computer's distinguished name in powershell without using the ActiveDirectory module - Stack Overflow"  |  https://stackoverflow.com/a/11146959
#
#   stackoverflow.com  |  "Getting AD Group Membership ADSI using PowerShell - Stack Overflow"  |  https://stackoverflow.com/a/45353275
#
#   www.alkanesolutions.co.uk  |  "The Difference Between ADSI and ADSISearcher | Alkane"  |  https://www.alkanesolutions.co.uk/2021/02/25/the-difference-between-adsi-and-adsisearcher/
#
# ------------------------------------------------------------