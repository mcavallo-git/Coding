#
#	Example Call:
#
#		$HashTable = `
#			JsonDecoder `
#				-InputObject ('{"integer":1,"string":"string","array":[1,2,"a","b"],"object":{"obj-int":2,"obj-str":"test-string"}}') `
#		;
#
function JsonDecoder {

	[CmdletBinding()]

	[OutputType('hashtable')]

	param (
		[Parameter(ValueFromPipeline)]
		$InputObject,

		$RecursiveCall = $false,

		[Int]$Verbosity=0,
		[Switch]$Quiet

	)

	process {

		$ReturnVal = $null;

		$Verbosity = If ($PSBoundParameters.ContainsKey('Quiet') -eq $false) { 0 } Else { $Verbosity };
		
		If ($Verbosity -ge 2) {
			Write-Host "`n`n----------------------------";
			Write-Host (("JsonDecoder - InputObject [")+($InputObject.GetType())+("] =")); Write-Host ($InputObject | Out-String);
		}

		$IsRecursiveCall = $false;
		If ($Env:ConvertToHashtable_RecursiveCall -eq $null) {
			$Env:ConvertToHashtable_RecursiveCall = $true;
			$IsRecursiveCall = $true;
		}

		If ($InputObject -eq $null) {
			#
			# --> Nulls
			#
			$ReturnVal = $null;


		} ElseIf (($InputObject -is [String]) -eq $true) {
			#
			# ---> Strings
			#
			If ($Verbosity -ge 2) { Write-Host "JsonDecoder - InputObject handler area:  [ Strings ]"; }

			$ReturnVal = $InputObject | ConvertFrom-Json; # Return strings converted into JSON-format

		} ElseIf ($InputObject -is [System.Collections.IEnumerable]) {
			#
			# --> Arrays
			#
			$JsonStringArray = $false;
			$ArrayOfStrings = $true;
			ForEach ($EachArrayItem In $InputObject) {
				If (($EachArrayItem -is [String]) -eq $false) {
					$ArrayOfStrings = $false;
				}
			}
			If ($ArrayOfStrings -eq $true) {
				If ((($InputObject[0])[0] -eq "[") -or (($InputObject[0])[0] -eq "{")) {
					$JsonStringArray = $true;
				}
			}

			If ($JsonStringArray -eq $true) {

				# JSON formatted as an array of strings (separated on every newline - az cli outputs this way by-default as-of 2019-04-08) 
				If ($Verbosity -ge 2) { Write-Host "JsonDecoder - InputObject handler area:  [ Array (string-only) ]"; }

				$ReturnVal = $InputObject | Out-String | ConvertFrom-Json;

			} Else {

				If ($Verbosity -ge 2) { Write-Host "JsonDecoder - InputObject handler area:  [ Array (non-string-only) ]"; }

				$CollectionArray = @(
					ForEach ($EachObject In $InputObject) {
						JsonDecoder -InputObject $EachObject; # Recursively convert array [sub objects] to [sub hash tables]
					}
				);
				$ReturnVal = Write-Output -NoEnumerate $CollectionArray; # Avoid enumerating the array-object, as it returns overly-complex data
			}

		} ElseIf ($InputObject -is [PSObject]) {
			#
			# --> Objects  **NOT hash table objects
			#
			If ($Verbosity -ge 2) { Write-Host "JsonDecoder - InputObject handler area:  [ Objects ]"; }

			$HashTable = @{};
			ForEach ($EachProperty In $InputObject.PSObject.Properties) {
				$HashTable[$EachProperty.Name] = JsonDecoder -InputObject $EachProperty.Value; # Recursively convert object [sub objects] to [sub hash tables]
			}
			$ReturnVal = $HashTable;


		} Else {
			#
			# --> Hash Tables
			#
			If ($Verbosity -ge 2) { Write-Host "JsonDecoder - InputObject handler area:  [ Hash Table ]"; }

			$ReturnVal = $InputObject;



		}

		If ($IsRecursiveCall -eq $false) {
			$Env:ConvertToHashtable_RecursiveCall = $null;
			If ($Verbosity -ge 1) {
				Write-Host ($ReturnVal | Format-List | Out-String);
			}
		}

		Return $ReturnVal;

	}

}

Export-ModuleMember -Function "JsonDecoder";

#
# Citation(s)
#
#	Original function "ConvertTo-Hashtable" thanks to:
#		4sysops.com, Convert JSON to a PowerShell hash table", https://4sysops.com/archives/convert-json-to-a-powershell-hash-table
#