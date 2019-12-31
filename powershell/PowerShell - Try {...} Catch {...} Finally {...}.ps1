# ------------------------------------------------------------
#
# PowerShell - Try {...} Catch {...} Finally {...}
#
#
# ------------------------------------------------------------


Try {
	$RegistryProp = Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Select-Object -ExpandProperty $Value -ErrorAction Stop;
} Catch {
	$RegistryProp = $Null;
} Finally {
	Write-Host "`$RegistryProp:";
	$RegistryProp;
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "About Try Catch Finally"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally
#
#   jonathanmedd.net  |  "Testing for the Presence of a Registry Key and Value"  |  https://www.jonathanmedd.net/2014/02/testing-for-the-presence-of-a-registry-key-and-value.html
#
# ------------------------------------------------------------