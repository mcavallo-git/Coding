
$NewUser = "USERNAME";
$NewKey = "${Env:USERPROFILE}\.ssh\azure\KEYNAME.pem";

# Local-config files containing for ssh usernames, hostnames, private-key filepaths, etc.
$MobaXtermSiteSettings = ("${Env:USERPROFILE}\Documents\MobaXterm\MobaXterm.ini");
$FilezillaSiteSettings = ("${Env:USERPROFILE}\AppData\Roaming\FileZilla\sitemanager.xml");

# Define the "Haystack", e.g. the string to parse (may have newlines aplenty)
$Haystack = (Get-Content ("${FilezillaSiteSettings}"));

# Define the "Pitchfork", e.g. the regex pattern which helps us parse through the "Haystack" to find the "Needle"
$Pitchfork_RegexDeprecatedKeys = ('<Keyfile>([a-zA-Z]\:[\w\s\\\-_\.\,\(\)]+(?:.ssh|_SSH)[\w\s\\\-_\.\,\(\)]*(?:boneal|bnl)[\w\s\\\-_\.\,\(\)]*\.pem)</Keyfile>');

# Define the "Needle", e.g. the matches returned from the regex (the output from the "Pitchfork" pitching through the "Haystack")
$Needle_Key = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedKeys}); # Parse through the "Haystack", looking for the "Needle"
While (($Needle_Key.Success) -eq $true) {
	$Haystack = $Haystack.Replace(($Needle_Key.Value),(('<Keyfile>')+($NewKey)+('</Keyfile>')));
	$Needle_Key = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedKeys});
}

$Pitchfork_RegexDeprecatedUsers = ('<User>boneal</User>');
$Needle_User = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedUsers});
While (($Needle_User.Success) -eq $true) {
	$Haystack = $Haystack.Replace(($Needle_User.Value),(('<User>')+(${NewUser})+('</User>')));
	$Needle_User = [Regex]::Match(${Haystack}, ${Pitchfork_RegexDeprecatedUsers});
}

# Update the FileZilla config-file
Set-Content -Path ("${FilezillaSiteSettings}") -Value ("${Haystack}");
