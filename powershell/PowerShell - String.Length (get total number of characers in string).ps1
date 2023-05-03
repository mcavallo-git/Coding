# ------------------------------------------------------------
# PowerShell - String.Length (get total number of characers in string)
# ------------------------------------------------------------
#
# Use [ String.Length ] to return the number of characters in a string variable
#
"String".Length; # Returns 6


#
# Use [ String.Count ] to return the number of elements in an array or custom-typed variable
#
@("S","t","r","i","n","g").Count;  # Returns 6
"String".Count;  # Returns 1  ⚠️ Avoid using the [ .Count ] method on strings ⚠️


# ------------------------------------------------------------
#
# Citation(s)
#
#   shellgeek.com  |  "String Length of Variable in PowerShell - ShellGeek"  |  https://shellgeek.com/string-length-of-variable-in-powershell/
#
# ------------------------------------------------------------