
# PowerShell - Add Specific [ Domain/User ] to the Local Administrators group

$Target_Domain = "DOMAIN";
$Target_User = "USERNAME";

$LocalAdministrators = [ADSI](("WinNT://")+($Env:COMPUTERNAME)+("/administrators,group"));

$LocalAdministrators.add(("WinNT://")+($Target_Domain)+("/")+($Target_User)+(",user"));
