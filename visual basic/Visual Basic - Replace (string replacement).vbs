' ------------------------------------------------------------
'
' Example script which obtains the full path of itself, then replaces its extension with ".exe"
'
'		Use-case: Allows use of task-scheduler to run timed, recurring kickoffs of local exe's, while running both invisibly and also running as the user currently using the windows machine 
'
' ------------------------------------------------------------

CreateObject("Wscript.Shell").Run Replace(WScript.ScriptFullName,".vbs",".exe"), 0, False


' ------------------------------------------------------------
'
' Citation(s)
'
'		ss64.com  |  "Replace - Find and replace text in a string"  |  https://ss64.com/vb/replace.html
'
'		www.w3schools.com  |  "VBScript Replace Function"  |  https://www.w3schools.com/asp/func_replace.asp
'
' ------------------------------------------------------------