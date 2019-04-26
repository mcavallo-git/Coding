
#   Black
#   DarkBlue
#   DarkGreen
#   DarkCyan
#   DarkRed
#   DarkMagenta
#   DarkYellow
#   Gray
#   DarkGray
#   Blue
#   Green
#   Cyan
#   Red
#   Magenta
#   Yellow
#   White



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

#
#	Citation(s)
#
#
#		docs.microsoft.com
#			"Write-Host"
#			 https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-host
#
