# ------------------------------------------------------------
# 
# 
#    PowerShell.exe -File "${Home}\Documents\GitHub\Coding\prtg\Custom Sensors\EXEXML\get-openhardwaremonitor-readings.ps1"
# 
# 
# ------------------------------------------------------------
#
# PRTG - Parse CSV logs output from "Open Hardware Monitor (e.g. OHW)" (system health monitoring software)
#
# ------------------------------------------------------------
#
# STEP 1) Setup Open Hardware Monitor (OHW)
#  > Download from URL:  https://openhardwaremonitor.org/downloads/
#   > Place OHW's downloaded files into directory "C:\ISO\OpenHardwareMonitor\" (modifiable, below - see variable "$Logfile_Dirname")
#
# ------------------------------------------------------------
#
# STEP 2) Setting-up CSV logging in OHW:
#  > Run OHW
#   > Select "Options" (top)
#    > Select "Log Sensors" (will have a checkmark next to it if actively logging to CSV)
#
# ------------------------------------------------------------
#
# STEP 3) Setting-up Scheduled Task to run PowerShell script in Windows (simpler than setting up PRTG to run PowerShell scripts as SYSTEM, directly)
#  > Create a Scheduled Task to run this PowerShell script every minute
#
# ------------------------------------------------------------
#
# STEP 4) Create a new PRTG "EXE/Script Advanced" Sensor to run a batch-file with one, single line, being: [  TYPE %Logfile_XmlOutput%  ] (whatever path this .ps1 file outputs-to)
#
# ------------------------------------------------------------
#
# Get the Temperature, fan speeds, etc. through Dell's oproprietary config but nt on the 730...Openhardware"'s  OpenHardwareMonitor's logfile (second line is column title, third row is values)
#

$Logfile_Dirname = "C:\ISO\OpenHardwareMonitor";
$Logfile_FullPath = "${Logfile_Dirname}\OpenHardwareMonitorLog-$(Get-Date -UFormat '%Y-%m-%d').csv";

# ------------------------------------------------------------

$Logfile_Basename = "${Logfile_Dirname}\OHW-Current";

$Logfile_XmlOutput_All = "${Logfile_Basename}-All.xml";

$Logfile_Temperature_CPU = "${Logfile_Basename}-Temp-CPU.txt";
$Logfile_Temperature_GPU = "${Logfile_Basename}-Temp-GPU.txt";
$Logfile_Temperature_SSD = "${Logfile_Basename}-Temp-SSD.txt";

$Logfile_FanSpeed_PMP = "${Logfile_Basename}-Fan-Pump.txt";
$Logfile_FanSpeed_PMP_PRC = "${Logfile_Basename}-FanPercent-Pump.txt";
$Logfile_FanSpeed_RAD = "${Logfile_Basename}-Fan-Radiator.txt";
$Logfile_FanSpeed_RAD_PRC = "${Logfile_Basename}-FanPercent-Radiator.txt";
$Logfile_FanSpeed_SSD = "${Logfile_Basename}-Fan-SSD.txt";
$Logfile_FanSpeed_SSD_PRC = "${Logfile_Basename}-FanPercent-SSD.txt";

$Logfile_GPU_Load = "${Logfile_Basename}-Load-GPU.txt";

# NVidia offers a free EXE utility named "NVidia System Management Interface (SMI)" which allows for command-line parameters to specify intended output
$Exe_NVidiaSMI = "C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe";

