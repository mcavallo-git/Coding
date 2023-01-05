# ------------------------------------------------------------
# 
# 
#    PowerShell.exe -File "${Home}\Documents\GitHub\Coding\prtg\Custom Sensors\EXEXML\get-hwinfo-readings.ps1"
# 
# 
# ------------------------------------------------------------

$Benchmark = New-Object System.Diagnostics.Stopwatch;
$Benchmark.Reset();  # Reuse same benchmark/stopwatch object by resetting it
$Benchmark.Start();

# ------------------------------------------------------------
#
# Get the Temperature, fan speeds, etc. through Dell's oproprietary config but nt on the 730...Openhardware"'s  OpenHardwareMonitor's logfile (second line is column title, third row is values)
#

$Logfile_Dirname = "C:\ISO\HWiNFO64";
$Logfile_StartsWith = "HWiNFO64-";

# ------------------------------------------------------------

$Logfile_Basename = "${Logfile_Dirname}\HWiNFO64-Current";

$Logfile_Clock_CPU_Core = "${Logfile_Basename}-Clock-CPU-Core";
$Logfile_Clock_GPU_Core = "${Logfile_Basename}-Clock-GPU-Core";
$Logfile_Clock_GPU_Mem = "${Logfile_Basename}-Clock-GPU-Mem";
$Logfile_Clock_GPU_Shad = "${Logfile_Basename}-Clock-GPU-Shad";

$Logfile_FanSpeed_CHA = "${Logfile_Basename}-FanRPM-Chassis";
$Logfile_FanSpeed_PMP = "${Logfile_Basename}-FanRPM-Pump";
$Logfile_FanSpeed_RAD = "${Logfile_Basename}-FanRPM-Radiator";
$Logfile_FanSpeed_SSD = "${Logfile_Basename}-FanRPM-SSD";

$Logfile_FanPercentage_CHA = "${Logfile_Basename}-FanPercentage-Chassis";
$Logfile_FanPercentage_PMP = "${Logfile_Basename}-FanPercentage-Pump";
$Logfile_FanPercentage_RAD = "${Logfile_Basename}-FanPercentage-Radiator";
$Logfile_FanPercentage_SSD = "${Logfile_Basename}-FanPercentage-SSD";

$Logfile_Load_CPU = "${Logfile_Basename}-Load-CPU";
$Logfile_Load_GPU = "${Logfile_Basename}-Load-GPU";
$Logfile_Load_GPU_Memory = "${Logfile_Basename}-Load-GPU-Memory";

$Logfile_Power_CPU = "${Logfile_Basename}-Power-CPU";
$Logfile_Power_GPU = "${Logfile_Basename}-Power-GPU";

$Logfile_RunDuration = "${Logfile_Basename}-RunDuration";

$Logfile_Temperature_CPU = "${Logfile_Basename}-Temp-CPU";
$Logfile_Temperature_GPU = "${Logfile_Basename}-Temp-GPU";
$Logfile_Temperature_SSD = "${Logfile_Basename}-Temp-SSD";
$Logfile_Temperature_T_SENSOR = "${Logfile_Basename}-Temp-T_SENSOR";

$Logfile_Voltage_03VCC = "${Logfile_Basename}-Voltage-03VCC";
$Logfile_Voltage_05VCC = "${Logfile_Basename}-Voltage-05VCC";
$Logfile_Voltage_12VCC = "${Logfile_Basename}-Voltage-12VCC";

# ------------------------------------------------------------

$Clock_CPU_Core = "";
$Clock_GPU_Core = "";
$Clock_GPU_Mem = "";
$Clock_GPU_Shad = "";

$GPU_Memory_Load = "";

$Load_CPU = "";
$Load_GPU = "";

$Speed_FAN_PMP = "";
$Speed_FAN_PMP_PRC = "";
$Speed_FAN_RAD = "";
$Speed_FAN_RAD_PRC = "";
$Speed_FAN_SSD = "";
$Speed_FAN_SSD_PRC = "";
$Speed_FAN_CHA = "";
$Speed_FAN_CHA_PRC = "";

$Power_CPU = "";
$Power_GPU = "";

$Temp_CPU = "";
$Temp_GPU = "";
$Temp_SSD = "";
$Temp_T_SENSOR = "";

$Voltage_03VCC = "";
$Voltage_05VCC = "";
$Voltage_12VCC = "";

# $XmlFooter = "</prtg>";
# $XmlHeader = "<?xml version=`"1.0`" encoding=`"Windows-1252`" ?>`n<prtg>";
# $XmlOutput_Array_All = @();

$Sensor_ErrorMessage="ERROR - HWiNFO reading returned a null or empty value";

