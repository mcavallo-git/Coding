function Get-MetaData
{
	Param
	(
			[Parameter(Mandatory=$true)]
			[string]$Directory = "",
		
			[Parameter(Mandatory=$true,
			HelpMessage="extension IE. .mp3, .txt or .mov")]
			[String]$FileExtension = "",
			
			[Switch]$recurse
	)

	if ($recurse) {
		$LPath = Get-ChildItem -Path $Directory -Directory -Recurse
	} else {
		$LPath = $Directory
	}

	$DirectoryCount = 1
	$RetrievedMetadata = $true
	$OutputList = New-Object 'System.Collections.generic.List[psobject]'

	foreach ($pa in $LPath) {
		
		$shell = New-Object -ComObject shell.application

		if ($recurse) {
			$objshell = $shell.NameSpace($pa.FullName)
		} else {
			$objshell = $shell.NameSpace($pa)
		}

		# Build data list
		$count = 0

		# Filter on filetype
		$filter = $objshell.items() | where {$_.Path -match $FileExtension}
		foreach ($file in $filter) {

			if ($RetrievedMetadata) {
				# Build metanumbers
				Write-Verbose "Building MetaIndex for filetype $FileExtension"
				$Metanumbers = New-Object -TypeName 'System.Collections.Generic.List[int]'
				for ($a = 0 ; $a -le 400;$a++)
				{
					if ($objshell.GetDetailsOf($file,$a))
					{
						$Metanumbers.Add([int]$a)
					}
				}
				$RetrievedMetadata = $false
				Write-Verbose "$($Metanumbers.Count) entries in MetaIndex for filetype $FileExtension"
			}

			$count++

			$CurrentDirectory = Get-ChildItem -Path $file.Path

			try {
				Write-Progress -Activity " Getting metadata from $DirectoryCount/$($LPath.count) $($CurrentDirectory[0].DirectoryName)" -Status "Working on $count/$($filter.count) - $($file.Name)" -PercentComplete (($count / $filter.count) * 100) -ErrorAction stop
			} catch {

			}

			# Build Hashtable for each file
			$Hash = @{}
			foreach ($nr in $Metanumbers) {
				$PropertyName = $($objshell.GetDetailsOf($objshell.Items, $nr))
				$PropertyValue = $($objshell.GetDetailsOf($File, $nr))
				$Hash[$PropertyName] = $PropertyValue
			}
			
			$Hash.Remove("")
			$FileMetaData = New-Object -TypeName PSobject -Property $hash
			$OutputList.Add($FileMetaData)
			$hash = $null
		}

		$DirectoryCount++

	}

	Write-Verbose "MetaData for $($OutputList.count) files found"

	Return $OutputList | Sort-Object

}
Export-ModuleMember -Function "Get-MetaData";

# ------------------------------------------------------------
#
# Example Call:
#   Get-MetaData -Directory "${ENV:USERPROFILE}\Desktop" -FileExtension "vssx";
#
# ------------------------------------------------------------
# Citation(s)
#
#   reddit.com  |  "Get-Metadata"  |  https://www.reddit.com/r/PowerShell/comments/8ch81m/getmetadata/
#
# ------------------------------------------------------------