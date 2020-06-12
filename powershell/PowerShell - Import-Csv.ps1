

$Logfile_Dirname = "C:\ISO\OpenHardwareMonitor";
$Logfile_Basename = "OpenHardwareMonitorLog-$(Get-Date -UFormat '%Y-%m-%d').csv";
$Logfile_FullPath = "${Logfile_Dirname}\${Logfile_Basename}";

# Get-Content -Path ("${Logfile_Fullpath}") -TotalCount (2);

$CsvObject = Import-Csv -Path ("${Logfile_Fullpath}");
$CsvObject | Format-Table;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Import-Csv"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/import-csv?view=powershell-5.1
#
# ------------------------------------------------------------