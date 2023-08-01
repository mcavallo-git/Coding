# ------------------------------------------------------------
# _IPinfoSensorReadings.ps1
# ------------------------------------------------------------
# Note: This script is intended to be ran as a Scheduled Task every minute
# ------------------------------------------------------------
#
# Get the latest IP address information from IPinfo.io (via an API call)
#

If ($True) {

  $Logfile_Dirname_IPinfo = "C:\ISO\IPinfo";
  
  $Filepath_AccessToken_IPinfo = "${Logfile_Dirname_IPinfo}\access_token";

  $AccessToken = "";

  $IP_Address = "";

  $ISP_Name = "";

  # Ensure output directories exist
  If ((Test-Path "${Logfile_Dirname_IPinfo}\Sensors") -NE $True) {
    If ((Test-Path "${Logfile_Dirname_IPinfo}") -NE $True) {
      New-Item -ItemType ("Directory") -Path ("${Logfile_Dirname_IPinfo}") | Out-Null;
    }
    New-Item -ItemType ("Directory") -Path ("${Logfile_Dirname_IPinfo}\Sensors") | Out-Null;
  }

  If (Test-Path -PathType "Leaf" -Path ("${Filepath_AccessToken_IPinfo}")) {
    # Only make IPinfo API calls if an access token has been setup

    $AccessToken = (([String](Get-Content -Path ("$Filepath_AccessToken_IPinfo"))).Trim());

    $URL_Base_IPinfo = "https://ipinfo.io/json";
    $URL_IPinfo = "${URL_Base_IPinfo}?token=${AccessToken}";

    # Make the API call to get IP address information
    [System.Net.ServicePointManager]::SecurityProtocol = ([System.Net.ServicePointManager]::SecurityProtocol -bor [System.Net.SecurityProtocolType]::Tls12);  # Ensure TLS 1.2 exists amongst available HTTPS Protocols
    $ProgressPreference = 'SilentlyContinue'; # Hide Invoke-WebRequest's progress bar
    $ResponseObj = (Invoke-WebRequest -UseBasicParsing -Uri ("${URL_IPinfo}"));
    $ResponseContent = (([String](${ResponseObj} | Select-Object -ExpandProperty "Content")).Trim());
    $ResponseJson = (${ResponseContent} | ConvertFrom-Json);

    $IP_Address = (([String](${ResponseJson} | Select-Object -ExpandProperty "ip")).Trim());

    $ISP_Name = (([String](${ResponseJson} | Select-Object -ExpandProperty "org")).Trim());

  }

  # Build the output JSON as a hash table / arrays, then convert it to JSON afterward
  $Output_HashTable = @{"prtg"=@{"result"=@();};};

  $EmptyValues = 0;

  # IP Address  -  Append to JSON output
  If ([String]::IsNullOrEmpty("${IP_Address}")) {
    $EmptyValues++;
  } Else {
    $Output_HashTable.prtg.result += @{ "value"=1; "channel"="${IP_Address}"; "float"=0; "decimalmode"=0; };
  }

  # ISP Name  -  Append to JSON output
  If ([String]::IsNullOrEmpty("${ISP_Name}")) {
    $EmptyValues++;
  } Else {
    $Output_HashTable.prtg.result += @{ "value"=1; "channel"="${ISP_Name}"; "float"=0; "decimalmode"=0; };
  }

  # Check for errors
  If ([String]::IsNullOrEmpty("${AccessToken}")) {
    # Error - No API token has been setup (yet)
    $Output_HashTable = @{"prtg"=@{"error"=1;"text"="ERROR - Access token not found at filepath [ ${Filepath_AccessToken_IPinfo} ] - Create a token via [ https://ipinfo.io/account/token ]";};};
  } ElseIf (${EmptyValues} -GE 2) {
    # Error - All values found to be empty, send error in the JSON body (instead of sending empty data)
    $Output_HashTable = @{"prtg"=@{"error"=1;"text"="ERROR - IPinfo sensor reading returned a null or empty value";};};
  }

  $Output_Json = (${Output_HashTable} | ConvertTo-Json -Depth 50 -Compress);

  # Handle invalid characters in sensor names - Note that PRTG does not function if certain unicode characters are in the filename (such as a degree symbol)
  $Output_Basename=(((("IPinfo._.json").Split([System.IO.Path]::GetInvalidFileNameChars()) -join '_') -Replace "[^a-zA-Z0-9-_\[\]\(\)\+\.]","_") -Replace "\.\.",".");
  $Output_Fullpath=("${Logfile_Dirname_IPinfo}\Sensors\${Output_Basename}");

  # Output the results to sensor-specific files
  Set-Content -LiteralPath ("${Output_Fullpath}") -Value ("${Output_Json}") -NoNewline;

}


# ------------------------------
#
# Cleanup Old Logfiles - IPinfo Sensors
#

If ($True) {
  $Retention_Days = "7";
  $Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
  $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
  Get-ChildItem -Path "${Logfile_Dirname_IPinfo}\Sensors" -File -Recurse -Force `
    | Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
    | Remove-Item -Recurse -Force -Confirm:$False `
  ;
  $ErrorActionPreference = $EA_Bak;
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   ipinfo.io  |  "IP Address API and Data Solutions - geolocation, company, carrier info, type and more - IPinfo IP Address Geolocation API"  |  https://ipinfo.io/
#
#   www.paessler.com  |  "Custom Sensors | PRTG Manual"  |  https://www.paessler.com/manuals/prtg/custom_sensors#advanced_elements
#
#   www.paessler.com  |  "PRTG Manual: Custom Sensors - Standard EXE/Script Sensor"  |  https://www.paessler.com/manuals/prtg/custom_sensors#standard_exescript
#
# ------------------------------------------------------------