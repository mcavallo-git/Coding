
function install_docker {
	Param(
	)


	If ((RunningAsAdministrator) -Ne ($True)) {

		PrivilegeEscalation -Command ("install_docker");

	} Else {

		$WSL_State = ((Get-WindowsOptionalFeature -Online | Where-Object { $_.FeatureName -Like "*Linux*" }).State);
		
		If ( "${WSL_State}" -Ne "Enabled" ) {
			Write-Output "Error - WSL Feature has state `"${WSL_State}`" - Required state is `"Enabled`""
			Write-Output "        Please the `"Windows Subsystem for Linux`" Feature";

		} Else {

		}

	}

}

Export-ModuleMember -Function "install_docker";

# ------------------------------------------------------------
# Citation(s)
#   
#   medium.com/faun  |  "Docker Running Seamlessly in Windows Subsystem Linux"  |  https://medium.com/faun/docker-running-seamlessly-in-windows-subsystem-linux-6ef8412377aa
#
# ------------------------------------------------------------