# ------------------------------

# Get the latest sensor data

$ProgressPreference=0;

$DefaultPort = (Get-Content 'C:\ISO\RemoteSensorMonitor\DefaultPort.txt' -EA:0);

$ResponseObj = (Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format('http://localhost:{0}', ((GV DefaultPort).Value))));

$RawJSON = (((${ResponseObj}.RawContent).Split("`n") | Select-String -Pattern '^[\s\]\[\{\}]') -join "`n");

$JSON_Content = (ConvertFrom-Json -InputObject (${RawJSON}));

# $JSON_Content | Format-Table;

# ------------------------------

# Fallback - Pull SSD temp(s) from S.M.A.R.T. values (if no value exists for it already)
If (([String]::IsNullOrEmpty(${Temp_SSD}))) {
  $EA_Bak=$ErrorActionPreference; $ErrorActionPreference=0;
  $SSD_SMART_Temperature = (Get-Disk | Get-StorageReliabilityCounter | Where-Object { $_.DeviceId -Eq 0; } | Select-Object -ExpandProperty "Temperature");
  $ErrorActionPreference=$EA_Bak;
  ${Temp_SSD}=(${SSD_SMART_Temperature});
}

# ------------------------------

# Clock - CPU
If ([Math]::Ceiling("$(${Clock_CPU_Core}.(${_}))") -Eq 0) {
  Write-Output "$(${Clock_CPU_Core}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_CPU_Core}.txt";
} Else {
  Write-Output "$(${Clock_CPU_Core}):OK" | Out-File -NoNewline "${Logfile_Clock_CPU_Core}.txt";
}
# Clock - GPU Core
If ([Math]::Ceiling("$(${Clock_GPU_Core}.(${_}))") -Eq 0) {
  Write-Output "$(${Clock_GPU_Core}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_GPU_Core}.txt";
} Else {
  Write-Output "$(${Clock_GPU_Core}):OK" | Out-File -NoNewline "${Logfile_Clock_GPU_Core}.txt";
}
# Clock - GPU Memory
If ([Math]::Ceiling("$(${Clock_GPU_Mem}.(${_}))") -Eq 0) {
  Write-Output "$(${Clock_GPU_Mem}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_GPU_Mem}.txt";
} Else {
  Write-Output "$(${Clock_GPU_Mem}):OK" | Out-File -NoNewline "${Logfile_Clock_GPU_Mem}.txt";
}
# Clock - GPU Shader
If ([String]::IsNullOrEmpty(${Clock_GPU_Shad}.(${_}))) {  # May equal zero without errors
  Write-Output "$(${Clock_GPU_Shad}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_GPU_Shad}.txt";
} Else {
  Write-Output "$(${Clock_GPU_Shad}):OK" | Out-File -NoNewline "${Logfile_Clock_GPU_Shad}.txt";
}

# ------------------------------

