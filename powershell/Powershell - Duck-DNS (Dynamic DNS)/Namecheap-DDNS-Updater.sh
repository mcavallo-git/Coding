
$domains='Paste_Subdomain_Here';
$token='Paste_Token_Here';

# Credentials Step 1.1 - Lock access permissions to this user (as well as any over-riding admins on this PC, as is tradition)
New-Item -ItemType "Directory" -Path (($Home)+("/.duck-dns")) -ErrorAction SilentlyContinue;



# Credentials Step 1.2 - Output the encoded string into the secret credentials file
[IO.File]::WriteAllText((($Home)+("/.duck-dns/secret")),([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((('https://www.duckdns.org/update?domains=')+($domains)+('&token=')+($token)+('&ip='))))));



[IO.File]::WriteAllText((($Home)('"/.namecheap/secret")),([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((
	('https://dynamicdns.park-your-domain.com/update?host')+($domains)+('&token=')+($token)+('&ip='))))));

https://dynamicdns.park-your-domain.com/update?host=iptester&domain=mcavallo.com&password=ord&ip=










#
# https://dynamicdns.park-your-domain.com/update?host=[host]&domain=[domain_name]&password=[ddns_password]&ip=[your_ip]
#

### 