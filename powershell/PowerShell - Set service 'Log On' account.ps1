If ($True) {
	Write-Output "`n`n";
	Write-Output "         Do you wish to set the service `"Log On`" user for [SERVICE_TYPE] services, now? (y/n)";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If ($KeyPress.Character -Eq "y") {
		<# Suggest a domainname\username for service user #>
		$CommonServiceUser = "${Env:USERDNSDOMAIN}\[COMMON_SERVICE_USERNAME]";
		Write-Output "`nPrompt:  Suggested service user is `"${CommonServiceUser}`" - Use this username? (y/n)";
		$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
		If ($KeyPress.Character -Eq "y") {
			$UsernamePlaintext = ${CommonServiceUser};
		} Else {
			$UsernamePlaintext = Read-Host -Prompt "`nPrompt:  Enter service user's username";
		}
		$SecureString_Password = Read-Host -AsSecureString -Prompt "`nPrompt:  Enter password for service-user `"${UsernamePlaintext}`"";
		<# Sub-Function to perform the actual updating of the service "Log On" users #>
		Function Set-ServiceAcctCreds([String]$ComputerName,[String]$ServiceName,[String]$CredsUsername,[System.Security.SecureString]$CredsPasswordSecureString) {
			<# Verify that a service matching the given name exists #>
			If ((Get-Service "$ServiceName" -ErrorAction "SilentlyContinue") -NE $Null) {
				Write-Output "`nSetting user `"${CredsUsername}`" as the Log On user for service `"${ServiceName}`"...";
				$StartService_UponCompletion = $False;
				If ((Get-Service "$ServiceName" -ErrorAction "SilentlyContinue") -Eq "Running") {
					$StartService_UponCompletion = $True;
				}
				$ServiceNameFilter = 'Name=' + "'" + $ServiceName + "'" + '';
				$Service = Get-WMIObject -ComputerName $ComputerName -namespace "root\cimv2" -class Win32_Service -Filter $ServiceNameFilter;
				$ServiceChange_Return = $service.Change($null,$null,$null,$null,$null,$null,$CredsUsername,$([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(${CredsPasswordSecureString})))));
				$ServiceStop_Return = $Service.StopService();
				While ($Service.Started){
					Start-Sleep -Seconds 2;
					$Service = Get-WMIObject -ComputerName $ComputerName -namespace "root\cimv2" -class Win32_Service -Filter $filter;
				};
				If ($StartService_UponCompletion -Eq $True) {
					$ServiceStart_Return = $Service.StartService();
				}
			}
		}
		<# Prep all services to update #>
		$ServiceNames = @();
		$ServiceNames += "SERVICE_NAME_1";
		$ServiceNames += "SERVICE_NAME_2";
		$ServiceNames += "SERVICE_NAME_3";
		$ServiceNames | ForEach-Object {
			<# Update each service's "Log on" user (automatically stops and starts them as-needed) #>
			Set-ServiceAcctCreds -ComputerName (${Env:COMPUTERNAME}) -ServiceName ($_) -CredsUsername (${UsernamePlaintext}) -CredsPasswordSecureString (${SecureString_Password});
		};
		$SecureString_Password = $Null;
		<# Restart IIS Services (Services will be restarted during the logon user-update #>
		$SVC_RESTART="Microsoft FTP Service"; Write-Output "`nRestarting service `"${SVC_RESTART}`""; Restart-Service -DisplayName "${SVC_RESTART}";
		$SVC_RESTART="World Wide Web Publishing Service"; Write-Output "`nRestarting service `"${SVC_RESTART}`""; Restart-Service -DisplayName "${SVC_RESTART}";
		<# Check for pending reboot #>
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		CheckPendingRestart;
	} Else {
		Write-Output "Info:  Skipped [ Set service `"Log On`" user ] - NO CHANGES MADE";
	}
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "windows - Powershell script to change service account - Stack Overflow"  |  https://stackoverflow.com/a/4370900
#
# ------------------------------------------------------------