@ECHO OFF

REM
REM ddns_updater
REM		--> Applying basic DDNS - Allows for resolution of a static hostname to proxy towards a non-static (dynamic) endpoint (IPv4)
REM

REM	Task Scheduler DDNS (trigger to run the following action, daily, starting at 12:01 AM, repeating every 5 minutes, ending after 1 day, max 10-second timeout)

PowerShell -Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse(); }; If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse(); }; }; Exit 0;"

