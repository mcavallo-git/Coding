
# ---------------------------------------------------------------------------------------------------------- #
#
#	WScript.Shell - SendKeys  https://docs.microsoft.com/en-us/office/vba/language/reference/user-interface-help/sendkeys-statement
#		-->	Simulates Keystrokes
#

$TypeIntoStartMenu = "powershell.exe";

# ---------------------------------------------------------------------------------------------------------- #
# Activators
#		--> Use activators to simulate holding ALT, CTRL, or SHIFT while simultaneously sending other keystrokes
#		--> Use activators followed-by a series of parenthesis-wrapped-keystrokes to avoid the "Shift-Up Shift-Down" etc. between each keystroke

$Activators = @{}; # Note: Use activators to hold ALT, CTRL, or SHIFT during keystrokes: i.e. hold SHIFT and type ABC -> +(ABC)
$Activators.ALT="%";
$Activators.CTRL="^";
$Activators.SHIFT="+"; # ex: simulate typing 'ABC' <---[   +A+B+C   ]---OR--[   +(ABC)   ]

# Note: Because SendKeys doesn't support OS-Specific keystrokes, use CTRL+ESC to [ open the Start Menu ]  ( which achieves a similar result to [ pressing the WindowsKey ] )
$OpenStartMenu = "^{ESC}";

$Shell = (New-Object -ComObject WScript.Shell);

$Shell.SendKeys($OpenStartMenu); Start-Sleep -Milliseconds 100; # Wait for the start-menu to open
$Shell.SendKeys($TypeIntoStartMenu);

# ---------------------------------------------------------------------------------------------------------- #

# One-Liner - Open the Start Menu
# 		PowerShell:   (New-Object -ComObject WScript.Shell).SendKeys('^{ESC}');
# 		CMD:          powershell -command "(New-Object -ComObject WScript.Shell).SendKeys('^{ESC}');"
# 		VB-Script:    WScript.CreateObject("WScript.Shell").SendKeys "^{ESC}"


# ---------------------------------------------------------------------------------------------------------- #

#
#	WScript.Shell - Popup
#		-->	Show a confirmation yes/no/cancel message (which [ times-out & returns -1 ] after 5 seconds)
(New-Object -ComObject WScript.Shell).Popup("Demo Message", 5, "Hello World", 3);
#
#

# ---------------------------------------------------------------------------------------------------------- #







#
#	Citations (other)
#
#		(CMD / Batch Script) Thanks to Stack Overflow user 'tinyfiledialogs' on the forum: https://stackoverflow.com/questions/13115508
#
#		(PowerShell Script) Thanks to Reddit user [No username (deleted)] on the forum: https://www.reddit.com/r/vbscript/comments/4gyu4u
#
#		(VB Script) Thanks to Neowin user 'kimsland' on the forum: https://www.reddit.com/r/vbscript/comments/4gyu4u
#
