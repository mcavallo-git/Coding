# ------------------------------------------------------------
#
# PowerShell - Set service 'Log on as' user to built-in account 'Local System', 'Local Service', 'Network Service' (sc.exe)
#
# ------------------------------------------------------------

$ServiceNames=$("MSSQLSERVER","SQLSERVERAGENT");

# $Logon_Username="LocalSystem"; <# Log on as built-in account 'Local System' #>
# $Logon_Username="NT Authority\LocalService"; <# Log on as built-in account 'Local Service' #>
$Logon_Username="NT Authority\NetworkService"; <# Log on as built-in account 'Network Service' #>

$Logon_Password="";

Get-Service `
| Where-Object { ${ServiceNames} -Contains $_.Name; } `
| ForEach-Object {
	If ($_.Status -Eq "Running") {
		$Running_DependentServices = ($_ | Get-Service -DependentServices | Where-Object { $_.Status -Eq "Running" });
		If (${Running_DependentServices} -NE $Null) {
			Write-Host "Stopping dependent service(s): [ $(${Running_DependentServices}.Name -join ', ') ]";
			$Running_DependentServices | Stop-Service;
		};
		Write-Host "Stopping service: [ $($_.Name) ]";
		$_ | Stop-Service;
	};
	Write-Host "Setting service 'Log on as' user to '${Logon_Username}' for service `"$($_.Name)`"...";
	Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList ("config `"$($_.Name)`" obj=`"${Logon_Username}`"") -Wait -PassThru; <# -Verb "RunAs" #>
	If ($_.Status -Eq "Stopped") {
		If (${Running_DependentServices} -NE $Null) {
			Write-Host "Starting dependent service(s): [ $(${Running_DependentServices}.Name -join ', ') ]";
			$Running_DependentServices | Start-Service;
		};
		Write-Host "Starting service: [ $($_.Name) ]";
		$_ | Start-Service;
	};
};


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-Service (Microsoft.PowerShell.Management) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-service?view=powershell-5.1
#
#   stackoverflow.com  |  "How to change the windows account to localsystem account using Powershell command Set-Service SwitchAccount - Stack Overflow"  |  https://stackoverflow.com/a/64682562
#
# ------------------------------------------------------------