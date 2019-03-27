
# ---------------------------------------------------------------------------------------------------------- #
#
#	WScript.Shell
#		SendKeys
#			-->	Simulates Keystrokes
#			--> Activators (Shift/Ctrl/Alt)
#				--> Activators to simulate holding ALT, CTRL, or SHIFT while simultaneously sending other keystrokes
#				--> Activators can be applied before/after batch-keystrokes by following the activator with parenthesis (which wrap the keystrokes)
$Activators = @{};
$Activators.ALT="%";
$Activators.CTRL="^";
$Activators.SHIFT="+";


#
#	Ex) Open the start-menu and type a string into it (must wait [some] milliseconds for the start-menu to open before sending string to it)
#
$Shell = (New-Object -ComObject WScript.Shell);

$Shell.SendKeys("^{ESC}");
Start-Sleep -Milliseconds 100;
$Shell.SendKeys("powershell.exe");

#
# ex) One-Liner to open the Start Menu
#

(New-Object -ComObject WScript.Shell).SendKeys('^{ESC}');

#		.bat/.cmd:          powershell -command "(New-Object -ComObject WScript.Shell).SendKeys('^{ESC}');"

#		.vbs:    WScript.CreateObject("WScript.Shell").SendKeys "^{ESC}"

# ---------------------------------------------------------------------------------------------------------- #
#
#	WScript.Shell - Popup
#		-->	Show a popup message
#

# Ex: Show a popup which [ times-out & returns -1 ] after 5 seconds, and has options yes/no/cancel (setting 3)
(New-Object -ComObject WScript.Shell).Popup("Demo Message", 5, "Hello World", 3);



# ---------------------------------------------------------------------------------------------------------- #
#
#	Citation(s)
#
#		docs.microsoft.com, "SendKeys statement"
#			https://docs.microsoft.com/en-us/office/vba/language/reference/user-interface-help/sendkeys-statement
#
#
