# Duck DNS Updater
####  Updates a DDNS IPv4 for a given subdomain (or group of subdomains, if specified in the 'domains' variable while building the secret file):
***

## 1 - Create Credentials
#### Before creating the scheduled task, we must first create a Duck-DNS FQDN to update. This may be done by performing the following steps:

###### * Browse to https://www.duckdns.org and login through a supported third-party account (they support multiple methods of logging in, such as Google, GitHub, and more)
###### * After logging in, find your "token" and copy/paste it into the respective variable (named 'token')
###### * After pasting your token, select / create a new Duck DNS subdomain and copy/paste it into the respective variable (named 'domains', multiple may be updated at once via a comma-delimited string)
###### * Run the following script in PowerShell to create your credentials 'secret' file, specific for the DDNS scheduled task, and secured to your user directory
```

$domains='subdomains';

$token='12345678-1234-1234-1234-123456789012';

Write-Host ([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((('https://www.duckdns.org/update?domains=')+($domains)+('&token=')+($token)+('&ip=')))));

New-Item -ItemType "Directory" -Path (($path_destination)+("/")) | Out-Null;

```
***

## 2 - Create the Scheduled Task

Name:  DDNS Updater

###### "General" Tab
```
			Description: Duck DNS Updater

☑ Run whether this user is logged in or not
```
***

###### "Trigger" Tab
```
			On a Schedule
			Daily
			Starting [TODAY] @ 12:01:30 AM
			☑ Synchronize across time zones
			Recur every 1 days
			Repeat task every 5 minutes for a duration of 1436 minutes (4 minutes short-of a full 24 hours)
			Stop task if it runs longer than 10 seconds
```
***


###### "Actions" Tab
```
Action:  Start a program

Program/script:			PowerShell

Add arguments (NOT optional):		-Command "ForEach ($LocalUser In (Get-ChildItem ('C:\Users'))) { If (Test-Path (($LocalUser.FullName)+('\.duck-dns\secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('\.duck-dns\secret'))))))).GetResponse(); } } Exit 0;"
```
***

###### Once created, the final command being run should show under the action tab as:
```
PowerShell -Command "ForEach ($LocalUser In (Get-ChildItem ('C:\Users'))) { If (Test-Path (($LocalUser.FullName)+('\.duck-dns\secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('\.duck-dns\secret'))))))).GetResponse(); } } Exit 0;"
```
***
