
# Set-Content (overwrite or append target file's contents).ps1


# Ex) Create a test file on the desktop and run it
Set-Content -Path ("${Env:UserProfile}\Desktop\test.ps1") -Value ("Split-Path `$PSCommandPath");
. "${Env:UserProfile}\Desktop\test.ps1";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Set-Content - Writes new content or replaces existing content in a file"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/set-content?view=powershell-5.1
#
# ------------------------------------------------------------