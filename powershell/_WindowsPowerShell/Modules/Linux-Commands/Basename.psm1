# 
# Basename
#  |
#  |--> Returns the base-filename (with or without file-extension) of given input-string
#  |
#  |--> Example(s):
#         Basename "${HOME}\tester\test.extension";  <# keeps extension #>
#         Basename -NoExtension "${HOME}\tester\test.extension";  <# removes extension #>
# 
function Basename {
	Param(
		[Switch]$NoExtension,

		[Switch]$WithoutExtension,

		[Parameter(Position=0, ValueFromRemainingArguments)]
		$InputPath
	)

	If ((($PSBoundParameters.ContainsKey('NoExtension')) -Eq ($True)) -Or (($PSBoundParameters.ContainsKey('WithoutExtension')) -Eq ($True))) {
		# Determine the basename WITHOUT extension
		$Basename = ([System.IO.Path]::GetFileNameWithoutExtension(${InputPath}));
	} Else {
		# Determine the basename WITH extension (default)
		$Basename = ([System.IO.Path]::GetFileName(${InputPath}));
	}

	Write-Output (${Basename});

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Basename";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Path Class - Performs operations on String instances that contain file or directory path information"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.path?view=netframework-4.8
#
# ------------------------------------------------------------