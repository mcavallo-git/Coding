'=============================================================
'
' ⚠️ Requires the "WMIC" Optional Feature to be enabled
'
'         Add-WindowsCapability -Online -Name "WMIC";
'
'=============================================================
' Open 'Task Scheduler' > 'Create Task' (top right)
'=============================================================
'
'   General:
'
'     Task Name:  SetDeviceProperties_DisableUsbPciePowerSaver
'
'     Run as user:  [ SYSTEM ]
'
'     ✔️ Run whether user is logged on or not (CHECKED)
'
'     ❌ Run with highest privileges (UN-CHECKED)
'
'=============================================================
'
'   Trigger:
'
'     At system startup  (no delay, no repeat)
'
'     At log on of any user  (delay for 1 minute, no repeat)
'
'     On workstation unlock of any user (delay for 1 minute, no repeat)
'
'=============================================================
'
'   Action:
'
'     Program/script:
'       C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe
'
'     Add arguments:
'       -Command "Start-Process -Filepath ((gcm powershell).Source) -ArgumentList ('-Command Set-CimInstance -Namespace root/WMI -Query ((write SELECT` *` FROM` MSPower_DeviceEnable` WHERE` InstanceName` LIKE` )+([string][char]34)+(write USB\\%)+([string][char]34)+([string][char]32)+(write OR` InstanceName` LIKE` )+([string][char]34)+(write PCI\\%)+([string][char]34)) -Property @{Enable=((gv false).Value)};') -Verb 'RunAs' -Wait -PassThru | Out-Null;"
'
'=============================================================
'
'   Conditions:
'
'     ❌️ Start the task only if the computer is on AC power (UN-CHECKED)
'
'       ❌️ Stop if the computer switches to battery power (UN-CHECKED)
'
'=============================================================
'
'   Settings:
'
'     ✔️ Run the task as soon as possible after a scheduled start is missed (CHECKED)
'
'     ✔️ Stop the task if it runs longer than:  [ 10 seconds ]
'
'     ✔️ If the running task does not end when requested, force it to stop (CHECKED)
'
'=============================================================