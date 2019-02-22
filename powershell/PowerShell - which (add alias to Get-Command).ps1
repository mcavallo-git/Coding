# PowerShell - which (add alias to Get-Command)
"`nNew-Alias which Get-Command;" | Add-Content ${Profile};

# PowerShell - Quick-Import
"`nNew-Alias ImportMods ((`$HOME)+(`"\Documents\WindowsPowerShell\Modules\ImportModules.ps1`"));`nImportMods;" | Add-Content ${Profile};


$Path = "C:\temp"
$Text = "This is the data that I am looking for"
$PathArray = @()
$Results = "C:\temp\test.txt"