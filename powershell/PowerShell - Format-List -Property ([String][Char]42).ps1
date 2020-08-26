
#   ! ! !   FORMAT-LIST WORKS VERY DIFFERENTLY IF YOU USE AN ASTERISK (ASCII CHAR 42) JUST AFTER IT, WHICH CAUSES IT TO SHOW ALL PROPERTIES OF TARGET OBJECT   ! ! !


# Run this quick test, yourself:


# Less results (not showing all properties)

Get-Item "${Home}" | Format-List;



# More results (showing all properties)

Get-Item "${Home}" | Format-List *;

Get-Item "${Home}" | Format-List -Property ([String][Char]42); <# These two commands are the same #>


<# Note: For file-naming simplification (mainly to avoid possible unintended issues), I used char-42 in the filename for this demo file to avoid putting glob-wildcards in its filename (e.g. the asterisk "*")  #>


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Format-List - Formats the output as a list of properties in which each property appears on a new line."  |  https://docs.microsoft.com/en-us/powershell/module/Microsoft.PowerShell.Utility/Format-List?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-Item - Gets the item at the specified location"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-item?view=powershell-5.1
#
#   stackoverflow.com  |  "file - Removing path and extension from filename in powershell - Stack Overflow"  |  https://stackoverflow.com/a/32634452
#
# ------------------------------------------------------------