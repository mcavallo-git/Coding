function Basename {
	Param(
		[Switch]$NoExtension,

		[Switch]$WithoutExtension,

		[Parameter(Position=0, ValueFromRemainingArguments)]
		$InputPath
	)

	If ((($PSBoundParameters.ContainsKey('NoExtension')) -Eq ($True)) -Or (($PSBoundParameters.ContainsKey('WithoutExtension')) -Eq ($True))) {
		$Basename = ([System.IO.Path]::GetFileNameWithoutExtension(${InputPath}));
	} Else {
		$Basename = ([System.IO.Path]::GetFileName(${InputPath}));
	}

	Write-Output (${Basename});

	Return;

}
Export-ModuleMember -Function "Basename";


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Path Class - Performs operations on String instances that contain file or directory path information"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.path?view=netframework-4.8
#
# ------------------------------------------------------------