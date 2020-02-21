# ------------------------------------------------------------

$FullPath = "${Home}";

# Directory Path-Component
$Dirname = (Split-Path -Path ("${FullPath}") -Parent);

# Filename Path-Component
$Basename = (Split-Path -Path ("${FullPath}") -Leaf);

Write-Host "`n  `$FullPath = `"${FullPath}`"`n  `$Dirname  = `"${Dirname}`"`n  `$Basename = `"${Basename}`"`n";


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