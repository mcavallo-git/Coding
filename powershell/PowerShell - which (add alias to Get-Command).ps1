# PowerShell - which (add alias to Get-Command)
"`nNew-Alias which Get-Command;" | Add-Content ${Profile};

# PowerShell - Quick-Import
"`nNew-Alias ImportMods ((`$HOME)+(`"\Documents\WindowsPowerShell\Modules\ImportModules.ps1`"));`nImportMods;" | Add-Content ${Profile};
