# ------------------------------------------------------------
#
# PowerShell - Strings   -->   Set a string variable without using quotation characters
#

<# Method 1 (Best) - Compatible with spaces #>
SV StringVar -Value (Write-Output *StringWithoutQuotes*);

<# Method 2 - Incompatible with spaces #>
SV StringVar StringWithoutQuotes;


# ------------------------------------------------------------
#
# PowerShell - Booleans   -->   Set a boolean variable without using dollar sign characters for $True and $False
#

# Set $BooleanFalse / $BooleanTrue to their respective values
SV BooleanFalse ([Boolean](0));
SV BooleanTrue ([Boolean](1));


# ------------------------------------------------------------
#
# PowerShell - Get variable value without using dollar sign charcters during variable name referencing
#
((GV StringVar).Value);
((GV BooleanFalse).Value);
((GV BooleanTrue).Value);


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "Creating String Arrays without Quotes - Power Tips - Power Tips - IDERA Community"  |  https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/creating-string-arrays-without-quotes
#
# ------------------------------------------------------------