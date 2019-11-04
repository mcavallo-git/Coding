function Basename {
	Param(
		[Parameter(Position=0, ValueFromRemainingArguments)]
		$InputPath
	)

	Write-Output [System.IO.Path]::GetFileName(${InputPath});
	# [System.IO.Path]::GetFileName("Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"); `
	# [System.IO.Path]::GetFileNameWithoutExtension("Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"); `
	# [System.IO.Path]::GetDirectoryName("Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"); `


	Return;

}
Export-ModuleMember -Function "Basename";


# ------------------------------------------------------------
# Citation(s)
#
#   getadmx.com  |  "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System"  |  https://getadmx.com/HKCU/Software/Microsoft/Windows/CurrentVersion/Policies/System
#
# ------------------------------------------------------------