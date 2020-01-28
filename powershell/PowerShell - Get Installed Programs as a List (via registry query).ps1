# ------------------------------------------------------------
#
# PowerShell - List all programs installed in windows (output to a file on the current user's desktop)
#
# ------------------------------------------------------------


$Logfile = "${Home}\Desktop\ProgramsAndFeatures_$($(${Env:USERNAME}).Trim())@$($(${Env:COMPUTERNAME}).Trim())" + $(If(${Env:USERDNSDOMAIN}){Write-Output ((".") + ($(${Env:USERDNSDOMAIN}).Trim()))}) +"_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log;"; `
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
| Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, Comments, URLInfoAbout `
| Where-Object { ([String]($_.DisplayName)).Trim() -NE "" } `
| Sort-Object -Property DisplayName `
| Format-Table -AutoSize `
| Out-File -Width 16384 "${Logfile}"; `
Notepad "${Logfile}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "PowerShell/Invoke-MSI.ps1 at master · MicksITBlogs/PowerShell · GitHub"  |  https://github.com/MicksITBlogs/PowerShell/blob/master/Invoke-MSI.ps1
#
#   stackoverflow.com  |  "PowerShell inline If (IIf) - Stack Overflow"  |  https://stackoverflow.com/a/25682508
#
#   stackoverflow.com  |  "powershell - How do I use Format-Table without truncation of values? - Stack Overflow"  |  https://stackoverflow.com/a/49123225
#
#   www.howtogeek.com  |  "How to Create a List of Your Installed Programs on Windows"  |  https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/
#
# ------------------------------------------------------------