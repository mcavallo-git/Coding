
# regular expression, regex testing
$Distro_Name = "CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc";

$RegexTest = "CanonicalGroupLimited\.(Ubuntu)[\d\.]{0,6}onWindows_[a-z0-9]{13}";

$MatchResults = ($Distro_Basename -match $RegexTest);

$MatchResults;
