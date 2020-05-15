If ($True) {
	$ServiceNames = @();
	$ServiceNames += "SERVICE_NAME_1";
	$ServiceNames += "SERVICE_NAME_2";
	Function Set-ServiceAcctCreds([string]$strCompName,[string]$strServiceName,[string]$newAcct,[string]$newPass) {
		$filter = 'Name=' + "'" + $strServiceName + "'" + '';
		$service = Get-WMIObject -ComputerName $strCompName -namespace "root\cimv2" -class Win32_Service -Filter $filter;
		$service.Change($null,$null,$null,$null,$null,$null,$newAcct,$newPass);
		$service.StopService();
		While ($service.Started){
			Start-Sleep -Seconds 2;
			$service = Get-WMIObject -ComputerName $strCompName -namespace "root\cimv2" -class Win32_Service -Filter $filter;
		};
		$service.StartService();
	}
	$UsernamePlaintext = Read-Host -Prompt "Enter [ account to run Services as ]'s username";
	$SecureString_ToPlainText = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt "Enter [ account to run Services as ]'s password"))));
	$ServiceNames | ForEach-Object {
		Write-Output "`nSetting service '$_' to log on as account '${UsernamePlaintext}' ";
		Set-ServiceAcctCreds -strCompName "${Env:COMPUTERNAME}" -strServiceName "$_" -newAcct "${UsernamePlaintext}" -newPass "${SecureString_ToPlainText}";
	};
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "windows - Powershell script to change service account - Stack Overflow"  |  https://stackoverflow.com/a/4370900
#
# ------------------------------------------------------------