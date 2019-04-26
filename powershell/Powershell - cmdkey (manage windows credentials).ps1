
#
# cmdkey  :::  Creates, lists, and deletes stored user names and passwords or credentials  :::  https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/cmdkey
#

$CredentialMatches = @();

$TargetContains="github";

$Haystack = (cmdkey /list);
$SelectedArray = $Haystack;

$NeedlesFound = 0;
$LineNumber = 0;
ForEach ($EachLine in $SelectedArray) {
	If ($EachLine.StartsWith("    Target: ") -eq $True) {
		$NextLine = $SelectedArray[$LineNumber+1];
		$EachTarget = $EachLine -Split ":target=" | Select -Skip 1 -First 1;
		$EachType = ($NextLine.Replace("    Type: ","")).Trim();
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

Write-Host "";

Write-Host -NoNewLine "Found [ ";
Write-Host -NoNewLine ($NeedlesFound) -ForegroundColor Green;
Write-Host -NoNewLine " ] Windows-Credential(s) with `"";
Write-Host -NoNewLine ($TargetContains) -ForegroundColor Green;
Write-Host -NoNewLine "`" in their target";


Write-Host "";

If ($NeedlesFound -ne 0) {

	Write-Host "";
	$DeletePrepMsg = (("This will delete the following [ ")+($NeedlesFound)+(" ] credential(s):"));
	ForEach ($EachCredential in $CredentialMatches) {
		Write-Host (("  [ ")+($EachCredential.Type)+(" ]  ")+($EachCredential.Target));
	}
	Write-Host "";
	
	# First Confirmation step
	$ConfirmKeyList = "abcdefghijklmopqrstuvwxyz"; # removed 'n'
	$FirstConfirmKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList));
	Write-Host -NoNewLine ("Are you sure you want to delete these credentials?") -BackgroundColor Black -ForegroundColor Yellow;
	Write-Host -NoNewLine (" If so, type the letter [ ") -ForegroundColor Yellow;
	Write-Host -NoNewLine ($FirstConfirmKey) -ForegroundColor Green;
	Write-Host -NoNewLine (" ]:  ") -ForegroundColor Yellow;
	$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
	If (($UserKeyPress.Character) -eq ($FirstConfirmKey)) {

		# Second Confirmation step (since we're deleting credentials)
		$SecondConfirmKey = (Get-Random -InputObject ([char[]]$ConfirmKeyList.Replace([string]$FirstConfirmKey,"")));
		Write-Host -NoNewLine ("Really really sure?") -BackgroundColor Black -ForegroundColor Yellow;
		Write-Host -NoNewLine (" If so, type the letter [ ") -ForegroundColor Yellow;
		Write-Host -NoNewLine ($SecondConfirmKey) -ForegroundColor Green;
		Write-Host -NoNewLine (" ]:  ") -ForegroundColor Yellow;
		$UserKeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown'); Write-Host (($UserKeyPress.Character)+("`n"));
		If (($UserKeyPress.Character) -eq ($SecondConfirmKey)) {
		ForEach ($EachCredential in $CredentialMatches) {
				$EachTarget = $EachCredential.Target;
				$EachType = $EachCredential.Type;
				Write-Host -NoNewLine "Deleting $EachType w/ Target `"$EachTarget`"...";
				cmdkey /delete:($EachTarget);
			}
		} Else {
			Write-Host "No Action Taken" -ForegroundColor Green;
		}
	} Else {
		Write-Host "No Action Taken" -ForegroundColor Green;
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
