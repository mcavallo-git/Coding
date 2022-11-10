# ------------------------------------------------------------
#
# PowerShell - Start-Process
#
# ------------------------------------------------------------

<# Run a 'background' (delayed) job #>
$Delay_Seconds=30; $Delay_PSCommand="Get-Date | Out-File '${Home}\Desktop\get-date.txt'; Notepad '${Home}\Desktop\get-date.txt';"; Start-Process -Filepath ("powershell.exe") -ArgumentList (@("-Command","`"Start-Sleep -Seconds ${Delay_Seconds}; ${Delay_PSCommand}`"")) -NoNewWindow;


# ------------------------------------------------------------

<# Restart a service #>
$ServiceName="W32Time"; Start-Process -Filepath ("${env:windir}\system32\sc.exe") -ArgumentList (@("restart","${ServiceName}")) -NoNewWindow -Wait -PassThru -ErrorAction ("SilentlyContinue");

<# Restart a service (as Admin) #>
$ServiceName="W32Time"; Start-Process -Filepath ("${env:windir}\system32\sc.exe") -ArgumentList (@("restart","${ServiceName}")) -Wait -PassThru -Verb ("RunAs") -ErrorAction ("SilentlyContinue");


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Start-Process - Starts one or more processes on the local computer"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/start-process
#
#   stackoverflow.com  |  "Powershell equivalent of bash ampersand (&) for forking/running background processes - Stack Overflow"  |  https://stackoverflow.com/a/13729303
#
#   stackoverflow.com  |  "powershell - Start-Process gives error - Stack Overflow"  |  https://stackoverflow.com/a/4543786
#
# ------------------------------------------------------------