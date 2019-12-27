# ------------------------------------------------------------
#  AutoStart one (or more) VMs on Windows Startup
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

Get-Content -Path "${HOME}\.vmware\startup-vmx.txt" | ForEach-Object { "C:\Windows\System32\CMD" /C "'C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe' -T wt start '$_'"; };


# ------------------------------------------------------------