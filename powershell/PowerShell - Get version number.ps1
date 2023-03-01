# ------------------------------------------------------------
#
# PowerShell
#   |--> Get the installed version of PowerShell
#
# ------------------------------------------------------------


# pwsh (PowerShell Core) has a built-in method for checking versioning (thankfully)
pwsh --version;


# PowerShell has no simple way to get its version (especially not from external sources, sadly)
PowerShell -Command 'Write-Output ((Write-Output PowerShell)+([String][Char]32)+(((GV PSVersionTable).Value).PSVersion.Major)+(Write-Output .)+(((GV PSVersionTable).Value).PSVersion.Minor))';


# ------------------------------------------------------------
#
# Get the version of PowerShell (for the current/running PowerShell session)


#
#  Format:   Major.Minor.Build (PowerShell)  /  Major.Minor.Patch  (pwsh)
#
$Version="";If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Major)){$Version+=(${PSVersionTable}.PSVersion.Major);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Minor)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Minor);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Patch)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Patch);}ElseIf(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Build)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Build);};};};Write-Output "PowerShell ${Version}"; <# Get the version of PowerShell in the format [ ajor.Minor.Build (PowerShell) / Major.Minor.Patch  (pwsh) ] #>


#
#  Format:   Major.Minor
#
$Version="";If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Major)){$Version+=(${PSVersionTable}.PSVersion.Major);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Minor)){$Version+="."; $Version+=(${PSVersionTable}.PSVersion.Minor);};};Write-Output "PowerShell ${Version}"; <# Get the version of PowerShell with the format [ Major.Minor ] #>


# ------------------------------------------------------------