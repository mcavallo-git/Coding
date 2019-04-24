
#
# cmdkey  :::  Creates, lists, and deletes stored user names and passwords or credentials  :::  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey
#

$CredentialMatches = $Null;

$Haystack = (cmdkey /list);

# $RegexPattern = '^\s*Target:\s*([^:])+:target=(.+)\s*$';
$RegexPattern = '^\s*Target:\s*([^:])+:target=(git:https:\/\/.+)\s*$';

ForEach ($EachLine in $Haystack){
	$Needle = [Regex]::Match($EachLine, $RegexPattern);
	If ($Needle.Success -eq $True) {
		If ($CredentialMatches -eq $Null) {
			$CredentialMatches = @{};
		}
		If ($CredentialMatches[$Needle.Groups[1].Value] -eq $Null) {
			$CredentialMatches[$Needle.Groups[1].Value] = @();
		}
		$CredentialMatches[$Needle.Groups[1].Value] += $Needle.Groups[2].Value;
		# Break;
	}
}

Write-Host "`n`n";

If ($CredentialMatches -eq $Null) {

	Write-Host ("No matches found");

} Else {

	Write-Host (("`n  Found [ ")+($CredentialMatches.Length)+(" ] matching Windows Credentials.`n")) -ForegroundColor Yellow;

	$CredentialMatches | Format-List;

	Write-Host (("`n  Proceed with deleting above Windows Credential(s)? (Y/N)`n")) -ForegroundColor Yellow;

	# !!! PERFORM "y/n" USER-INPUT CHECK TO CONFIRM DELETION OF CREDENTIALS !!!

	$UserAgreed_BeginDeletingCredentials = $False;

	If ($UserAgreed_BeginDeletingCredentials -eq $True) {
		# cmdkey /del:($_ -replace " ","" -replace "Target:","");
	}

}

Write-Host "`n`n";

#
#	Citation(s)
#	
#		Thanks to StackOverflow user [ Jebuz ] for their post on forum [ https://stackoverflow.com/questions/39478018 ]
#
