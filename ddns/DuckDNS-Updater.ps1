# ----------------------------------------------------------------------------------------------------------------------------------------
#
#### Refer to "README.md"
#
# ----------------------------------------------------------------------------------------------------------------------------------------
If ($False) { # One-Liner command (for use w/ Task Scheduler):


powershell.exe -Command "If (Test-Path ((${Home})+('\.ddns\secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((${Home})+('\.ddns\secret')))))).GetResponse(); }; Exit 0;"


}
# ----------------------------------------------------------------------------------------------------------------------------------------
# Expanded (same as single line, above)


# PowerShell -Command "
ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) {
	If (Test-Path (($LocalUser.FullName)+('/.ddns/secret'))) {
		[System.Net.WebRequest]::Create(
			[System.Text.Encoding]::Unicode.GetString(
				[System.Convert]::FromBase64String(
					(Get-Content(
						(($LocalUser.FullName)+('/.ddns/secret')))
					)
				)
			)
		).GetResponse();
	}
}
Exit 0;
# "


# ----------------------------------------------------------------------------------------------------------------------------------------
# Creating the Credentials file(s) - Read-in the user-specific domain/password from the credentials file(s), below


$nc_host = Get-Content -Path (($Home)+("/.ddns/host"));
$nc_domain = Get-Content -Path (($Home)+("/.ddns/domain"));
$nc_token = Get-Content -Path (($Home)+("/.ddns/token"));
$nc_ip = "";

$nc_urlPlaintext = (("https://dynamicdns.park-your-domain.com/update?host=")+($nc_host)+("&domain=")+($nc_domain)+("&password=")+($nc_token)+("&ip=")+($nc_ip));

$nc_urlBase64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($nc_urlPlaintext));

New-Item -ItemType "Directory" -Path ("$HOME/.ddns") -ErrorAction SilentlyContinue; # Credentials - Ensure that parent-directory exists

[IO.File]::WriteAllText(("$HOME/.ddns/secret"),($nc_urlBase64)); # Credentials - Output the base-64 encoded string into the final url-file



# ----------------------------------------------------------------------------------------------------------------------------------------