# ------------------------------------------------------------
#
# PowerShell
#   User SIDs (Security Identifiers)
#
#                                MCavallo, 2019-06-20_13-58-45
# ------------------------------------------------------------


# Get User-SID (Security Identifier) for current user
$UserSID = (&{If(Get-Command "whoami" -ErrorAction "SilentlyContinue") { (whoami /user /fo table /nh).Split(" ")[1] } Else { $Null }});
Write-Host $UserSID;

#
# Note: For CMD, to get the user's SID, run:
#		FOR /f "tokens=2" %A IN ('whoami /user /fo table /nh') DO @echo %A
#

#
# Note: Get all local (non-domain) user SIDs
#		wmic useraccount get * /format:list
#
