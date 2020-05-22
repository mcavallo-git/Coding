#	------------------------------------------------------------
#
#	"Press any key to close this window..."
#

Write-Host -NoNewLine "`n`n  Press any key to close this window...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');



# ------------------------------------------------------------
#
# "Press 'y' to confirm..."
#

Write-Host -NoNewLine "`n`n  Press 'y' to confirm...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
If ($KeyPress.Character -Eq "y") {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


# ------------------------------------------------------------
#
# "Press 'Escape' to close this window..."
#

Write-Host -NoNewLine "`n`n  Press 'Escape' to close this window...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.VirtualKeyCode -NE 27) {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


# ------------------------------------------------------------
#
# Require 'y' to proceed
#

Write-Host -NoNewLine "`n`n  Press 'y' to proceed...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.Character -NE "y") {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


# ------------------------------------------------------------
#
# Message "Press any key to confirm, or retry command using parameter '-Force' to perform a manual override of this message"
#  + Wait [ up-to X-Seconds ]
#

If ($True) {
	Start-Sleep 1;
	$SecondsToTimeoutAfter = 30;
	$SecondsAlreadyWaited = 0;
	Write-Output "`n`n  Press any key to confirm, or retry command using parameter '-Force' to perform a manual override of this message`n`n";
	While ((!$Host.UI.RawUI.KeyAvailable) -And (${SecondsAlreadyWaited}++ -LT ${SecondsToTimeoutAfter})) {
		[Threading.Thread]::Sleep(1000);
	}
	If ($Host.UI.RawUI.KeyAvailable) {
		$KeyPress = ($Host.UI.RawUI.KeyAvailable);
		Write-Host "`$KeyPress:";
		$KeyPress;
		$KeyPress | Format-List;
		<# FAILURE #>
	}
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


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "powershell - Press any key to continue - Stack Overflow"  |  https://stackoverflow.com/a/20886446
#
#   stackoverflow.com  |  "powershell - Waiting for user input with a timeout - Stack Overflow"  |  https://stackoverflow.com/a/150326
#
# ------------------------------------------------------------