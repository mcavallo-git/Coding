# ------------------------------------------------------------
#
# PowerShell - Array.Contains(...) vs. Array -Contains ...
#
# ------------------------------------------------------------



PS C:\Windows\system32> @("AAA","BBB").Contains('ccc')
False

PS C:\Windows\system32> @("AAA","BBB").Contains('bbb')    <-- ! ! ! "Array.Contains(...)" seems to be case-sensitive
False                                                     <-- ! ! !

PS C:\Windows\system32> @("AAA","BBB").Contains('BBB')
True

PS C:\Windows\system32> @("AAA","BBB") -contains 'BBB'
True

PS C:\Windows\system32> @("AAA","BBB") -contains 'bbb'    <-- ! ! ! "Array -contains ..." seems to be case insensitive
True                                                      <-- ! ! !



# ------------------------------------------------------------
#
# Citation(s)
#
#   devblogs.microsoft.com  |  "Using the PowerShell Contains Operator | Scripting Blog"  |  https://devblogs.microsoft.com/scripting/using-the-powershell-contains-operator/
#
# ------------------------------------------------------------