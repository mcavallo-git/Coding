# ------------------------------------------------------------
#
# PowerShell - Use "splatting" to pass command parameters
#

$WriteHost_SplatParams = @{};
$WriteHost_SplatParams.("Object")=("`n""Parameter splatting demo - Passing parameters to the [ Write-Host ] command""`n");
$WriteHost_SplatParams.("ForegroundColor")=("Yellow");
$WriteHost_SplatParams.("BackgroundColor")=("Magenta");
Write-Host @WriteHost_SplatParams;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "about Splatting - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting
#
#   docs.microsoft.com  |  "Write-Host (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host
#
# ------------------------------------------------------------