#	------------------------------------------------------------
#
#		PRESS ANY KEY TO EXIT 
#

Write-Host -NoNewLine "`n`n  Press any key to exit...";
$KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');



#	------------------------------------------------------------
#
#		PRESS 'ESCAPE' TO EXIT
#

Write-Host -NoNewLine "`n`nPress the 'Escape' key to exit... " -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.VirtualKeyCode -ne 27) {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}



#	------------------------------------------------------------
#
# Debug - View input codes based on key(s) pressed
#
Write-Host -NoNewLine "`n`n  Awaiting KeyPress... ";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host "`n`nKey-Press:`"";
$KeyPress | Format-List;

If ( $KeyPress.VirtualKeyCode -eq 27 ) {
	Write-Host "'Escape' key was pressed";
} ElseIf ( $KeyPress.VirtualKeyCode -eq 13 ) {
	Write-Host "'Enter' key was pressed";
} ElseIf ( $KeyPress.VirtualKeyCode -eq 8 ) {
	Write-Host "'Backspace' key was pressed";
}



#	------------------------------------------------------------
#
# Thanks to stackoverflow user 'Knuckle-Dragger' on forum: https://stackoverflow.com/questions/20886243
#
#	------------------------------------------------------------
