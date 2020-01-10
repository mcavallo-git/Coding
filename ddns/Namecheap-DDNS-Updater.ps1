# ------------------------------------------------------------
#
#### Refer to "README.md"
#
# ------------------------------------------------------------
#	Single Line (for use w/ Task Scheduler):


PowerShell -Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If ((Test-Path (($LocalUser.FullName)+('/.namecheap/hostname'))) -And (Test-Path (($LocalUser.FullName)+('/.namecheap/domain'))) -And (Test-Path (($LocalUser.FullName)+('/.namecheap/token')))) { [System.Net.WebRequest]::Create((('https://dynamicdns.park-your-domain.com/update?host=')+(Get-Content (($LocalUser.FullName)+('/.namecheap/hostname')))+('&domain=')+(Get-Content (($LocalUser.FullName)+('/.namecheap/domain')))+('&password=')+(Get-Content (($LocalUser.FullName)+('/.namecheap/token')))+('&ip='))).GetResponse();	} ElseIf (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse(); }; If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse(); }; }; Exit 0;"


# ------------------------------------------------------------
# Expanded (same as single line, above)


# PowerShell -Command "
ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) {
	If ((Test-Path (($LocalUser.FullName)+('/.namecheap/hostname'))) -And (Test-Path (($LocalUser.FullName)+('/.namecheap/domain'))) -And (Test-Path (($LocalUser.FullName)+('/.namecheap/token')))) {
		[System.Net.WebRequest]::Create((('https://dynamicdns.park-your-domain.com/update?host=')+(Get-Content (($LocalUser.FullName)+('/.namecheap/hostname')))+('&domain=')+(Get-Content (($LocalUser.FullName)+('/.namecheap/domain')))+('&password=')+(Get-Content (($LocalUser.FullName)+('/.namecheap/token')))+('&ip='))).GetResponse();
	} ElseIf (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) {
		[System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse();
	};
	If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) {
		[System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();
	};
};
Exit 0;
# "


# ------------------------------------------------------------
#	Creating a base-64 encoded token as a single Credentials file(s) - Read-in the user-specific hostname/domain-name/token from the credentials file(s), below


$nc_hostname = Get-Content -Path ("$(${Env:USERPROFILE})/.namecheap/hostname"); `
$nc_domain = Get-Content -Path ("$(${Env:USERPROFILE})/.namecheap/domain"); `
$nc_token = Get-Content -Path ("$(${Env:USERPROFILE})/.namecheap/token"); `
$nc_urlPlaintext = "https://dynamicdns.park-your-domain.com/update?host=$(${nc_hostname})&domain=$(${nc_domain})&password=$(${nc_token})&ip="; `
$nc_urlBase64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes(${nc_urlPlaintext})); `
New-Item -ItemType "Directory" -Path ("${Env:USERPROFILE}/.namecheap") -ErrorAction SilentlyContinue; <# Credentials - Ensure that parent-directory exists #> `
[IO.File]::WriteAllText(("${Env:USERPROFILE}/.namecheap/secret"),(${nc_urlBase64})); <# Credentials - Output the base-64 encoded string into the final url-file #>



#	Example_URL:  https://dynamicdns.park-your-domain.com/update?host=[host]&domain=[domain_name]&password=[ddns_password]&ip=[your_ip]


# ------------------------------------------------------------
# 
#	Citation(s)
#
#		namecheap.com  |  "How do I use a browser to dynamically update the host's IP?"  |  https://www.namecheap.com/support/knowledgebase/article.aspx/29/11/how-do-i-use-a-browser-to-dynamically-update-the-hosts-ip
#
# ------------------------------------------------------------