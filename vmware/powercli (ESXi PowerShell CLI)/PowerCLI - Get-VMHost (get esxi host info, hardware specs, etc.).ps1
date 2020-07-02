
Get-VMHost | ForEach-Object {
	Write-Output "------------------------------------------------------------";
	Write-Output "ApiVersion             = $($_.ApiVersion)";
	Write-Output "Build                  = $($_.Build)";
	Write-Output "ConnectionState        = $($_.ConnectionState)";
	Write-Output "CpuTotalMhz            = $($_.CpuTotalMhz)";
	Write-Output "CpuUsageMhz            = $($_.CpuUsageMhz)";
	Write-Output "CryptoState            = $($_.CryptoState)";
	Write-Output "CustomFields           = $($_.CustomFields)";
	Write-Output "DatastoreIdList        = $($_.DatastoreIdList)";
	Write-Output "DiagnosticPartition    = $($_.DiagnosticPartition)";
	Write-Output "ExtensionData          = $($_.ExtensionData)";
	Write-Output "FirewallDefaultPolicy  = $($_.FirewallDefaultPolicy)";
	Write-Output "HyperthreadingActive   = $($_.HyperthreadingActive)";
	Write-Output "Id                     = $($_.Id)";
	Write-Output "IsStandalone           = $($_.IsStandalone)";
	Write-Output "LicenseKey             = $($_.LicenseKey)";
	Write-Output "Manufacturer           = $($_.Manufacturer)";
	Write-Output "MaxEVCMode             = $($_.MaxEVCMode)";
	Write-Output "MemoryTotalGB          = $($_.MemoryTotalGB)";
	Write-Output "MemoryTotalMB          = $($_.MemoryTotalMB)";
	Write-Output "MemoryUsageGB          = $($_.MemoryUsageGB)";
	Write-Output "MemoryUsageMB          = $($_.MemoryUsageMB)";
	Write-Output "Model                  = $($_.Model)";
	Write-Output "Name                   = $($_.Name)";
	Write-Output "NetworkInfo            = $($_.NetworkInfo)";
	Write-Output "NumCpu                 = $($_.NumCpu)";
	Write-Output "Parent                 = $($_.Parent)";
	Write-Output "ParentId               = $($_.ParentId)";
	Write-Output "PowerState             = $($_.PowerState)";
	Write-Output "ProcessorType          = $($_.ProcessorType)";
	Write-Output "State                  = $($_.State)";
	Write-Output "StorageInfo            = $($_.StorageInfo)";
	Write-Output "TimeZone               = $($_.TimeZone)";
	Write-Output "Uid                    = $($_.Uid)";
	Write-Output "Version                = $($_.Version)";
	Write-Output "VMSwapfileDatastore    = $($_.VMSwapfileDatastore)";
	Write-Output "VMSwapfileDatastoreId  = $($_.VMSwapfileDatastoreId)";
	Write-Output "VMSwapfilePolicy       = $($_.VMSwapfilePolicy)";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   pubs.vmware.com  |  "Get-VMHost - vSphere PowerCLI Cmdlets Reference"  |  https://pubs.vmware.com/vsphere-51/index.jsp?topic=%2Fcom.vmware.powercli.cmdletref.doc%2FGet-VMHost.html
#
# ------------------------------------------------------------