
#	PowerShell - @().Count and @{}.Count - Get the length, size, count, etc. of a hash-table, array, object, etc.


@{ a=1; b=2 }.Count; <# "Hashtable.Count Gets the number of key/value pairs contained in the Hashtable" #>


@(1,3).Count; <# "To determine how many items are in an array, use the Length property or its Count alias" #>

# ------------------------------------------------------------
#
#	Citation(s)
#
#		docs.microsoft.com  |  "Hashtable.Count Property"  |  https://docs.microsoft.com/en-us/dotnet/api/system.collections.hashtable.count
#
#		docs.microsoft.com  |  "About Arrays"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arrays?view=powershell-6#count-or-length-or-longlength
#
# ------------------------------------------------------------
