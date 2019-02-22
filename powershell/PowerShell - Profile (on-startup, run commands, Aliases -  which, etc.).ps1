
$Pro = @{};

$Pro.Which = "New-Alias which Get-Command;";

$Pro.ImportMods = "New-Alias ImportMods `"~\Documents\WindowsPowerShell\Modules\ImportModules.ps1`"; ImportMods;";

Foreach ($k In ($Pro.Keys)) { If (!(Get-Content $Profile | Select-String $Pro[$k].Replace("\", "\\"))) { (("`n")+($Pro[$k])) | Add-Content ${Profile}; } }
