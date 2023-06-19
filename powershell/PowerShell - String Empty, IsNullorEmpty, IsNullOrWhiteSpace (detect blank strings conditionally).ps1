# ------------------------------
# PowerShell - String Empty, IsNullorEmpty, IsNullOrWhiteSpace (detect blank strings conditionally)
# ------------------------------
#
# Test if string is empty/unset
#

If ([String]::IsNullOrEmpty("${___STRING_VAR___}") -Eq $True) {
	# String IS empty/unset
} Else {
	# String is NOT empty/unset
}


# ------------------------------
#
# [String]::Empty
#

[String]::Empty -Eq "";        # True
[String]::Empty -Eq $True;     # True

([String]::Empty) -Eq $False;  # False
([String]::Empty) -Eq $Null;   # False


# Test if a string is empty
$StringVar="";
If (([String]::Empty) -Eq ("${StringVar}")) {
	Write-Host "String IS [ empty ]";
} Else {
	Write-Host "String is NOT [ empty ]";
}


# ------------------------------
#
# [String]::IsNullOrEmpty
#

[String]::IsNullOrEmpty($Null);        # True
[String]::IsNullOrEmpty("");           # True

[String]::IsNullOrEmpty("  ");         # False
[String]::IsNullOrEmpty("abc");        # False


# Test if a string is null or empty
$StringVar="";
If ([String]::IsNullOrEmpty("${StringVar}") -Eq $True) {
	Write-Host "String IS [ null or empty ]";
} Else {
	Write-Host "String is NOT [ null or empty ]";
}


# ------------------------------
#
# [String]::IsNullOrWhiteSpace
#

[String]::IsNullOrWhiteSpace($Null)    # True
[String]::IsNullOrWhiteSpace("");      # True
[String]::IsNullOrWhiteSpace("  ");    # True   # <--- The main difference between [ IsNullOrWhiteSpace ] and [ IsNullOrEmpty ]

[String]::IsNullOrWhiteSpace("abc");   # False


# Test if a string is null, empty or blank (whitespace only)
$StringVar="";
If ([String]::IsNullOrWhiteSpace("${StringVar}") -Eq $True) {
	Write-Host "String IS [ null, empty or blank (whitespace only) ]";
} Else {
	Write-Host "String is NOT [ null, empty or blank (whitespace only) ]";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "String.IsNullOrEmpty(String) Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.string.isnullorempty
#
#   stackoverflow.com  |  "c# - string.IsNullOrEmpty(string) vs. string.IsNullOrWhiteSpace(string) - Stack Overflow"  |  https://stackoverflow.com/a/6976641
#
# ------------------------------------------------------------