

Write-Host "Vibs_Valid:";
$ValidExtraVibs `
| Sort-Object -Property Name -Unique `
| Sort-Object -Property Name,@{Expression={$_.Version}; Ascending=$False} `
| Select-Object -Property Name,Version


# ------------------------------------------------------------
#
#	Citation(s)
#
#   stackoverflow.com  |  "select distinct items from a column in powershell"  |  https://stackoverflow.com/a/8439487
#
#   social.technet.microsoft.com  |  "sort-object multiple properties - use descending first RRS feed"  |  https://social.technet.microsoft.com/Forums/windowsserver/en-US/e2067689-d28b-4455-9a05-d933e31ab311/sortobject-multiple-properties-use-descending-first?forum=winserverpowershell
#
# ------------------------------------------------------------