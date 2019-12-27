# ------------------------------------------------------------
#  AutoStart one (or more) VMs on Windows Startup
# ------------------------------------------------------------
#
# 1) In your home-directory ( e.g. in %USERPROFILE% ), create a folder named ".vmware"
# 
# 2) Within the ".vmware" folder, create a file named "startup-vmx.txt"
# 
# 3) Within "startup-vmx.txt", place the fullpath locations of any VMs' [ .vmx ] files which you wish to start on-boot (such as "E:\Images\Windows10.vmx")
# 
# 4)Create a new basic scheduled Task via Windows' "Task Scheduler" to run the bottom one-liner to grab your newly created "startup-vmx.txt" and start them at-boot (select on pc startup as task trigger)
# 
# 
# ------------------------------------------------------------
#
# One-Liner Syntax
#

PowerShell.exe -Command "ForEach ($EachVMX In (Get-Content '~\.vmware\startup-vmx.txt')) { If ((Test-Path (${EachVMX})) -And (([String]::IsNullOrEmpty(${EachVMX}.Trim())) -Eq $False)) { Start-Process -Filepath 'C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe' -ArgumentList (('-T wt start ')+(${EachVMX})); Start-Sleep 5; }; };"


# ------------------------------------------------------------
#
# Verbose Syntax
#

ForEach ($EachVMX In (Get-Content '~\.vmware\startup-vmx.txt')) {
	If ((Test-Path (${EachVMX})) -And (([String]::IsNullOrEmpty(${EachVMX}.Trim())) -Eq $False)) {
		Start-Process -Filepath 'C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe' -ArgumentList (('-T wt start ')+(${EachVMX}));
		Start-Sleep 5;
	};
};


# ------------------------------------------------------------