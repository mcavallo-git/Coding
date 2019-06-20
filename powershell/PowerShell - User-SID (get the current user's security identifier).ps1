# ------------------------------------------------------------
#
# PowerShell
#   Get User-SID (Security Identifier) for current user
#
#                                MCavallo, 2019-06-20_13-58-45
# ------------------------------------------------------------

$UserSid = (cmd /c "FOR /f `"tokens=2`" %A IN ('WHOAMI /USER /FO TABLE /NH') DO @echo %A");
$UserSid;
