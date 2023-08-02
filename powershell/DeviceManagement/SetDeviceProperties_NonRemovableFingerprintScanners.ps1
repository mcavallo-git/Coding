#
# %ISO_DIR%\DeviceManagement\SetDeviceProperties_NonRemovableFingerprintScanners.ps1
#
If ($True) {
  Get-PnpDevice -Class 'Biometric' -FriendlyName '*Fingerprint*' -Status 'OK' -EA:0 | ForEach-Object {
    $InstanceId = (${_}.InstanceId);
    $RegEdit = @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${InstanceId}"; Name="Capabilities"; };
    If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
      $GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
      ${RegEdit}.Value = ($GetEachItemProp);
      $(0x00000002, 0x00000004) | ForEach-Object {
        ${RegEdit}.Value = ((${Regedit}.Value) - ((${Regedit}.Value) -band ${_}));
      }
      If ((${GetEachItemProp}) -NE (${RegEdit}.Value)) {
        Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
      }
      $ParentInstanceId = (Get-PnpDeviceProperty -KeyName 'DEVPKEY_Device_Parent' -InstanceId "${InstanceId}" | Select-Object -ExpandProperty "Data" -EA:0);
      $RegEditParent = @{ Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${ParentInstanceId}"; Name="Capabilities"; };
      If ((Test-Path -Path (${RegEditParent}.Path)) -Eq $True) {
        $GetEachParentItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEditParent}.Path) -Name (${RegEditParent}.Name) -ErrorAction ("Stop"));
        ${RegEditParent}.Value = $GetEachItemProp;
        $(0x00000002, 0x00000004) | ForEach-Object {
          ${RegEditParent}.Value = ((${RegEditParent}.Value) - ((${RegEditParent}.Value) -band ${_}));
        }
        If ((${GetEachParentItemProp}) -NE (${RegEditParent}.Value)) {
          Set-ItemProperty -LiteralPath (${RegEditParent}.Path) -Name (${RegEditParent}.Name) -Value (${RegEditParent}.Value);
        }
      }
    }
  }
}