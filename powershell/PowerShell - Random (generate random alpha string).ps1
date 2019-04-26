
# ------------------------------------------------------------
#
#	Generate a random string built from various characters:
#
$CharacterCount = 29;
$ASCII = @{};

$ASCII.Alpha_Upper = [char[]](65..90);  # ABCDEFGHIJKLMNOPQRSTUVWXYZ
$ASCII.Alpha_Lower = [char[]](97..122); # abcdefghijklmnopqrstuvwxyz
$ASCII.Numeric = [char[]](48..57); # 0123456789
$ASCII.Specials = [char[]](33,35,36,37,38,42,63,64,94,126); # !#$%&*?@^~

$ASCII.AlphaNumeric_Upper = [char[]]((48..57) + (65..90));  # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
$ASCII.AlphaNumeric_Lower = [char[]]((48..57) + (97..122)); # 0123456789abcdefghijklmnopqrstuvwxyz
$ASCII.AlphaNumeric_Mixed = [char[]]((48..57) + (65..90) + (97..122)); # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz

$ASCII.AlphaNumSpecials_Upper = [char[]]((48..57) + (65..90) + (33,35,36,37,38,42,63,64,94,126));  # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ
$ASCII.AlphaNumSpecials_Lower = [char[]]((48..57) + (97..122) + (33,35,36,37,38,42,63,64,94,126)); # 0123456789abcdefghijklmnopqrstuvwxyz
$ASCII.AlphaNumSpecials_Mixed = [char[]]((48..57) + (65..90) + (97..122) + (33,35,36,37,38,42,63,64,94,126)); # 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz

$ASCII.Alpha_Mixed = [char[]](65..90) + (97..122); # ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz

$RandomStrings = @{};
ForEach ($EachKey In $ASCII.Keys) {
	If ($RandomStrings[$EachKey] -eq $null) { $RandomStrings[$EachKey] = "" };
	For ($i = 0; $i -lt $CharacterCount; $i++) { $RandomStrings[$EachKey] += (Get-Random -InputObject ($ASCII[$EachKey])) };
}
# $RandomStrings | Sort-Object -Property Name | Format-Table;

# $RandomStrings.PSObject.Properties

# $RandomStrings.Keys | Sort-Object

Write-Host "`n";
$RandomStrings.Keys | Sort-Object | ForEach { Write-Host (("`n  ")+($_).PadRight(25," ")+(":::  ")+($RandomStrings[$_])); };
Write-Host "`n";

# $RandomStrings | Get-Member



<#
	# ------------------------------------------------------------
	#
	# Generate a pseudo-random string by base-64 encoding random numbers
	#
	$RandomCharacterCount = 20;
	$RandString = (([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Random -SetSeed (Get-Random))))).Substring(0,$RandomCharacterCount));
	$RandString;
#>



# ------------------------------------------------------------
#
# Citation(s)
#		
#		"Generate Random Letters with PowerShell"  :::  https://devblogs.microsoft.com/scripting/generate-random-letters-with-powershell/
#
