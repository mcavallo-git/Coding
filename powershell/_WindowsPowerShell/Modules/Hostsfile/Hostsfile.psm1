#
#	PowerShell - Hostsfile
#		|
#		|--> Description:  Open the Windows "hosts" file (with admin/escalated privileges, np++, hostsfile, hostfile, edit, windows)
#
Function Hostsfile() {
	Param(

		[Switch]$Quiet,

		[Parameter(Position=0, ValueFromRemainingArguments)]$inline_args

	)

	If ((Test-Path "C:\Program Files\Notepad++\notepad++.exe") -Eq $True) {
		$Text_Editor = "C:\Program Files\Notepad++\notepad++.exe";
	}

	<# Edit the Windows hosts file with admin/elevated privileges #>
	Start-Process "${Text_Editor}" -ArgumentList "C:\Windows\System32\drivers\etc\hosts" -Verb "RunAs";

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Hostsfile";
}
