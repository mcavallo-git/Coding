# ------------------------------------------------------------
#
# PowerShell
#   |--> Get PowerShell's Version Number
#
# ------------------------------------------------------------

Write-Output "PowerShell v$(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10))";


# ------------------------------------------------------------

# As a Variable
$PowerShellVersion=$(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10));
Write-Output "PowerShell v$PowerShellVersion";


# ------------------------------------------------------------