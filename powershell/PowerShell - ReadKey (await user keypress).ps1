#	------------------------------------------------------------
#
#	"Press any key to close this window..."
#

Write-Host -NoNewLine "`n`n  Press any key to close this window...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');



# ------------------------------------------------------------
#
# "Press 'Escape' to close this window..."
#

Write-Host -NoNewLine "`n`n  Press 'Escape' to close this window...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.VirtualKeyCode -ne 27) {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


# ------------------------------------------------------------
#
# "Closing in 3...2...1..."
#

Write-Host -NoNewLine "  Closing in ";
$WaitSeconds = 3;
While ($WaitSeconds -gt 0) {
	Write-Host -NoNewLine ($SecondsTilAutoExit);
	$MillisecondsRemaining = 1000;
	While ($MillisecondsRemaining -gt 0) {
		$WaitMilliseconds = 250;
		$MillisecondsRemaining -= $WaitMilliseconds;
		[Threading.Thread]::Sleep($WaitMilliseconds);
		Write-Host -NoNewLine ".";
	}
	$WaitSeconds--;
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
