# ------------------------------------------------------------
#
# PowerShell
#   |--> Get the installed version of PowerShell
#
# ------------------------------------------------------------


# pwsh (PowerShell Core) has a build-in method for checking versioning (thankfully)
pwsh --version;


# PowerShell has no simple way to get its version (especially not from external sources, sadly)
PowerShell -Command "Write-Output ((Write-Output PowerShell)+([String][Char]32)+(((GV PSVersionTable).Value).PSVersion.Major)+(Write-Output .)+(((GV PSVersionTable).Value).PSVersion.Minor))";


# ------------------------------------------------------------
#
# Get the version of PowerShell (for the current/running PowerShell session)


#
#  Format:   Major.Minor.Patch
#
$PSV="";If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Major)){$PSV+=(${PSVersionTable}.PSVersion.Major);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Minor)){$PSV+="."; $PSV+=(${PSVersionTable}.PSVersion.Minor);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Patch)){$PSV+="."; $PSV+=(${PSVersionTable}.PSVersion.Patch);};};};Write-Output "PowerShell ${PSV}"; # Get the version of PowerShell with the format [ Major.Minor.Patch ]


#
#  Format:   Major.Minor
#
$PSV="";If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Major)){$PSV+=(${PSVersionTable}.PSVersion.Major);If(-Not [String]::IsNullOrEmpty(${PSVersionTable}.PSVersion.Minor)){$PSV+="."; $PSV+=(${PSVersionTable}.PSVersion.Minor);};};Write-Output "PowerShell ${PSV}"; # Get the version of PowerShell with the format [ Major.Minor ]


# ------------------------------------------------------------