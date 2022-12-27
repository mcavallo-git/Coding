# ------------------------------------------------------------
#
#	PowerShell - Get-SystemSpecs
#		|
#		|--> Description:  Gets hardware specs for current device
#		|
#		|--> Example:     PowerShell -Command ("Get-SystemSpecs")
#
# ------------------------------------------------------------
Function Get-SystemSpecs() {
  Param(
  )
  # ------------------------------------------------------------
  If ($False) { # RUN THIS SCRIPT REMOTELY:

    $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Get-SystemSpecs/Get-SystemSpecs.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-SystemSpecs' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-SystemSpecs\Get-SystemSpecs.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
    Get-SystemSpecs;

  }
  # ------------------------------
  # Setup Logfile

  $Domain=(Get-CimInstance -ClassName "Win32_ComputerSystem" | Select-Object -ExpandProperty Domain);
  $HostName=(Get-CimInstance -ClassName "Win32_ComputerSystem" | Select-Object -ExpandProperty Name);
  $Logfile="${HOME}\Desktop\Get-SystemSpecs.${HostName}.${Domain}.txt";
  Set-Content -Path ("${Logfile}") -Value ("");

  # ------------------------------

  Write-Host "";
  Write-Host -NoNewline "Acquiring data .";

  # ------------------------------

  Add-Content -Path ("${Logfile}") -Value ("System Specs ");
  Add-Content -Path ("${Logfile}") -Value ("    Hostname:  ${hostname} ");
  Add-Content -Path ("${Logfile}") -Value ("    Datetime:  $(Get-Date -Format 'yyyy-MM-dd @ HH:mm:ss.fff (zzz)') ");
  Add-Content -Path ("${Logfile}") -Value ("");

  # ------------------------------

  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  CPU  (Processor) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_Processor" | Select-Object -Property CurrentClockSpeed,MaxClockSpeed,Name,NumberOfCores,NumberOfLogicalProcessors | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # VIDEO CARD
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  GPU  (Graphics/Video Card) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_VideoController" | Select-Object -Property AdapterRAM,Description,DriverVersion,Name | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # MEMORY/RAM
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  Memory/RAM (Capacity in Bytes) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_PhysicalMemory" | Select-Object -Property BankLabel,Capacity,DeviceLocator,FormFactor,Manufacturer,PartNumber,Speed | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  Motherboard RAM Limits (MaxCapacity in kilobytes, MemoryDevices is total RAM Slots) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_PhysicalMemoryArray" | Select-Object -Property MaxCapacity,MemoryDevices | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # DISK(S)
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  Disk(s)   (Size in bytes) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_DiskDrive" | Select-Object -Property Caption,DeviceID,Index,Partitions,Size | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # PC MODEL/NAME
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  Model / Manufacturer ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_ComputerSystem" | Select-Object -Property Manufacturer,Model,Name,SystemType | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # MOTHERBOARD/BIOS
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  Motherboard ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Write-Output "" | Out-File -Width 16384 -Append -FilePath ("${Logfile}");
  Write-Output "--- " | Out-File -Width 16384 -Append -FilePath ("${Logfile}");
  Write-Output "-----  Motherboard " | Out-File -Width 16384 -Append -FilePath ("${Logfile}");
  Write-Output "--- " | Out-File -Width 16384 -Append -FilePath ("${Logfile}");
  Get-CimInstance -ClassName "Win32_BaseBoard" | Select-Object -Property Manufacturer,Product,SerialNumber | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  BIOS ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_BIOS" | Select-Object -Property ReleaseDate,SMBIOSBIOSVersion,SMBIOSMajorVersion,SMBIOSMinorVersion | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # NETWORK INTERFACE CARDS
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  NICs (Network Interface Cards) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_NetworkAdapterConfiguration" | Select-Object -Property Index,Description,IPAddress,MACAddress,DefaultIPGateway,DHCPServer | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # OPERATING SYSTEM
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  OS (Operating System) ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_OperatingSystem" | Select-Object -Property Caption,OSArchitecture,Version | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  # LOGIN USERNAME/DOMAIN
  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Add-Content -Path ("${Logfile}") -Value ("-----  User/Domain ");
  Add-Content -Path ("${Logfile}") -Value ("--- ");
  Get-CimInstance -ClassName "Win32_ComputerSystem" | Select-Object -Property Domain,PartOfDomain,PrimaryOwnerName,UserName | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}");

  # ------------------------------

  Write-Host -NoNewline ".";
  Add-Content -Path ("${Logfile}") -Value ("");

  notepad.exe ("${Logfile}");

  # ------------------------------------------------------------

  Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "Get-SystemSpecs";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   learn.microsoft.com  |  "Add-Content (Microsoft.PowerShell.Management) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.management/add-content
#
#   learn.microsoft.com  |  "Get-CimInstance (CimCmdlets) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance
#
#   learn.microsoft.com  |  "Out-File (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Learn"  |  https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/out-file
#
#   stackoverflow.com  |  "Powershell - How to get the Output without the VariableValue when using WMIC - Stack Overflow"  |  https://stackoverflow.com/a/74111705
#
# ------------------------------------------------------------