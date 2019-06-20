# ------------------------------------------------------------
#
# PowerShell
#   User SIDs (Security Identifiers)
#
#                                MCavallo, 2019-06-20_13-58-45
# ------------------------------------------------------------


# Get User-SID (Security Identifier) for current user
$UserSid = (cmd /c "FOR /f `"tokens=2`" %A IN ('WHOAMI /USER /FO TABLE /NH') DO @echo %A");
$UserSid;


# Get all local (non-domain) user SIDs
#		wmic useraccount get * /format:list