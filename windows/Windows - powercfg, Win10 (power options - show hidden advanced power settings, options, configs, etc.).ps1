# ------------------------------------------------------------
#
#   Windows 10 - Show additional advanced power options (beyond the defaults)
#

If ($True) {

<# Backup current settings #>
$Start_Timestamp=(Get-Date -UFormat '%Y%m%d-%H%M%S');
powercfg.exe /Q >"${Env:TEMP}\powercfg-Q_${Start_Timestamp}.txt";
powercfg.exe /Qh >"${Env:TEMP}\powercfg-Qh__${Start_Timestamp}.txt";

$Visibility = "Show";
# $Visibility = "Hide";

If ($AdvOptions_ShowAll -Eq $True) {
	$AdvOpt_ShowHide = "-ATTRIB_HIDE";
	$Text_ShowHide = "shown";
} Else {
	$AdvOpt_ShowHide = "+ATTRIB_HIDE";
	$Text_ShowHide = "hidden";
}


Function SetPowercfg {
	Param(
		[Parameter(Mandatory=$true)]
		[String]$GUID_Group,
		[Parameter(Mandatory=$true)]
		[String]$GUID_Setting,
		[String]$Visibility=""
	);
	$SettingChanged=$False;
	$SettingStatus_PreCheck=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting});
	$SettingShown_PreCheck = If ($SettingStatus_PreCheck -Eq "None") { "shown"; } Else { "hidden"; };
	If ("${Visibility}" -Eq "Show") {
		<# Show the setting on 'advanced power options' #>
		If ($SettingShown_PreCheck -Eq "shown") {
			<# Setting already set as-requested #>
			Write-Host "INFO: (Skipped) Power option already has visibility of [ ${SettingShown_PreCheck} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
		} Else {
			<# Update the setting via powercfg.exe #>
			Write-Host "INFO: Applying power option visibility of [ shown ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
			$SettingAction=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting} -ATTRIB_HIDE);
			$SettingChanged=$True;
		}
	} ElseIf ("${Visibility}" -Eq "Hide") {
		<# Hide the setting on 'advanced power options' #>E
		If ($SettingShown_PreCheck -Eq "hidden") {
			<# Setting already requested #>
			Write-Host "INFO: (Skipped) Power option already has visibility of [ ${SettingShown_PreCheck} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
		} Else {
			Write-Host "INFO: Applying power option visibility of [ hidden ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
			<# Update the setting via powercfg.exe #>
			$SettingAction=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting} +ATTRIB_HIDE);
			$SettingChanged=$True;
		}
	} Else {
		Write-Host "INFO: Power option visibility is [ ${SettingShown_PreCheck} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
	}
	$SettingShown_PostCheck=${SettingStatus_PreCheck};
	If (${SettingChanged} -Eq $True) {
		$SettingStatus_PostCheck=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting});
		$SettingShown_PostCheck = If ($SettingStatus_PreCheck -Eq "None") { "shown"; } Else { "hidden"; };
	}
	# Return ${SettingShown_PostCheck};
	Return;
}

# Hard disk burst ignore time
SetPowercfg -GUID_Group SUB_DISK -GUID_Setting DISKBURSTIGNORE -Visibility ${Visibility};

# AHCI Link Power Management - HIPM/DIPM
SetPowercfg -GUID_Group SUB_DISK -GUID_Setting 0b2d69d7-a2a1-449c-9680-f91c70521c60 -Visibility ${Visibility};

# AHCI Link Power Management - Adaptive
SetPowercfg -GUID_Group SUB_DISK -GUID_Setting dab60367-53fe-4fbc-825e-521d069d2456 -Visibility ${Visibility};


# NVMe Idle Timeout
SetPowercfg -GUID_Group SUB_DISK -GUID_Setting d639518a-e56d-4345-8af2-b9f32fb26109 -Visibility ${Visibility};

# NVMe Power State Transition Latency Tolerance
SetPowercfg -GUID_Group SUB_DISK -GUID_Setting fc95af4d-40e7-4b6d-835a-56d131dbc80e -Visibility ${Visibility};


