# ------------------------------------------------------------
# PowerShell - Set-CimInstance (Uncheck 'Allow the computer to turn off this device to save power' on all USB Controllers & PCIe devices)
# ------------------------------------------------------------

# Option 1 - WQL Query
Set-CimInstance -Namespace root/WMI -Query 'SELECT * FROM MSPower_DeviceEnable WHERE InstanceName LIKE "USB\\%" OR InstanceName LIKE "PCI\\%"' -Property @{Enable=$false};

# Option 1 - WQL Query (prepped for scheduled task)
Set-CimInstance -Namespace root/WMI -Query ((write SELECT` *` FROM` MSPower_DeviceEnable` WHERE` InstanceName` LIKE` )+([string][char]34)+(write USB\\%)+([string][char]34)+([string][char]32)+(write OR` InstanceName` LIKE` )+([string][char]34)+(write PCI\\%)+([string][char]34)) -Property @{Enable=((gv false).Value)};

# Option 2 - For-Loop
foreach ($EACH_USB_PWR_MGMT in (Get-CimInstance -ClassName MSPower_DeviceEnable -Namespace root/WMI | Where-Object {($_.InstanceName -Like 'USB*') -Or ($_.InstanceName -Like 'PCI*')})) { ${EACH_USB_PWR_MGMT}.Enable=$false; Set-CimInstance -InputObject ${EACH_USB_PWR_MGMT}; };


# ------------------------------------------------------------

# Create a scheduled task to automatically uncheck 'Allow the computer to turn off this device to save power' for all USB Controllers & PCIe devices
#  |
#  |--> Manually set trigger: At system startup
#  |--> Manually set trigger: At log on of any user (delay task for 1 minute)
#  |--> Manually set trigger: On workstation unlock of any user (delay task for 1 minute)

$Args_SchedTask=@{ TaskName="USB_PCIe_Devices_DisablePowerSaver"; Description="Uncheck 'Allow the computer to turn off this device to save power' on all USB Controllers & PCIe Devices"; Trigger=(New-ScheduledTaskTrigger -Once -At (Get-Date)); Action=(New-ScheduledTaskAction -Execute ((gcm powershell).Source) -Argument (("-Command `"Start-Process -Filepath ((gcm powershell).Source) -ArgumentList ('-Command Set-CimInstance -Namespace root/WMI -Query ((write SELECT`` *`` FROM`` MSPower_DeviceEnable`` WHERE`` InstanceName`` LIKE`` )+([string][char]34)+(write USB\\%)+([string][char]34)+([string][char]32)+(write OR`` InstanceName`` LIKE`` )+([string][char]34)+(write PCI\\%)+([string][char]34)) -Property @{Enable=((gv false).Value)};') -Verb 'RunAs' -Wait -PassThru | Out-Null;`""))); User="System";}; Register-ScheduledTask @Args_SchedTask;


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.reddit.com  |  "Uncheck "Allow the computer to turn off this device to save power" on all USB Controllers : PowerShell"  |  https://www.reddit.com/r/PowerShell/comments/lr5iyk/uncheck_allow_the_computer_to_turn_off_this/
#
# ------------------------------------------------------------