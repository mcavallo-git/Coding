
# ----------------------------------------------------------------------------------------------------------------------------------------
# Credentials - Read-in the user-specific hostname/domain-name/token from the credentials file(s), below
#
$nc_host = Get-Content -Path (($Home)+("/.namecheap/host"));
$nc_domain = Get-Content -Path (($Home)+("/.namecheap/domain"));
$nc_token = Get-Content -Path (($Home)+("/.namecheap/token"));
$nc_ip = "";

$nc_updateUrl = (("https://dynamicdns.park-your-domain.com/update?host=")+($nc_host)+("&domain=")+($nc_domain)+("&password=")+($nc_token)+("&ip=")+($nc_ip))

# Credentials - Output the base-64 encoded string into the final url-file
[IO.File]::WriteAllText(
	(($Home)+("/.namecheap/secret")),
	(
		[Convert]::ToBase64String(
			[System.Text.Encoding]::Unicode.GetBytes(
				$nc_updateUrl
			)
		)
	)
);

#
#	Example_URL
# https://dynamicdns.park-your-domain.com/update?host=[host]&domain=[domain_name]&password=[ddns_password]&ip=[your_ip]
#


# ----------------------------------------------------------------------------------------------------------------------------------------
#		DDNS Update - Read-in the user-secret & update related DDNS host(s)

ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) {
	If (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) {
		[System.Net.WebRequest]::Create(
			[System.Text.Encoding]::Unicode.GetString(
				[System.Convert]::FromBase64String(
					(Get-Content(
						(($LocalUser.FullName)+('/.namecheap/secret')))
					)
				)
			)
		).GetResponse();
	}
}



# ----------------------------------------------------------------------------------------------------------------------------------------
# 
#	Citation(s)
#
#		www.namecheap.com,
#			"How do I use a browser to dynamically update the host's IP?"
#			 https://www.namecheap.com/support/knowledgebase/article.aspx/29/11/how-do-i-use-a-browser-to-dynamically-update-the-hosts-ip
#
