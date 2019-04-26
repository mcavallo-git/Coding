
# ------------------------------------------------------------
#
#	Generate a string built from random characters [a-zA-Z]
#
$CharacterCount = 29;
$AlphaCodes = @{};
$AlphaCodes.Upper = (65..90);
$AlphaCodes.Lower = (97..122);
$AlphaCodes.Ints = (48..57);
$AlphaCodes.Combo = ($AlphaCodes.Upper) + ($AlphaCodes.Lower);

$RandomStrings = @{};
ForEach ($EachKey In $AlphaCodes.Keys) {
	If ($RandomStrings[$EachKey] -eq $null) { $RandomStrings[$EachKey] = "" };
	For ($i = 0; $i -lt $CharacterCount; $i++) { $RandomStrings[$EachKey] += [char](Get-Random -InputObject ($AlphaCodes[$EachKey])) };
}
$RandomStrings | Format-Table;

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
