
#
# cmdkey  :::  Creates, lists, and deletes stored user names and passwords or credentials  :::  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey
#

$CredentialMatches = @();

# $TargetStartsWith="TERMSRV";
$TargetContains="test.123";

# $Haystack = (cmdkey /list:"$TargetStartsWith*");
$Haystack = (cmdkey /list);
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

	Write-Host (("Found [ 0 ] Windows-Credentials with `"")+($TargetContains)+("`" in their target"));

} Else {

	Write-Host "`n";
	$DeletePrepMsg = (("This will delete the following [ ")+($NeedlesFound)+(" ] credential(s):"));
	Write-Host ($DeletePrepMsg) -BackgroundColor DarkRed -ForegroundColor White;
	# $CredentialMatches | Format-List;
	ForEach ($EachCredential in $CredentialMatches) {
		Write-Host (("  Type:`"")+($EachCredential.Type)+("`", Target:`"")+($EachCredential.Target)+("`"  "));
	}
	
	# First Confirmation step
	$ConfirmKeyList = "abcdefghijklmopqrstuvwxyz"; # removed 'n'
	$FirstConfirmKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList)); # removed 'n'
	Write-Host -NoNewLine (("`nAre you sure you want to delete these credentials? Press '")+($FirstConfirmKey)+("' : ")) -ForegroundColor Yellow;
	$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
	If (($UserKeyPress.Character) -eq ($FirstConfirmKey)) {

		# $ConfirmKeyList2 = $ConfirmKeyList.Replace([string]$FirstConfirmKey,"");

		# Second Confirmation step (since we're deleting credentials)
		$SecondConfirmKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList.Replace([string]$FirstConfirmKey,"")));
		Write-Host -NoNewLine (("`nReally really sure? Press '")+($SecondConfirmKey)+("' : ")) -ForegroundColor Yellow;
		$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
		If (($UserKeyPress.Character) -eq ($SecondConfirmKey)) {
		ForEach ($EachCredential in $CredentialMatches) {
				$EachTarget = $EachCredential.Target;
				$EachType = $EachCredential.Type;
				Write-Host "  Deleting $EachType w/ Target `"$EachTarget`"...";
				Write-Host "cmdkey /delete:(`"$EachTarget`");";
				# cmdkey /delete:($EachTarget);
			}
		} Else {
			Write-Host "`nNo Action Taken" -ForegroundColor Green;
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
