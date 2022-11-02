# ------------------------------------------------------------
#
# List all WMIC namespaces
#

Get-WmiObject -Namespace "ROOT" -Class "__Namespace" | Select Name;


# ------------------------------------------------------------
#
# List all WMIC classes
#

(Get-WmiObject -Query "SELECT * FROM meta_class" | Sort-Object -Property Name -Unique).Name;


# ------------------------------------------------------------
#
# WMIC Query (direct call, various WMIC endpoints) - Output WMIC query reults in List format
#

# BIOS
WMIC BIOS Get * /Format:list

# DesktopMonitor
WMIC DesktopMonitor Get * /Format:list

# DiskDrive
WMIC DiskDrive Get * /Format:list

# IDEController
WMIC IDEController Get * /Format:list

# MemoryChip
WMIC MemoryChip Get * /Format:list

# NIC
WMIC NIC Get * /Format:list

# NICConfig
WMIC NICConfig Get * /Format:list

# OS
WMIC OS Get * /Format:list

# Product  (Installed programs - similar to appwiz.cpl's list)
WMIC Product Get * /Format:list


# ------------------------------------------------------------
#
# WMIC Query (direct call) - Output WMIC query reults in HTML format to a file on the desktop via WMIC's "/Output" inline parameter and the "/format:htable" argument
#

WMIC /Output:%USERPROFILE%\Desktop\bios.html BIOS Get Manufacturer,Name,Version /Format:htable


# ------------------------------------------------------------
#
# Output all to a logfile & display all available methods for each WMI class
#

$Logfile_txt = "${Home}\Desktop\WMI_Classes_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log.txt"; `
$Logfile_csv = "${Logfile_txt}.csv"; `
If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $Host.UI.RawUI.BufferSize = (New-Object ((($Host.UI.RawUI).BufferSize).GetType().FullName) (16384, $Host.UI.RawUI.BufferSize.Height)); }; <# Update PowerShell console width to 16384 characters #> `
Write-Output "Properties.Count`tWMI Class Name`tProperties..." | Out-File -Width 16384 "${Logfile_csv}"; `
Get-WmiObject -Query "SELECT * FROM meta_class" `
| Where-Object { $_.Properties -NE @{} } `
| Select-Object -Property Name,Properties `
| Sort-Object -Property Name -Unique `
| ForEach-Object { $EachLine=@(); $_.Properties | ForEach-Object { $EachLine += "$($_.Name)"; }; Write-Output "$($($_.Name.PadRight(120)))  { $($EachLine -join ', ') }" | Out-File -Width 16384 -Append "${Logfile_txt}"; Write-Output "$($EachLine.Count)`t$($_.Name)`t$($EachLine -join `"`t`")}" | Out-File -Width 16384 -Append "${Logfile_csv}"; }; `
Notepad "${Logfile_txt}";
Notepad "${Logfile_csv}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Retrieving a WMI Class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/wmisdk/retrieving-a-class
#
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject
#
# ------------------------------------------------------------