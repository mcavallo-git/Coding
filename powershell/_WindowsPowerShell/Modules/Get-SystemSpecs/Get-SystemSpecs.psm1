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

    $ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/Get-SystemSpecs/Get-SystemSpecs.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'Get-SystemSpecs' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\Get-SystemSpecs\Get-SystemSpecs.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak; Get-SystemSpecs;

  }
  # ------------------------------
  Write-Host "";
  Write-Host -NoNewline "Acquiring data .";
  Write-Host -NoNewline "."; $Win32_BaseBoard=(Get-CimInstance -ClassName "Win32_BaseBoard");
  Write-Host -NoNewline "."; $Win32_BIOS=(Get-CimInstance -ClassName "Win32_BIOS");
  Write-Host -NoNewline "."; $Win32_ComputerSystem=(Get-CimInstance -ClassName "Win32_ComputerSystem");
  Write-Host -NoNewline "."; $Win32_DiskDrive=(Get-CimInstance -ClassName "Win32_DiskDrive");
  Write-Host -NoNewline "."; $Win32_NetworkAdapterConfiguration=(Get-CimInstance -ClassName "Win32_NetworkAdapterConfiguration");
  Write-Host -NoNewline "."; $Win32_OperatingSystem=(Get-CimInstance -ClassName "Win32_OperatingSystem");
  Write-Host -NoNewline "."; $Win32_PhysicalMemory=(Get-CimInstance -ClassName "Win32_PhysicalMemory");
  Write-Host -NoNewline "."; $Win32_PhysicalMemoryArray=(Get-CimInstance -ClassName "Win32_PhysicalMemoryArray");
  Write-Host -NoNewline "."; $Win32_Processor=(Get-CimInstance -ClassName "Win32_Processor");
  Write-Host -NoNewline "."; $Win32_VideoController=(Get-CimInstance -ClassName "Win32_VideoController");
  # ------------------------------
  # Setup Logfile
  $Domain=(${Win32_ComputerSystem} | Select-Object -ExpandProperty Domain);
  $HostName=(${Win32_ComputerSystem} | Select-Object -ExpandProperty Name);
  $Logfile="${HOME}\Desktop\Get-SystemSpecs.${HostName}.${Domain}.txt";
  # ------------------------------
  # Header
  Set-Content -Path ("${Logfile}") -Value ("------------------------------------------------------------");
  Add-Content -Path ("${Logfile}") -Value ("System Specs");
  Add-Content -Path ("${Logfile}") -Value ("    Hostname:  ${hostname}");
  Add-Content -Path ("${Logfile}") -Value ("    Datetime:  $(Get-Date -Format 'yyyy-MM-dd @ HH:mm:ss.fff (zzz)')");
  Add-Content -Path ("${Logfile}") -Value ("------------------------------------------------------------");
  # ------------------------------
  # CPU  (Processor)
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  CPU  (Processor)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_Processor} | Select-Object -Property Name,NumberOfCores,NumberOfLogicalProcessors,CurrentClockSpeed,MaxClockSpeed | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # GPU  (Graphics/Video Card)
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  GPU  (Graphics/Video Card)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_VideoController} | Select-Object -Property Name,Description,AdapterRAM,DriverVersion | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # Memory/RAM
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  Memory/RAM  (Capacity in Bytes)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_PhysicalMemory} | Select-Object -Property DeviceLocator,BankLabel,Manufacturer,PartNumber,Speed,Capacity,FormFactor | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  Motherboard RAM Limits  (MaxCapacity in kilobytes, MemoryDevices is total RAM Slots)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_PhysicalMemoryArray} | Select-Object -Property MemoryDevices,MaxCapacity | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # Disk(s)
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  Disk(s)  (Size in bytes)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_DiskDrive} | Select-Object -Property Index,Caption,DeviceID,Partitions,Size | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # PC Model / Manufacturer
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  Model / Manufacturer");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_ComputerSystem} | Select-Object -Property Name,SystemType,Manufacturer,Model | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # Motherboard/BIOS
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  Motherboard");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_BaseBoard} | Select-Object -Property Manufacturer,Product,SerialNumber | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  BIOS");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_BIOS} | Select-Object -Property ReleaseDate,SMBIOSBIOSVersion,SMBIOSMajorVersion,SMBIOSMinorVersion | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # NICs (Network Interface Cards)
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  NICs  (Network Interface Cards)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_NetworkAdapterConfiguration} | Select-Object -Property Index,Description,IPAddress,MACAddress,DefaultIPGateway,DHCPServer | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # OS (Operating System)
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  OS  (Operating System)");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_OperatingSystem} | Select-Object -Property Caption,Version,OSArchitecture | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
  # User/Domain
  Add-Content -Path ("${Logfile}") -Value ("`n");
  Add-Content -Path ("${Logfile}") -Value ("---");
  Add-Content -Path ("${Logfile}") -Value ("-----  User/Domain");
  Add-Content -Path ("${Logfile}") -Value ("---");
  ${Win32_ComputerSystem} | Select-Object -Property UserName,PrimaryOwnerName,Domain,PartOfDomain | Format-Table | Out-File -Width 16384 -Append -FilePath ("${Logfile}") -Encoding ("utf8");
  # ------------------------------
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