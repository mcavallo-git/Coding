
$RegEdits = @();

$RegEdits += @{
	Path = "HKCU:\Software\Policies\Microsoft\Windows\Explorer";
	Props = @(
		@{ Name="NoWindowMinimizingShortcuts";  Type="REG_DWORD";  Value="1"; }
	)
};



If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	# Current session does not have Admin-Rights --> open a new session (or request credentials to open a new session) which does
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -Verb RunAs;
	Exit;

} Else {
	#
	#	Example:
	#
	# 		New-Item --> Can be used to create new registry keys (assuming the current powershell session is running with elevated privileges)
	#
	#			Set-ItemProperty --> Can be used to create new registry values (DWord 32-bit, etc.)
	#

	Foreach ($EachRegEdit In $RegEdits) {

		If ((Test-Path -Path ($EachRegEdit.Path)) -eq $true) {
			# Skip creating registry key if it already exists
			Write-Host (("`n`n  Found Registry Key `"")+($EachRegEdit.Path)+("`" (no need to create)`n`n"));
		} Else {
			# Create missing key in the registry
			Write-Host (("`n`n  Creating Registry Key `"")+($EachRegEdit.Path)+("`" `n`n"));
			New-Item -Path ($EachRegEdit.Path);
		}

		Foreach ($EachProp In $EachRegEdit.Props) {
			Write-Host (("`n`n  Checking Property `"")+($EachProp.Name)+("`" on Key`"")+($EachRegEdit.Path)+("`":"));
	
			# Check for each key-property
			$Revertable_ErrorActionPreference = $ErrorActionPreference; $ErrorActionPreference = 'SilentlyContinue';
			$GetEachItemProp = Get-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name);
			$last_exit_code = If($?){0}Else{1};
			$ErrorActionPreference = $Revertable_ErrorActionPreference;

			If ($last_exit_code -eq 0) {

				$EachProp.LastValue = $GetEachItemProp.($EachProp.Name);

				If (($EachProp.LastValue) -eq ($EachProp.Value)) {
					# Existing key-property found with correct value
					Write-Host (("`n`n  Found Existing Property `"")+($EachProp.Name)+("`" on Key `"")+($EachRegEdit.Path)+("`" with correct Value of `"")+($EachProp.Value)+("`" `n`n"));

				} Else {
					# Modify the value of an existing property on an existing registry key
					Write-Host (("`n`n  Updating Property `"")+($EachProp.Name)+("`" on Key `"")+($EachRegEdit.Path)+("`" from `"")+($EachProp.LastValue)+("`" to `"")+($EachProp.Value)+("`" `n`n"));
					Set-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -Value ($EachProp.Value);
					
				}
			} Else {
				# Add the missing property to the Registry Key
				Write-Host (("`n`n  Adding Property `"")+($EachProp.Name)+("`" to Key `"")+($EachRegEdit.Path)+("`" with Value `"")+($EachProp.Value)+("`" `n`n"));
				New-ItemProperty -Path ($EachRegEdit.Path) -Name ($EachProp.Name) -PropertyType ($EachProp.Type) -Value ($EachProp.Value);
				Write-Host " `n`n";

			}
			
		}


	}

}

Write-Host -NoNewLine " Press any key to exit...";
$KeyPress = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
