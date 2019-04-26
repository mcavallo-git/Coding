
# ------------------------------------------------------------
#
#	Generate a string built from random characters [a-zA-Z]
#
$CharacterCount = 29;
$ASCII = @{};
$ASCII.Numeric = (48..57);
$ASCII.UpperAlpha = (65..90);
$ASCII.LowerAlpha = (97..122);
$ASCII.UpperAlphaNumeric = (48..57 + 65..90);
$ASCII.LowerAlphaNumeric = (48..57 + 97..122);
$ASCII.ComboAlpha = (65..90 + 97..122);
$ASCII.ComboAlphaNumeric = (48..57 + 65..90 + 97..122);

$RandomStrings = @{};
ForEach ($EachKey In $ASCII.Keys) {
	If ($RandomStrings[$EachKey] -eq $null) { $RandomStrings[$EachKey] = "" };
	For ($i = 0; $i -lt $CharacterCount; $i++) { $RandomStrings[$EachKey] += [char](Get-Random -InputObject ($ASCII[$EachKey])) };
}
# $RandomStrings | Sort-Object -Property Name | Format-Table Name, Value;
$RandomStrings | sort-object -property @{Expression="Name";Descending=$true}, @{Expression="Name";Descending=$false} | format-table
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
