# ----------------------------------------------------------
# T-Mobile 5G Internet Gateway (Sagemcom Fast 5688W) - Disable Wi-Fi Antennas & Signal Broadcasting
# ----------------------------------------------------------

If ($True) {
  # Set whether Wi-Fi should be enabled or disabled
  $EnableWifi = $False; # Disable Wi-Fi
  # $EnableWifi = $True; # Enable Wi-Fi
  # Get the modem's administrator password from the user
  Write-Host "";
  $ModemPassword = (Read-Host -AsSecureString -Prompt "Enter Modem Administrator Password");
  # Acquire a session token from the modem
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Acquiring authentication token from the modem...";
  $ModemToken = (curl.exe -s -X POST http://192.168.12.1/TMI/v1/auth/login -d "{`"username`":`"admin`",`"password`":`"$((${ModemPassword} | ConvertFrom-SecureString -AsPlainText))`"}" | ConvertFrom-Json | Select-Object -ExpandProperty auth | Select-Object -ExpandProperty token);
  # Do not keep credentials laying around any longer than needed (Admin Password)
  Remove-Variable -Name 'ModemPassword';
  # Download the current Wi-Fi config from the modem
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Downloading the current Wi-Fi config from the modem...";
  $JsonConfig = (curl.exe -s "http://192.168.12.1/TMI/v1/network/configuration?get=ap" -H "Authorization: Bearer ${ModemToken}");
  # Modify the downloaded config
  $JsonConfigObj = (${JsonConfig} | ConvertFrom-Json);
  @("2.4ghz","5.0ghz") | ForEach-Object {
    # Disable Wi-Fi antennas
    ${JsonConfigObj}.("${_}").("isMUMIMOEnabled") = ${EnableWifi};
    ${JsonConfigObj}.("${_}").("isRadioEnabled") = ${EnableWifi};
    ${JsonConfigObj}.("${_}").("isWMMEnabled") = ${EnableWifi};
    # Disable Wi-Fi signal broadcasting
    ${JsonConfigObj}.("${_}").("ssid").("isBroadcastEnabled") = ${EnableWifi};
    ${JsonConfigObj}.("${_}").("ssidGuest").("isBroadcastEnabled") = ${EnableWifi};
  }
  # Upload the modified config back to the modem
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Please wait 60 seconds (uploading config to the modem)...";
  $JsonConfigObj | ConvertTo-Json -Depth 100 -Compress | curl.exe -s -d "@-" "http://192.168.12.1/TMI/v1/network/configuration?set=ap" -H "Authorization: Bearer ${ModemToken}";
  # Do not keep credentials laying around any longer than needed (Session Token)
  Remove-Variable -Name 'ModemToken';
  # Report runtime completion
  Write-Host "";
  Write-Host "[$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffffff')]  Info:  Runtime complete";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   pastebin.com  |  "NaterTater T-Mobile Arcadyan KVD21 Settings - Pastebin.com"  |  https://pastebin.com/N4W3asVL
#
#   www.youtube.com  |  "✅ HACKED - Hidden Settings - Arcadyan KVD21 T-Mobile 5G Home Internet - Turn Off Wifi - YouTube"  |  https://www.youtube.com/watch?v=_hqN7PMRyes
#
# ------------------------------------------------------------