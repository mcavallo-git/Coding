' ------------------------------------------------------------
'
' USE NOTEPAD REPLACER TO REDIRECT NOTEPAD.exe TO [  C:\Users\USERNAME\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat  ] (must use non-variable syntax, e.g. cannot use %USERPROFILE% )
'
' ------------------------------------------------------------
'
' RUN THIS SCRIPT (VIA CMD):
'
' NO ARGS
'   "C:\Windows\System32\wscript.exe" "%USERPROFILE%\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs"
'
' 1 ARGUMENT
'   "C:\Windows\System32\wscript.exe" "%USERPROFILE%\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs" "%USERPROFILE%\Desktop\test.txt"
'
' ------------------------------------------------------------

VSCode_Workspace = objShell.Environment("USER").Item("USERPROFILE") & "\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"

WScript.Echo "VSCode_Workspace = [" & VSCode_Workspace & "]"

If WScript.Arguments.Count = 0 Then
	RunCommand = VSCode_Workspace
Else
	RunCommand = VSCode_Workspace & " " & WScript.Arguments(0)
End if

CreateObject("Wscript.Shell").Run(RunCommand, 0, False)


' ------------------------------------------------------------
'
' Citation(s)
'
'   developer.rhino3d.com  |  "Nothing vs Empty vs Null with VBScript"  |  https://developer.rhino3d.com/guides/rhinoscript/nothing-empty-null/
'
'   ss64.com  |  ".Run - VBScript"  |  https://ss64.com/vb/run.html
'
'   ss64.com  |  "VBScript Arguments - VBScript"  |  https://ss64.com/vb/arguments.html
'
'   stackoverflow.com  |  "Can I pick up environment variables in vbscript WSH script?"  |  https://stackoverflow.com/a/904747
'
'   tutorialspoint.com  |  "VBScript If..ElseIf..Else Statements"  |  https://www.tutorialspoint.com/vbscript/vbscript_if_elseif_else_statement.htm
'
' ------------------------------------------------------------