# ------------------------------------------------------------
#
# PowerShell - Get Long Filenames
#
# ------------------------------------------------------------


# Get filenames in the current directory which are longer than [MINIMUM_LENGTH] characters

$MINIMUM_LENGTH=220; Get-ChildItem -Recurse | Where-Object {$_.FullName.Length -ge ${MINIMUM_LENGTH}} | Select-Object -Property "FullName";


# ------------------------------------------------------------
#
#	Citation(s)
#
#   stackoverflow.com  |  "How do I find files with a path length greater than 260 characters in Windows? - Stack Overflow"  |  https://stackoverflow.com/a/28914214
#
# ------------------------------------------------------------