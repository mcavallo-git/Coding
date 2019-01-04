# List all possible power config GUIDs in Windows
# Run: this-script.ps1 | Out-File powercfg.ps1
# Then edit and run powercfg.ps1
# (c) Pekka "raspi" Järvinen 2017

$powerSettingTable = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSetting
$powerSettingInSubgroubTable = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSettingInSubgroup

Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSettingCapabilities | ForEach-Object {
  $tmp = $_.ManagedElement
  $tmp = $tmp.Remove(0, $tmp.LastIndexOf('{') + 1)
  $tmp = $tmp.Remove($tmp.LastIndexOf('}'))
  
  $guid = $tmp

  $s = ($powerSettingInSubgroubTable | Where-Object PartComponent -Match "$guid")

  if (!$s) {
    return
  }
  
  $tmp = $s.GroupComponent
  $tmp = $tmp.Remove(0, $tmp.LastIndexOf('{') + 1)
  $tmp = $tmp.Remove($tmp.LastIndexOf('}'))
  
  $groupguid = $tmp
  
  $s = ($powerSettingTable | Where-Object InstanceID -Match "$guid")
  
  $descr = [string]::Format("# {0}", $s.ElementName)
  $runcfg = [string]::Format("powercfg -attributes {0} {1} -ATTRIB_HIDE", $groupguid, $guid)
  
  Write-Output $descr
  Write-Output $runcfg
  Write-Output ""
  
}

# Citation: Pulled from [ https://gist.github.com/raspi/203aef3694e34fefebf772c78c37ec2c ] on [ 20190104-135522-0500 ]
