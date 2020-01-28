# ------------------------------------------------------------
#
# PowerShell - Format-Table -Autosize + Out-File -Width X (Show full table data without truncation of values)
#
# ------------------------------------------------------------


$Logfile = "${Home}\Desktop\ProgramsAndFeatures_$(Hostname)_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log;"; `
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
#   stackoverflow.com  |  "powershell - How do I use Format-Table without truncation of values? - Stack Overflow"  |  https://stackoverflow.com/a/49123225
#
#   www.howtogeek.com  |  "How to Create a List of Your Installed Programs on Windows"  |  https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/
#
# ------------------------------------------------------------