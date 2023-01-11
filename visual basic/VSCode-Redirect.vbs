' ------------------------------------------------------------
'
'
' Intended Use:
'  | 
'  |--> Replaces [ Notepad.exe ] with [ VS-Code INTO a static Workspace (essential) ]
'  |
'  |--> Leverages "Notepad Replacer" (free, open source tool) which redirects "notepad.exe"
'  |      calls to whatever target you tell it to - in this instance, it should redirect to
'  |      [ "wscript.exe" ".../VSCode-Redirect.vbs" ]
'  |
'  |--> All filetypes which are desired to always use VS-Code as their default editor should
'         be "Opened With" (right click in Windows > "Open With") the default "Notepad.exe",
'         which will be redirected to this script, which opens VS-code with into said
'         code-workspace (so you have all your workstation/user-specific configs!)
'
'
' ------------------------------------------------------------
'
'
' [Step 1/3] Download "Notepad Replacer"
'   |
'   |--> Automatically via PowerShell convenience-script (forces TLS 1.2, downloads to your "Downloads" directory):
'   |
'   |      $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $(New-Object Net.WebClient).DownloadFile(([Net.HttpWebRequest]::Create("https://www.binaryfortress.com/Data/Download/?package=notepadreplacer").GetResponse().ResponseUri.AbsoluteUri),"${Home}\Downloads\NotepadReplacerSetup.exe"); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
'   |
'   |-->  Manually via "Notepad Replacer" source (BinaryFortress) URL @ https://www.binaryfortress.com/Data/Download/?package=notepadreplacer
'
'
' ------------------------------
'
'
' [Step 2/3] Install & configure "Notepad Replacer" to redirect from [ notepad.exe ] towards [ this-script ]
'   |
'   |--> Automatically via PowerShell convenience-script (some click-through & license acceptance still req'd):
'   |      Get-ChildItem -Path ("${Home}\Downloads\NotepadReplacerSetup*.exe") | ForEach-Object { Start-Process -Filepath ("$_") -ArgumentList (@("/NOTEPAD=`"${Home}\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue"); Break; };
'   |
'   |-->  Manually by opening "NotepadReplacerSetup*.exe" runtime & browsing to this file
'
'
' ------------------------------
'
'
' [Step 3/3] Ensure that "wscript.exe" is the default handler for ".vbs"-extensioned files
'   |
'   |--> Right-Click any ".vbs" file (such as this script) -> "Open-with" -> "Choose another app"
'   |
'   |--> Select "wscript.exe", which has full-name of "Microsoft ® Windows Based Script Host"
'   |
'   |--> If neither of these options present themself, manually set "wscript.exe" by selecting "More Apps" -> "Look for another app on this PC" -> goto "C:\Windows\System32\wscript.exe" ]
'   |
'   |--> Check "Always use this app to open .vbs files" -> Select "OK" to confirm
'   |
'   |--> You have completed setting "wscript.exe" to be the default handler for ".vbs"-extensioned files
'
'
' ------------------------------------------------------------
' Consolidated Steps 2 & 3 (from above)
'
'
'   $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $(New-Object Net.WebClient).DownloadFile(([Net.HttpWebRequest]::Create("https://www.binaryfortress.com/Data/Download/?package=notepadreplacer").GetResponse().ResponseUri.AbsoluteUri),"${Home}\Downloads\NotepadReplacerSetup.exe"); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; Get-ChildItem -Path ("${Home}\Downloads\NotepadReplacerSetup*.exe") | ForEach-Object { Start-Process -Filepath ("$_") -ArgumentList (@("/NOTEPAD=`"${Home}\Documents\GitHub\Coding\visual basic\VSCode-Redirect.vbs`"")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue"); Break; };
'
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

Set WScriptArguments = WScript.Arguments

' WScript.Echo "VSCode_Workspace = [" & VSCode_Workspace & "]"

' WScript.Echo "WScriptArguments.Count = [" & WScriptArguments.Count & "]"

if WScriptArguments.Count = 0 then
	RunCommand = """" & VSCode_Workspace & """"
Else
	' RunCommand = """" & VSCode_Workspace & """" & " " & """" & WScript.Arguments(0) & """"
	RunCommand = """" & VSCode_Workspace & """" & " " & """" & WScriptArguments.Item(0) & """"
End if

' WScript.Echo "RunCommand = [" & RunCommand & "]"

CreateObject("Wscript.Shell").Run RunCommand, 0, False


' ------------------------------------------------------------
'
' Citation(s)
'
'   developer.rhino3d.com  |  "Nothing vs Empty vs Null with VBScript"  |  https://developer.rhino3d.com/guides/rhinoscript/nothing-empty-null/
'
'   social.msdn.microsoft.com  |  "passing parameters to a vbs file in command line"  |  https://social.msdn.microsoft.com/Forums/sqlserver/en-US/8855a587-ff0d-4f58-8ae7-d5aefa21c612/passing-parameters-to-a-vbs-file-in-command-line?forum=sqlsmoanddmo
'
'   ss64.com  |  ".Run - VBScript"  |  https://ss64.com/vb/run.html
'
'   ss64.com  |  "VBScript Arguments - VBScript"  |  https://ss64.com/vb/arguments.html
'
'   stackoverflow.com  |  "Can I pick up environment variables in vbscript WSH script?"  |  https://stackoverflow.com/a/904747
'
'   tutorialspoint.com  |  "VBScript If..ElseIf..Else Statements"  |  https://www.tutorialspoint.com/vbscript/vbscript_if_elseif_else_statement.htm
'
'   www.binaryfortress.com  |  "Frequently Asked Questions (FAQ) • Notepad Replacer by Binary Fortress Software"  |  https://www.binaryfortress.com/NotepadReplacer/FAQ/
'
' ------------------------------------------------------------