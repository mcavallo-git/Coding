# ------------------------------------------------------------
#
# PowerShell - Regex-Matching using separate ^(Capture)(Groups)$ in the output
#
# ------------------------------------------------------------

#
# General Syntax
#
[Regex]::Match('Haystack','Pattern');

 
#
# General Syntax - NO capture groups
#
[Regex]::Match('hello world','^hello world$').Success;  # Returns "True"
[Regex]::Match('hello world','^hello world$').Captures.Groups[0].Value;  # Returns "hello world"


#
# General Syntax - WITH capture groups
#
[Regex]::Match('hello world','^(hello)\s(world)$').Success;  # Returns "True"
[Regex]::Match('hello -----','^(hello)\s(world)$').Success;  # Returns "False"
[Regex]::Match('hello world','^(hello)\s(world)$').Captures.Groups[0].Value;  # Returns "hello world"
[Regex]::Match('hello world','^(hello)\s(world)$').Captures.Groups[1].Value;  # Returns "hello"
[Regex]::Match('hello world','^(hello)\s(world)$').Captures.Groups[2].Value;  # Returns "world"


# ------------------------------------------------------------
#
#  Regex Patterns
#

$Pattern_UUID='^\b[0-9A-Fa-f]{8}\b-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-\b[0-9A-Fa-f]{12}\b$';  # Regex Patterns:  Microsoft UUIDs/GUIDs

$Pattern_UUID='^{[0-9A-Fa-f]{8}\b-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-[0-9A-Fa-f]{4}-\b[0-9A-Fa-f]{12}}$';  # Regex Patterns:  Microsoft UUIDs/GUIDs


# ------------------------------------------------------------
#
# Ex 1)  Hello World
#

If ($True) {

  $Haystack = 'hello world'; # "Haystack", aka the string to parse (may have newlines aplenty)
  $Pattern  = '^(hello)\s(world)$'; # Regex pattern which defines the "Needle" to match while parsing the through the "Haystack"
  $Needle   = [Regex]::Match($Haystack, $Pattern); # Parse through the "Haystack", looking for the "Needle"
  If ($Needle.Success -ne $False) {
    Write-Output "`n`$Needle.Groups[0].Value: $($Needle.Groups[0].Value)"; # 'hello world'   (regex capture group 0, e.g. whole string)
    Write-Output "`n`$Needle.Groups[0].Value: $($Needle.Groups[1].Value)"; # 'hello'  (regex capture group 1)
    Write-Output "`n`$Needle.Groups[0].Value: $($Needle.Groups[2].Value)"; # 'world'  (regex capture group 2)
  }
  Write-Output ("`$Needle.Success = [ $($Needle.Success) ]");

}


# ------------------------------------------------------------
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


# ------------------------------------------------------------

# Ex ) String & Integer regex-matching
$Distro_Name = "CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc";
$RegexTest = "CanonicalGroupLimited\.(Ubuntu)[\d\.]{0,6}onWindows_[a-z0-9]{13}";
$MatchResults = ($Distro_Basename -match $RegexTest);
$MatchResults;


# ------------------------------------------------------------
#
# Citation(s)
#
#   dodocs.microsoft.commain  |  "Regex.Match Method (System.Text.RegularExpressions) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.text.regularexpressions.regex.match
#
# ------------------------------------------------------------