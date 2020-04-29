
# Example for getting a PSCredential object by asking current host to input username and password
$Office365Credential = Get-Credential -Message "Microsoft Office 365 Credentials";


# Example for getting a PSCredential object by asking current host to input password (attempt to pre-populate username)
$Office365Credential = Get-Credential -UserName "$($Env:USERNAME)@$($Env:USERDOMAIN).com" -Message "Microsoft Office 365 Credentials";


Connect-AzureAD -Credential ($Office365Credential) | Format-List;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Credential - Gets a credential object based on a user name and password"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/get-credential?view=powershell-5.1
#
# ------------------------------------------------------------