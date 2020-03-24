
<# Restart Windows Explorer #>

Stop-Process -ProcessName ("explorer.exe");

<#

Note:
   Windows automatically handles re-starting explorer.exe as soon as it is stopped
    |--> NEED INFO REGARDING WHAT RESTARTS IT, HERE

#>
