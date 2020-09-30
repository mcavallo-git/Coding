
# ------------------------------------------------------------
#
#   Windows 10 - Show additional advanced power options (beyond the defaults)
#

If ($True) {

$AdvOptions_ShowAll = $True; <# Show hidden advanced power options, settings, configs, etc.#>
# $AdvOptions_ShowAll = $False; <# Hide hidden advanced power options, settings, configs, etc.#>

If ($AdvOptions_ShowAll -Eq $True) {
	$AdvOpt_ShowHide = "-ATTRIB_HIDE";
	$Text_ShowHide = "shown";
} Else {
	$AdvOpt_ShowHide = "+ATTRIB_HIDE";
	$Text_ShowHide = "hidden";
}

# Hard disk burst ignore time
powercfg.exe -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 80e3c60e-bb94-4ad8-bbe0-0d3195efc663 ${AdvOpt_ShowHide};

# AHCI Link Power Management - HIPM/DIPM
powercfg.exe -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 0b2d69d7-a2a1-449c-9680-f91c70521c60 ${AdvOpt_ShowHide};

# AHCI Link Power Management - Adaptive
powercfg.exe -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 dab60367-53fe-4fbc-825e-521d069d2456 ${AdvOpt_ShowHide};


# NVMe Idle Timeout
powercfg.exe -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 d639518a-e56d-4345-8af2-b9f32fb26109 ${AdvOpt_ShowHide};

# NVMe Power State Transition Latency Tolerance
powercfg.exe -attributes 0012ee47-9041-4b5d-9b77-535fba8b1442 fc95af4d-40e7-4b6d-835a-56d131dbc80e ${AdvOpt_ShowHide};


# Sleep transition settings

# Allow Away Mode Policy
powercfg.exe -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 25dfa149-5dd1-4736-b5ab-e8a37b5b8187 ${AdvOpt_ShowHide};

# System unattended sleep timeout
powercfg.exe -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 7bc4a2f9-d8fc-4469-b07b-33eb785aaca0 ${AdvOpt_ShowHide};

# Allow System Required Policy
powercfg.exe -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 A4B195F5-8225-47D8-8012-9D41369786E2 ${AdvOpt_ShowHide};

# Allow Standby States
powercfg.exe -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 abfc2519-3608-4c2a-94ea-171b0ed546ab ${AdvOpt_ShowHide};

# Allow sleep with remote opens
powercfg.exe -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 d4c1d4c8-d5cc-43d3-b83e-fc51215cb04d ${AdvOpt_ShowHide};

# System FastS4 Support
powercfg.exe -attributes 238c9fa8-0aad-41ed-83f4-97be242c8f20 94AC6D29-73CE-41A6-809F-6363BA21B47E ${AdvOpt_ShowHide};


# Device idle policy

# NOTE: shows in first node of settings tree if unhidden
powercfg.exe -attributes 4faab71a-92e5-4726-b531-224559672d19 ${AdvOpt_ShowHide};


# Processor power settings

# Processor performance boost policy
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 45bcc044-d885-43e2-8605-ee0ec6e96b59 ${AdvOpt_ShowHide};

# Processor performance increase policy
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 465e1f50-b610-473a-ab58-00d1077dc418 ${AdvOpt_ShowHide};

# Processor performance increase threshold
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 06cadf0e-64ed-448a-8927-ce7bf90eb35d ${AdvOpt_ShowHide};

# Processor performance increase threshold for Processor Power Efficiency Class 1
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 06cadf0e-64ed-448a-8927-ce7bf90eb35e ${AdvOpt_ShowHide};

# Processor performance core parking min cores
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318583 ${AdvOpt_ShowHide};

# Processor performance core parking min cores for Processor Power Efficiency Class 1
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 0cc5b647-c1df-4637-891a-dec35c318584 ${AdvOpt_ShowHide};

# Processor performance decrease threshold
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 12a0ab44-fe28-4fa9-b3bd-4b64f44960a6 ${AdvOpt_ShowHide};

# Processor performance core parking increase time
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 2ddd5a84-5a71-437e-912a-db0b8c788732 ${AdvOpt_ShowHide};

# Allow Throttle States
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 3b04d4fd-1cc7-4f23-ab1c-d1337819c4bb ${AdvOpt_ShowHide};

# Processor performance decrease policy
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 40fbefc7-2e9d-4d25-a185-0cfd8574bac6 ${AdvOpt_ShowHide};

# Processor performance core parking parked performance state
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 447235c7-6a8d-4cc0-8e24-9eaf70b96e2b ${AdvOpt_ShowHide};

# Processor idle demote threshold
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 4b92d758-5a24-4851-a470-815d78aee119 ${AdvOpt_ShowHide};

# Processor performance core parking distribution threshold
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 4bdaf4e9-d103-46d7-a5f0-6280121616ef ${AdvOpt_ShowHide};

# Processor performance time check interval
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 4d2b0152-7d5c-498b-88e2-34345392a2c5 ${AdvOpt_ShowHide};

# Processor duty cycling
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 4e4450b3-6179-4e91-b8f1-5bb9938f81a1 ${AdvOpt_ShowHide};

# Processor idle disable
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 5d76a2ca-e8c0-402f-a133-2158492d58ad ${AdvOpt_ShowHide};

# Processor idle threshold scaling
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 6c2993b0-8f48-481f-bcc6-00dd2742aa06 ${AdvOpt_ShowHide};

# Processor performance core parking decrease policy
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 71021b41-c749-4d21-be74-a00f335d582b ${AdvOpt_ShowHide};

# Maximum processor frequency
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 75b0ae3f-bce0-45a7-8c89-c9611c25e100 ${AdvOpt_ShowHide};

# Processor idle promote threshold
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 7b224883-b3cc-4d79-819f-8374152cbe7c ${AdvOpt_ShowHide};

# Processor performance history count
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 7d24baa7-0b84-480f-840c-1b0743c00f5f ${AdvOpt_ShowHide};

# Processor performance core parking overutilization threshold
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 943c8cb6-6f93-4227-ad87-e9a3feec08d1 ${AdvOpt_ShowHide};

# Processor performance increase time
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 984cf492-3bed-4488-a8f9-4286c97bf5aa ${AdvOpt_ShowHide};

# Processor idle time check
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 c4581c31-89ab-4597-8e2b-9c9cab440e6b ${AdvOpt_ShowHide};

# Processor performance core parking increase policy
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 c7be0679-2817-4d69-9d02-519a537ed0c6 ${AdvOpt_ShowHide};

# Processor performance decrease time
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 d8edeb9b-95cf-4f95-a73c-b061973693c8 ${AdvOpt_ShowHide};

# Processor performance core parking decrease time
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 dfd10d17-d5eb-45dd-877a-9a34ddd15c82 ${AdvOpt_ShowHide};

# Processor performance core parking max cores
powercfg.exe -attributes 54533251-82be-4824-96c1-47b60b740d00 ea062031-0e34-4ff1-9b6d-eb1059334028 ${AdvOpt_ShowHide};

Write-Output "";
Write-Output "------------------------------------------------------------";
Write-Output "Windows 10 - Advanced Power Options are now ${Text_ShowHide}";
Write-Output "------------------------------------------------------------";
Write-Output "AMD Ryzen Balanced plan  -->  SETUP EFFICIENT CORE THROTTLING";
Write-Output "";
Write-Output "> Open 'Power & sleep settings' (type it into Win10 start menu and click the name to open it)";
Write-Output " > Click 'Additional power settings' (right side) -> Ensure that power plan 'AMD Ryzen Balanced' is active";
Write-Output "  > Click 'Change plan settings' next to 'AMD Ryzen Balanced' then click 'Change advanced power settings'";
Write-Output "   > Set option 'Processor performance core parking min cores' to value '10%'";
Write-Output "   > Set option 'Processor performance core parking increase time' to value '1 Time check intervals'";
Write-Output "   > Set option 'Processor performance decrease policy' to value 'Rocket'";
Write-Output "   > Set option 'Processor idle threshold scaling' to value 'Enable scaling'";
Write-Output "   > Set option 'Processor performance core parking decrease time' to value '2 Time check intervals'";
Write-Output "  > Close 'Additional power settings' (Win7 style control panel) window";
Write-Output " > Back in Win10's settings, under 'Performance and Energy', set the draggable bar to the middle setting";
Write-Output "  > Verify that the text just above the bar reads as 'Power mode: Better performance'";
Write-Output "> Verify desired CPU core-clock throttling monitoring software such as OpenHardwareMonitor";
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
# ------------------------------------------------------------