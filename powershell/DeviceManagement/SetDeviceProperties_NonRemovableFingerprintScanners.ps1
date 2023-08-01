# ------------------------------------------------------------
# SetDeviceProperties_NonRemovableFingerprintScanners
#   |-->  PowerShell - Set Biometric Fingerprint Reader Devices as Non-Removable
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

    Write-Host "------------------------------------------------------------";

    $InstanceId = (${_}.InstanceId);

    $RegEdit = @{
      Path="Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Enum\${InstanceId}";
      Name="Capabilities";
      Type="DWord";
      Description="Defines the capabilities for a given device. Citation [ https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#1069 ]";
    };

    If ((Test-Path -Path (${RegEdit}.Path)) -Eq $True) {
      $GetEachItemProp = (Get-ItemPropertyValue -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -ErrorAction ("Stop"));
      ${RegEdit}.Value = $GetEachItemProp;
      # Bitwise slice off any instances of the Capability to-remove
      ${RemoveCapabilities} | ForEach-Object {
        # Note that the bitwise AND will be zero if the value doesn't include the value to remove - it will only modify values which require an update.
        ${RegEdit}.Value = ((${Regedit}.Value) - ((${Regedit}.Value) -band ${_}));
      }
      If ((${GetEachItemProp}) -Eq (${RegEdit}.Value)) {
        Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" is already set to value `"$(${RegEdit}.Value)`"`n";
      } Else {
        Write-Host "`nInfo:  Setting Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`" to value `"$(${RegEdit}.Value)`"...`n";
        Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
      }
      Write-Host "`nInfo:  Confirming value for Registry key `"$(${RegEdit}.Path)`"'s property `"$(${RegEdit}.Name)`"...";
      Get-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name);
    } Else {
      Write-Host "`nInfo:  (Skipped) Registry key `"$(${RegEdit}.Path)`" not found to exist`n";
    }

  }

}


# ------------------------------------------------------------
#
# [ Reference - https://github.com/tpn/winsdk-10/blob/master/Include/10.0.10240.0/um/cfgmgr32.h#1069 ]
#
# //
# // Capabilities bits (the capability value is returned from calling
# // CM_Get_DevInst_Registry_Property with CM_DRP_CAPABILITIES property)
# //
#
# #define CM_DEVCAP_LOCKSUPPORTED     (0x00000001)
# #define CM_DEVCAP_EJECTSUPPORTED    (0x00000002)
# #define CM_DEVCAP_REMOVABLE         (0x00000004)
# #define CM_DEVCAP_DOCKDEVICE        (0x00000008)
# #define CM_DEVCAP_UNIQUEID          (0x00000010)
# #define CM_DEVCAP_SILENTINSTALL     (0x00000020)
# #define CM_DEVCAP_RAWDEVICEOK       (0x00000040)
# #define CM_DEVCAP_SURPRISEREMOVALOK (0x00000080)
# #define CM_DEVCAP_HARDWAREDISABLED  (0x00000100)
# #define CM_DEVCAP_NONDYNAMIC        (0x00000200)
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
#   superuser.com  |  "windows 10 - How to remove my mouse from the "Safely Remove Hardware" - Super User"  |  https://superuser.com/a/1676269
#
# ------------------------------------------------------------