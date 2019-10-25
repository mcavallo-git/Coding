
function install_docker {
	Param(
	
	)


	If ((RunningAsAdministrator) -Ne ($True)) {

		PrivilegeEscalation -Command ("install_docker");

	} Else {



	}

}

Export-ModuleMember -Function "install_docker";

# ------------------------------------------------------------
# Citation(s)
#   
#   medium.com/faun  |  "Docker Running Seamlessly in Windows Subsystem Linux"  |  https://medium.com/faun/docker-running-seamlessly-in-windows-subsystem-linux-6ef8412377aa
#
# ------------------------------------------------------------