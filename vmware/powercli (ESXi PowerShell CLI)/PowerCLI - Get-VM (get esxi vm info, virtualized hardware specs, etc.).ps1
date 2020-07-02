
Get-VM | ForEach-Object {
	Write-Output "------------------------------------------------------------";
	Write-Output "CoresPerSocket           =  $($_.CoresPerSocket)";
	Write-Output "CreateDate               =  $($_.CreateDate)";
	Write-Output "CustomFields             =  $($_.CustomFields)";
	Write-Output "DatastoreIdList          =  $($_.DatastoreIdList)";
	Write-Output "DrsAutomationLevel       =  $($_.DrsAutomationLevel)";
	Write-Output "ExtensionData            =  $($_.ExtensionData)";
	Write-Output "Folder                   =  $($_.Folder)";
	Write-Output "FolderId                 =  $($_.FolderId)";
	Write-Output "Guest                    =  $($_.Guest)";
	Write-Output "GuestId                  =  $($_.GuestId)";
	Write-Output "HAIsolationResponse      =  $($_.HAIsolationResponse)";
	Write-Output "HardwareVersion          =  $($_.HardwareVersion)";
	Write-Output "HARestartPriority        =  $($_.HARestartPriority)";
	Write-Output "Id                       =  $($_.Id)";
	Write-Output "MemoryGB                 =  $($_.MemoryGB)";
	Write-Output "MemoryMB                 =  $($_.MemoryMB)";
	Write-Output "Name                     =  $($_.Name)";
	Write-Output "Notes                    =  $($_.Notes)";
	Write-Output "NumCpu                   =  $($_.NumCpu)";
	Write-Output "PersistentId             =  $($_.PersistentId)";
	Write-Output "PowerState               =  $($_.PowerState)";
	Write-Output "ProvisionedSpaceGB       =  $($_.ProvisionedSpaceGB)";
	Write-Output "ResourcePool             =  $($_.ResourcePool)";
	Write-Output "ResourcePoolId           =  $($_.ResourcePoolId)";
	Write-Output "Uid                      =  $($_.Uid)";
	Write-Output "UsedSpaceGB              =  $($_.UsedSpaceGB)";
	Write-Output "VApp                     =  $($_.VApp)";
	Write-Output "Version                  =  $($_.Version)";
	Write-Output "VMHost                   =  $($_.VMHost)";
	Write-Output "VMHostId                 =  $($_.VMHostId)";
	Write-Output "VMResourceConfiguration  =  $($_.VMResourceConfiguration)";
	Write-Output "VMSwapfilePolicy         =  $($_.VMSwapfilePolicy)";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   pubs.vmware.com  |  "Get-VM - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-VM.html
#
# ------------------------------------------------------------