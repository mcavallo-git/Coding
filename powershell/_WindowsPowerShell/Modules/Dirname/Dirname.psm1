# 
# Dirname
#  |
#  |--> Returns the parent-directory's fullpath of given input-string
#  |
#  |--> Example(s):
#         Dirname "${HOME}\tester\test.extension";
# 
function Dirname {
	Param(
		[Parameter(Position=0, ValueFromRemainingArguments)]
		$InputPath
	)

	# Determine the parent-directory's fullpath
	$Dirname = ([System.IO.Path]::GetDirectoryName(${InputPath}));

	Write-Output (${Dirname});

	Return;

}
Export-ModuleMember -Function "Dirname";


# ------------------------------------------------------------
# Citation(s)
#
#   docs.microsoft.com  |  "Path Class - Performs operations on String instances that contain file or directory path information"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.path?view=netframework-4.8
#
# ------------------------------------------------------------