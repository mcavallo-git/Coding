# ------------------------------------------------------------
# PowerShell - LastBootupTime (get uptime, duration since Windows last booted)
# ------------------------------------------------------------

# Get Uptime

(Get-Date) - (Get-CimInstance Win32_OperatingSystem -ComputerName $c).LastBootupTime;


# ------------------------------------------------------------