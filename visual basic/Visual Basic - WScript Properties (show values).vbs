
Newline = Chr( 10 )

ReturnString = ""

ReturnString = ReturnString & "--- WScript Properties ---"
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "BuildVersion" & Newline & WScript.BuildVersion
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "FullName" & Newline & WScript.FullName
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "Interactive" & Newline & WScript.Interactive
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "Name" & Newline & WScript.Name
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "Path" & Newline & WScript.Path
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "ScriptName" & Newline & WScript.ScriptName
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "ScriptFullName" & Newline & WScript.ScriptFullName
ReturnString = ReturnString & Newline & Newline

ReturnString = ReturnString & "Version" & Newline & WScript.Version
ReturnString = ReturnString & Newline & Newline

WScript.Echo ReturnString
