# ------------------------------------------------------------
#
# PowerShell
#   |--> Get the installed version of PowerShell
#
# ------------------------------------------------------------


# pwsh (PowerShell Core) has a built-in method for checking versioning (thankfully)
pwsh --version;


# Native PowerShell (v5.1 and lower) has no simple way to get its version (especially not from external sources, sadly)
PowerShell -Command 'Write-Output ((Write-Output PowerShell)+([String][Char]32)+(((GV PSVersionTable).Value).PSVersion.Major)+(Write-Output .)+(((GV PSVersionTable).Value).PSVersion.Minor))';

PowerShell -Command '(gv PSVersionTable).Value';


# ------------------------------------------------------------
#
# Get the version of PowerShell (for the current/running PowerShell session)
#

#
#  Format:   Major.Minor.Build (PowerShell)  /  Major.Minor.Patch  (pwsh)
#
$Version="";If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Major)){$Version+=(${PSVersionTable}.PSVersion.Major);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Minor)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Minor);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Patch)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Patch);}ElseIf(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Build)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Build);};};};Write-Output "PowerShell ${Version}"; <# Get the version of PowerShell in the format [ ajor.Minor.Build (PowerShell) / Major.Minor.Patch  (pwsh) ] #>


#
#  Format:   Major.Minor
#
$Version="";If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Major)){$Version+=(${PSVersionTable}.PSVersion.Major);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Minor)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Minor);};};Write-Output "PowerShell ${Version}"; <# Get the version of PowerShell with the format [ Major.Minor ] #>


# ------------------------------------------------------------

# Open a PowerShell v2 terminal --> Requires Windows Optional Feature ".NET Framework 3.5 (includes .NET 2.0 and 3.0)"

PowerShell.exe -Version 2


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Using the Windows PowerShell 2.0 Engine - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/scripting/windows-powershell/starting-the-windows-powershell-2.0-engine?view=powershell-7.3
#
#   4sysops.com  |  "Differences between PowerShell versions – 4sysops"  |  https://4sysops.com/wiki/differences-between-powershell-versions/
#
# ------------------------------------------------------------