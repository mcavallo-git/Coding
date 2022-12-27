# ------------------------------------------------------------
#
# PowerShel - Update the Powershell console's max characters-per-line by increasing the output buffer size
#  |-->  Turns off word-wrap (you may not see some of the text as it goes off the console, but you can still highlight copy it)
#  |-->  Prevents clipping of the powershell console's outpu
#
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
| Out-File -Width 16384 -Append "${Logfile}" -Encoding utf8; `
Notepad "${Logfile}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Out-File - Sends output to a file"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file
#
#   stackoverflow.com  |  "console - Powershell output column width - Stack Overflow"  |  https://stackoverflow.com/a/1165347
#
#   stackoverflow.com  |  "powershell - How do I use Format-Table without truncation of values? - Stack Overflow"  |  https://stackoverflow.com/a/49123225
#
#   www.howtogeek.com  |  "How to Create a List of Your Installed Programs on Windows"  |  https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/
#
# ------------------------------------------------------------