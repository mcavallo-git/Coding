# [Windows - Sync WAN-IPv4 to a Static DDNS Hostname](https://github.com/mcavallo-git/Coding/blob/master/ddns/README.md)
###### Resolve DNS A-Record lookups for [ a Static, Custom Hostname ] to resolve to [ the WAN-IPv4 (Dynamic or Static) for a given workstation ]

## Using Host: [Namecheap](https://www.namecheap.com/support/knowledgebase/article.aspx/43/11/how-do-i-set-up-a-host-for-dynamic-dns)

### [Namecheap] - Create a new [ A record ] under a Domain (of your selection) on [Namecheap](https://www.namecheap.com) (requires Namecheap to be the DNS provider for given Domain)
* ###### Browse to https://www.namecheap.com and login with your username/password (and preferably OTP)
* ###### After logging in, browse to https://www.namecheap.com/domains/list and select "Manage" to the right of the domain you wish to create the DDNS subdomain under
* ###### Select "Advanced DNS" on the top-right, scroll down, and make sure 'Dynamic DNS' is turned ON.
* ###### Add a new record of type "A + Dynamic-DNS Record", select a new "host" name to-be-updated

### [Namecheap] - Create a local credentials-file (auto-generated via PowerShell)
* ###### Open a text-editor and copy-paste the script (below) into it
* ###### Copy the NameCheap subdomain & paste it into the script, below (e.g. copy your subdomain and paste it over "subdomain")
* ###### Copy the NameCheap domain & paste it into the script, below (e.g. copy your domain name and paste it over "domain.com")
* ###### Copy the NameCheap password (next to "Dynamic DNS Password") & paste it into the script, below (e.g. copy your Password and paste it over "password")
* ###### Copy your entire script (including respective Namecheap credentials) & paste it into a PowerShell terminal (e.g. open 'PowerShell.exe' and copy-paste your script into it)
```

# Namecheap Credentials Setup
# Note: This script uses native PowerShell methods to create a Namecheap credentials-file with filename "secret" in the directory ".namecheap" within your user directory

$nc_host   = "subdomain";
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

## Using Host: [Duck DNS](https://www.duckdns.org)

### [Duck DNS] - Create a new [ subdomain ] on the [Duck DNS Domains page](https://www.duckdns.org/domains)
* ###### Browse to https://www.duckdns.org and login through a supported third-party account (they support multiple methods of logging in, such as Google, GitHub, and more)
* ###### Once you've logged in, find the "domains" section on the [Duck DNS Domains page](https://www.duckdns.org/domains)
* ###### In the field with placeholder="sub domain", enter your desired subdomain-name & click "add domain"

### [Duck DNS] - Create a local credentials-file (auto-generated via PowerShell)
* ###### Open a text-editor and copy-paste the script (below) into it
* ###### Browse to the [Duck DNS Domains page](https://www.duckdns.org/domains)
* ###### Copy the Duck DNS "token" value & paste it into the script, below (e.g. copy your token and paste it over "token")
* ###### Copy the Duck DNS subdomain-name (located under the 'domains' table) & paste it into the script, below (e.g. copy your subdomain and paste it over "subdomain")
* ###### Copy your entire script (including respective Duck DNS credentials) & paste it into a PowerShell terminal (e.g. open 'PowerShell.exe' and copy-paste your script into it)
```

# Duck DNS Credentials Setup
# Note: This script uses native PowerShell methods to create a Duck DNS credentials-file with filename "secret" in the directory ".duck-dns" within your user directory

$domains="subdomain";
$token="token";

# Credentials - Lock access permissions to this user (as well as any over-riding admins on this PC, as is tradition)
New-Item -ItemType "Directory" -Path ("$HOME/.duck-dns") -ErrorAction SilentlyContinue;

# Credentials - Output the encoded string into the secret credentials file
[IO.File]::WriteAllText((($Home)+("/.duck-dns/secret")),([Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((('https://www.duckdns.org/update?domains=')+($domains)+('&token=')+($token)+('&ip='))))));

```
***



##  Create a local Scheduled Task

* ### Open "Task Scheduler"
* ### Click "Create Task..." (on the right)
* ### In the newly opened window, locate the tab-names at the top, and fill in each tab's values with the respective tab-values, below:
***

##### "General" Tab
*Name*
```DDNS Updater```

*Description*
```DDNS Updater```

*When running this task, use the following user account*
```SYSTEM    (i.e. NT AUTHORITY\SYSTEM)```

*Run whether this user is logged in or not*
```☑    (checked)```
***

##### "Trigger" Tab
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


##### "Actions" Tab
```
Action:  Start a program

Program/script:			PowerShell

Add arguments (NOT optional):		-Command "ForEach ($LocalUser In (Get-ChildItem ('C:/Users'))) { If (Test-Path (($LocalUser.FullName)+('/.namecheap/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.namecheap/secret'))))))).GetResponse();} If (Test-Path (($LocalUser.FullName)+('/.duck-dns/secret'))) { [System.Net.WebRequest]::Create([System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String((Get-Content((($LocalUser.FullName)+('/.duck-dns/secret'))))))).GetResponse();}} Exit 0;"
```
***

* ### Save the task by clicking "OK" at the bottom
* ### You may run the scheduled task manually by opening "Task Scheduler", selecting "Task Scheduler Library" (on the left), & right-click->"Run" on the task-name ("DDNS Updater")
* ### You may inspect the final Powershell command being-run by viewing it outside of "Edit" mode, within "Task Scheduler", under the "Action" tab
***


## Done (End of Guide)
***

### Note: Script Action Summary
##### This script intends to:
* ##### Be run from specific, trusted device(s), only
* ##### Commmunicate with external sources (URL) via secure protocols, only
* ##### Securely store/cache any credential-data used during runtime
* ##### Securely pass authentication/authorization data while accessing any external providers
***

### Note: Script Goals (To-Do)
##### This script may eventually (once upgraded):
* ##### Check DNS Provider user's owned-hostnames for the target-hostname
* ##### Check DNS Provider user's permissions for hostname A-Record modification/creation
* ##### Check DNS Provider's target-hostname's A-Record to avoid attempting-to-update-it-the-value-it-already-is
* ##### Updates DNS Provider's target-hostname's A-Record to the current-device's WAN-IPv4 (if needed)
***
