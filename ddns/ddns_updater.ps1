#
# ddns_updater
#		|--> Applying basic DDNS - Allows syncing of a given Hostname's A-Record to a given device's dynamic IPv4 address
#
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
