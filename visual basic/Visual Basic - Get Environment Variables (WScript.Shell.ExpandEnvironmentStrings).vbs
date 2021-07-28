
Set WScript_Shell = Wscript.CreateObject( "Wscript.Shell" )

Newline = Chr( 10 )

ReturnString = ""

ReturnString = ReturnString & "APPDATA" & Newline & WScript_Shell.ExpandEnvironmentStrings("%APPDATA%")
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "COMPUTERNAME" & Newline & WScript_Shell.ExpandEnvironmentStrings("%COMPUTERNAME%")
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "LOCALAPPDATA" & Newline & WScript_Shell.ExpandEnvironmentStrings("%LOCALAPPDATA%")
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "USERDOMAIN" & Newline & WScript_Shell.ExpandEnvironmentStrings("%USERDOMAIN%")
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "USERNAME" & Newline & WScript_Shell.ExpandEnvironmentStrings("%USERNAME%")
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "USERPROFILE" & Newline & WScript_Shell.ExpandEnvironmentStrings("%USERPROFILE%")
ReturnString = ReturnString & Newline & Newline

WScript.Echo ReturnString


' ------------------------------------------------------------
'
''' RUN THIS SCRIPT:
'
' C:\Windows\System32\wscript.exe "%USERPROFILE%\Documents\GitHub\Coding\visual basic\Visual Basic - Get Environment Variables (WScript.Shell.ExpandEnvironmentStrings(...))"
'
'
' ------------------------------------------------------------
'
' Citation(s)
'
'   social.msdn.microsoft.com  |  "Determining a user's home directory"  |  https://social.msdn.microsoft.com/Forums/vstudio/en-US/3ea54767-2b2b-4df9-a832-69e55cd8bb5d/determining-a-users-home-directory?forum=netfxbcl
'
' ------------------------------------------------------------