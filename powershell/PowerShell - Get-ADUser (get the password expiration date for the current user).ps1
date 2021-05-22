# ------------------------------------------------------------
#
# PowerShell - Get-ADUser (get the password expiration date for the current user)
#
# ------------------------------------------------------------

<# One-Liner - Get password expiration date for current user  #>
If (-Not (Get-Command "Get-ADUser" -ErrorAction SilentlyContinue)) { <# Install RSAT Tools if they're not already installed ( needed for function "Get-ADUser" ) #> PowerShell -Command "Start-Process -Filepath ('C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe') -ArgumentList ('-Command Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online;') -Verb 'RunAs' -Wait -PassThru | Out-Null;"; }; If (Get-Command "Get-ADUser" -ErrorAction SilentlyContinue) { <# Get current user's password expiration Date#> Get-ADUser "${Env:USERNAME}" -Server "${Env:USERDNSDOMAIN}" –Properties "UserPrincipalName","msDS-UserPasswordExpiryTimeComputed" | Select-Object -Property "UserPrincipalName",@{Name="ExpiryDate";Expression={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}; };


# ------------------------------------------------------------
#
# Citation(s)
#
#   activedirectorypro.com  |  "How to Get AD Users Password Expiration Date"  |  https://activedirectorypro.com/how-to-get-ad-users-password-expiration-date/
#
#   docs.microsoft.com  |  "Get-ADUser (ActiveDirectory) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/activedirectory/get-aduser?view=windowsserver2019-ps
#
# ------------------------------------------------------------