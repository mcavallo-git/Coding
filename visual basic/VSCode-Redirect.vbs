' ------------------------------------------------------------
'
' USE NOTEPAD REPLACER TO REDIRECT NOTEPAD.exe TO:
'
'   C:\Users\USERNAME\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs
'
' (can't use variables such as USERPROFILE, etc. in notepad-replacer's input syntax)
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

' Set ObjShell = CreateObject("Shell.Application")
' Set VSCode_Workspace = ObjShell.Environment("USER").Item("USERPROFILE") & "\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"

UserProfile = CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%")
' MsgBox UserProfile

VSCode_Workspace = UserProfile & "\Documents\GitHub\Coding\cmd\cmd - VSCode-Workspace.bat"

Set InlineArguments = WScript.Arguments

' WScript.Echo "VSCode_Workspace = [" & VSCode_Workspace & "]"

' WScript.Echo "InlineArguments.Count = [" & InlineArguments.Count & "]"

if InlineArguments.Count = 0 then
	RunCommand = """" & VSCode_Workspace & """"
Else
	RunCommand = """" & VSCode_Workspace & """" & " " & """" & WScript.Arguments(0) & """"
End if

' WScript.Echo "RunCommand = [" & RunCommand & "]"

CreateObject("Wscript.Shell").Run RunCommand, 0, False


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