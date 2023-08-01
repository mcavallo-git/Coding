# ------------------------------------------------------------
#
# Disable the 'Safely Remove Hardware and Eject Media' capability for target Plug and Play (PnP) devices
#

If ($True) {

  # Set the list of capabilities to remove
  $RemoveCapabilities = @()
  $RemoveCapabilities += 0x00000002;  # "CM_DEVCAP_EJECTSUPPORTED" capability, e.g. flags the device as [ an ejectable device ]
  $RemoveCapabilities += 0x00000004;  # "CM_DEVCAP_REMOVABLE" capability, e.g. flags the device as [ a removable device ]

  # Get the list of devices to remove capabilities from
  Get-PnpDevice -Class 'Biometric' -FriendlyName '*Fingerprint*' -Status 'OK' -EA:0 | ForEach-Object {

    $InstanceId = (${_}.InstanceId);

    $RegEdit = @{
      Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${InstanceId}";
      Name="Capabilities";
      Type="DWord";
      Description="Defines the capabilities for a given device. Citation [ https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#1069 ]";
    };

    # ------------------------------
    # Parse each device in question
    Write-Host "------------------------------------------------------------";
    If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
      $GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
      ${RegEdit}.Value = $GetEachItemProp;
      # Bitwise slice off any instances of the Capability to-remove
      ${RemoveCapabilities} | ForEach-Object {
        # Note that the bitwise AND will be zero if the value doesn't include the value to remove - it will only modify values which require an update.
        ${RegEdit}.Value = ((${RegEdit}.Value) - ((${RegEdit}.Value) -band ${_}));
      }
      If ((${GetEachItemProp}) -Eq (${RegEdit}.Value)) {
        Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" is already set to value `"$(${RegEdit}.Value)`"`n";
      } Else {
        Write-Host "`nInfo:  Setting Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" to value `"$(${RegEdit}.Value)`"...`n";
        Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
      }
      Write-Host "`nInfo:  Confirming value for Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`"...";
      Get-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name);

      # ------------------------------
      # Repeat this process for the parent device
      Write-Host "------------------------------------------------------------";
      $ParentInstanceId = (Get-PnpDeviceProperty -KeyName 'DEVPKEY_Device_Parent' -InstanceId "${InstanceId}" | Select-Object -ExpandProperty "Data" -EA:0);
      $RegEditParent = @{
        Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${ParentInstanceId}";
        Name="Capabilities";
        Type="DWord";
        Description="Defines the capabilities for a given device. Citation [ https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#1069 ]";
      };
      If ((Test-Path -Path (${RegEditParent}.Path)) -Eq $True) {
        $GetEachParentItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEditParent}.Path) -Name (${RegEditParent}.Name) -ErrorAction ("Stop"));
        ${RegEditParent}.Value = $GetEachItemProp;
        # Bitwise slice off any instances of the Capability to-remove
        ${RemoveCapabilities} | ForEach-Object {
          # Note that the bitwise AND will be zero if the value doesn't include the value to remove - it will only modify values which require an update.
          ${RegEditParent}.Value = ((${RegEditParent}.Value) - ((${RegEditParent}.Value) -band ${_}));
        }
        If ((${GetEachParentItemProp}) -Eq (${RegEditParent}.Value)) {
          Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEditParent}.Path)`"'s property `"$(${RegEditParent}.Name)`" is already set to value `"$(${RegEditParent}.Value)`"`n";
        } Else {
          Write-Host "`nInfo:  Setting Registry key `"$(${RegEditParent}.Path)`"'s property `"$(${RegEditParent}.Name)`" to value `"$(${RegEditParent}.Value)`"...`n";
          Set-ItemProperty -LiteralPath (${RegEditParent}.Path) -Name (${RegEditParent}.Name) -Value (${RegEditParent}.Value);
        }
        Write-Host "`nInfo:  Confirming value for Registry key `"$(${RegEditParent}.Path)`"'s property `"$(${RegEditParent}.Name)`"...";
        Get-ItemProperty -LiteralPath (${RegEditParent}.Path) -Name (${RegEditParent}.Name);
      } Else {
        Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEditParent}.Path)`" not found to exist`n";
      }
      # End of parent device handling
      # ------------------------------

    } Else {
      Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEdit}.Path)`" not found to exist`n";
    }

  }

}