@ECHO OFF
# 
# Hyper-V's Enabled/Disabled setting exists in two places:
#  1) The set of Windows Features currently enabled on target image (windows OS) - Edit using "OptionalFeatures.exe" (native windows command-line tool)
#  2) The bootup setting pulled from Boot Configuration Data (BCD) - Edit using "bcdedit.exe" (native windows command-line tool)

# glitch where "Hyper-V" role/feature is disabled, yet VMWare Workstation still states it can't start VMs because "VMware Workstation and Hyper V are not compatible. #ove the Hyper V Role from the system before runnin VMware Workstation."
# 
# ------------------------------------------------------------

# Using PowerShell:

bcdedit /set hypervisorlaunchtype Off; <# <-- Disable Hyper V [ Boot Configuration Data ] #> Get-WindowsOptionalFeature -Online | Where-Object { $_.State -Eq "Disabled" } | Where-Object { @("HypervisorPlatform", "Microsoft-Hyper-V-All", "Microsoft-Hyper-V", "Microsoft-Hyper-V-Tools-All", "Microsoft-Hyper-V-Management-PowerShell", "Microsoft-Hyper-V-Hypervisor", "Microsoft-Hyper-V-Services", "Microsoft-Hyper-V-Management-Clients").Contains($_.FeatureName) -Eq $True } | Disable-WindowsOptionalFeature -Online -NoRestart; <# <-- Disable Hyper V [ Windows Features ] #> 


# ------------------------------------------------------------
# Citation(s)
#
#   answers.microsoft.com  |  "Hyper V #nants left over after disabling, preventing other Virtualization software from running in 64-bit mode"  |  https://answers.microsoft.com/en-us/insider/forum/all/hyper-v-#nants-left-over-after-disabling/81e4fef1-d08e-4ef4-8e1e-b24c47bd7677?auth=1
#
# ------------------------------------------------------------