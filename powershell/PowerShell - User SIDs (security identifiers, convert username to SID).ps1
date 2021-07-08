# ------------------------------------------------------------
#
# Windows (PowerShell/CMD) - Get User SIDs (Security Identifiers)
#
# ------------------------------------------------------------


# Get current user's SID (Security Identifier)
((whoami /user /fo table /nh).Split(" ")[1]);

# Get current user's SID (Security Identifier) - Long/drawn-out method
$UserSID=(&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});
Write-Host $UserSID;


# ------------------------------

# Convert UserSID --> Username/Domain/etc.
cmd /c "wmic useraccount where sid='$((whoami /user /fo table /nh).Split(" ")[1])' get * /format:list"


# ------------------------------

# Convert Username/Domain --> UserSID
???


# ------------------------------

#
# Note: For CMD, to get the user's SID, run:
#		FOR /f "tokens=2" %A IN ('whoami /user /fo table /nh') DO @echo %A
#

#
# Note: Get all local (non-domain) user SIDs
#		wmic useraccount get * /format:list
#


# ------------------------------------------------------------

# Store as a variable
$UserSID=(&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});
Write-Host $UserSID;


# ------------------------------------------------------------


# Get local user info (Username, SID, etc.) via wmic
wmic useraccount get name,fullname,sid


# Get local user info (Username, SID, etc.) via PowerShell method(s)
$SidToLookup = ((whoami /user /fo table /nh).Split(" ")[1]);
Get-LocalUser -SID "${SidToLookup}" | Format-List


# 
# $namequery = "'name=${Env:USERNAME}'";(wmic useraccount where $namequery get sid);
# 
# (wmic useraccount where name="${Env:USERNAME}" and domain="${Env:USERDOMAIN}" get sid);
# 

# ------------------------------------------------------------


# Get domain user info (Username, SID, etc.)
nltest /dclist:${Env:USERDOMAIN};
nltest /dsgetdc:${Env:USERDOMAIN};
wmic /node:"ACQUIRE_FROM_PREVIOUS" /user:"${Env:USERDOMAIN}\${Env:USERNAME}" useraccount get name,fullname,sid;

# ------------------------------------------------------------
#
#   cmd - whoami (displays user, group and privileges information (including SIDs) for current user)
#
# ------------------------------------------------------------

# Syntax
#     /upn           Displays the user name in user principal name (UPN) format.
#     /fqdn          Displays the user name in fully qualified domain name (FQDN) format.
#     /logonid       Displays the logon ID of the current user.
#     /user          Displays the current domain and user name and the security identifier (SID).
#     /groups        Displays the user groups to which the current user belongs.
#     /priv          Displays the security privileges of the current user.
#     /fo <Format>   Specifies the output format. Valid values include:
#            table   Displays output in a table. This is the default value.
#            list    Displays output in a list.
#            csv     Displays output in comma-separated value (CSV) format.
#     /all           Displays all information in the current access token, including the current user name, security identifiers (SID), privileges, and groups that the current user belongs to.
#     /nh            Specifies that the column header should not be displayed in the output. This is valid only for table and CSV formats.
#     /?             Displays help at the command prompt.
whoami [/upn | /fqdn | /logonid]
whoami {[/user] [/groups] [/priv]} [/fo <Format>] [/nh]
whoami /all [/fo <Format>] [/nh]


# Get ALL the info! (about current user)
whoami /all


# Show domain\username
whoami


# Show AD groups to determine which other users exist in said group(s)
whoami /groups /fo table /nh
# Note:  Do not include domain name in GROUPNAME
net group GROUPNAME /domain


# ------------------------------------------------------------

# Store list of current session's [ user, group and privileges information ] on a file on the desktop
whoami /USER /FO TABLE /NH 1>"%USERPROFILE%\Desktop\cmd.whoami.log"
notepad "%USERPROFILE%\Desktop\cmd.whoami.log"


# Example) Get User Info (including SID, via CMD)
whoami /user /fo table /nh


# Example) Get User SID (via PowerShell)
$UserSID = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});
Write-Host $UserSID;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "whoami - Displays user, group and privileges information for the user who is currently logged on to the local system"  |  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/whoami
#
# ------------------------------------------------------------

# ------------------------------------------------------------