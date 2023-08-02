<!-- ------------------------------------------------------------ -->
<!-- https://superuser.com/a/1801861/699988 -->
<!-- ------------------------------------------------------------ -->

***

## I solved the issue of improper devices showing up under `Safely Remove Hardware and Eject Media` in the taskbar via the following:

- ### [`SetDeviceProperties_NonRemovableFingerprintScanners.verbose.ps1`](https://github.com/mcavallo-git/Coding/blob/main/powershell/DeviceManagement/SetDeviceProperties_NonRemovableFingerprintScanners.verbose.ps1#L8-L89)

  > I just finished writing/testing this script, and put it on my public GitHub for external reference - Use it as you wish (but I would recommend at least reading the next two notes for a bit of prefacing)

  > I added a variables `$PnP_Class` and `$PnP_FriendlyName` to the top of the script to make it easier to target other types of devices which shouldn't be removable/ejectable

- ### [`SetDeviceProperties_NonRemovableFingerprintScanners.ps1`](https://github.com/mcavallo-git/Coding/blob/main/powershell/DeviceManagement/SetDeviceProperties_NonRemovableFingerprintScanners.ps1#L4-L31)

  > This is a thinned down version of the above script which I run against using Task Scheduler (not directly out of my GitHub)

  > Suggestion: For simplified copy-paste, I write a lot of scripts wrapped in a large outer `If ($True) { ... }` block, so that you can just copy that whole outer `If` block and not worry about losing this or that or certain lines running without others when pasting into a terminal 👍

***

> Here's a general workflow for the above script(s)...

- Use PowerShell's `Get-PnpDevice` cmdlet to target the device(s) you wish to no longer show as removable/ejectable media. For each `PnpDevice` acquired:

1. Append the device's `InstanceId` property onto the static USB devices registry path

2. Perform a [Bitwise AND (`-band`)](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_arithmetic_operators?view=powershell-7.3#bitwise-operators) between the device's `Capability` value and each of the undesired capabilities (namely `CM_DEVCAP_EJECTSUPPORTED` (`0x2`) and `CM_DEVCAP_REMOVABLE` (`0x4`)), then subtract the resultant value coming out of the `-band` from the `Capability` value.

  - If the `Capability` value *DID* contain either `0x2` or `0x4`, then the `-band` resultant value will contain the exact differential to subtract off of the `Capability` to remove only the functionality which isnt needed.

  - If the `Capability` value *DIDN'T* contain either `0x2` or `0x4`, then the `-band` will result in a value of `0`, and we will subtract nothing (e.g. no changes to be made)

    - The above script also takes this final subtracted value and compares it against the original `Capability` value to see if it actually should perform a registry update (and skips it if not)

3. ⚠️ Repeat step 2 for each device's parent device
    - Use PowerShell's `Get-PnpDeviceProperty` cmdlet targeting each device (from step 1)'s `InstanceId`, and grab the KeyName `DEVPKEY_Device_Parent`
      - Syntax: `$ParentInstanceId = (Get-PnpDeviceProperty -KeyName 'DEVPKEY_Device_Parent' -InstanceId "${InstanceId}" | Select-Object -ExpandProperty "Data" -EA:0);`
      - ⚠️ This `Data` field will yield the `InstanceId` of the parent element (such as a USB dock), which requires performing steps 1 & 2 for in the same manner as the original device itself
    - > This was the kicker that finally made things work for me - I had a USB hub between the device and my computer which had a capability of `0x84` (which contains `0x4`), and was causing the device to still show up as removable/ejectable even though the device itself had its `Capability` value set as intended  

***

Hope this helps!

