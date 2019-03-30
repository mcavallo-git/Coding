
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

$HOST.PrivateData.ErrorForegroundColor = "Red";
$HOST.PrivateData.ErrorBackgroundColor = "Black";
$HOST.PrivateData.WarningForegroundColor = "Yellow";
$HOST.PrivateData.WarningBackgroundColor = "Black";
$HOST.PrivateData.DebugForegroundColor = "Yellow";
$HOST.PrivateData.DebugBackgroundColor = "Black";
$HOST.PrivateData.VerboseForegroundColor = "Yellow";
$HOST.PrivateData.VerboseBackgroundColor = "Black";
$HOST.PrivateData.ProgressForegroundColor = "Yellow";
$HOST.PrivateData.ProgressBackgroundColor = "DarkCyan";


Foreach ($DatSetting In $ColorSets) {
	
	Write-Host -NoNewLine "Updating variable $HOST.PrivateData[$DatSettingName]";
	$DatSettingName = $DatSetting.Value;
	
	Write-Host -NoNewLine "from";
	Write-Host -NoNewLine $DatSettingCurrent -ForegroundColor $DatSettingCurrent;
	If ( $HOST.PrivateData[$DatSettingName] -ne $null ) {
		$DatSettingCurrent = $HOST.PrivateData[$DatSettingName];
	}
	$DatSettingUpdated = $DatSetting.Value;

	If ($DatSettingUpdated -ne $DatSettingCurrent) {

		Write-Host -NoNewLine "Updating variable $HOST.PrivateData[$DatSettingName]";

		Write-Host -NoNewLine $DatSettingCurrent -ForegroundColor $DatSettingCurrent;
		
		Write-Host -NoNewLine "to";

		Write-Host -NoNewLine $DatSettingUpdated; -ForegroundColor $DatSettingUpdated;

	}

}

# $HOST.PrivateData
