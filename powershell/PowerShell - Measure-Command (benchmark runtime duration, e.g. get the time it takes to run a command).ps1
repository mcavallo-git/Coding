# ------------------------------------------------------------
#
# PowerShell - Measure-Command
#
# ------------------------------------------------------------

### Benchmark different methods of obtaining the local device's hostname
Measure-Command { HOSTNAME.exe };
Measure-Command { [System.Net.Dns]::GetHostName() };
Measure-Command { $env:COMPUTERNAME };
Measure-Command { get-content env:computername };
Measure-Command { gc env:computername };

### Benchmark different methods of obtaining the local device's FQDN (hostname.domainname)
Measure-Command { [System.Net.DNS]::GetHostByName('').HostName };
Measure-Command { [System.Net.DNS]::GetHostByName($Null).HostName };


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Measure-Command - Measures the time it takes to run script blocks and cmdlets"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/measure-command
#
#   stackoverflow.com  |  ".net - How do I get the localhost name in PowerShell? - Stack Overflow"  |  https://stackoverflow.com/a/1169904
#
# ------------------------------------------------------------