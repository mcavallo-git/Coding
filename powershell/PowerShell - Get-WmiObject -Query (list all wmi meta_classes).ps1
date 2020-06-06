# ------------------------------------------------------------


(Get-WmiObject -Query "SELECT * FROM meta_class" | Sort-Object -Property Name -Unique).Name;


# ------------------------------------------------------------


#
# Output all to a logfile & display all available methods for each WMI class
#
$Logfile = "${Home}\Desktop\WMI_Classes_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log.txt"; `
If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $Host.UI.RawUI.BufferSize = (New-Object ((($Host.UI.RawUI).BufferSize).GetType().FullName) (16384, $Host.UI.RawUI.BufferSize.Height)); }; <# Update PowerShell console width to 16384 characters #> `
Get-WmiObject -Query "SELECT * FROM meta_class" `
| Where-Object { $_.Properties -NE @{} } `
| Select-Object -Property Name,Properties `
| Sort-Object -Property Name -Unique `
| ForEach-Object { $EachLine=@(); $_.Properties | ForEach-Object { $EachLine += "$($_.Name)"; }; Write-Output "$($($_.Name.PadRight(120)))  { $($EachLine -join ', ') }"; } `
| Out-File -Width 16384 -Append "${Logfile}"; `
Notepad "${Logfile}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Retrieving a WMI Class - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/wmisdk/retrieving-a-class
#
# ------------------------------------------------------------