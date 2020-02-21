# ------------------------------------------------------------

$FullPath = "${Home}";

$Dirname = (Split-Path -Path (${FullPath}) -Parent);

$Basename = (Split-Path -Path (${FullPath}) -Leaf);


# ------------------------------------------------------------
### Current runtime script's directory / basename

$ThisDir = (Split-Path -Path ($MyInvocation.MyCommand.Path) -Parent);

$ThisScript = (Split-Path -Path ($MyInvocation.MyCommand.Name) -Leaf);


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Split-Path - Returns the specified part of a path"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/split-path
#
# ------------------------------------------------------------