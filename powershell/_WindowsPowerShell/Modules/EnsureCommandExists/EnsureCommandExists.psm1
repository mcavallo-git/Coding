function EnsureCommandExists {
	Param(
		
		[Parameter(Mandatory=$true)]
		[String]$Name,

		[Switch]$Quiet,

		[String]$OnErrorShowUrl = "",

		[Switch]$ContinueOnErrors,

		[ValidateSet("","version","-version","--version","/version","-v","--v","/v")]
		[String]$VersionMethod="",

		[String]$VersionRegex="",

		[String]$VersionSeparator="",

		$VersionMinLevels = $null
		
	)

	If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Info: Checking for local command: ") + ($Name)); }

	$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';
	$GetCommand = (Get-Command $Name);
	$ErrorActionPreference = $Revertable_ErrorActionPreference;
	
	$MinimumVersion = $null;
	$CurrentVersion = $null;
	$ErrorMessage = $null;
	$ValidLevels = $Null;
	$LeftmostIndexExceeded = $Null;

	If($GetCommand -eq $null) {
		#
		# Fail - Command not found
		#
		$ErrorMessage = (("Fail - Command not found: ") + ($Name));

	} Else {
		#
		# Pass - Command Exists
		#

		If (($PSBoundParameters.ContainsKey('VersionMethod')) -and ($VersionMethod -ne "")) {


			$VersionExpression = (($Name)+(" ")+($VersionMethod));

			$Haystack = Invoke-Expression -Command ($VersionExpression);
			$Needle = $null;
			ForEach ($EachLine in $Haystack) {
				$Needle = [Regex]::Match($EachLine, $VersionRegex);
				If ($Needle.Success -eq $True) {
					$MinimumVersion = "";
					$CurrentVersion = "";
					$VersionMinLevels.Keys | Sort | Foreach {
						$EachKey = [Int]$_;
						If ($EachKey -gt 1) {
							$MinimumVersion += $VersionSeparator;
							$CurrentVersion += $VersionSeparator;
						}
						$MinimumVersion += [String]$VersionMinLevels[$EachKey];
						$CurrentVersion += [String]$Needle.Groups[$EachKey].Value;
						If ($LeftmostIndexExceeded -eq $Null) { # If a previous (more-leftmost) index has a higher version, don't worry any to the right of it being lower-or-not
							If (([int]$Needle.Groups[$EachKey].Value) -gt ([int]$VersionMinLevels[$EachKey])) {
								If ($ValidLevels -ne $False) { # Leave fail-out status as False if its already False
									$ValidLevels = $True; # Require at least one minimum-version-level to be matched (if we're performing matching)
									$LeftmostIndexExceeded = $EachKey; # Save the highest index which was greater-than the required version
								}
							} ElseIf (([int]$Needle.Groups[$EachKey].Value) -eq ([int]$VersionMinLevels[$EachKey])) {
								If ($ValidLevels -ne $False) {
									$ValidLevels = $True; # Require at least one minimum-version-level to be matched (if we're performing matching)
								}
							} Else {
								$ValidLevels = $False;
							}
						}
					};
					
# Write-Host ("MinimumVersion");
# Write-Host ($MinimumVersion);
# Write-Host ("CurrentVersion");
# Write-Host ($CurrentVersion);

					If (($ValidLevels -ne $Null) -and ($ValidLevels -ne $False)) {
						Write-Host "Found local install:   $Name v$CurrentVersion";
						$CommandExists ;
					} Else {
						$ErrorMessage = "Fail - [ $VersionExpression ] does exist locally, but the version installed: $CurrentVersion, is too-low compared to the required minimum version: $MinimumVersion";
					}
					Break;
				}
			}
						
			If (($Needle.Success -ne $null) -and ($Needle.Success -eq $True)) {
				# $CurrentVersion = $Needle.Groups[0];
				# Write-Host "Found local install: `"$Name`" v$CurrentVersion";
			} Else {
				$ErrorMessage = "Fail - Local command not-found: [ $Name ]";
			}

		} Else {

			$CurrentVersion = [System.String]::Join(".",($GetCommand.Version));
		
		}

		#
		# Check installed version
		#
		
		#
		# ...
		#
		# $Haystack = az --version;
		# $RegexPattern = '^(azure\-cli\ \()([\d\.]+)(\))';
		# $Needle = [Regex]::Match($Haystack, $RegexPattern);
		# $Needle.Groups[2].Value;
		#
		#	...
		#
		### Parse a webpage's HTML
		# $OnErrorShowUrl = "https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest"));
		# $uri = ([System.Uri]($OnErrorShowUrl));
		# $uri;
		#
		# ...
		#

	}

	If ($ErrorMessage -eq $null) {
		
		# Pass - Command exists
		$CommandExists = 1;
		If (!($PSBoundParameters.ContainsKey('Quiet'))) { Write-Host (("Pass - Command exists: ") + ($Name) + (" (v") + ($CurrentVersion) + (")")); }

	} Else {

		# Fail - Command not found / has an invalid version
		$CommandExists = 0;
		Write-Host $ErrorMessage;

		If ($PSBoundParameters.ContainsKey('OnErrorShowUrl')) {

			#
			# Check to make sure the "Start" command exists
			#
			$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';
			$GetStartCommand = (Get-Command "Start");
			$ErrorActionPreference = $Revertable_ErrorActionPreference;

			If (!($PSBoundParameters.ContainsKey('Quiet'))) {
				Write-Host (("For Info on troubleshooting, download/installation references, etc. please visit Url: ")+($OnErrorShowUrl));
			}

			$StartCmdExists = If($GetStartCommand -eq $null){0}Else{1};
			If ($StartCmdExists -eq 1) {

				# On windows devices, calling [ Start $URL ] will open a browser to target URL
				Write-Host (("Opening browser to URL: ")+($OnErrorShowUrl));
				Start ($OnErrorShowUrl);

			}

		}

		If (!($PSBoundParameters.ContainsKey('ContinueOnErrors'))) {

			# Do not continue on errors - Exit now
			BombOut `
			-ExitCode 1 `
			-MessageOnError ($ErrorMessage) `
			-MessageOnSuccess ("");

		}

	}

	Return $CommandExists;
}

Export-ModuleMember -Function "EnsureCommandExists";

# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Invoke-Expression - Runs commands or expressions on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/invoke-expression?view=powershell-5.1
#
# ------------------------------------------------------------