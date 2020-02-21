# ------------------------------------------------------------

$FullPath = "${Home}";
Write-Host "`$FullPath = `"${FullPath}`"";

# Directory Path-Component
$Dirname = (Split-Path -Path (${FullPath}) -Parent);
Write-Host "`$Dirname = `"${Dirname}`"";

# Filename Path-Component
$Basename = (Split-Path -Path (${FullPath}) -Leaf);
Write-Host "`$Basename = `"${Basename}`"";


# ------------------------------------------------------------
# Ex) Get Current runtime script's directory / basename

$ThisDir = (Split-Path -Path ($MyInvocation.MyCommand.Path) -Parent);

$ThisScript = (Split-Path -Path ($MyInvocation.MyCommand.Name) -Leaf);


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Split-Path - Returns the specified part of a path"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path
#
# ------------------------------------------------------------