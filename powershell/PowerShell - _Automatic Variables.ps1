
$MyInvocation.MyCommand.Name; # Current Function / File (w/ extension)

[IO.Path]::GetFileNameWithoutExtension($MyInvocation.MyCommand.Name); # Removes Extension

# See Citation(s) (Below) - especially docs.microsoft.com


# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "About Automatic Variables"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_automatic_variables
#
#		ss64.com  |  "Automatic Variables"  |  https://ss64.com/ps/syntax-automatic-variables.html
#
# ------------------------------------------------------------