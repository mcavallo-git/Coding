# ------------------------------------------------------------
#
# (Powershell)  -EA ___ vs.  -ErrorAction ___  (and associated equivalencies (==))
#

-EA 0   ==   -ErrorAction SilentlyContinue

-EA 1   ==   -ErrorAction Stop

-EA 2   ==   -ErrorAction Continue

-EA 3   ==   -ErrorAction Inquire

# -----

-EA:0   ==   -ErrorAction:SilentlyContinue

-EA:1   ==   -ErrorAction:Stop

-EA:2   ==   -ErrorAction:Continue

-EA:3   ==   -ErrorAction:Inquire


# ------------------------------------------------------------
#
# (Powershell)  $ErrorActionPreference  -  Determines how PowerShell responds to a non-terminating error  -  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables#erroractionpreference
#

If ($True) {
	$Revertable_ErrorActionPreference = $ErrorActionPreference;
	$ErrorActionPreference = ("SilentlyContinue");
	<# Do some action (which requires $ErrorActionPreference to be some value other than default) #>
	$ErrorActionPreference = $Revertable_ErrorActionPreference;
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "What is -ea? - Learn PowerShell - Ask the Experts - IDERA Community"  |  https://community.idera.com/database-tools/powershell/ask_the_experts/f/learn_powershell-12/10510/what-is--ea
#
#   devblogs.microsoft.com  |  "-ErrorAction SilentlyContinue =&gt; -EA 0 - PowerShell Team"  |  https://devblogs.microsoft.com/powershell/erroraction-silentlycontinue-gt-ea-0/
#
#   docs.microsoft.com  |  "about CommonParameters - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_commonparameters#-erroraction
#
#   docs.microsoft.com  |  "about Preference Variables - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_preference_variables#erroractionpreference
#
# ------------------------------------------------------------