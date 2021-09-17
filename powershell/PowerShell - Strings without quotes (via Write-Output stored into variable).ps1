# ------------------------------------------------------------
#
# PowerShell - Strings   -->   Set a string variable without using quotation characters
#

# Method 1 (Best) - More compact
SV StringVar String` without` quotes` and` with` spaces;
(GV StringVar).Value;

# Method 2 - Less compact
SV StringVar -Value (Write-Output String` without` quotes` and` with` spaces);
(GV StringVar).Value;

# Example String w/o quotes using ticks to escape spaces in strings
If (Test-Path C:\Program` Files\Notepad++\notepad++.exe) { Start-Process C:\Program` Files\Notepad++\notepad++.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; } ElseIf (Test-Path C:\Program` Files` (x86)\Notepad++\notepad++.exe) { Start-Process C:\Program` Files` (x86)\Notepad++\notepad++.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; } Else { Start-Process C:\Windows\System32\notepad.exe -ArgumentList C:\Windows\System32\drivers\etc\hosts -Verb RunAs; };


# ------------------------------------------------------------
#
# PowerShell - Booleans   -->   Set a boolean variable without using dollar sign characters for $True and $False
#

# Set a variable to $False without using dollar signs
SV BooleanFalse ([Boolean](0));
(GV BooleanFalse).Value;


# Set a variable to $True without using dollar signs
SV BooleanTrue ([Boolean](1));
(GV BooleanTrue).Value;


# ------------------------------------------------------------
#
# Citation(s)
#
#   community.idera.com  |  "Creating String Arrays without Quotes - Power Tips - Power Tips - IDERA Community"  |  https://community.idera.com/database-tools/powershell/powertips/b/tips/posts/creating-string-arrays-without-quotes
#
# ------------------------------------------------------------