# Fan Speed (RPM) - Water-Pump (W_PUMP+)
If ([Math]::Ceiling("$(${Speed_FAN_PMP}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_PMP}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_PMP}.txt";
} Else {
  Write-Output "$(${Speed_FAN_PMP}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_PMP}.txt";
}
# Fan Speed (RPM) - Radiator (CHA_FAN1)
If ([Math]::Ceiling("$(${Speed_FAN_RAD}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_RAD}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_RAD}.txt";
} Else {
  Write-Output "$(${Speed_FAN_RAD}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_RAD}.txt";
}
# Fan Speed (RPM) - Chassis (CHA_FAN2)
If ([Math]::Ceiling("$(${Speed_FAN_CHA}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_CHA}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_CHA}.txt";
} Else {
  Write-Output "$(${Speed_FAN_CHA}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_CHA}.txt";
}
# Fan Speed (RPM) - SSD (CHA_FAN3)
If ([Math]::Ceiling("$(${Speed_FAN_SSD}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_SSD}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_SSD}.txt";
} Else {
  Write-Output "$(${Speed_FAN_SSD}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_SSD}.txt";
}

# ------------------------------

# Fan Speed (%) - Water-Pump (W_PUMP+)
If ([Math]::Ceiling("$(${Speed_FAN_PMP_PRC}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_PMP_PRC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_PMP}.txt";
} Else {
  Write-Output "$(${Speed_FAN_PMP_PRC}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_PMP}.txt";
}
# Fan Speed (%) - Radiator (CHA_FAN1)
If ([Math]::Ceiling("$(${Speed_FAN_RAD_PRC}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_RAD_PRC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_RAD}.txt";
} Else {
  Write-Output "$(${Speed_FAN_RAD_PRC}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_RAD}.txt";
}
# Fan Speed (%) - Chassis (CHA_FAN2)
If ([Math]::Ceiling("$(${Speed_FAN_CHA_PRC}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_CHA_PRC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_CHA}.txt";
} Else {
  Write-Output "$(${Speed_FAN_CHA_PRC}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_CHA}.txt";
}
# Fan Speed (%) - SSD (CHA_FAN3)
If ([Math]::Ceiling("$(${Speed_FAN_SSD_PRC}.(${_}))") -Eq 0) {
  Write-Output "$(${Speed_FAN_SSD_PRC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_SSD}.txt";
} Else {
  Write-Output "$(${Speed_FAN_SSD_PRC}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_SSD}.txt";
}

# ------------------------------

# Load - CPU
If ([String]::IsNullOrEmpty(${Load_CPU}.(${_}))) {  # May equal zero without errors
  Write-Output "$(${Load_CPU}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Load_CPU}.txt";
} Else {
  Write-Output "$(${Load_CPU}):OK" | Out-File -NoNewline "${Logfile_Load_CPU}.txt";
}

# Load - GPU
If ([String]::IsNullOrEmpty(${Load_GPU}.(${_}))) {  # May equal zero without errors
  Write-Output "$(${Load_GPU}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Load_GPU}.txt";
} Else {
  Write-Output "$(${Load_GPU}):OK" | Out-File -NoNewline "${Logfile_Load_GPU}.txt";
}
# Load - GPU Memory
If ([String]::IsNullOrEmpty(${GPU_Memory_Load}.(${_}))) {  # May equal zero without errors
  Write-Output "$(${GPU_Memory_Load}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Load_GPU_Memory}.txt";
} Else {
  Write-Output "$(${GPU_Memory_Load}):OK" | Out-File -NoNewline "${Logfile_Load_GPU_Memory}.txt";
}

# ------------------------------

# Power - CPU
If ([Math]::Ceiling("$(${Power_CPU}.(${_}))") -Eq 0) {
  Write-Output "$(${Power_CPU}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Power_CPU}.txt";
} Else {
  Write-Output "$(${Power_CPU}):OK" | Out-File -NoNewline "${Logfile_Power_CPU}.txt";
}
# Power - GPU
If ([Math]::Ceiling("$(${Power_GPU}.(${_}))") -Eq 0) {
  Write-Output "$(${Power_GPU}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Power_GPU}.txt";
} Else {
  Write-Output "$(${Power_GPU}):OK" | Out-File -NoNewline "${Logfile_Power_GPU}.txt";
}

# ------------------------------

# Temperature (°C) - CPU  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
If ([Math]::Ceiling("$(${Temp_CPU}.(${_}))") -Eq 0) {
  Write-Output "$(${Temp_CPU}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_CPU}.txt";
} Else {
  Write-Output "$(${Temp_CPU}):OK" | Out-File -NoNewline "${Logfile_Temperature_CPU}.txt";
}
# Temperature (°C) - GPU  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
If ([Math]::Ceiling("$(${Temp_GPU}.(${_}))") -Eq 0) {
  Write-Output "$(${Temp_GPU}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_GPU}.txt";
} Else {
  Write-Output "$(${Temp_GPU}):OK" | Out-File -NoNewline "${Logfile_Temperature_GPU}.txt";
}
# Temperature (°C) - SSD  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
If ([Math]::Ceiling("$(${Temp_GPU}.(${_}))") -Eq 0) {
  Write-Output "$(${Temp_SSD}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_SSD}.txt";
} Else {
  Write-Output "$(${Temp_SSD}):OK" | Out-File -NoNewline "${Logfile_Temperature_SSD}.txt";
}
# Temperature (°C) - T_SENSOR  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
If ([Math]::Ceiling("$(${Temp_T_SENSOR}.(${_}))") -Eq 0) {
  Write-Output "$(${Temp_T_SENSOR}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_T_SENSOR}.txt";
} Else {
  Write-Output "$(${Temp_T_SENSOR}):OK" | Out-File -NoNewline "${Logfile_Temperature_T_SENSOR}.txt";
}

# ------------------------------

# Voltage (V) - 3VCC (+3.3V PSU voltage)
If ([Math]::Ceiling("$(${Voltage_03VCC}.(${_}))") -Eq 0) {
  Write-Output "$(${Voltage_03VCC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Voltage_03VCC}.txt";
} Else {
  Write-Output "$(${Voltage_03VCC}):OK" | Out-File -NoNewline "${Logfile_Voltage_03VCC}.txt";

# Voltage (V) - 5VCC (+5.0V PSU voltage)
If ([Math]::Ceiling("$(${Voltage_05VCC}.(${_}))") -Eq 0) {
  Write-Output "$(${Voltage_05VCC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Voltage_05VCC}.txt";
} Else {
  Write-Output "$(${Voltage_05VCC}):OK" | Out-File -NoNewline "${Logfile_Voltage_05VCC}.txt";

# Voltage (V) - 12VCC (+12.0V PSU voltage)
If ([Math]::Ceiling("$(${Voltage_12VCC}.(${_}))") -Eq 0) {
  Write-Output "$(${Voltage_12VCC}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Voltage_12VCC}.txt";
} Else {
  Write-Output "$(${Voltage_12VCC}):OK" | Out-File -NoNewline "${Logfile_Voltage_12VCC}.txt";
}


# ------------------------------
#
# Cleanup old logfiles
#

# Add-Type -AssemblyName "Microsoft.VisualBasic";  <# Required to use Recycle Bin action 'SendToRecycleBin' #>
# | ForEach-Object { [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("$(${_}.FullName)",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete file to the Recycle Bin #> } `

$Retention_Days = "7";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
$EA_Bak=$ErrorActionPreference; $ErrorActionPreference=0;
Get-ChildItem -Path "${Logfile_Dirname}" -File -Recurse -Force `
| Where-Object { ($_.Name -Like "${Logfile_StartsWith}*") } `
| Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
| Remove-Item -Recurse -Force -Confirm:$False `
;
$ErrorActionPreference=$EA_Bak;


# ------------------------------
#
# Get Data from "Remote Sensor Monitor"
#

$RSM_Dirname="C:\ISO\RemoteSensorMonitor";
$RSM_Host="localhost";
$EA_Bak=$ErrorActionPreference; $ErrorActionPreference=0;
$RSM_Port=(Get-Content "${RSM_Dirname}\DefaultPort.txt");
$ErrorActionPreference=$EA_Bak;
$RSM_Results="${RSM_Dirname}\results";
If (-Not ([String]::IsNullOrEmpty(${RSM_Port}))) {
  $ProgressPreference=0;
  $RegexPattern_JsonBody='\n((\[(\n|.)+\n\])|(\{(\n|.)+\n\}))';
  # Pull the latest sensor data from "Remote Sensor Monitor"
  $EA_Bak=$ErrorActionPreference; $ErrorActionPreference=0;
  $RSM_HtmlResponse=((Invoke-WebRequest -UseBasicParsing -Uri "http://${RSM_Host}:${RSM_Port}").RawContent);
  $ErrorActionPreference=$EA_Bak;
  If ((-Not ([String]::IsNullOrEmpty(${RSM_HtmlResponse}))) -And (([Regex]::Match("${RSM_HtmlResponse}","${RegexPattern_JsonBody}").Success) -Eq $True)) {
    # Ensure the output directory exists
    If ((Test-Path "${RSM_Results}") -NE $True) {
      New-Item -ItemType ("Directory") -Path ("${RSM_Results}") | Out-Null;
    }
    # Parse the JSON response
    $JsonResponse=([Regex]::Match("${RSM_HtmlResponse}","${RegexPattern_JsonBody}").Captures.Groups[1].Value);
    # Walk through each item in the JSON response
    (${JsonResponse} | ConvertFrom-Json) | ForEach-Object {
      # ------------------------------
      $SensorApp = ($_.SensorApp);
      $SensorClass = ($_.SensorClass);
      $SensorName = ($_.SensorName);
      $SensorValue = ($_.SensorValue);
      $SensorUnit = ($_.SensorUnit);
      $SensorUpdateTime = ($_.SensorUpdateTime);
      # ------------------------------
      $ResultsFile=("${RSM_Results}\${SensorApp}.${SensorClass}.${SensorName}.txt");
      # $RoundedValue=([Math]::Round(${SensorValue},4));
      # Output the results to sensor-specific files
      If ([String]::IsNullOrEmpty(${SensorValue})) {
        Write-Output "${SensorValue}:${Sensor_ErrorMessage}" | Out-File -NoNewline "${ResultsFile}";
      } Else {
        Write-Output "${SensorValue}:OK" | Out-File -NoNewline "${ResultsFile}";
      }
    }
  }
}


# ------------------------------

# Benchmark (KEEP AS FINAL RUNTIME (e.g. keep at the very very end of this script)

$Benchmark.Stop();
$RunDuration=("$(${Benchmark}.Elapsed)");
If ([String]::IsNullOrEmpty(${RunDuration})) {
  Write-Output "${RunDuration}:${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_RunDuration}.txt";
} Else {
  Write-Output "${RunDuration}:OK" | Out-File -NoNewline "${Logfile_RunDuration}.txt";
}

# ------------------------------------------------------------