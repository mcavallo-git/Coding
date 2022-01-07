# ------------------------------------------------------------
#	Restart-Explorer
# 	|--> ... Restarts Windows Explorer
#
# ------------------------------------------------------------
function Restart-Explorer {
	Param(
	)

	If ((Get-Command 'PrivilegeEscalation' -ErrorAction "SilentlyContinue") -Ne $Null) {
		# TASKKILL /F /IM explorer.exe
		# CMD /C "TASKKILL /F /IM explorer.exe";
		TaskSnipe -Name "explorer.exe" -SkipConfirm;
		Start-Sleep -Seconds 1;
		ii .;
	}

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Restart-Explorer";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Stop “explorer” process completely using PowerShell"  |  https://stackoverflow.com/a/8610349
#
# ------------------------------------------------------------