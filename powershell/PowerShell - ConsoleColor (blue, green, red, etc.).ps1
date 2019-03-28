# ---------------------------------------------------------------------------------------------------------------------- #
#	PowerShell
#		--> set ConsoleColor
#

Write-Host "FAIL" -ForegroundColor red;
# writes "FAIL", in red-coloring, to the host

Write-Host "PASS" -ForegroundColor green;
# writes "PASS", in red-coloring, to the host



# ---------------------------------------------------------------------------------------------------------------------- #
# Color Options
#		--> PowerShell has a limited set of 16 color options
#		--> The $color object, below, displays interchangeable values, either or which (index-int or color-string) may be used
#	
$colors = @{};
$colors[0] = "Black";
$colors[1] = "DarkBlue";
$colors[2] = "DarkGreen";
$colors[3] = "DarkCyan";
$colors[4] = "DarkRed";
$colors[5] = "DarkMagenta";
$colors[6] = "DarkYellow";
$colors[7] = "Gray";
$colors[8] = "DarkGray";
$colors[9] = "Blue";
$colors[10] = "Green";
$colors[11] = "Cyan";
$colors[12] = "Red";
$colors[13] = "Magenta";
$colors[14] = "Yellow";
$colors[15] = "White";



# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com, "ConsoleColor Enum"
#			https://docs.microsoft.com/en-us/dotnet/api/system.consolecolor
#
