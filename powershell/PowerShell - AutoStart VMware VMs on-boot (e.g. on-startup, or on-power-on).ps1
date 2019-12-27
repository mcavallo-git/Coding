# ------------------------------------------------------------
#  AutoStart one (or more) VMs on Windows Startup
# ------------------------------------------------------------
#
# In your user's home-directory, create a folder named ".vmware"
# Within the ".vmware" folder, create a file named "startup-vmx.txt"
# Within "startup-vmx.txt", place the fullpath locations of any VMs' [ .vmx ] files which you wish to start on-boot (such as "E:\Images\Windows10.vmx")
# Create a new basic scheduled Task via Windows' "Task Scheduler" to run the bottom one-liner to grab your newly created "startup-vmx.txt" and start them at-boot (select on pc startup as task trigger)
# 
# 
# ------------------------------------------------------------
#
# Verbose Syntax, using variables and spread-out commands for easier reading
#

$VMwareStartupList_Vmx="${HOME}\.vmware\startup-vmx.txt";

Get-Content -Path "${VMwareStartupList_Vmx}" | ForEach-Object {

	$VMwareHostTypes = @{ Workstation="wt"; Fusion="fusion"; Player="player"; };

	"C:\Windows\System32\CMD" /C "'C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe' -T $(${VMwareHostTypes}.Workstation) start '$_'";

};

# ------------------------------------------------------------
#
# As a one-liner
#

PowerShell.exe -Command 'Get-Content ~\.vmware\startup-vmx.txt | ForEach-Object { Start-Process -Filepath ("C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe") -ArgumentList (-T wt start "$_") -Verb ("RunAs") -WindowStyle ("Hidden"); }';

# ------------------------------------------------------------