# Sleep transition settings

# Allow Away Mode Policy
SetPowercfg -GUID_Group SUB_SLEEP -GUID_Setting AWAYMODE -Visibility ${Visibility};

# System unattended sleep timeout
SetPowercfg -GUID_Group SUB_SLEEP -GUID_Setting UNATTENDSLEEP -Visibility ${Visibility};

# Allow System Required Policy
SetPowercfg -GUID_Group SUB_SLEEP -GUID_Setting SYSTEMREQUIRED -Visibility ${Visibility};

# Allow Standby States
SetPowercfg -GUID_Group SUB_SLEEP -GUID_Setting ALLOWSTANDBY -Visibility ${Visibility};

# Allow sleep with remote opens
SetPowercfg -GUID_Group SUB_SLEEP -GUID_Setting REMOTEFILESLEEP -Visibility ${Visibility};

# Allow hybrid sleep
SetPowercfg -GUID_Group SUB_SLEEP -GUID_Setting HYBRIDSLEEP -Visibility ${Visibility};


# Device idle policy  -  NOTE: shows in first node of settings tree if unhidden
SetPowercfg -GUID_Group SUB_NONE -GUID_Setting DEVICEIDLE -Visibility ${Visibility};


# Processor power settings

# Processor performance boost policy
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFBOOSTPOL -Visibility ${Visibility};

# Processor performance increase policy
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFINCPOL -Visibility ${Visibility};

# Processor performance increase threshold
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFINCTHRESHOLD -Visibility ${Visibility};

# Processor performance increase threshold for Processor Power Efficiency Class 1
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFINCTHRESHOLD -Visibility ${Visibility};

# Processor performance core parking min cores
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPMINCORES -Visibility ${Visibility};

# Processor performance core parking min cores for Processor Power Efficiency Class 1
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPMINCORES1 -Visibility ${Visibility};

# Processor performance decrease threshold
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFDECTHRESHOLD -Visibility ${Visibility};

# Processor performance core parking increase time
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPINCREASETIME -Visibility ${Visibility};

# Allow Throttle States
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting THROTTLING -Visibility ${Visibility};

# Processor performance decrease policy
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFDECPOL -Visibility ${Visibility};

# Processor performance core parking parked performance state
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPPERF -Visibility ${Visibility};

# Processor idle demote threshold
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting IDLEDEMOTE -Visibility ${Visibility};

# Processor performance core parking distribution threshold
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPDISTRIBUTION -Visibility ${Visibility};

# Processor performance time check interval
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFCHECK -Visibility ${Visibility};

# Processor duty cycling
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFDUTYCYCLING -Visibility ${Visibility};

# Processor idle disable
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting IDLEDISABLE -Visibility ${Visibility};

# Processor idle threshold scaling
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting IDLESCALING -Visibility ${Visibility};

# Processor performance core parking decrease policy
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPDECREASEPOL -Visibility ${Visibility};

# Maximum processor frequency
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PROCFREQMAX -Visibility ${Visibility};

# Maximum processor frequency for Processor Power Efficiency Class 1
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PROCFREQMAX1 -Visibility ${Visibility};

# Processor idle promote threshold
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting IDLEPROMOTE -Visibility ${Visibility};

# Processor performance history count
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFHISTORY -Visibility ${Visibility};

# Processor performance core parking overutilization threshold
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPOVERUTIL -Visibility ${Visibility};

# Processor performance increase time
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFINCTIME -Visibility ${Visibility};

# Processor idle time check
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting IDLECHECK -Visibility ${Visibility};

# Processor performance core parking increase policy
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPINCREASEPOL -Visibility ${Visibility};

# Processor performance decrease time
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFDECTIME -Visibility ${Visibility};

# Processor performance core parking decrease time
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPDECREASETIME -Visibility ${Visibility};

# Processor performance core parking max cores
SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting CPMAXCORES -Visibility ${Visibility};

