
# ------------------------------------------------------------- #

# Regex-Matching using separate ^(Capture)(Groups)$ in the output

# ------------------------------------------------------------- #
#
# General Syntax
#
$Needle = [Regex]::Match($Haystack, $RegexPattern);


# Note: Microsoft UUIDs
$Pattern_UUID  = '^\b[0-9A-Fa-f]{8}\b-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-\b[0-9A-Fa-f]{12}\b$';
$Pattern_UUID  = '^{[0-9A-Fa-f]{8}\b-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-\b[0-9A-Fa-f]{12}}$';



# ------------------------------------------------------------- #
#
# Ex 1)  Hello World
#

$Haystack = 'hello world'; # "Haystack", aka the string to parse (may have newlines aplenty)
$Pattern  = '^(hello)\s(world)$'; # Regex pattern which defines the "Needle" to match while parsing the through the "Haystack"
$Needle   = [Regex]::Match($Haystack, $Pattern); # Parse through the "Haystack", looking for the "Needle"
If ($Needle.Success -ne $False) {
	$Needle.Groups[0].Value; # 'hello world'   (regex capture group 0, e.g. whole string)
	$Needle.Groups[1].Value; # 'hello'  (regex capture group 1)
	$Needle.Groups[2].Value; # 'world'  (regex capture group 2)
}
Write-Output (("`$Needle.Success = [ $($Needle.Success) ]"));


# ------------------------------------------------------------- #
#
# Ex 2)  Obtain the version of local Azure-CLI Module
#

$Haystack = (az --version);

$RegexPattern = '^azure\-cli\s*\(?(\d+)\.(\d+)\.(\d+)\)?\s*\*?$';

ForEach ($EachLine in $Haystack){
	$Needle = [Regex]::Match($EachLine, $RegexPattern);
	If ($Needle.Success -eq $True) {
		Break;
	}
}

If ($Needle.Success -eq $True) {
	Write-Host (("Found local install: `"")+($Needle.Groups[1].Value) + ("`" v") + ($Needle.Groups[2].Value));
} Else {
	Write-Host ("No matches found");
}


# ------------------------------------------------------------- #
