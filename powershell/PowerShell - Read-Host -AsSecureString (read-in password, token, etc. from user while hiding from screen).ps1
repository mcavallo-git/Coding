# ------------------------------------------------------------
#
# Show a confirmation prompt to the user
#  |--> Note: This only really cares about "y" confirmation responses, and lumps all the others as cancel actions
#

If ($True) {
	Write-Output -NoNewLine "Info:  Yes or no? (y/n)" -ForegroundColor "Yellow" -BackgroundColor "Black";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If ($KeyPress.Character -Eq "y") {
		Write-Output "Info:  You selected `"y`"";
	} Else {
		Write-Output "Info:  You did not select `"y`"";
	}
}


# ------------------------------------------------------------
#
# Wait endlessly for a single keypress
#

Write-Output -NoNewLine "Info:  System restart required - Press 'y' to confirm and reboot this machine, now..." -ForegroundColor "Yellow" -BackgroundColor "Black";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.Character -NE "y") {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


# ------------------------------------------------------------
#
# Read a generic string in from the user
#

$UsernamePlaintext = Read-Host -Prompt 'Type an example Username (in plaintext)';
Write-Output "You typed `"${UsernamePlaintext}`"";


# ------------------------------------------------------------
#
# Read a Securestring in from the user & convert it to plaintext
#

$SecureString_ToPlainText = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt 'Type an example securestring'))));
Write-Output "You typed `"${SecureString_ToPlainText}`"";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Read-Host - Reads a line of input from the console."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-5.1
#
#   stackoverflow.com  |  "c# - Convert String to SecureString - Stack Overflow"  |  https://stackoverflow.com/a/43084626
#
#   www.scriptinglibrary.com  |  "Passwords and SecureString, How To Decode It with Powershell | Scripting Library"  |  https://www.scriptinglibrary.com/languages/powershell/securestring-how-to-decode-it-with-powershell/
#
# ------------------------------------------------------------