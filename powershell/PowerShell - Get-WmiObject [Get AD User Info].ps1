
# PowerShell - Get Info regarding current user which is held in Active Directory

$MatchUsername = ($Env:USERNAME);
$QueryAD = "SELECT * FROM ds_user WHERE ds_sAMAccountName='$MatchUsername'";
$ResultsnAD = Get-WmiObject -Query $QueryAD -Namespace "root\Directory\LDAP";

$ResultsnAD;

# $ResultsnAD.DS_userPrincipalName;
# $ResultsnAD.DS_mail;
# $ResultsnAD.DS_name;



# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com, "Get-WmiObject"
#			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1
#


