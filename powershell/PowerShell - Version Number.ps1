#
# PowerShell
# 	|--> Version Number
#

# As a Variable
$PowerShellVersion=$(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10));
Write-Output "PowerShell v$PowerShellVersion";

# Show in one-line:
Write-Output "PowerShell v$(($($PSVersionTable.PSVersion.Major))+($($PSVersionTable.PSVersion.Minor)/10))";
