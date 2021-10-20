# ------------------------------------------------------------
#
# PowerShell
#   |--> Get PowerShell's Version Number
#
# ------------------------------------------------------------


# Get the version of Powershell (as a string value (Major.Minor.Patch)
$PSV=""; If ((${PSVersionTable}.PSVersion.Major)) { $PSV+=(${PSVersionTable}.PSVersion.Major); If ((${PSVersionTable}.PSVersion.Minor)) { $PSV+="."; $PSV+=(${PSVersionTable}.PSVersion.Minor); If ((${PSVersionTable}.PSVersion.Patch)) { $PSV+="."; $PSV+=(${PSVersionTable}.PSVersion.Patch); }; }; }; Write-Output "PowerShell v${PSV}";


# Get the version of Powershell (as a decimal/numeric value (Major.Minor, only))
$PSV=$(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10)); Write-Output "PowerShell v${PSV}";


# ------------------------------------------------------------
#
# PowerShell Core has a build-in method for checking versioning
#

pwsh --version;


# ------------------------------------------------------------