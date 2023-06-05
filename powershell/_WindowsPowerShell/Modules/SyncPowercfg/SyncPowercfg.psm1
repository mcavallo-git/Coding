# ------------------------------------------------------------
#
#	PowerShell - SyncPowercfg
#		|
#		|--> Description:  (Windows 10) Show/Hide additional advanced power options (beyond the defaults)
#		|
#		|--> Example:      PowerShell -Command ("SyncPowercfg -Visibility 'shown';")
#
# ------------------------------------------------------------

Function SyncPowercfg() {
	Param(
		[ValidateSet('hidden','shown','status')]
		[String]$Visibility="status"
	)
	# ------------------------------------------------------------
	If ($False) { # RUN THIS SCRIPT:


		$ProtoBak=[System.Net.ServicePointManager]::SecurityProtocol; [System.Net.ServicePointManager]::SecurityProtocol=[System.Net.SecurityProtocolType]::Tls12; $ProgressPreference='SilentlyContinue'; Clear-DnsClientCache; Set-ExecutionPolicy "RemoteSigned" -Scope "CurrentUser" -Force; Try { Invoke-Expression ((Invoke-WebRequest -UseBasicParsing -TimeoutSec (7.5) -Uri ('https://raw.githubusercontent.com/mcavallo-git/Coding/main/powershell/_WindowsPowerShell/Modules/SyncPowercfg/SyncPowercfg.psm1') ).Content) } Catch {}; If (-Not (Get-Command -Name 'SyncPowercfg' -ErrorAction 'SilentlyContinue')) { Import-Module ([String]::Format('{0}\Documents\GitHub\Coding\powershell\_WindowsPowerShell\Modules\SyncPowercfg\SyncPowercfg.psm1', ((Get-Variable -Name 'HOME').Value))); }; [System.Net.ServicePointManager]::SecurityProtocol=$ProtoBak;
		SyncPowercfg -Visibility 'shown';


	}
	# ------------------------------------------------------------


	Function DoLogging {
		Param([String]$LogFile="",[String]$Text="",[String]$Level="INFO");
		$Timestamp_Decimal=$([String](Get-Date -Format 'yyyy-MM-ddTHH:mm:ss.fffzzz'));
		$OutString="[${Timestamp_Decimal} ${Level} $($MyInvocation.MyCommand.Name)] ${Text}";
		Write-Host "${OutString}";
		Write-Output "${OutString}" | Out-File -Width 16384 -Append "${LogFile}";
	};

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
		$SettingShown_PreCheck=If ($SettingStatus_PreCheck -Eq "None") { "shown"; } Else { "hidden"; };
		If ("${Visibility}" -Eq "shown") {
			<# Show the setting on 'advanced power options' #>
			If ($SettingShown_PreCheck -Eq "shown") {
				<# Setting already set as-requested #>
				DoLogging -LogFile "${LogFile}" -Text "Power option already has visibility of [ ${SettingShown_PreCheck} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
			} Else {
				<# Update the setting via powercfg.exe #>
				DoLogging -LogFile "${LogFile}" -Level "WARN" -Text "Applying power option visibility of [ ${Visibility} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
				$SettingAction=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting} -ATTRIB_HIDE);
				$SettingChanged=$True;
			}
		} ElseIf ("${Visibility}" -Eq "hidden") {
			<# Hide the setting on 'advanced power options' #>
			If ($SettingShown_PreCheck -Eq "hidden") {
				<# Setting already set as-requested #>
				DoLogging -LogFile "${LogFile}" -Text "Power option already has visibility of [ ${SettingShown_PreCheck} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
			} Else {
				<# Update the setting via powercfg.exe #>
				DoLogging -LogFile "${LogFile}" -Level "WARN" -Text "Applying power option visibility of [ ${Visibility} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
				$SettingAction=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting} +ATTRIB_HIDE);
				$SettingChanged=$True;
			}
		} Else {
			DoLogging -LogFile "${LogFile}" -Text "Power option visibility is [ ${SettingShown_PreCheck} ] for GUID_Group=[ ${GUID_Group} ] & GUID_Setting=[ ${GUID_Setting} ]";
		}
		$SettingShown_PostCheck=${SettingStatus_PreCheck};
		If (${SettingChanged} -Eq $True) {
			$SettingStatus_PostCheck=(C:\Windows\System32\powercfg.exe -attributes ${GUID_Group} ${GUID_Setting});
			$SettingShown_PostCheck=If ($SettingStatus_PreCheck -Eq "None") { "shown"; } Else { "hidden"; };
		}
		# Return ${SettingShown_PostCheck};
		Return;
	};

	<# Setup Logfile #>
	$Start_Timestamp=(Get-Date -Format "yyyyMMddTHHmmsszz");
	$LogDir="${Env:TEMP}\SetPowercfg";
	$LogFile="${LogDir}\LogFile_${Start_Timestamp}.log";
	If ((Test-Path -Path ("${LogDir}")) -Eq ($False)) {
		New-Item -ItemType "Directory" -Path ("${LogDir}") | Out-Null;
	}

	<# Backup current settings #>
	powercfg.exe /Q >"${LogDir}\powercfg-Q_${Start_Timestamp}.bak.txt";
	powercfg.exe /Qh >"${LogDir}\powercfg-Qh__${Start_Timestamp}.bak.txt";

	<# Show header text in console & logfile #>
	DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";
	DoLogging -LogFile "${LogFile}" -Text "Windows 10 - Setting advanced power options' visibility to [ ${Visibility} ]";
	DoLogging -LogFile "${LogFile}" -Text "Logfile: [ ${LogFile} ]";
	DoLogging -LogFile "${LogFile}" -Text "------------------------------------------------------------";

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
	SetPowercfg -GUID_Group SUB_PROCESSOR -GUID_Setting PERFINCTHRESHOLD1 -Visibility ${Visibility};

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

  # Display/Monitor power settings

	# Turn off display after
	SetPowercfg -GUID_Group SUB_VIDEO -GUID_Setting VIDEOIDLE -Visibility ${Visibility};

	# Console lock display off timeout
	SetPowercfg -GUID_Group SUB_VIDEO -GUID_Setting VIDEOCONLOCK -Visibility ${Visibility};


	If ($False) {
		<# Show decent configuration for AMD CPU's power-plan #>
		Write-Host "------------------------------------------------------------";
		Write-Host "  v v v     !!! AMD (RYZEN) PROCESSORS ONLY !!!     v v v";
		Write-Host "";
		Write-Host "AMD Ryzen Balanced plan  -->  SETUP EFFICIENT CORE THROTTLING";
		Write-Host "";
		Write-Host "> Open 'Power & sleep settings' (type it into Win10 start menu and click the name to open it)";
		Write-Host " > Click 'Additional power settings' (right side) -> Ensure that power plan 'AMD Ryzen Balanced' is active";
		Write-Host "  > Click 'Change plan settings' next to 'AMD Ryzen Balanced' then click 'Change advanced power settings'";
		Write-Host "   > Set option 'Allow throttle states' to value 'Enabled'";
		Write-Host "   > Set option 'Minimum processor state' to value '15%'";
		Write-Host "   > Set option 'Maximum processor state' to value '100%'";
		Write-Host "   > Set option 'Processor performance core parking min cores' to value '10%'";
		Write-Host "   > Set option 'Processor performance core parking increase time' to value '1 Time check intervals'";
		Write-Host "   > Set option 'Processor performance decrease policy' to value 'Rocket'";
		Write-Host "   > Set option 'Processor idle threshold scaling' to value 'Enable scaling'";
		Write-Host "   > Set option 'Processor performance core parking decrease time' to value '2 Time check intervals'";
		Write-Host "  > Close 'Additional power settings' (Win7 style control panel) window";
		Write-Host " > Back in Win10's settings, under 'Performance and Energy', set the draggable bar to the middle setting";
		Write-Host "  > Verify that the text just above the bar reads as 'Power mode: Better performance'";
		Write-Host "> Verify that CPU core-clock is throttling as-desired via monitoring software such as 'OpenHardwareMonitor'";
		Write-Host "> Done";
		Write-Host "";
		Write-Host "------------------------------------------------------------";
	}

	# ------------------------------------------------------------
	#
	#   WARNING: The following shows ALL Win10 advanced power options,
	#            and is not easily undone (makes you dig to find common settings once all are shown)
	#
	If ($False) {

		$powerSettingTable=Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSetting
		$powerSettingInSubgroubTable=Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSettingInSubgroup

		Get-WmiObject -Namespace root\cimv2\power -Class Win32_PowerSettingCapabilities | ForEach-Object {
			$tmp=$_.ManagedElement
			$tmp=$tmp.Remove(0, $tmp.LastIndexOf('{') + 1)
			$tmp=$tmp.Remove($tmp.LastIndexOf('}'))

			$guid=$tmp

			$s=($powerSettingInSubgroubTable | Where-Object PartComponent -Match "$guid")

			if (!$s) {
				return
			}

			$tmp=$s.GroupComponent
			$tmp=$tmp.Remove(0, $tmp.LastIndexOf('{') + 1)
			$tmp=$tmp.Remove($tmp.LastIndexOf('}'))

			$groupguid=$tmp

			$s=($powerSettingTable | Where-Object InstanceID -Match "$guid")

			$descr=[string]::Format("# {0}", $s.ElementName)
			$runcfg=[string]::Format("powercfg -attributes {0} {1} -ATTRIB_HIDE", $groupguid, $guid)

			Write-Host $descr
			Write-Host $runcfg
			Write-Host ""
		}

	}

	Return;

}

<# Only export the module if the caller is attempting to import it #>
If (($MyInvocation.GetType()) -Eq ("System.Management.Automation.InvocationInfo")) {
	Export-ModuleMember -Function "SyncPowercfg";
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