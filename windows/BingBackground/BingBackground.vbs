Use_Extension = ".exe"
CreateObject( "WScript.Shell" ).Run Chr(34) & Replace( WScript.ScriptFullName , ".vbs" , Use_Extension ) & Chr(34), 0, True