Write-Output "------------------------------------------------------------";
Write-Output "Windows 10 - Advanced power options visibility set to [ ${Visibility} ]";
Write-Output "------------------------------------------------------------";
Write-Output "";
Write-Output "  v v v     !!! AMD (RYZEN) PROCESSORS ONLY !!!     v v v";
Write-Output "";
Write-Output "AMD Ryzen Balanced plan  -->  SETUP EFFICIENT CORE THROTTLING";
Write-Output "";
Write-Output "> Open 'Power & sleep settings' (type it into Win10 start menu and click the name to open it)";
Write-Output " > Click 'Additional power settings' (right side) -> Ensure that power plan 'AMD Ryzen Balanced' is active";
Write-Output "  > Click 'Change plan settings' next to 'AMD Ryzen Balanced' then click 'Change advanced power settings'";
Write-Output "   > Set option 'Allow throttle states' to value 'Enabled'";
Write-Output "   > Set option 'Minimum processor state' to value '15%'";
Write-Output "   > Set option 'Maximum processor state' to value '100%'";
Write-Output "   > Set option 'Processor performance core parking min cores' to value '10%'";
Write-Output "   > Set option 'Processor performance core parking increase time' to value '1 Time check intervals'";
Write-Output "   > Set option 'Processor performance decrease policy' to value 'Rocket'";
Write-Output "   > Set option 'Processor idle threshold scaling' to value 'Enable scaling'";
Write-Output "   > Set option 'Processor performance core parking decrease time' to value '2 Time check intervals'";
Write-Output "  > Close 'Additional power settings' (Win7 style control panel) window";
Write-Output " > Back in Win10's settings, under 'Performance and Energy', set the draggable bar to the middle setting";
Write-Output "  > Verify that the text just above the bar reads as 'Power mode: Better performance'";
Write-Output "> Verify that CPU core-clock is throttling as-desired via monitoring software such as 'OpenHardwareMonitor'";
Write-Output "> Done";
Write-Output "";
Write-Output "------------------------------------------------------------";

}


# ------------------------------------------------------------
#
#   WARNING: The following shows ALL Win10 advanced power options,
#            and is not easily undone (makes you dig to find common settings once all are shown)
#
If ($False) {

	$powerSettingTable = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSetting
	$powerSettingInSubgroubTable = Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSettingInSubgroup

	Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSettingCapabilities | ForEach-Object {
		$tmp = $_.ManagedElement
		$tmp = $tmp.Remove(0, $tmp.LastIndexOf('{') + 1)
		$tmp = $tmp.Remove($tmp.LastIndexOf('}'))

		$guid = $tmp

		$s = ($powerSettingInSubgroubTable | Where-Object PartComponent -Match "$guid")

		if (!$s) {
			return
		}

		$tmp = $s.GroupComponent
		$tmp = $tmp.Remove(0, $tmp.LastIndexOf('{') + 1)
		$tmp = $tmp.Remove($tmp.LastIndexOf('}'))

		$groupguid = $tmp

		$s = ($powerSettingTable | Where-Object InstanceID -Match "$guid")

		$descr = [string]::Format("# {0}", $s.ElementName)
		$runcfg = [string]::Format("powercfg -attributes {0} {1} -ATTRIB_HIDE", $groupguid, $guid)

		Write-Output $descr
		Write-Output $runcfg
		Write-Output ""
	}

}

# ------------------------------------------------------------
#
# Citation(s)
#
#   gist.github.com  |  "Enable all advanced power settings in Windows. · GitHub"  |  https://gist.github.com/raspi/203aef3694e34fefebf772c78c37ec2c
#
#   gist.github.com  |  "Show/hide hidden settings in Win10 Power Options · GitHub"  |  https://gist.github.com/Nt-gm79sp/1f8ea2c2869b988e88b4fbc183731693
#
#   superuser.com  |  "How to Access Hidden Power and Processor Options in Windows 10 - Super User"  |  https://superuser.com/a/1437854
#
# ------------------------------------------------------------