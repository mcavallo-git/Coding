# ------------------------------------------------------------
<# RUN THIS SCRIPT ON-THE-FLY:

	$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol;	[System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/Get-FileMetadata/Get-FileMetadata.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-FileMetadata' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-FileMetadata\Get-FileMetadata.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; Get-Command Get-FileMetadata;

#>
# ------------------------------------------------------------
function Get-FileMetaData
{
	<#
	.SYNOPSIS
		Get-FileMetaData returns metadata information about a single file.

	.DESCRIPTION
		This function will return all metadata information about a specific file. It can be used to access the information stored in the filesystem.
	
	.EXAMPLE
		Get-FileMetaData -File "c:\temp\image.jpg"

		Get information about an image file.

	.EXAMPLE
		Get-FileMetaData -File "c:\temp\image.jpg" | Select Dimensions

		Show the dimensions of the image.

	.EXAMPLE
		Get-ChildItem -Path .\ -Filter *.exe | foreach {Get-FileMetaData -File $_.Name | Select Name,"File version"}

		Show the file version of all binary files in the current folder.
	#>

	param([Parameter(Mandatory=$True)][string]$File = $(throw "Parameter -File is required."))

	if(!(Test-Path -Path $File))
	{
		throw "File does not exist: $File"
		Exit 1
	}

	$tmp = Get-ChildItem $File
	$pathname = $tmp.DirectoryName
	$filename = $tmp.Name

	$shellobj = New-Object -ComObject Shell.Application
	$folderobj = $shellobj.namespace($pathname)
	$fileobj = $folderobj.parsename($filename)
	$results = New-Object PSOBJECT
	for($a=0; $a -le 294; $a++)
	{
		if($folderobj.getDetailsOf($folderobj, $a) -and $folderobj.getDetailsOf($fileobj, $a)) 
		{
			$hash += @{$($folderobj.getDetailsOf($folderobj, $a)) = $($folderobj.getDetailsOf($fileobj, $a))}
			$results | Add-Member $hash -Force
		}
	}
	$results
}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-FileMetaData";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   gallery.technet.microsoft.com  |  "Script Get-FileMetaData"  |  https://gallery.technet.microsoft.com/scriptcenter/Get-FileMetaData-3a7ddea7
#
# ------------------------------------------------------------