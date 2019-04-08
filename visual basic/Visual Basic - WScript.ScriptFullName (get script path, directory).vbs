
'
' WScript.ScriptFullName - This property is read only and returns the full path to the script currently being executed.
'	
'	WScript.ScriptName - This property is read only and returns the filename of the script currently being executed.
'

ScriptDirname = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

ScriptBasename = CreateObject("Scripting.FileSystemObject").GetBaseName(WScript.ScriptFullName)

WScript.Echo "ScriptDirname = [" & ScriptDirname & "]"

WScript.Echo "ScriptBasename = [" & ScriptBasename & "]"


' ----------------------------------------------------------------------------------------
'
' Citation(s)
'
'		ss64.com,
'			"WScript properties"
'			 https://ss64.com/vb/syntax-wscript.html
'