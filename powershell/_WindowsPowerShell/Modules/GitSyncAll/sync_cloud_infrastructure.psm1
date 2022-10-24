# ------------------------------------------------------------
#
#	sync_cloud_infrastructure
#		Quickly pull & update the local device's git repository from the cloud
#
# ------------------------------------------------------------
function sync_cloud_infrastructure {
	#
	# Module to Fetch & Pull all Repositories in a given directory [ %USERPROFILE%\Documents\GitHub ] Directory 
	#
	Param(
		[Switch]$Quiet
	)
	Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; Clear-DnsClientCache; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/main/sync.ps1?t=$((Date).Ticks)")); [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
	Return;
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "sync_cloud_infrastructure";
}
