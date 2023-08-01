#
# C:\ISO\DeviceManagement\SetDeviceProperties_NonRemovableFingerprintScanners.ps1
#
If ($True) {
  Get-PnpDevice -Class 'Biometric' -FriendlyName '*Fingerprint*' -Status 'OK' -EA:0 | ForEach-Object {
    $InstanceId = (${_}.InstanceId);
    $RegEdit = @{
      Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${InstanceId}";
      Name="Capabilities";
      Type="DWord";
    };
    If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
      $GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
      ${RegEdit}.Value = ($GetEachItemProp);
      $(0x00000002, 0x00000004) | ForEach-Object {
        ${RegEdit}.Value = ((${Regedit}.Value) - ((${Regedit}.Value) -band ${_}));
      }
      If ((${GetEachItemProp}) -NE (${RegEdit}.Value)) {
        Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
      }
    }
  }
}