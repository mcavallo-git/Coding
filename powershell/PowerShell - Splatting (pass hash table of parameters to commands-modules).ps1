# ------------------------------------------------------------
#
# PowerShell - Use "splatting" to pass command parameters
#


# Splatting --> Shorter Example
$P=@{Object="`nParameter splatting demo - Passing parameters to the [ Write-Host ] command`n";ForegroundColor="Yellow";BackgroundColor="Magenta"}; Write-Host @P;


# Splatting --> Longer Example
If ($True) {
$WriteHost_SplatParams = @{};
$WriteHost_SplatParams.("Object")=("`nParameter splatting demo - Passing parameters to the [ Write-Host ] command`n");
$WriteHost_SplatParams.("ForegroundColor")=("Yellow");
$WriteHost_SplatParams.("BackgroundColor")=("Magenta");
$WriteHost_SplatParams_AsString = (($WriteHost_SplatParams.Keys | ForEach-Object { Write-Output "-$(${_})"; Write-Output "`"$(${WriteHost_SplatParams}[${_}])`""; }) -replace "`n","``n" -join " ");
Write-Host "Calling [ Write-Host ${WriteHost_SplatParams_AsString}; ]...";
Write-Host @WriteHost_SplatParams;
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "about Splatting - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_splatting
#
#   docs.microsoft.com  |  "Write-Host (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host
#
# ------------------------------------------------------------