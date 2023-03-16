# ------------------------------------------------------------
#
# PowerShell - String replace using .Replace() or -replace (regex replacement using capture groups)
#   |
#   |--> .Replace()   !!!  CASE SENSITIVE     !!!
#   |
#   |--> -replace     !!!  CASE IN-SENSITIVE  !!!  (regex-matching)
#
# ------------------------------------------------------------

#
# Substring Replacement
#

"Hello World!".Replace("World","City");  <# Returns "Hello World!" #>

"Hello World!".Replace("world","City");  <# Returns "Hello World!"  -  CASE SENsitive #>

"Hello World!" -replace "world","City";  <# Returns "Hello City!"  -  CASE INsensitive #>

"Hello World!".Replace(" World","");     <# Returns "Hello!"  -  Remove substring #>

"Hello World!" -replace " World","";     <# Returns "Hello!"  -  Remove substring #>

"Hello World!" -replace " World";        <# Returns "Hello!"  -  Remove substring (second arg not required for -replace to slice) #>


#
# Substring Replacement - Regex Capture Groups
#

'00:00:00' -replace "^([-+]?)(\d+):(\d+):(\d+)$","[`$1] [`$2] [`$3] [`$4]";  <# Returns "[] [00] [00] [00]" #>

'-05:00:00' -replace "^([-+]?)(\d+):(\d+):(\d+)$","[`$1] [`$2] [`$3] [`$4]";  <# Returns "[-] [05] [00] [00]" #>

'+13:45:00' -replace "^([-+]?)(\d+):(\d+):(\d+)$","[`$1] [`$2] [`$3] [`$4]";  <# Returns "[+] [13] [45] [00]" #>

$TZ_MinutesOffset=$(([String](Get-TimeZone).BaseUtcOffset) -replace "^([-+]?)(\d+):(\d+):(\d+)$",":`$3"); $TZ_MinutesOffset;  <# Returns ":00" (minutes offset for current system's timezone) #>



# ------------------------------
#
# Example - Perform regex replacements to remove a substring from a string
#

$String="Hello World!";
$SliceSubstring="World";
${String} -replace "${SliceSubstring}";



# ------------------------------
#
# Example - Remove "invalid" characters (any characters NOT found in a given set of characters)
#

"..*[$#(In!#<$>#va!#lid + @!# Char# !>>< act ers)<<].." -replace "[^a-zA-Z0-9-_%\[\]\(\)\+\.]","";  <# Returns "..[(Invalid+Characters)].."  #>


# ------------------------------
#
# Example - Perform regex replacements to remove semi-colons from the end of a string
#

"htmlfile;" -replace "^((?:(?!;).)+)(;)?$","`$1";  <# Returns "htmlfile" (attempts to remove any semi-colons at the end of the string, and returns the whole string if no semi-colon exists as the last character in the string #>

"htmlfile:" -replace "^((?:(?!;).)+)(;)?$","`$1";  <# Returns "htmlfile:" (attempts to remove any semi-colons at the end of the string, and returns the whole string if no semi-colon exists as the last character in the string #>


# ------------------------------
#
# Example - Perform regex replacements on an Entity Framework exported Microsoft SQL schema file to make its contents idempotent
#

(Get-Content "${env:FULLPATH_SQL_SCHEMA_FILE}").replace('DROP TABLE [', 'DROP TABLE IF EXISTS [') | Set-Content "${env:FULLPATH_SQL_SCHEMA_FILE}";  <# Append " IF EXISTS" immediately after any "DROP TABLE" commands #>

(Get-Content "${env:FULLPATH_SQL_SCHEMA_FILE}") -replace "(^\s*(?:EXEC\(N')?)(CREATE (?:UNIQUE )?INDEX )(\[[^\]]+\])(\s+ON\s+)(\[[^\s]+)(\s[^';]+)((?:'|;).*)$","`$1DROP INDEX IF EXISTS `$3 ON `$5; `$2`$3`$4`$5`$6`$7" | Set-Content "${env:FULLPATH_SQL_SCHEMA_FILE}";  <# Prepend "DROP INDEX IF EXISTS [INDEX_NAME] ON [DB_NAME].[TABLE_NAME];" before all "CREATE INDEX" & "CREATE UNIQUE INDEX" commands #>


# ------------------------------
#
# Example - Perform regex replacements using capture groups by converting the md5 checksum for a given string to GUID format
#

(Get-FileHash -Algorithm ("MD5") -InputStream ([System.IO.MemoryStream]::New([System.Text.Encoding]::ASCII.GetBytes("tester")))).Hash -replace '([0-9A-F]{8})([0-9A-F]{4})([0-9A-F]{4})([0-9A-F]{4})([0-9A-F]{12})','$1-$2-$3-$4-$5';


# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Weekend Scripter: Remove Non-Alphabetic Characters from String - Scripting Blog"  |  https://devblogs.microsoft.com/scripting/weekend-scripter-remove-non-alphabetic-characters-from-string/
#
#   docs.microsoft.com  |  "about_Comparison_Operators - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_comparison_operators?view=powershell-5.1#replacement-operator
#
#   powershell.org  |  "Regular Expressions are a -replace's best friend – PowerShell.org"  |  https://powershell.org/2013/08/regular-expressions-are-a-replaces-best-friend/
#
#   stackoverflow.com  |  "PowerShell to remove text from a string - Stack Overflow"  |  https://stackoverflow.com/a/19169526
#
# ------------------------------------------------------------