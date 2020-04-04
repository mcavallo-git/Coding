# ------------------------------------------------------------
#
# PowerShell - Run a program as a background task
#
# ------------------------------------------------------------


Start-Process -NoNewWindow -Filepath ("C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe") -ArgumentList (@("-Command","`"Start-Sleep -Seconds 30; Get-Date | Out-File '${Home}\Desktop\get-date.txt'; Notepad '${Home}\Desktop\get-date.txt';`""))


# ------------------------------------------------------------
#
# Citation(s)
#
#   stackoverflow.com  |  "Powershell equivalent of bash ampersand (&) for forking/running background processes - Stack Overflow"  |  https://stackoverflow.com/a/13729303
#
# ------------------------------------------------------------