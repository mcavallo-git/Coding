# ------------------------------------------------------------
# https://github.com/mcavallo-git/Coding/blob/main/powershell/DeviceManagement/SetDeviceProperties_NonRemovableFingerprintScanners.verbose.ps1
# ------------------------------------------------------------
#
# Disable the 'Safely Remove Hardware and Eject Media' capability for target Plug and Play (PnP) devices
#

If ($True) {

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


# ------------------------------------------------------------
#
# //
# // Capabilities bits (the capability value is returned from calling
# // CM_Get_DevInst_Registry_Property with CM_DRP_CAPABILITIES property)
# //
#
# $RemoveCapabilities += 0x00000001;  # CM_DEVCAP_LOCKSUPPORTED
# $RemoveCapabilities += 0x00000002;  # CM_DEVCAP_EJECTSUPPORTED
# $RemoveCapabilities += 0x00000004;  # CM_DEVCAP_REMOVABLE
# $RemoveCapabilities += 0x00000008;  # CM_DEVCAP_DOCKDEVICE
# $RemoveCapabilities += 0x00000010;  # CM_DEVCAP_UNIQUEID
# $RemoveCapabilities += 0x00000020;  # CM_DEVCAP_SILENTINSTALL
# $RemoveCapabilities += 0x00000040;  # CM_DEVCAP_RAWDEVICEOK
# $RemoveCapabilities += 0x00000080;  # CM_DEVCAP_SURPRISEREMOVALOK
# $RemoveCapabilities += 0x00000100;  # CM_DEVCAP_HARDWAREDISABLED
# $RemoveCapabilities += 0x00000200;  # CM_DEVCAP_NONDYNAMIC
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   github.com  |  "Capabilities bits (the capability value is returned from calling CM_Get_DevInst_Registry_Property with CM_DRP_CAPABILITIES property) · GitHub"  |  https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#1069
#
#   learn.microsoft.com  |  "Get-PnpDevice (PnpDevice) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/pnpdevice/get-pnpdevice
#
#   learn.microsoft.com  |  "Get-PnpDeviceProperty (PnpDevice) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/pnpdevice/get-pnpdeviceproperty
#
#   learn.microsoft.com  |  "DEVPKEY_Device_Parent - Windows drivers | Microsoft Learn"  |  https://learn.microsoft.com/en-us/windows-hardware/drivers/install/devpkey-device-parent
#
#   superuser.com  |  "windows 10 - How to remove my mouse from the "Safely Remove Hardware" - Super User"  |  https://superuser.com/a/1676269
#
# ------------------------------------------------------------