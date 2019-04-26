
#
# cmdkey  :::  Creates, lists, and deletes stored user names and passwords or credentials  :::  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey
#

$CredentialMatches = @();

$TargetStartsWith="TERMSRV";
$TargetContains="remote";

$Haystack = (cmdkey /list:"$TargetStartsWith*");
$FullHaystack = (cmdkey /list);
$SelectedArray = $Haystack;

$NeedlesFound = 0;
$LineNumber = 0;
ForEach ($EachLine in $SelectedArray) {
	# Write-Host ('-'*25);
	$EachLine;
	If ($EachLine.StartsWith("    Target: ") -eq $True) {
		$NextLine = $SelectedArray[$LineNumber+1];
		$EachTarget = $EachLine.Replace("    Target: ","");
		$EachType = $NextLine.Replace("    Type: ","");
		If ($EachTarget.Contains($TargetContains)) {
			$CredentialMatches += @{
				Type = $EachType;
				Target = $EachTarget;
			}
			$NeedlesFound++;
		}

	}
	$LineNumber++;
}

<#
# $CredentialType="Generic";
# $CredentialType="Generic Certificate";
# $CredentialType="Domain Password";
$RegexName = (('^\s*Target:\s*([^:]+):target=(')+($TargetContains)+('[a-zA-Z0-9\/\-\@\.]+)\s*$'));
$RegexType = (('^\s*Type:\s*')+($CredentialType)+('$'));
$NeedlesFoundRegex = 0;
$LineNumber = 0;
ForEach ($EachLine in $FullHaystack) {
	Write-Host ('-'*25);
	$EachLine;
	$FullHaystack[$LineNumber+1];
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
		$NeedlesFoundRegex++;
	}
	$LineNumber++;
}
#>

Write-Host "`n";

If ($NeedlesFound -eq 0) {

	Write-Host (("Found [ 0 ] Windows-Credentials whose target starts with `"")+($TargetStartsWith)+("`" "));

} Else {

	Write-Host "`n";
	$DeletePrepMsg = (("This will delete the following [ ")+($NeedlesFound)+(" ] credential(s):"));
	Write-Host ((" "*($DeletePrepMsg.Length))+("`n")+($DeletePrepMsg)+("`n")+((" "*($DeletePrepMsg.Length)+("`n")))) -BackgroundColor Magenta -ForegroundColor White;
	# $CredentialMatches | Format-List;
	ForEach ($EachCredential in $CredentialMatches) {
		Write-Host (("  Type:`"")+($EachCredential.Type)+("`", Target:`"")+($EachCredential.Target)+("`"  "));
	}
	
	Write-Host -NoNewLine "`n`nIf you're sure you want to delete these credentials, press 'y': " -ForegroundColor Yellow;
	$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	Write-Host (($UserKeyPress.Character)+("`n"));

	If ($UserKeyPress.Character -eq 'y') {
		ForEach ($EachCredential in $CredentialMatches) {
			$EachTarget = $EachCredential.Target;
			$EachType = $EachCredential.Type;
			Write-Host "  Deleting $EachType w/ Target `"$EachTarget`"..." -ForegroundColor Magenta;
			# cmdkey /delete:($EachTarget);
		}
	} Else {
		Write-Host "`nNo Action Taken" -ForegroundColor Green;
	}

}


Write-Host -NoNewLine "`nPress any key to exit...";
$KeyPressExit = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
Write-Host "`n";



#
#	Citation(s)
#	
#		Thanks to StackOverflow user [ Jebuz ] for their post on forum [ https://stackoverflow.com/questions/39478018 ]
#
