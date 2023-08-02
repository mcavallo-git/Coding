<!-- ------------------------------------------------------------ -->
<!-- https://github.com/mcavallo-git/Coding/blob/main/powershell/DeviceManagement/SafelyRemoveAndEjectMediaHotfix.md -->
<!-- https://superuser.com/a/1801861/699988 -->
<!-- ------------------------------------------------------------ -->

I solved the issue of improper devices showing up under `Safely Remove Hardware and Eject Media` in the taskbar via the following:

***

### [`SetDeviceProperties_NonRemovableFingerprintScanners.verbose.ps1`](https://github.com/mcavallo-git/Coding/blob/main/powershell/DeviceManagement/SetDeviceProperties_NonRemovableFingerprintScanners.verbose.ps1#L8-L89)
```powershell
If ($True) {
  #
  # Disable the 'Safely Remove Hardware and Eject Media' capability for target Plug and Play (PnP) devices
  #
  # Set the class/friendlyname of devices to update
  $PnP_Class = "Biometric";
  $PnP_FriendlyName = "*Fingerprint*";
  # Set the list of capabilities to remove (additional "capabilities bits" listed at the bottom of this script)
  $RemoveCapabilities = @()
  $RemoveCapabilities += 0x00000002;    # CM_DEVCAP_EJECTSUPPORTED  (flags the device as ejectable)
  $RemoveCapabilities += 0x00000004;    # CM_DEVCAP_REMOVABLE       (flags the device as removable)
  # Get the list of devices to remove capabilities from
  Get-PnpDevice -Class "${PnP_Class}" -FriendlyName "${PnP_FriendlyName}" -Status 'OK' -EA:0 | ForEach-Object {
    $InstanceId = (${_}.InstanceId);
    $RegEdit = @{
      Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${InstanceId}";
      Name="Capabilities";
      Type="DWord";
      Description="Defines the capabilities for a given device. Citation [ https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#L1067-L1076 ]";
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
        Description="Defines the capabilities for a given device. Citation [ https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#L1067-L1076 ]";
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
```

> Note that variables `$PnP_Class` and `$PnP_FriendlyName` (at the top of the script) are intended to be set on a case-by-case basis to ensure the script only targets devices which shouldn't be removable/ejectable

***

> Here's a thinned down version of the above script (intended for automation - to be ran through Task Scheduler)

### [`SetDeviceProperties_NonRemovableFingerprintScanners.ps1`](https://github.com/mcavallo-git/Coding/blob/main/powershell/DeviceManagement/SetDeviceProperties_NonRemovableFingerprintScanners.ps1#L4-L31)
```powershell
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
```

***

> Here's a general workflow for the above script(s)...

1. Use PowerShell's [`Get-PnpDevice`](https://learn.microsoft.com/en-us/powershell/module/pnpdevice/get-pnpdevice) cmdlet to target the device(s) you wish to no longer show as removable/ejectable media. For each `PnpDevice` acquired:

2. Append the device's `InstanceId` property onto the static USB devices registry path, such as: `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${InstanceId}`

3. Perform a [`Bitwise AND`](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.3#bitwise-operators) (`-band`) between the device's `Capability` value and each of the undesired capabilities (namely [`CM_DEVCAP_EJECTSUPPORTED`](https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#L1067-L1076) (`0x2`) and [`CM_DEVCAP_REMOVABLE`](https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#L1067-L1076) (`0x4`)), then subtract the resultant value coming out of the `-band` from the `Capability` value.

    - If the `Capability` value *DID* contain either `0x2` or `0x4`, then the `-band` resultant value will contain the exact differential to subtract off of the `Capability` to remove only the functionality which isnt needed.

    - If the `Capability` value *DIDN'T* contain either `0x2` or `0x4`, then the `-band` will result in a value of `0`, and we will subtract nothing (e.g. no changes to be made)

      - The above script also takes this final subtracted value and compares it against the original `Capability` value to see if it actually should perform a registry update (and skips it if not)

4. Repeat step 2 & 3 for each device's parent device (and its associated `InstanceId`)
    - > ⚠️ This behavior is 'fun', in that the parents device can have a `Capability` including `0x2` or `0x4` and that will cause the child device to continue to show up as ejectable/removable
    - Use PowerShell's [`Get-PnpDeviceProperty`](https://learn.microsoft.com/en-us/powershell/module/pnpdevice/get-pnpdeviceproperty) cmdlet targeting each device (from step 2)'s `InstanceId` along with the KeyName [`DEVPKEY_Device_Parent`](https://learn.microsoft.com/en-us/windows-hardware/drivers/install/devpkey-device-parent) and expand the property `Data` (from the returned object)
      - This `Data` field will yield the `InstanceId` of the parent element (such as a USB dock), which requires performing steps 2 & 3 for in the same manner as the original device itself

***