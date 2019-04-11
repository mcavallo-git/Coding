# ----------------------------------------------------------------------------------------------------------------------------------------
#
#### Refer to "README.md"
#
# ----------------------------------------------------------------------------------------------------------------------------------------
# Single Line (for use w/ Task Scheduler):


PowerShell -Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();}} Exit 0;"


# ----------------------------------------------------------------------------------------------------------------------------------------
# Expanded (same as single line, above)


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


# ----------------------------------------------------------------------------------------------------------------------------------------
# Creating the Credentials file(s) - Read-in the user-specific domain/password from the credentials file(s), below


$nc_host = Get-Content -Path (($Home)+("/.duck-dns/host"));
$nc_domain = Get-Content -Path (($Home)+("/.duck-dns/domain"));
$nc_token = Get-Content -Path (($Home)+("/.duck-dns/token"));
$nc_ip = "";

$nc_urlPlaintext = (("https://dynamicdns.park-your-domain.com/update?host=")+($nc_host)+("&domain=")+($nc_domain)+("&password=")+($nc_token)+("&ip=")+($nc_ip));

$nc_urlBase64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($nc_urlPlaintext));

New-Item -ItemType "Directory" -Path ("$HOME/.duck-dns") -ErrorAction SilentlyContinue; # Credentials - Ensure that parent-directory exists

[IO.File]::WriteAllText(("$HOME/.duck-dns/secret"),($nc_urlBase64)); # Credentials - Output the base-64 encoded string into the final url-file



# ----------------------------------------------------------------------------------------------------------------------------------------