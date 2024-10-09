# ------------------------------------------------------------
#
# PowerShell - Select-String
#
# ------------------------------------------------------------


<# Select-String (case IN-sensitive) #>
Write-Output "Line 1" "Line 2" "Line 3" "Line 4" "Line 5" | Select-String -Pattern '^[a-z]';  # Returns all lines


<# Select-String (case SENSITIVE) #>
Write-Output "Line 1" "Line 2" "Line 3" "Line 4" "Line 5" | Select-String -CaseSensitive -Pattern '^[a-z]';  # Returns ""


<# Select-String using Regex matching w/ Capture Groups (requires a Dockerfile) #>
( Get-Content "_PATH_TO\Dockerfile" | Select-String -Pattern '^FROM (.+) as base' | Select-Object -First 1 | ForEach-Object { ${_}.Matches.Captures.Groups[1].Value } );


<# Using "-Context PRE,POST" to get the lines before/after a matched line #>
Write-Output "Line 1" "Line 2" "Line 3" "Line 4" "Line 5" `
| Select-String -Pattern '^Line 3$' -Context 1,1 `
| ForEach-Object {
Write-Host "`$_.Context.PreContext:   $($_.Context.PreContext)";
Write-Host "`$_.Line:                 $($_.Line)";
Write-Host "`$_.Context.PostContext:  $($_.Context.PostContext)";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Select-String (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/select-string
#
#   stackoverflow.com  |  "powershell - How to Select-String multiline? - Stack Overflow"  |  https://stackoverflow.com/a/55374303
#
# ------------------------------------------------------------