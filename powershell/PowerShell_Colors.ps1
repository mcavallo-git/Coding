
$ColorSets = @{};
$ColorSets.ErrorForegroundColor = "Red";
$ColorSets.ErrorBackgroundColor = "Black";
$ColorSets.WarningForegroundColor = "Yellow";
$ColorSets.WarningBackgroundColor = "Black";
$ColorSets.DebugForegroundColor = "Yellow";
$ColorSets.DebugBackgroundColor = "Black";
$ColorSets.VerboseForegroundColor = "Yellow";
$ColorSets.VerboseBackgroundColor = "Black";
$ColorSets.ProgressForegroundColor = "Yellow";
$ColorSets.ProgressBackgroundColor = "DarkCyan";


# $HOST.PrivateData.ErrorForegroundColor = "Red";
# $HOST.PrivateData.ErrorBackgroundColor = "Black";
# $HOST.PrivateData.WarningForegroundColor = "Yellow";
# $HOST.PrivateData.WarningBackgroundColor = "Black";
# $HOST.PrivateData.DebugForegroundColor = "Yellow";
# $HOST.PrivateData.DebugBackgroundColor = "Black";
# $HOST.PrivateData.VerboseForegroundColor = "Yellow";
# $HOST.PrivateData.VerboseBackgroundColor = "Black";
# $HOST.PrivateData.ProgressForegroundColor = "Yellow";
# $HOST.PrivateData.ProgressBackgroundColor = "DarkCyan";

Foreach ($DatSetting In $ColorSets.GetEnumerator()) {
	
	$DatName = $DatSetting.Name;
	
	# $DatUpdated = $DatSetting.Value;
	$DatUpdated = "Red";

	If ($DatUpdated -ne $DatCurrent) {

		Write-Host -NoNewLine "Updating variable `$HOST.PrivateData.$DatName ";

		If ($HOST.PrivateData[$DatName] -ne $null) {

			$DatCurrent = $HOST.PrivateData[$DatName];

			Write-Host -NoNewLine "from "; Write-Host -NoNewLine $DatCurrent -ForegroundColor $DatCurrent;
			
		}

		If ($HOST.PrivateData[$DatName] -ne $null) {

			$DatCurrent = $HOST.PrivateData[$DatName];

			Write-Host -NoNewLine "from [ ";
				Write-Host -NoNewLine $DatCurrent -ForegroundColor $DatCurrent;
			Write-Host -NoNewLine " ]";
			
		}

		If ($DatUpdated -ne $null) {

			Write-Host -NoNewLine "to [ ";
				Write-Host -NoNewLine $DatUpdated -ForegroundColor $DatUpdated;
			Write-Host -NoNewLine " ]";

		}

	}

	Write-Host "`n";

}

# $HOST.PrivateData
