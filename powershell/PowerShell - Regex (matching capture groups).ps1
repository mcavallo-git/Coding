
# ------------------------------------------------------------- #

# Regex-Matching using separate ^(Capture)(Groups)$ in the output

# ------------------------------------------------------------- #
#
# General Syntax
#
$Needle = [Regex]::Match($Haystack, $RegexPattern);


# ------------------------------------------------------------- #
#
# Ex 1)  Hello World
#

$Haystack = 'hello world'; # "Haystack", aka the string to parse (may have newlines aplenty)

$RegexPattern = '^(hello)\s(world)$'; # Regex pattern which defines the "Needle" to match while parsing the through the "Haystack"

$Needle = [Regex]::Match($Haystack, $RegexPattern); # Parse through the "Haystack", looking for the "Needle"

$Needle.Groups[0].Value; # Should output:  'hello world'   (original entire input, denoting successful regex string-match)

$Needle.Groups[1].Value; # Should output:  'hello'   (first capture group, aka first parenthesis-bound )

$Needle.Groups[2].Value; # Should output:  'world'


# ------------------------------------------------------------- #
#
# Ex 2)  Obtain the version of local Azure-CLI Module
#

$Haystack = az --version;

$RegexPattern = '^(azure\-cli\ \()([\d\.]+)(\))';

$Needle = [Regex]::Match($Haystack, $RegexPattern);

$Needle.Groups[2].Value;

# ------------------------------------------------------------- #
