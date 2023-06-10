# ------------------------------------------------------------
# PowerShell - Read-Host -AsSecureString (get user input, password, token, etc.)
# ------------------------------------------------------------
#
# Show a confirmation prompt to the user
#  |--> Note: This only really cares about "y" confirmation responses, and lumps all the others as cancel actions
#

If ($True) {
	Write-Output "Info:  Yes or no?  (press 'y' to confirm)";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If ($KeyPress.Character -Eq "y") {
		Write-Host "Info:  Confirmed (received `"y`" keypress)";
	} Else {
		Write-Host "Info:  Skipped (did not receive `"y`" keypress)";
	}
}


# ------------------------------------------------------------
#
# Wait endlessly for a single keypress
#

Write-Output "Info:  System restart required - Press 'y' to confirm and reboot this machine, now...";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
While ($KeyPress.Character -NE "y") {
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
}


# ------------------------------------------------------------
#
# Read a generic string in from the user
#

$UsernamePlaintext = Read-Host -Prompt 'Type an example Username (in plaintext)';
Write-Output "You typed `"${UsernamePlaintext}`"";


# ------------------------------------------------------------
#
# Read a Securestring in from the user & convert it to plaintext
#

$SecureString_ToPlainText = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt 'Type an example securestring'))));
Write-Output "You typed `"${SecureString_ToPlainText}`"";


# ------------------------------------------------------------
#
# Set a group of services to run using a combined service-user
#

If ($True) {
	Write-Output "`n`n";
	Write-Output "         Do you wish to set the service `"Log On`" user for [SERVICE_TYPE] services, now?  (press 'y' to confirm)";
	$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
	If ($KeyPress.Character -Eq "y") {
		<# Suggest a domainname\username for service user #>
		$CommonServiceUser = "${Env:USERDNSDOMAIN}\[COMMON_SERVICE_USERNAME]";
		Write-Output "`nPrompt:  Suggested service user is `"${CommonServiceUser}`" - Use this username?  (press 'y' to confirm)";
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
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1')); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		CheckPendingRestart;
	} Else {
		Write-Output "Info:  Skipped [ Set service `"Log On`" user ] - NO CHANGES MADE";
	}
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Read-Host - Reads a line of input from the console."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/read-host?view=powershell-5.1
#
#   stackoverflow.com  |  "c# - Convert String to SecureString - Stack Overflow"  |  https://stackoverflow.com/a/43084626
#
#   www.scriptinglibrary.com  |  "Passwords and SecureString, How To Decode It with Powershell | Scripting Library"  |  https://www.scriptinglibrary.com/languages/powershell/securestring-how-to-decode-it-with-powershell/
#
# ------------------------------------------------------------