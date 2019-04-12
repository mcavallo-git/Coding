#
# ddns_updater
#		--> Applying basic DDNS - Allows for resolution of a static hostname to proxy towards a non-static (dynamic) endpoint (IPv4)
#
ForEach (`$LocalUser In (Get-ChildItem ('C:/Users'))) {
	If (Test-Path ((`$LocalUser.FullName)+('/.namecheap/secret'))) {
		[System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content(((`$LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse();
	};
	If (Test-Path ((`$LocalUser.FullName)+('/.duck-dns/secret'))) {
		[System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content(((`$LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();
	};
};
