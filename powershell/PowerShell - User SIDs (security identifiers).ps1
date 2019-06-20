# ------------------------------------------------------------
#
# PowerShell
#   User SIDs (Security Identifiers)
#
#                                MCavallo, 2019-06-20_13-58-45
# ------------------------------------------------------------


# Get User-SID (Security Identifier) for current user
$UserSid = (&{If(Get-Command "WHOAMI" -ErrorAction "SilentlyContinue") { (WHOAMI /USER /FO TABLE /NH).Split(" ")[1] } Else { $Null }});
Write-Host $UserSid;

#
# Note: For CMD, to get the user's SID, run:
#		FOR /f "tokens=2" %A IN ('WHOAMI /USER /FO TABLE /NH') DO @echo %A
#

#
# Note: Get all local (non-domain) user SIDs
#		wmic useraccount get * /format:list
#
