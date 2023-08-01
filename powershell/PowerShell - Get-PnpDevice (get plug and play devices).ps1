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

#
# ⚠️
# Refer to file (in this repo):
#    SetDeviceProperties_NonRemovableFingerprintScanners.verbose.ps1
#
# ... or its compressed/somewhat-minified version:
#    SetDeviceProperties_NonRemovableFingerprintScanners.ps1
# ⚠️
#

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