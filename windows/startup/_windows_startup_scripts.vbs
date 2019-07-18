Use_Extension = ".bat"
CreateObject( "WScript.Shell" ).Run Replace( WScript.ScriptFullName , ".vbs" , Use_Extension ), 0, True
