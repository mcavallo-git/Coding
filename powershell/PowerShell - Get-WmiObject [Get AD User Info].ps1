
# PowerShell - Get Info regarding current user which is held in Active Directory

$user2Find = ($Env:USERNAME);

$query = "SELECT * FROM ds_user where ds_sAMAccountName='$user2find'";

$user = Get-WmiObject -Query $query -Namespace "root\Directory\LDAP";

$user;

# $user.DS_userPrincipalName;
# $user.DS_mail;
# $user.DS_name;
