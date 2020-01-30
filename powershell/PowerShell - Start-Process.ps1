

Start-Process -Filepath ("C:\Windows\system32\sc.exe") -ArgumentList (@("restart","W32Time")) -NoNewWindow -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process - Starts one or more processes on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
# ------------------------------------------------------------