# ------------------------------------------------------------
#
# PowerShell - Array.Count, Hashtable.Count - Get the length, size, count, etc. of a hash-table, array, object, etc.
#
# ------------------------------------------------------------
#
# Hash Tables (Objects)  -  "Hashtable.Count Gets the number of key/value pairs contained in the Hashtable" -Microsoft
#

@{ a=1; b=2 }.Count;  # Returns 2


# ------------------------------------------------------------
#
# Arrays  -  "To determine how many items are in an array, use the Length property or its Count alias. Longlength is useful if the array contains more than 2,147,483,647 elements."  - Microsoft
#

@(1,3).Count;  # Returns 2

@(1..500).Count;  # Returns 500

"String".Count;  # Returns 1  ⚠️ Avoid using the [ .Count ] method on strings ⚠️


# ------------------------------------------------------------
#
# Strings  -  Use String.Length to return the number of characters in a string variable
#

"String".Length; # Returns 6


# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "Hashtable.Count Property"  |  https://docs.microsoft.com/en-us/dotnet/api/system.collections.hashtable.count
#
#		docs.microsoft.com  |  "About Arrays"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-6#count-or-length-or-longlength
#
# ------------------------------------------------------------