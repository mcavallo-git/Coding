
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
	If ($null -eq $RandomStrings[$EachKey]) { $RandomStrings[$EachKey] = "" };
	For ($i = 0; $i -lt $CharacterCount; $i++) { $RandomStrings[$EachKey] += (Get-Random -InputObject ($ASCII[$EachKey])) };
}
# $RandomStrings | Sort-Object -Property Name | Format-Table;

# $RandomStrings.PSObject.Properties

# $RandomStrings.Keys | Sort-Object

Write-Host "`n";
$RandomStrings.Keys | Sort-Object | ForEach { Write-Host (("`n  ")+($_).PadRight(25," ")+(":::  ")+($RandomStrings[$_])); };
Write-Host "`n";

# $RandomStrings | Get-Member

# ------------------------------------------------------------
#
# MinIO - Create a randomly generated Access Key & Secret Key
#
If ($False) {
	$Path_ConfigJson = Read-Host -Prompt "Enter path to MinIO's 'config.json' file";
	$AccessKey = "";
	$SecretKey = "";
	$CharacterCount = 29;
	$UpdateConfigJson = $False;
	$ASCII_Chars_AlphaUppers = [char[]]((48..57) + (65..90)); <# 0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ #>
	For ($i = 0; $i -lt $CharacterCount; $i++) { $AccessKey += (Get-Random -InputObject ($ASCII_Chars_AlphaUppers)) };
	For ($i = 0; $i -lt $CharacterCount; $i++) { $SecretKey += (Get-Random -InputObject ($ASCII_Chars_AlphaUppers)) };
	<# Update MinIO's config.json file with the newly generated keys #>
	$ConfigJson = (Get-Content "${Path_ConfigJson}") | ConvertFrom-Json;
	For ($i = 0; $i -lt 2; $i++) {
		$CurrentKey = (((($ConfigJson.credentials)._)[$i]).key);
		If ($CurrentKey -Eq "access_key") {
			If (($ConfigJson.credentials._[$i].value) -Eq "minioadmin") {
				<# Only update Access key if it is currently set to the default (insecure) value of 'minioadmin' #>
				Write-Host "";
				Write-Host "Info:  Detected default MinIO Access Key of 'minioadmin' - Generating new Access Key..." -BackgroundColor "Black" -ForegroundColor "Yellow";
				$ConfigJson.credentials._[$i].value = $AccessKey;
				$UpdateConfigJson = $True;
			} Else {
				$AccessKey = $ConfigJson.credentials._[$i].value;
			}
		} ElseIf ($CurrentKey -Eq "secret_key") {
			If (($ConfigJson.credentials._[$i].value) -Eq "minioadmin") {
				<# Only update Secret key if it is currently set to the default (insecure) value of 'minioadmin' #>
				Write-Host "";
				Write-Host "Info:  Detected default MinIO Secret Key of 'minioadmin' - Generating new Secret Key..." -BackgroundColor "Black" -ForegroundColor "Yellow";
				$ConfigJson.credentials._[$i].value = $SecretKey;
				$UpdateConfigJson = $True;
			} Else {
				$SecretKey = $ConfigJson.credentials._[$i].value;
			}
		} Else {
			Write-Host "Error: Unknown credential key `"$CurrentKey`" found in config-file `"${Path_ConfigJson}`"";
		}
	}
	If ($UpdateConfigJson -Eq $True) {
		$CompressedConfigJson = (${ConfigJson} | ConvertTo-Json -Depth 99 -Compress);
		Write-Host "";
		Write-Host "Info:  Updating MinIO service's config to use new (non-default) Access/Secret keys...";
		Set-Content -Path ("${Path_ConfigJson}") -Value ("${CompressedConfigJson}");
		Start-Sleep 1;
	}
}

# ------------------------------------------------------------
#
# Generate a pseudo-random string by base-64 encoding random numbers
#
If ($False) {
	$RandomCharacterCount = 20;
	$RandString = (([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Random -SetSeed (Get-Random))))).Substring(0,$RandomCharacterCount));
	$RandString;
}



# ------------------------------------------------------------
#
# Citation(s)
#		
#		"Generate Random Letters with PowerShell"  :::  https://devblogs.microsoft.com/scripting/generate-random-letters-with-powershell/
#
