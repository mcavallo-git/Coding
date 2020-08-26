# ------------------------------------------------------------
#
#   PowerShell - While Loops
#
# ------------------------------------------------------------


<# Wait until a given amount of time has passed, but also allow for other logic to run during the waiting period (within the while-loop) #>
$StartTime=(Get-Date);
While (($StartTime.AddSeconds(30)) -GT (Get-Date)) {
	Start-Sleep -Seconds 1; <# Wait 1 second every loop-iteration #>
	Get-Date;
};


<# Reboot the machine, but only after the user confirms by pressing 'y' (keep looping and listening until 'y' is pressed) #>
Write-Host -NoNewLine "`n`n  Restart required - Press 'y' to confirm and reboot this machine, now...`n`n" -BackgroundColor "Black" -ForegroundColor "Yellow";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.Character -NE "y") {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}
Start-Process -Filepath ("shutdown") -ArgumentList (@("/t 0","/r")) -NoNewWindow -Wait -PassThru;



# ------------------------------------------------------------
#
# PowerShell - For Loops
#
#   (SEE SEPARATE FILE - "PowerShell - For Loops.ps1" (or similar name)
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "About While - Describes a language statement that you can use to run a command block based on the results of a conditional test"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_while?view=powershell-5.1
#
# ------------------------------------------------------------