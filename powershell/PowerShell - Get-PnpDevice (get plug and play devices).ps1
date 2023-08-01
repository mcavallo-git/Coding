# ------------------------------------------------------------
# PowerShell - Get-PnpDevice (get plug and play devices)
# ------------------------------------------------------------

# Get devices by class - Mouse devices
Get-PnpDevice -Class 'Mouse' -Status 'OK';

# Get devices by class - Biometric devices
Get-PnpDevice -Class 'Biometric' -Status 'OK';

# Get available 'classes'
Get-PnpDevice | Select-Object -ExpandProperty "Class" -Unique | Sort-Object
# AudioEndpoint
# Battery
# Biometric
# Computer
# DiskDrive
# Display
# Firmware
# HDC
# HIDClass
# Image
# Keyboard
# MEDIA
# Monitor
# Mouse
# Net
# NvModuleTracker
# Ports
# Printer
# PrintQueue
# Processor
# SCSIAdapter
# SecurityDevices
# SmartCard
# SmartCardFilter
# SmartCardReader
# SoftwareDevice
# System
# USB
# USBDevice
# Volume
# VolumeSnapshot
# WPD
# WSDPrintDevice


# ------------------------------------------------------------

# Get devices by class & name - Biometric fingerprint readers
Get-PnpDevice -Class 'Biometric' -FriendlyName '*Fingerprint*' -Status 'OK';

# Get devices by class & name - 'USB Mass Storage Device' (USB Flash Drives)
Get-PnpDevice -Class 'USB' -FriendlyName '*Storage*' -Status 'OK';

# Get devices by class & name - Sandisk Disks (USB Flash Drives)
Get-PnpDevice -Class 'DiskDrive' -FriendlyName '*USB*Sandisk*' -Status 'OK';


# ------------------------------------------------------------
#
# Disable the 'Safely Remove Hardware and Eject Media' capability for target Plug and Play (PnP) devices
#

If ($True) {

  $DryRun = $True;   # DON'T MAKE CHANGES
  # $DryRun = $False;  # MAKE CHANGES

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
        If ($False -Eq ${DryRun}) { 
          Set-ItemProperty -LiteralPath (${RegEdit}.Path) -Name (${RegEdit}.Name) -Value (${RegEdit}.Value);
        }
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
          If ($False -Eq ${DryRun}) { 
            Set-ItemProperty -LiteralPath (${RegEditParent}.Path) -Name (${RegEditParent}.Name) -Value (${RegEditParent}.Value);
          }
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
#   learn.microsoft.com  |  "Get-PnpDeviceProperty (PnpDevice) | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/pnpdevice/get-pnpdeviceproperty
#
#   learn.microsoft.com  |  "DEVPKEY_Device_Parent - Windows drivers | Microsoft Learn"  |  https://learn.microsoft.com/en-us/windows-hardware/drivers/install/devpkey-device-parent
#
#   superuser.com  |  "windows 10 - How to remove my mouse from the "Safely Remove Hardware" - Super User"  |  https://superuser.com/a/1676269
#
# ------------------------------------------------------------