# $CsvHeadersArr = @('Time', 'Fan Control #1', 'Fan Control #2', 'Fan Control #3', 'Fan Control #4', 'Fan Control #5', 'Fan Control #6', 'Fan Control #7', 'CPU VCore', 'Voltage #2', 'AVCC', '3VCC', 'Voltage #5', 'Voltage #6', 'Voltage #7', '3VSB', 'VBAT', 'VTT', 'Voltage #11', 'Voltage #12', 'Voltage #13', 'Voltage #14', 'Voltage #15', 'Temperature #1', 'Temperature #2', 'Temperature #3', 'Temperature #4', 'Temperature #5', 'Temperature #6', 'Fan #1', 'Fan #2', 'Fan #4', 'Fan #6', 'CPU Core #1', 'CPU Core #2', 'CPU Core #3', 'CPU Core #4', 'CPU Core #5', 'CPU Core #6', 'CPU Total', 'CPU Package', 'Bus Speed', 'CPU Core #1', 'CPU Core #2', 'CPU Core #3', 'CPU Core #4', 'CPU Core #5', 'CPU Core #6', 'CPU Package', 'CPU CCD #1', 'CPU Core #1', 'CPU Core #2', 'CPU Core #3', 'CPU Core #4', 'CPU Core #5', 'CPU Core #6', 'CPU Cores', 'Memory', 'Used Memory', 'Available Memory', 'GPU Core', 'GPU Core', 'GPU Memory', 'GPU Shader', 'GPU Core', 'GPU Frame Buffer', 'GPU Video Engine', 'GPU Bus Interface', 'GPU Fan', 'GPU', 'GPU Memory Total', 'GPU Memory Used', 'GPU Memory Free', 'GPU Memory', 'GPU Power', 'GPU PCIE Rx', 'GPU PCIE Tx', 'Used Space');

$CsvTrimmer = (Get-Content -Path ("${Logfile_Fullpath}"));

$CsvImport = @{};
$CsvImport.Paths = (@("$($CsvTrimmer[0])").Split(","));
$CsvImport.Descriptions = (@("$($CsvTrimmer[1])").Split(","));
$CsvImport.Values = (("$($CsvTrimmer[-1])").Split(","));

$Ohw_SensorReadings = @();

For ($i=0; ($i -LT (($CsvImport.Paths).Count)); $i++) {
	$EachSensorReading_Obj = @{};
	$EachSensorReading_Obj.Path = (($CsvImport.Paths)[$i]);
	$EachSensorReading_Obj.Description = (($CsvImport.Descriptions)[$i]);
	$EachSensorReading_Obj.Value = (($CsvImport.Values)[$i]);
	# ------------------------------------------------------------
	#
	# Boil-down the results to Shorthand/Nickname versions for each PC component
	#
	# ------------------------------------------------------------

	#
	# Mobo Readings
	#
	If (($EachSensorReading_Obj.Path) -Match "lpc/.+/control/") {
		$EachSensorReading_Obj.Description = "Mobo Fans (% PWM), $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "lpc/.+/fan/") {
		$EachSensorReading_Obj.Description = "Mobo Fans (RPM), $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "lpc/.+/voltage/") {
		$EachSensorReading_Obj.Description = "Mobo Voltages, $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "lpc/.+/temperature/") {
		$EachSensorReading_Obj.Description = "Mobo Temps, $($EachSensorReading_Obj.Description)";

	#
	# Processor (CPU) Readings
	#
	} ElseIf (($EachSensorReading_Obj.Path) -Match "cpu/.+/load/") {
		$EachSensorReading_Obj.Description = "CPU Load, $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "cpu/.+/power/") {
		$EachSensorReading_Obj.Description = "CPU Power, $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "cpu/.+/temperature/") {
		$EachSensorReading_Obj.Description = "CPU Temps, $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "cpu/.+/clock/") {
		$EachSensorReading_Obj.Description = "CPU Clock, $($EachSensorReading_Obj.Description)";

	#
	# Memory (RAM) Readings
	#
	} ElseIf (($EachSensorReading_Obj.Path) -Match "/ram/load/") {
		$EachSensorReading_Obj.Description = "RAM Load, $($EachSensorReading_Obj.Description)";
	} ElseIf (($EachSensorReading_Obj.Path) -Match "/ram/data/") {
		$EachSensorReading_Obj.Description = "RAM Data, $($EachSensorReading_Obj.Description)";

	#
	# Graphics Card (GPU) Readings
	#
	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/temperature/") {
		$EachSensorReading_Obj.Description = "GPU Temps, $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/clock/") {
		$EachSensorReading_Obj.Description = "GPU Clock, $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/control/") {
		$EachSensorReading_Obj.Description = "GPU Fan (% PWM), $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/fan/") {
		$EachSensorReading_Obj.Description = "GPU Fan (RPM), $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/smalldata/") {
		$EachSensorReading_Obj.Description = "GPU Totals, $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/load/") {
		$EachSensorReading_Obj.Description = "GPU Load, $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/power/") {
		$EachSensorReading_Obj.Description = "GPU Power, $($EachSensorReading_Obj.Description)";

	} ElseIf (($EachSensorReading_Obj.Path) -Match "gpu/.+/throughput/") {
		$EachSensorReading_Obj.Description = "GPU Rx/Tx, $($EachSensorReading_Obj.Description)";

	#
	# Storage Disk (HDD/SSD) Readings
	#
	} ElseIf (($EachSensorReading_Obj.Path) -Match "hdd/.+/load/") {
		$EachSensorReading_Obj.Description = "Disk Load, $($EachSensorReading_Obj.Description)";

	# ------------------------------------------------------------
	}
	$Ohw_SensorReadings += $EachSensorReading_Obj;
}

