
#
# Aliases (PowerShell)
#



#
# Ex) Set an alias to a command & save it to ${Profile} (for next startup)
#
"`nNew-Alias which Get-Command;" | Add-Content ${Profile};



#
# Ex) Set an alias to a filepath & save it to ${Profile} (for next startup)
#
"`nNew-Alias ImportMods ((`$HOME)+(`"\Documents\WindowsPowerShell\Modules\ImportModules.ps1`"));`nImportMods;" | Add-Content ${Profile};



#
#	Citation(s)
#
#		docs.microsoft.com
#			"New-Alias"
#			 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/new-alias
#
