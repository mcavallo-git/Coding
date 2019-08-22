
#	PowerShell - String Repeat
#		|--> Think of the string as an integer/float, and just multiply it (using the asterisk followed by an integer-multiplier) to repeat the string, e.g. '-'*60


# Ex ) create a string containing 60 dash "-" characters

$dashes = ( '-' * 60 );
Write-Host "$($dashes)";

# ... or short-hand ...

Write-Host ('-'*60);
