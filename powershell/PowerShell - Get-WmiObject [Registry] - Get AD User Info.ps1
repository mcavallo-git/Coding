# ------------------------------------------------------------
#
# PowerShell
#		|--> Get Info regarding current user which is held in Active Directory
# 	|--> Potentially shows all (accessible) Office365/Azure Active-Directory related attributes/properties, as well (need to verify this against control-case -MCavallo, 2019-09-04) 
#


Get-WmiObject -Query "SELECT * FROM ds_user WHERE ds_sAMAccountName='${Env:USERNAME}'" -Namespace "root\Directory\LDAP";


#
# nltest /dclist:${Env:USERDOMAIN};
# nltest /dsgetdc:${Env:USERDOMAIN};
#
# $ResultsnAD.DS_userPrincipalName;
# $ResultsnAD.DS_mail;
# $ResultsnAD.DS_name;
#


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject
#
# ------------------------------------------------------------