# 
# SyncRegedits
#   |--> Proxies to "SyncRegistry" PowerShell Method
#
function SyncRegedits {
	Param(
	)

	PrivilegeEscalation -Command ("SyncRegistry");

}

Export-ModuleMember -Function "SyncRegedits";
