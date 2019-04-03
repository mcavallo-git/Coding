# ----------------------------------------------------------------------------------------------------------------------------------------
#
#### Refer to "README.md"
#
# ----------------------------------------------------------------------------------------------------------------------------------------
#
# Single Line (for use w/ Task Scheduler):
#
PowerShell -Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();}} Exit 0;"
#
# ----------------------------------------------------------------------------------------------------------------------------------------
#
# PowerShell -Command "
ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) {
	If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) {
		[System.Net.WebRequest]::Create(
			[System.Text.Encoding]::Unicode.GetString(
				[System.Convert]::FromBase64String(
					(Get-Content(
						(($LocalUser.FullName)+('/.duck-dns/secret')))
					)
				)
			)
		).GetResponse();
	}
}
Exit 0;
# "
#
# ----------------------------------------------------------------------------------------------------------------------------------------