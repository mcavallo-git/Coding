# ------------------------------------------------------------
#
# PowerShell - List all programs installed in windows (output to a file on the current user's desktop)
#
# ------------------------------------------------------------


$Logfile = "${Home}\ProgramsAndFeatures_$(Hostname)_$(Get-Date -UFormat '%Y%m%d-%H%M%S').log;"; `
Get-ItemProperty HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\* `
| Select-Object DisplayName, DisplayVersion, Publisher, InstallDate `
| Where-Object { ([String]($_.DisplayName)).Trim() -NE "" } `
| Sort-Object -Property DisplayName `
| Format-Table –AutoSize; `
> "${Logfile}"; `
Notepad "${Logfile}";


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.howtogeek.com  |  "How to Create a List of Your Installed Programs on Windows"  |  https://www.howtogeek.com/165293/how-to-get-a-list-of-software-installed-on-your-pc-with-a-single-command/
#
# ------------------------------------------------------------