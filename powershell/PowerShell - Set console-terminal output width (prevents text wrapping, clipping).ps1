# ------------------------------------------------------------
#
# PowerShell - Set console-terminal output width (prevents text wrapping, clipping)
#  |-->  Turns off word-wrap (you may not see some of the text as it goes off the console, but you can still highlight copy it)
#  |-->  Prevents clipping of the powershell console's output
#
# ------------------------------------------------------------
#
# Set output width - Current command
#

Get-Module | Out-String -Width 16382;


# ------------------------------------------------------------
#
# Set output width - Current session
#


If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $Host.UI.RawUI.BufferSize = (New-Object ((($Host.UI.RawUI).BufferSize).GetType().FullName) (16384, $Host.UI.RawUI.BufferSize.Height)); }; <# Update PowerShell console width to 16384 characters #>


<#   ^^^   OneLiner   /   Drawn-out method   vvv   #>


<# Update the Powershell console's max characters-per-line by increasing the output buffer size #>
If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) {
$rawUI = $Host.UI.RawUI;
$oldSize = $rawUI.BufferSize;
$typeName = $oldSize.GetType( ).FullName;
$newSize = New-Object $typeName (16384, $oldSize.Height);
$rawUI.BufferSize = $newSize;
}


# ------------------------------------------------------------
#
# Format-Table -Autosize + Out-File -Width X (Show full table data without truncation of values)
#

$Logfile = "${Home}\Desktop\ProgramsAndFeatures_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log.txt"; `
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
| Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, Comments, URLInfoAbout `
| Where-Object { ([String]($_.DisplayName)).Trim() -NE "" } `
| Sort-Object -Property DisplayName `
| Format-Table -AutoSize `
| Out-File -Width 16384 -Append "${Logfile}"; `
Notepad "${Logfile}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Out-File (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file
#
#   learn.microsoft.com  |  "Out-String (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-string
#
#   stackoverflow.com  |  "console - Powershell output column width - Stack Overflow (rawUI.BufferSize)"  |  https://stackoverflow.com/a/1165347
#
#   stackoverflow.com  |  "console - Powershell output column width - Stack Overflow (Out-String)"  |  https://stackoverflow.com/a/978794
#
#   stackoverflow.com  |  "powershell - How do I use Format-Table without truncation of values? - Stack Overflow"  |  https://stackoverflow.com/a/49123225
#
#   www.howtogeek.com  |  "How to Create a List of Your Installed Programs on Windows"  |  https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/
#
# ------------------------------------------------------------