# DDNS - Resolving a static Hostname to a dynamic IP
###### Resolve DNS A-Record lookups for [ a Static, Custom Hostname ] to [ the WAN-IPv4 (Dynamic) of a given workstation ]

### Script Requirements:
* ##### Is intended to be run from specific, trusted device(s), only
* ##### Commmunicates with external sources (URL) via secure protocols, only
* ##### Securely stores/caches all credential-data needed for script
* ##### Securely passes Authentication/Authorization data when validating itself to DNS Provider(s)
* ##### Checks DNS Provider user's owned-hostnames for the target-hostname
* ##### Checks DNS Provider user's permissions for hostname A-Record modification/creation
* ##### Checks DNS Provider's target-hostname's A-Record to avoid attempting-to-update-it-the-value-it-already-is
* ##### Updates DNS Provider's target-hostname's A-Record to the current-device's WAN-IPv4 (if needed)
***


# 1.1 - Namecheap

## Create Credentials
#### Before creating the scheduled task, we must first create a Namecheap ddns-record to update. This may be done by performing the following steps:

* ###### Browse to https://www.namecheap.com and login with your username/password (and preferably OTP)
* ###### After logging in, browse to https://www.namecheap.com/domains/list and select "Manage" to the right of the domain you wish to create the DDNS subdomain under
* ###### Select "Advanced DNS" on the top-right, scroll down, and make sure 'Dynamic DNS' is turned ON.
* ###### Add a new record of type "A + Dynamic-DNS Record", select a new "host" name to-be-updated
* ###### Copy the (newly created) host into the script, below (without domain)
* ###### Copy the domain name into the script, below
* ###### Copy the password next to "Dynamic DNS Password" into the script, below
* ###### Run the following script in PowerShell to create your credentials 'secret' file, specific for the DDNS scheduled task, and secured to your user directory
```

$nc_host   = "host";
$nc_domain = "domain.com";
$nc_token  = "password";
$nc_ip     = "";

$nc_urlPlaintext = (("https://dynamicdns.park-your-domain.com/update?host=")+($nc_host)+("&domain=")+($nc_domain)+("&password=")+($nc_token)+("&ip=")+($nc_ip));

$nc_urlBase64 = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($nc_urlPlaintext));

# Credentials - Output the base-64 encoded string into the final url-file
New-Item -ItemType "Directory" -Path ("$HOME/.namecheap") -ErrorAction SilentlyContinue;
[IO.File]::WriteAllText((($Home)+("/.namecheap/secret")),($nc_urlBase64));

```
***


# 1.2 - Duck DNS

## Create Credentials
#### Before creating the scheduled task, we must first create a Duck-DNS FQDN to update. This may be done by performing the following steps:

* ###### Browse to https://www.duckdns.org and login through a supported third-party account (they support multiple methods of logging in, such as Google, GitHub, and more)
* ###### After logging in, find your "token" and copy/paste it into the respective variable (named 'token')
* ###### After pasting your token, select / create a new Duck DNS subdomain and copy/paste it into the respective variable (named 'domains', multiple may be updated at once via a comma-delimited string)
* ###### Run the following script in PowerShell to create your credentials 'secret' file, specific for the DDNS scheduled task, and secured to your user directory
```

$domains='Paste_Subdomain_Here';
$token='Paste_Token_Here';

# Credentials Step 1.1 - Lock access permissions to this user (as well as any over-riding admins on this PC, as is tradition)
New-Item -ItemType "Directory" -Path ("$HOME/.duck-dns") -ErrorAction SilentlyContinue;

# Credentials Step 1.2 - Output the encoded string into the secret credentials file
[IO.File]::WriteAllText((($Home)+("/.duck-dns/secret")),([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((('https://www.duckdns.org/update?domains=')+($domains)+('&token=')+($token)+('&ip='))))));

```
***



## 2 - Create the Scheduled Task


### "General" Tab
*Name*
```DDNS Updater```

*Description*
```Duck DNS Updater```

*When running this task, use the following user account*
```SYSTEM    (i.e. NT AUTHORITY\SYSTEM)```

*Run whether this user is logged in or not*
```☑    (checked)```
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

Add arguments (NOT optional):		-Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse();} If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();}} Exit 0;"
```
***

###### Once created, the final command being run should show under the action tab as:
```
PowerShell -Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse();} If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();}} Exit 0;"
```
***
