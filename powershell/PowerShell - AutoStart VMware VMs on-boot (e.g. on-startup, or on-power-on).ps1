# ------------------------------------------------------------
#  AutoStart one (or more) VMs on Windows Startup
# ------------------------------------------------------------

$VMwareStartupList_Vmx="${HOME}\.vmware\startup-vmx.txt"; # 
Get-Content -Path "${VMwareStartupList_Vmx}" | ForEach-Object {
$VMwareHostTypes = @{ Workstation="wt"; Fusion="fusion"; Player="player"; };
"C:\Windows\System32\CMD" /C "'C:\Program Files (x86)\VMware\VMware Workstation\vmrun.exe' -T $(${VMwareHostTypes}.Workstation) start '$_'";
};

