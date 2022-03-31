# ------------------------------
# PowerShell - String IsNullorEmpty, IsNullOrWhiteSpace (detect blank strings, conditional)
# ------------------------------

$StringVar="";
If ([String]::IsNullOrEmpty(${StringVar}) -Eq $True) {
	Write-Host "String is null or empty";
} Else {
	Write-Host "String is NOT null or empty";
}


# ------------------------------
#
# [String]::IsNullOrEmpty
#

[String]::IsNullOrEmpty($Null);        # True
[String]::IsNullOrEmpty("");           # True
[String]::IsNullOrEmpty("  ");         # False
[String]::IsNullOrEmpty("abc");        # False


# ------------------------------
#
# [String]::IsNullOrWhiteSpace
#
[String]::IsNullOrWhiteSpace($Null)    # True
[String]::IsNullOrWhiteSpace("");      # True
[String]::IsNullOrWhiteSpace("  ");    # True   # <--- The main difference between [ IsNullOrWhiteSpace ] and [ IsNullOrEmpty ]
[String]::IsNullOrWhiteSpace("abc");   # False


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "String.IsNullOrEmpty(String) Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.string.isnullorempty
#
#   stackoverflow.com  |  "c# - string.IsNullOrEmpty(string) vs. string.IsNullOrWhiteSpace(string) - Stack Overflow"  |  https://stackoverflow.com/a/6976641
#
# ------------------------------------------------------------