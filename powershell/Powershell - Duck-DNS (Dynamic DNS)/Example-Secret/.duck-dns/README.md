# Duck DNS Credentials
#### Prepping a Duck-DNS "secret" file

```

$domains='subdomains';

$token='12345678-1234-1234-1234-123456789012';

Write-Host ([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((('https://www.duckdns.org/update?domains=')+($domains)+('&token=')+($token)+('&ip=')))));

```
