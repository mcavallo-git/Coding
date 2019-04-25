
#
# cmdkey  :::  Creates, lists, and deletes stored user names and passwords or credentials  :::  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey
#

$CredentialMatches = @();

$Haystack = (cmdkey /list);

$NameQuery="git:https://";
$NameQuery="TERMSRV";

$CredentialType="Generic";
# $CredentialType="Generic Certificate";
# $CredentialType="Domain Password";

$RegexName = (('^\s*Target:\s*([^:]+):target=(')+($NameQuery)+('[a-zA-Z0-9\/\-\@\.]+)\s*$'));
$RegexType = (('^\s*Type:\s*')+($CredentialType)+('$'));

$NeedlesFound = 0;

ForEach ($EachLine in $Haystack) {
	$EachLine;
	$NeedleResults = [Regex]::Match($EachLine, $RegexName);
	If ($NeedleResults.Success -eq $True) {
		If ($CredentialMatches -eq $Null) {
			$CredentialMatches = @{};
		}
		If ($CredentialMatches -eq $Null) {
			$CredentialMatches = @();
		}
		$CredentialMatches += @{
			Type = $NeedleResults.Groups[1].Value;
			Target = $NeedleResults.Groups[2].Value;
		}
		$NeedlesFound++;
		# Break;
	}
}

Write-Host "`n`n";

If ($NeedlesFound -eq 0) {

	Write-Host (("Found [ 0 ] Windows-Credentials matching `"")+($NameQuery)+("`" "));

} Else {

	Write-Host (("`nMatched [ ")+($NeedlesFound)+(" ] Windows-Credentials matching `"")+($NameQuery)+("`"`n")) -ForegroundColor Yellow;
	# $CredentialMatches | Format-List;
	ForEach ($EachCredential in $CredentialMatches) {
		Write-Host (("    [ ")+($EachCredential.Type)+(" ]   ")+($EachCredential.Target));
	}

	Write-Host -NoNewLine (("`n`nDelete [ ")+($NeedlesFound)+(" ] matched item(s)? (Y/N)`n")) -ForegroundColor Yellow;
	$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');

	If ($UserKeyPress.Character -eq 'y') {
		Write-Host (("Deleting [ ")+($NeedlesFound)+(" ] credentials")) -ForegroundColor Magenta;
		cmdkey /del:($_ -replace " ","" -replace "Target:","");
	} Else {
		Write-Host "No Action Taken" -ForegroundColor Green;
	}

}


Write-Host -NoNewLine "`n`nPress any key to exit...";
$KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host "`n`n";



#
#	Citation(s)
#	
#		Thanks to StackOverflow user [ Jebuz ] for their post on forum [ https://stackoverflow.com/questions/39478018 ]
#
