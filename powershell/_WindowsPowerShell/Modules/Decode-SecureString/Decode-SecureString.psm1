# ------------------------------------------------------------
#
# .Synopsis
#    Tries to decode a SecureString and returns its clear text value
#
# .DESCRIPTION
#    Tries to decode a SecureString from a PSCredential Object and returns its clear text value
#
# .EXAMPLE
#    get-credential | Decode-SecureString
#
# .EXAMPLE
#    get-credential | dssp
#
# .EXAMPLE
#    Decode-SecureString -SecureString SecureString
#
# .AUTHOR
#    paolofrigo@gmail.com , 2018 https://www.scriptinglibrary.com
#
# ------------------------------------------------------------
Function Decode-SecureString
{
	[CmdletBinding()]
	[Alias('dssp')]
	[OutputType([string])]
	Param
	(
		[Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,Position=0)] $SecureString
	)
	Begin
	{
	}
	Process
	{
		Return [System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($SecureString));
	}
	End
	{
	}
}
Export-ModuleMember -Function "Decode-SecureString";


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.scriptinglibrary.com  |  "Passwords and SecureString, How To Decode It with Powershell | Scripting Library"  |  https://www.scriptinglibrary.com/languages/powershell/securestring-how-to-decode-it-with-powershell/
#
# ------------------------------------------------------------