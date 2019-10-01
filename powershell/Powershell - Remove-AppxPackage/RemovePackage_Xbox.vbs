Use_Extension = ".ps1"
CreateObject( "WScript.Shell" ).Run Replace( WScript.ScriptFullName , ".vbs" , Use_Extension ), 0, True