$XmlHeader = "<?xml version=`"1.0`" encoding=`"Windows-1252`" ?>`n<prtg>";
$XmlFooter = "</prtg>";

$XmlOutput_Array_All = @();

$Temp_CPU = "";
$Temp_GPU = "";
$Temp_SSD = "";

$Speed_FAN_PMP = "";
$Speed_FAN_PMP_PRC = "";
$Speed_FAN_RAD = "";
$Speed_FAN_RAD_PRC = "";
$Speed_FAN_SSD = "";
$Speed_FAN_SSD_PRC = "";

$Dirname_RevertTo = ((Get-Location).Path);
$Dirname_NVidiaSMI = (Split-Path -Path ("${Exe_NVidiaSMI}") -Parent);
Set-Location -Path ("${Dirname_NVidiaSMI}");
$Load_GPU = (nvidia-smi.exe --query-gpu=utilization.gpu --format="csv,nounits,noheader" --id=0);
# $Temp_GPU = (nvidia-smi.exe --query-gpu=temperature.gpu --format="csv,nounits,noheader" --id=0);
Set-Location -Path ("${Dirname_RevertTo}");

# $Obj_OhwUpdatedValues.Keys | ForEach-Object {
ForEach ($EachSensorReading_Obj In ${Ohw_SensorReadings}) { # ForEach (Array-Based)

	$EachSensorPath = ("$($EachSensorReading_Obj.Path)" -Replace "`"", "");
	$EachSensorDesc = ("$($EachSensorReading_Obj.Description)" -Replace "`"", "");
	$EachSensorVal  = ("$($EachSensorReading_Obj.Value)" -Replace "`"", "");
	$EachSensor_XmlArr = @();

	$EachSensor_XmlArr += "   <result>";
	$EachSensor_XmlArr += "       <Channel>${EachSensorDesc}</Channel>";
	$EachSensor_XmlArr += "       <Value>${EachSensorVal}</Value>";
	$EachSensor_XmlArr += "       <Mode>Absolute</Mode>";
	If (${EachSensorPath} -Match "/temperature/") { # Use units of Degrees-Celsius (°C) for temperature readings
		$EachSensor_XmlArr += "       <Unit>Temperature</Unit>";
	} ElseIf (${EachSensorPath} -Match "/fan/") { # Use units of Rotations per Minute (RPM) for fans and liquid-cooling pumps
		$EachSensor_XmlArr += "       <Unit>Custom</Unit>";
		$EachSensor_XmlArr += "       <CustomUnit>RPM</CustomUnit>";
	} ElseIf (${EachSensorPath} -Match "/control/") { # Use units of Percentage of Max-Fan-Speed (% PWM) for fans and liquid-cooling pumps
		$EachSensor_XmlArr += "       <Unit>Custom</Unit>";
		$EachSensor_XmlArr += "       <CustomUnit>% PWM</CustomUnit>";
	} ElseIf (${EachSensorPath} -Match "/voltage/") { # Use units of Volts (V) for electric-pressure readings
		$EachSensor_XmlArr += "       <Unit>Custom</Unit>";
		$EachSensor_XmlArr += "       <CustomUnit>Volts</CustomUnit>";
	}
	$EachSensor_XmlArr += "       <Float>1</Float>";
	$EachSensor_XmlArr += "       <ShowChart>0</ShowChart>";
	$EachSensor_XmlArr += "       <ShowTable>0</ShowTable>";
	$EachSensor_XmlArr += "   </result>";

	$XmlOutput_Array_All += $EachSensor_XmlArr;

	If (${EachSensorDesc} -Eq "CPU Temps, CPU Package") {
		$Temp_CPU = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "GPU Temps, GPU Core") {
		$Temp_GPU = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Temps, Temperature #2") {
		$Temp_SSD = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Fans (RPM), Fan #6") {
		$Speed_FAN_PMP = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Fans (% PWM), Fan #6") {
		$Speed_FAN_PMP_PRC = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Fans (RPM), Fan #2") {
		$Speed_FAN_RAD = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Fans (% PWM), Fan #2") {
		$Speed_FAN_RAD_PRC = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Fans (RPM), Fan #4") {
		$Speed_FAN_SSD = "${EachSensorVal}";
	} ElseIf (${EachSensorDesc} -Eq "Mobo Fans (% PWM), Fan #4") {
		$Speed_FAN_SSD_PRC = "${EachSensorVal}";
	}

};

# Output the XML contents to output files (separated by-category, as well as one combined file)
Write-Output (("${XmlHeader}")+("`n")+(${XmlOutput_Array_All} -join "`n")+("`n")+("${XmlFooter}")) | Out-File -NoNewline "${Logfile_XmlOutput_All}";

Write-Output "${Temp_CPU}:OK" | Out-File -NoNewline "${Logfile_Temperature_CPU}";
Write-Output "${Temp_GPU}:OK" | Out-File -NoNewline "${Logfile_Temperature_GPU}";
Write-Output "${Temp_SSD}:OK" | Out-File -NoNewline "${Logfile_Temperature_SSD}";

Write-Output "${Speed_FAN_PMP}:OK" | Out-File -NoNewline "${Logfile_FanSpeed_PMP}";
Write-Output "${Speed_FAN_RAD}:OK" | Out-File -NoNewline "${Logfile_FanSpeed_RAD}";
Write-Output "${Speed_FAN_SSD}:OK" | Out-File -NoNewline "${Logfile_FanSpeed_SSD}";

Write-Output "${Speed_FAN_PMP_PRC}:OK" | Out-File -NoNewline "${Logfile_FanSpeed_PMP_PRC}";
Write-Output "${Speed_FAN_RAD_PRC}:OK" | Out-File -NoNewline "${Logfile_FanSpeed_RAD_PRC}";
Write-Output "${Speed_FAN_SSD_PRC}:OK" | Out-File -NoNewline "${Logfile_FanSpeed_SSD_PRC}";

Write-Output "${Load_GPU}:OK" | Out-File -NoNewline "${Logfile_GPU_Load}";


# ------------------------------------------------------------
# 
# Citation(s)
#
#   community.spiceworks.com  |  "[SOLVED] Invalid Global Switch - wmic - Spiceworks General Support - Spiceworks"  |  https://community.spiceworks.com/topic/218342-invalid-global-switch-wmic
# 
#   docs.microsoft.com  |  "Get-Content"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-content?view=powershell-5.1
# 
#   docs.microsoft.com  |  "Get-WmiObject"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1
# 
#   docs.microsoft.com  |  "wmic - Win32 apps | Microsoft Docs"  |  https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmic?redirectedfrom=MSDN
#
#   docs.microsoft.com  |  "WMIC switches: Windows Management Instrumentation (WMI); Scripting | Microsoft Docs"  |  https://docs.microsoft.com/en-us/previous-versions/windows/it-pro/windows-server-2003/cc787035(v=ws.10)?redirectedfrom=MSDN
#
#   pastebin.com  |  "[Batch] calc - Pastebin.com"  |  https://pastebin.com/Kr35D3A4
#
#   pastebin.com  |  "[Batch] EXEXML/ohm-computer1.bat - Pastebin.com"  |  https://pastebin.com/V5dU1GSf
#
#   pastebin.com  |  "[Batch] ohm-computer1-hw - Pastebin.com"  |  https://pastebin.com/4GjHWeTn
#
#   pastebin.com  |  "[Batch] pingcheck - Pastebin.com"  |  https://pastebin.com/1ESd9Tv9
#
#   sites.google.com  |  "Example 2 (WMI/OHM) - Custom sensors for PRTG"  |  https://sites.google.com/site/prtghowto/example-2
# 
#   www.paessler.com  |  "PRTG Manual: Custom Sensors"  |  https://www.paessler.com/manuals/prtg/custom_sensors
# 
# ------------------------------------------------------------