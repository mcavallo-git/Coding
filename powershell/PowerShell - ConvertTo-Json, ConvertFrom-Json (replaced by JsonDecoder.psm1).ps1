# ------------------------------------------------------------
#
# PowerShell - PowerShell - ConvertTo-Json, ConvertFrom-Json (replaced by JsonDecoder.psm1)
#               |
#               |-->  EX) Get Windows OS' build info
#
# ------------------------------------------------------------
#
# Converting  >>> to <<<  JSON
#  |
#  |--> Use the PowerShell native "ConvertTo-Json" method
#

ConvertTo-Json -InputObject (@{integer=1; string="string"; array=@(1,2,"a","b"); object=@{"obj-int"=2;"obj-str"="<div>test-string</div>";};}) -Depth 100;

<# "-Compress" --> Removes newlines and leading-spaces from output #>
ConvertTo-Json -InputObject (@{integer=1; string="string"; array=@(1,2,"a","b"); object=@{"obj-int"=2;"obj-str"="<div>test-string</div>";};}) -Depth 100 -Compress;


# WITH character encoding on the output-string (default in ConvertTo-JSON):
(@{integer=1; string="string"; array=@(1,2,"a","b"); object=@{"obj-int"=2;"obj-str"="<div>test-string</div>";};}) | ConvertTo-Json -Depth 100;

# With NO character encoding on the output-string (default in ConvertTo-JSON):
(@{integer=1; string="string"; array=@(1,2,"a","b"); object=@{"obj-int"=2;"obj-str"="<div>test-string</div>";};}) | ConvertTo-Json -Depth 100 | ForEach-Object { [System.Text.RegularExpressions.Regex]::Unescape($_); };


# ------------------------------------------------------------
#
# Converting  >>> from <<<  JSON
#  |
#  |--> Use the "JsonDecoder" module (instead of PowerShell native "ConvertFrom-Json" method)
#

Set-ExecutionPolicy -ExecutionPolicy "Bypass" -Scope "CurrentUser" -Force; New-Item -Force -ItemType "File" -Path ("${Env:TEMP}\JsonDecoder.psm1") -Value (($(New-Object Net.WebClient).DownloadString("https://raw.githubusercontent.com/mcavallo-git/Coding/master/powershell/_WindowsPowerShell/Modules/JsonDecoder/JsonDecoder.psm1"))) | Out-Null; Import-Module -Force ("${Env:TEMP}\JsonDecoder.psm1");

JsonDecoder -InputObject ('{"integer":1,"string":"string","array":[1,2,"a","b"],"object":{"obj-int":2,"obj-str":"test-string"}}');


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "ConvertFrom-Json - Converts a JSON-formatted string to a custom object or a hash table."  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertfrom-json
#
#   docs.microsoft.com  |  "ConvertTo-Json - Converts an object to a JSON-formatted string"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json
#
#   docs.microsoft.com  |  "Import-Module - Adds modules to the current session"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/import-module
#
#   stackoverflow.com  |  "PowerShell: ConvertTo-Json problem containing special characters - Stack Overflow"  |  https://stackoverflow.com/a/37706732
#
# ------------------------------------------------------------
