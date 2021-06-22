# ------------------------------------------------------------
#
# PowerShell - Strings   -->   Set a string variable without using quotation characters
#

# Method 1 (Best) - More compact
SV StringVar String` without` quotes` and` with` spaces;
GV StringVar;

# Method 2 - Less compact
SV StringVar -Value (Write-Output String` without` quotes` and` with` spaces);
GV StringVar;


# ------------------------------------------------------------
#
# PowerShell - Booleans   -->   Set a boolean variable without using dollar sign characters for $True and $False
#

# Set a variable to $False without using dollar signs
SV BooleanFalse ([Boolean](0));
GV BooleanFalse;


# Set a variable to $True without using dollar signs
SV BooleanTrue ([Boolean](1));
GV BooleanTrue;


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