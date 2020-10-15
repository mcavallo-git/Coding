

# Set $StringVar to contain a string-typed value of "StringWithoutQuotes"
SV StringVar StringWithoutQuotes; <# Method 1 #>
SV StringVar -Value (Write-Output *StringWithoutQuotes*); <# Method 2 #>


# Set $BooleanFalse / $BooleanTrue to their respective values
SV BooleanFalse ([Boolean](0));
SV BooleanTrue ([Boolean](1));


# Get the values for above variable(s)
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