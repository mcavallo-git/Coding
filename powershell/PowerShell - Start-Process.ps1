

Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("restart","W32Time"))  -Wait -PassThru -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("restart","W32Time")) -NoNewWindow  -Wait -PassThru -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process - Starts one or more processes on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
#   stackoverflow.com  |  "powershell - Start-Process gives error - Stack Overflow"  |  https://stackoverflow.com/a/4543786
#
# ------------------------------------------------------------