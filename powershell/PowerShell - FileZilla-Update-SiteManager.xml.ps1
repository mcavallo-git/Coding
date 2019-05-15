
$NewUser = "USERNAME";
$NewKey = "${Env:USERPROFILE}\.ssh\azure\KEYNAME.pem";

# FileZilla Saved Sites, usernames, & any additional locally-saved settings
$FilezillaSiteSettings = ("${Env:USERPROFILE}\AppData\Roaming\FileZilla\sitemanager.xml");

# Define the "Haystack", e.g. the string to parse (may have newlines aplenty)
$Haystack = (Get-Content ("${FilezillaSiteSettings}"));

# Define the "Pitchfork", e.g. the regex pattern which helps us parse through the "Haystack" to find the "Needle"
$Pitchfork_RegexDeprecatedKeys = (('<Keyfile>([\w\:\\\-_\.]+(?:.ssh|_SSH)[\w\:\\\-_\.]*(?:boneal|bnl)[\w\:\\\-_\.]*\.pem)</Keyfile>'));

# Define the "Needle", e.g. the matches returned from the regex (the output from the "Pitchfork" pitching through the "Haystack")
$Needle = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedKeys}); # Parse through the "Haystack", looking for the "Needle"

While (($Needle.Success) -eq $true) {
	$Haystack = $Haystack.Replace(($Needle.Value),(('<Keyfile>')+($NewKey)+('</Keyfile>')));
	$Needle = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedKeys}); # Parse through the "Haystack", looking for the "Needle"
}

$Pitchfork_RegexDeprecatedUsers = ('<User>boneal</User>');
$NeedleUser = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedUsers});
While (($NeedleUser.Success) -eq $true) {
	$Haystack = $Haystack.Replace(($NeedleUser.Value),(('<User>')+(${NewUser})+('</User>')));
	$NeedleUser = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedUsers});
}

# Update the FileZilla config-file
Set-Content -Path ("${FilezillaSiteSettings}") -Value ("${Haystack}");
