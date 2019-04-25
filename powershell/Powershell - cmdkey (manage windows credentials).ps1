
#
# cmdkey  :::  Creates, lists, and deletes stored user names and passwords or credentials  :::  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey
#

$CredentialMatches = @();

$Haystack = (cmdkey /list);

$Needle="git:https\://";

$RegexPattern = (('^\s*Target:\s*([^:]+):target=(')+($Needle)+('[a-zA-Z0-9\/\-\@\.]+)\s*$'));

$NeedlesFound = 0;

ForEach ($EachLine in $Haystack) {
	$Needle = [Regex]::Match($EachLine, $RegexPattern);
	If ($Needle.Success -eq $True) {
		If ($CredentialMatches -eq $Null) {
			$CredentialMatches = @{};
		}
		If ($CredentialMatches -eq $Null) {
			$CredentialMatches = @();
		}
		$CredentialMatches += @{
			Type = $Needle.Groups[1].Value;
			Target = $Needle.Groups[2].Value;
		}
		$NeedlesFound++;
		# Break;
	}
}

Write-Host "`n`n";

If ($NeedlesFound -eq 0) {

	Write-Host (("Found [ 0 ] Windows-Credentials matching `"")+($Needle)+("`" "));

} Else {

	Write-Host (("`nMatched [ ")+($NeedlesFound)+(" ] Windows-Credentials matching `"")+($Needle)+("`"`n")) -ForegroundColor Yellow;
	# $CredentialMatches | Format-List;
	ForEach ($EachCredential in $CredentialMatches) {
		Write-Host (("    [ ")+($EachCredential.Type)+(" ]   ")+($EachCredential.Target));
	}

	Write-Host (("`nProceed with deleting above Windows Credential(s)? (Y/N)`n")) -ForegroundColor Yellow;

	# !!! PERFORM "y/n" USER-INPUT CHECK TO CONFIRM DELETION OF CREDENTIALS !!!

	$UserAgreed_BeginDeletingCredentials = $False;

	If ($UserAgreed_BeginDeletingCredentials -eq $True) {
		cmdkey /del:($_ -replace " ","" -replace "Target:","");
	}

}

Write-Host "`n`nClosing after 60s...`n`n";

Start-Sleep -Seconds 60


#
#	Citation(s)
#	
#		Thanks to StackOverflow user [ Jebuz ] for their post on forum [ https://stackoverflow.com/questions/39478018 ]
#
