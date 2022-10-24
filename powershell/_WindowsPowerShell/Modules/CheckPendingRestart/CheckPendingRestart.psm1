# ------------------------------------------------------------
#	PowerShell - CheckPendingRestart
#		|
#		|--> Description:  Exhaustively scours the registry, searching for all possible/known signifiers that a reboot of the system is required
#		|
#		|--> Example:     PowerShell -Command ("CheckPendingRestart")
#
Function CheckPendingRestart() {
	Param(
		[Switch]$AutoApprove,
		[Switch]$Quiet,
		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:

		<# Check for pending reboot #>
		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "ByPass" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/CheckPendingRestart/CheckPendingRestart.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'CheckPendingRestart' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\CheckPendingRestart\CheckPendingRestart.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		CheckPendingRestart;

	}
	# ------------------------------------------------------------

	$RebootFlags = @();
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Updates"; Name="UpdateExeVolatile"; RebootIfKeyExists=$False; RebootIfValueExists=$False; RebootIfNotEqualTo=0; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager"; Name="PendingFileRenameOperations"; RebootIfKeyExists=$False; RebootIfValueExists=$True; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager"; Name="PendingFileRenameOperations2"; RebootIfKeyExists=$False; RebootIfValueExists=$True; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\RebootRequired"; Name="NA"; RebootIfKeyExists=$True; RebootIfValueExists=$False; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Services\Pending"; Name="NA"; RebootIf="Any GUID subkeys exist"; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\PostRebootReporting"; Name="NA"; RebootIfKeyExists=$True; RebootIfValueExists=$False; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce"; Name="DVDRebootSignal"; RebootIfKeyExists=$False; RebootIfValueExists=$True; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootPending"; Name="NA"; RebootIfKeyExists=$True; RebootIfValueExists=$False; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\RebootInProgress"; Name="NA"; RebootIfKeyExists=$True; RebootIfValueExists=$False; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Component Based Servicing\PackagesPending"; Name="NA"; RebootIfKeyExists=$True; RebootIfValueExists=$False; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\ServerManager\CurrentRebootAttempts"; Name="NA"; RebootIfKeyExists=$True; RebootIfValueExists=$False; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon"; Name="JoinDomain"; RebootIfKeyExists=$False; RebootIfValueExists=$True; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Netlogon"; Name="AvoidSpnSet"; RebootIfKeyExists=$False; RebootIfValueExists=$True; RebootIfNotEqualTo=$Null; }
	$RebootFlags += @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName"; Name="ComputerName"; RebootIfKeyExists=$False; RebootIfValueExists=$False; RebootIfNotEqualTo="$((Get-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName').ComputerName)"; }

	$RebootRequired = $False;

	# Exhaustively scour the registry, searching for all possible/known signifiers that a reboot of the system is required
	ForEach ($EachRegEdit In $RebootFlags) {
		If ($EachRegEdit.RebootIfKeyExists -Eq $True) {
			If ((Test-Path -Path ($EachRegEdit.Path)) -Eq $True) {
				$RebootRequired = $True;
			}
		} Else {
			Try {
				$PropValue = (Get-ItemPropertyValue -Path ($EachRegEdit.Path) -Name ($EachRegEdit.Name) -ErrorAction ("Stop"));
			} Catch {
				$PropValue = $Null;
			};
			If ($PropValue -NE $Null) { # Registry-Key-Property exists
				If ($EachRegEdit.RebootIfValueExists -Eq $True) {
					$RebootRequired = $True;
				} ElseIf ($PropValue -NE $EachRegEdit.RebootIfNotEqualTo) {
					$RebootRequired = $True;
				}
			}
		}
	}

	If ($RebootRequired -Eq $True) {
		<# Reboot IS required #>
		If (!($PSBoundParameters.ContainsKey('AutoApprove'))) {
			<# Require that the user enters a 'y' character into the terminal before rebooting #>
			Write-Host -NoNewLine "Info:  System restart required - Press 'y' to confirm and reboot this machine, now..." -ForegroundColor "Yellow" -BackgroundColor "Black";
			$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
			While ($KeyPress.Character -NE "y") {
				$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
			}
		}
		<# Reboot the machine #>
		Start-Process -Filepath ("shutdown") -ArgumentList (@("/t 0","/r")) -NoNewWindow -Wait -PassThru;
	} Else {
		<# Reboot NOT required#>
		Write-Host -NoNewLine "Info:  Restart not required" -ForegroundColor "Cyan" -BackgroundColor "Black";
		Write-Host -NoNewLine "  (no pending-reboot flags found)" -ForegroundColor "Gray" -BackgroundColor "Black";
	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "CheckPendingRestart";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   adamtheautomator.com  |  "How to check for a pending reboot (automated with PowerShell)"  |  https://adamtheautomator.com/pending-reboot-registry-windows/
#
# ------------------------------------------------------------