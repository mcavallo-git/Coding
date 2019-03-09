
# PowerShell / PowerShell-Code (Linux) - Updating Duck DNS IPv4s for a given DDNS domain (or group-of-domains, if specified in the 'user' field of the secret file):

#
# VIA TASK SCHEDULER:
#
# Name:  Duck DNS Update
#
# Description: Duck DNS Update
#
# ☑ Run whether this user is logged in or not
#
# Trigger:  On a Schedule
#           Daily
#           Starting [TODAY] @ 12:01:30 AM
#           ☑ Synchronize across time zones
#           Recur every 1 days
#           Repeat task every 5 minutes for a duration of 1436 minutes (4 minutes short-of a full 24 hours)
#           Stop task if it runs longer than 10 seconds
#
# Action:  Start a program
# 
# Program/script:  Powershell
#
# Additional Arguments:  -WindowStyle Minimized "[System.Net.WebRequest]::Create('https://www.duckdns.org/update?domains='+$(Get-Content '~\duck_dns\user')+'&token='+$(Get-Content '~\duck_dns\token')+'&ip=').GetResponse().StatusCode; Start-Sleep 1; Exit;"
#


PowerShell -WindowStyle Minimized "[System.Net.WebRequest]::Create('https://www.duckdns.org/update?domains='+$(Get-Content '~\duck_dns\user')+'&token='+$(Get-Content '~\duck_dns\token')+'&ip=').GetResponse().StatusCode; Start-Sleep 1; Exit;";

# Domain Names, Base64
$DuckDns_DomainsBase64="encoded_domain(s)";

# Domain Token, Base64
$DuckDns_TokenBase64="encoded_token";

### Encoding string(s) to base64...
# [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes("string-to-encode"))

###  Decoding strings from base64...
$DuckDns_Token = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($DuckDns_TokenBase64));

$DuckDns_Domains = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($DuckDns_DomainsBase64));

$DuckDns_Url = "https://www.duckdns.org/update?domains=${DuckDns_Domains}&token=${DuckDns_Token}&ip=";

$DuckDns_WebRequest = [System.Net.WebRequest]::Create($DuckDns_Url);

$DuckDns_Response = $DuckDns_WebRequest.GetResponse();

$DuckDns_ResStatusCode = $DuckDns_Response.StatusCode;

$DuckDns_Response.Close();

$DuckDns_Response.Dispose();

# Show the final status-code returned as output
$DuckDns_ResStatusCode;

Start-Sleep 1;

