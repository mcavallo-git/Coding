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
# STEP 3) Setup a Scheduled Task to run OpenHardwareMonitor.exe at startup
#
# ------------------------------------------------------------
#
# STEP 4) Setup a Scheduled Task to run this PowerShell script at startup, and repeating every minute
#
# ------------------------------------------------------------
#
# STEP 5) Create a new PRTG Sensor with type "EXE/Script Advanced" which runs a batch file in "../EXE/*.bat" (which target only one of the many sensors' output TXT files, shown below)
#
# ------------------------------------------------------------

$Benchmark = New-Object System.Diagnostics.Stopwatch;
$Benchmark.Reset(); <# Reuse same benchmark/stopwatch object by resetting it #>
$Benchmark.Start();

# ------------------------------------------------------------
#
# Get the Temperature, fan speeds, etc. through Dell's oproprietary config but nt on the 730...Openhardware"'s  OpenHardwareMonitor's logfile (second line is column title, third row is values)
#

$Logfile_Dirname = "C:\ISO\OpenHardwareMonitor";
$Logfile_StartsWith = "OpenHardwareMonitorLog-";

$Logfile_Input_FullPath = "${Logfile_Dirname}\${Logfile_StartsWith}$(Get-Date -UFormat '%Y-%m-%d').csv";

# ------------------------------------------------------------

$Logfile_Basename = "${Logfile_Dirname}\OHW-Current";

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

$Logfile_Time_Range = "${Logfile_Basename}-Time";

$Logfile_Voltage_3VCC = "${Logfile_Basename}-Voltage-3VCC";

# $Logfile_XmlOutput_All = "${Logfile_Basename}-All.xml";

# ------------------------------------------------------------

# NVIDIA offers a free EXE utility named "NVIDIA System Management Interface (SMI)" which allows for command-line parameters to specify intended output
$Exe_NVidiaSMI = "C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe";

# $CsvHeadersArr = @('Time', 'Fan Control #1', 'Fan Control #2', 'Fan Control #3', 'Fan Control #4', 'Fan Control #5', 'Fan Control #6', 'Fan Control #7', 'CPU VCore', 'Voltage #2', 'AVCC', '3VCC', 'Voltage #5', 'Voltage #6', 'Voltage #7', '3VSB', 'VBAT', 'VTT', 'Voltage #11', 'Voltage #12', 'Voltage #13', 'Voltage #14', 'Voltage #15', 'Temperature #1', 'Temperature #2', 'Temperature #3', 'Temperature #4', 'Temperature #5', 'Temperature #6', 'Fan #1', 'Fan #2', 'Fan #4', 'Fan #6', 'CPU Core #1', 'CPU Core #2', 'CPU Core #3', 'CPU Core #4', 'CPU Core #5', 'CPU Core #6', 'CPU Total', 'CPU Package', 'Bus Speed', 'CPU Core #1', 'CPU Core #2', 'CPU Core #3', 'CPU Core #4', 'CPU Core #5', 'CPU Core #6', 'CPU Package', 'CPU CCD #1', 'CPU Core #1', 'CPU Core #2', 'CPU Core #3', 'CPU Core #4', 'CPU Core #5', 'CPU Core #6', 'CPU Cores', 'Memory', 'Used Memory', 'Available Memory', 'GPU Core', 'GPU Core', 'GPU Memory', 'GPU Shader', 'GPU Core', 'GPU Frame Buffer', 'GPU Video Engine', 'GPU Bus Interface', 'GPU Fan', 'GPU', 'GPU Memory Total', 'GPU Memory Used', 'GPU Memory Free', 'GPU Memory', 'GPU Power', 'GPU PCIE Rx', 'GPU PCIE Tx', 'Used Space');

$Clock_CPU_Core = @{Avg="";Max="";Min="";};
$Clock_GPU_Core = @{Avg="";Max="";Min="";};
$Clock_GPU_Mem = @{Avg="";Max="";Min="";};
$Clock_GPU_Shad = @{Avg="";Max="";Min="";};

$GPU_Memory_Load = @{Avg="";Max="";Min="";};

$Load_CPU = @{Avg="";Max="";Min="";};
$Load_GPU = @{Avg="";Max="";Min="";};

$Speed_FAN_PMP = @{Avg="";Max="";Min="";};
$Speed_FAN_PMP_PRC = @{Avg="";Max="";Min="";};
$Speed_FAN_RAD = @{Avg="";Max="";Min="";};
$Speed_FAN_RAD_PRC = @{Avg="";Max="";Min="";};
$Speed_FAN_SSD = @{Avg="";Max="";Min="";};
$Speed_FAN_SSD_PRC = @{Avg="";Max="";Min="";};
$Speed_FAN_CHA = @{Avg="";Max="";Min="";};
$Speed_FAN_CHA_PRC = @{Avg="";Max="";Min="";};

$Power_CPU = @{Avg="";Max="";Min="";};
$Power_GPU = @{Avg="";Max="";Min="";};

$Temp_CPU = @{Avg="";Max="";Min="";};
$Temp_GPU = @{Avg="";Max="";Min="";};
$Temp_SSD = @{Avg="";Max="";Min="";};
$Temp_T_SENSOR = @{Avg="";Max="";Min="";};

$Time_Range = @{Avg="";Max="";Min="";};

$Voltage_3VCC = @{Avg="";Max="";Min="";};

# $XmlFooter = "</prtg>";
# $XmlHeader = "<?xml version=`"1.0`" encoding=`"Windows-1252`" ?>`n<prtg>";
# $XmlOutput_Array_All = @();

$Sensor_ErrorMessage="ERROR - Open Hardware Monitor reading returned a null or empty value";

<# Make sure the OHW Logfile exists #>
If ((Test-Path -PathType "Leaf" -Path ("${Logfile_Input_FullPath}") -ErrorAction ("SilentlyContinue")) -Eq $False) {
  <# Remove any logged data from a previous run #>
  # Get-Item "${Logfile_Basename}*.txt" | Remove-Item -Force;

  <# End the current run #>
  # Exit 1;

  $Sensor_ErrorMessage="ERROR - Open Hardware Monitor logfile not found: ${Logfile_Input_FullPath}";

} Else {

  $RowCount_HeaderRows=(2);
  $RowCount_DataRows=(60);

  $LogContent_HeaderRows = (Get-Content -Path ("${Logfile_Input_FullPath}") -TotalCount (${RowCount_HeaderRows}));

  $CsvImport = @{};
  ${CsvImport}["Descriptions"] = (@("$($LogContent_HeaderRows[1])").Split(","));
  ${CsvImport}["Paths"] = (@("$($LogContent_HeaderRows[0])").Split(","));
  ${CsvImport}["Paths"][0]="Time"; <# OHW leaves the first row's first column blank for whatever reason #>

  <# Avoid random bug where OHW doesn't grab the GPU correctly at logfile creation time, which combines with OHW matching the headers on an existing log's data after said bugged run, which truncates all future data which is in addition to an existing log's header columns (truncates GPU data if GPU data wasn't pulled at time of log creation) #>
  $RequiredPath="gpu";
  If (((${CsvImport}["Paths"] | Where-Object { "${_}" -Like "*${RequiredPath}*" }).Count) -Eq (0)) {
    $Dirname = [IO.Path]::GetDirectoryName("${Logfile_Input_FullPath}");
    $Basename = [IO.Path]::GetFileNameWithoutExtension("${Logfile_Input_FullPath}");
    $Extension = [IO.Path]::GetExtension("${Logfile_Input_FullPath}");
    <# Remove any logged data from a previous run #>
    Get-Item "${Logfile_Basename}*.txt" | Remove-Item -Force;
    <# Rename the logfile - Allow OHW to recreate the logfile with updated headers (including (namely) missing gpu header columns) #>
    ${Logfile_Renamed_MissingHeaders}=("${Dirname}\${Basename}_MISSING-[${RequiredPath}]-HEADERS_$(Get-Date -Format 'yyyyMMddTHHmmss.fff')${Extension}");
    Move-Item -Path ("${Logfile_Input_FullPath}") -Destination ("${Logfile_Renamed_MissingHeaders}") -Force;
    <# End the current run #>
    Exit 1;
  }

  $LogContent_DataAndHeaderCheck=(Get-Content -Path ("${Logfile_Input_FullPath}") -Tail (${RowCount_DataRows}+${RowCount_HeaderRows}));
  $LogContent_DataRows=(${LogContent_DataAndHeaderCheck} | Select-Object -Last ((${LogContent_DataAndHeaderCheck}.Count)-${RowCount_HeaderRows}));

  $DataRows_SensorReadings=@();

  $GetCulture=(Get-Culture); <# Get the system's display format of items such as numbers #>

  For ($i=0; $i -LT ((${CsvImport}["Paths"]).Count); $i++) {

    $Each_HeaderPath=(${CsvImport}["Paths"][$i]);
    $Each_HeaderDescription=(${CsvImport}["Descriptions"][$i]);
    $Updated_HeaderDescription=("");

    # ------------------------------
    # OHW outputs descriptions which are non-unique - update them to be unique, instead
    # ------------------------------
    #
    # Mobo Readings
    #
    If (${Each_HeaderPath} -Match "lpc/.+/control/") {
      $Updated_HeaderDescription=("Mobo Fans (% PWM), ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "lpc/.+/fan/") {
      $Updated_HeaderDescription=("Mobo Fans (RPM), ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "lpc/.+/voltage/") {
      $Updated_HeaderDescription=("Mobo Voltages, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "lpc/.+/temperature/") {
      $Updated_HeaderDescription=("Mobo Temps, ${Each_HeaderDescription}");

    # ------------------------------
    #
    # Processor (CPU) Readings
    #
    } ElseIf (${Each_HeaderPath} -Match "cpu/.+/load/") {
      $Updated_HeaderDescription=("CPU Load, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "cpu/.+/power/") {
      $Updated_HeaderDescription=("CPU Power, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "cpu/.+/temperature/") {
      $Updated_HeaderDescription=("CPU Temps, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "cpu/.+/clock/") {
      $Updated_HeaderDescription=("CPU Clocks, ${Each_HeaderDescription}");

    # ------------------------------
    #
    # Memory (RAM) Readings
    #
    } ElseIf (${Each_HeaderPath} -Match "/ram/load/") {
      $Updated_HeaderDescription=("RAM Load, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "/ram/data/") {
      $Updated_HeaderDescription=("RAM Data, ${Each_HeaderDescription}");

    # ------------------------------
    #
    # Graphics Card (GPU) Readings
    #
    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/temperature/") {
      $Updated_HeaderDescription=("GPU Temps, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/clock/") {
      $Updated_HeaderDescription=("GPU Clocks, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/control/") {
      $Updated_HeaderDescription=("GPU Fan (% PWM), ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/fan/") {
      $Updated_HeaderDescription=("GPU Fan (RPM), ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/smalldata/") {
      $Updated_HeaderDescription=("GPU Memory, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/load/") {
      $Updated_HeaderDescription=("GPU Load, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/power/") {
      $Updated_HeaderDescription=("GPU Power, ${Each_HeaderDescription}");

    } ElseIf (${Each_HeaderPath} -Match "gpu/.+/throughput/") {
      $Updated_HeaderDescription=("GPU Rx/Tx, ${Each_HeaderDescription}");

    # ------------------------------
    #
    # Storage Disk (HDD/SSD) Readings
    #
    } ElseIf (${Each_HeaderPath} -Match "hdd/.+/load/") {
      $Updated_HeaderDescription=("Disk Load, ${Each_HeaderDescription}");

    # ------------------------------
    }

    If ("${Updated_HeaderDescription}" -NE "") {
      ${CsvImport}["Descriptions"][$i]=("${Updated_HeaderDescription}");
    }

  }

  For ($i_Row=-1; $i_Row -GE (-1 * ${LogContent_DataRows}.Count); $i_Row--) {
    <# Walk through the last minute's worth of sensor data stored in the CSV logfile #>
    $Each_DataRow=(${LogContent_DataRows}[$i_Row] -Split ",");
    $Each_Row_SensorReadings = @{"Time"=(${Each_DataRow}[0][0]);};
    For ($i_Column=0; $i_Column -LT (${CsvImport}["Paths"].Count); $i_Column++) {
      <# Walk through each column on each row #>
      $Each_StringValue=(${Each_DataRow}[${i_Column}] -Replace "`"", "");
      $Each_Value=0.0;
      If (${i_Column} -Eq 0) {
        <# Convert [String] to [DateTime] w/o throwing an error #>
        $Each_Value=(Get-Date -Date (${Each_StringValue}) -UFormat ("%s"));
      } Else {
        <# Convert [String] to [DateTime] w/o throwing an error #>
        If (([Decimal]::TryParse(${Each_StringValue}, [Globalization.NumberStyles]::Float, ${GetCulture}, [Ref]${Each_Value})) -Eq ($True)) {
          <# Do Nothing (String-to-Decimal conversion already performed in above "If" statement's conditional block #>
          }
      }
      <# Store each values into an object, push the object to an array (below), then calculate min/max later all-at-once #>
      ${Each_Row_SensorReadings}.(${CsvImport}["Paths"][${i_Column}]) = (${Each_Value});
    }
    ${DataRows_SensorReadings} += ${Each_Row_SensorReadings};
  }

  If ($False) {
    $Dirname_RevertTo = ((Get-Location).Path);
    $Dirname_NVidiaSMI = (Split-Path -Path ("${Exe_NVidiaSMI}") -Parent);
    Set-Location -Path ("${Dirname_NVidiaSMI}");
    $Load_GPU = (nvidia-smi.exe --query-gpu=utilization.gpu --format="csv,nounits,noheader" --id=0);
    # $Temp_GPU = (nvidia-smi.exe --query-gpu=temperature.gpu --format="csv,nounits,noheader" --id=0);
    Set-Location -Path ("${Dirname_RevertTo}");
  }

  <# Calculated output data based on latest input data #>
  For ($i_Column=0; $i_Column -LT ((${CsvImport}["Paths"]).Count); $i_Column++) {

    $Each_MinMaxAverage = (${DataRows_SensorReadings}.(${CsvImport}["Paths"][${i_Column}]) | Measure-Object -Average -Maximum -Minimum);

    $EachSensorReading_Obj = @{};
    # $Each_SensorPath = (${CsvImport}["Paths"][${i_Column}] -Replace "`"", "");
    $Each_SensorDescription = (${CsvImport}["Descriptions"][${i_Column}] -Replace "`"", "");

    $EachSensorReading_Obj["Average"] = (${Each_MinMaxAverage}.Average);
    $EachSensorReading_Obj["Maximum"] = (${Each_MinMaxAverage}.Maximum);
    $EachSensorReading_Obj["Minimum"] = (${Each_MinMaxAverage}.Minimum);
    
    $Each_Value = @{};
    ${Each_Value}.Avg = (${Each_MinMaxAverage}.Average);
    ${Each_Value}.Max = (${Each_MinMaxAverage}.Maximum);
    ${Each_Value}.Min = (${Each_MinMaxAverage}.Minimum);

    # ------------------------------------------------------------

    # $Each_XmlOutput_Array = @();
    # $Each_XmlOutput_Array += "   <result>";
    # $Each_XmlOutput_Array += "       <Channel>${Each_SensorDescription}</Channel>";
    # $Each_XmlOutput_Array += "       <Value>$(${Each_Value}.Max)</Value>";
    # $Each_XmlOutput_Array += "       <Mode>Absolute</Mode>";
    # If (${Each_SensorPath} -Match "/temperature/") { # Use units of Degrees-Celsius (°C) for temperature readings
    #   $Each_XmlOutput_Array += "       <Unit>Temperature</Unit>";
    # } ElseIf (${Each_SensorPath} -Match "/fan/") { # Use units of Rotations per Minute (RPM) for fans and liquid-cooling pumps
    #   $Each_XmlOutput_Array += "       <Unit>Custom</Unit>";
    #   $Each_XmlOutput_Array += "       <CustomUnit>RPM</CustomUnit>";
    # } ElseIf (${Each_SensorPath} -Match "/control/") { # Use units of Percentage of Max Fan Speed (% PWM) for fans and liquid-cooling pumps
    #   $Each_XmlOutput_Array += "       <Unit>Custom</Unit>";
    #   $Each_XmlOutput_Array += "       <CustomUnit>% PWM</CustomUnit>";
    # } ElseIf (${Each_SensorPath} -Match "/voltage/") { # Use units of Volts (V) for electric-pressure readings
    #   $Each_XmlOutput_Array += "       <Unit>Custom</Unit>";
    #   $Each_XmlOutput_Array += "       <CustomUnit>Volts</CustomUnit>";
    # }
    # $Each_XmlOutput_Array += "       <Float>1</Float>";
    # $Each_XmlOutput_Array += "       <ShowChart>0</ShowChart>";
    # $Each_XmlOutput_Array += "       <ShowTable>0</ShowTable>";
    # $Each_XmlOutput_Array += "   </result>";

    # $XmlOutput_Array_All += $Each_XmlOutput_Array;

    @("Avg","Max","Min") | ForEach-Object {

      # ------------------------------

      If (${Each_SensorDescription} -Eq "Time") {
        ${Time_Range}.(${_}) = (Get-Date -Date ($((New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor(${Each_Value}.(${_}))))) -UFormat ("%m/%d/%Y %H:%M:%S"));

        # ------------------------------

      } ElseIf (${Each_SensorDescription} -Eq "CPU Clocks, CPU Core #1") {
        ${Clock_CPU_Core}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "CPU Load, CPU Total") {
        ${Load_CPU}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "CPU Power, CPU Cores") {
        ${Power_CPU}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "CPU Temps, CPU Package") {
        ${Temp_CPU}.(${_}) = (${Each_Value}.(${_}));

        # ------------------------------

      } ElseIf (${Each_SensorDescription} -Eq "GPU Load, GPU Core") {
        ${Load_GPU}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "GPU Power, GPU Power") {
        ${Power_GPU}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "GPU Temps, GPU Core") {
        ${Temp_GPU}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "GPU Load, GPU Memory") {
        ${GPU_Memory_Load}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "GPU Clocks, GPU Core") {
        ${Clock_GPU_Core}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "GPU Clocks, GPU Memory") {
        ${Clock_GPU_Mem}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "GPU Clocks, GPU Shader") {
        ${Clock_GPU_Shad}.(${_}) = (${Each_Value}.(${_}));

        # ------------------------------

      # } ElseIf (${Each_SensorDescription} -Eq "Mobo Temps, Temperature #2") {
      #   ${Temp_SSD}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #1") {  <# Chassis Fan 1 #>
        ${Speed_FAN_RAD}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #1") {  <# Chassis Fan 1 #>
        ${Speed_FAN_RAD_PRC}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #3") {  <# Chassis Fan 2 #>
        ${Speed_FAN_CHA}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #3") {  <# Chassis Fan 2 #>
        ${Speed_FAN_CHA_PRC}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #4") {  <# Chassis Fan 3 #>
        ${Speed_FAN_SSD}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #4") {  <# Chassis Fan 3 #>
        ${Speed_FAN_SSD_PRC}.(${_}) = (${Each_Value}.(${_}));
        #
        #     -  T_SENSOR = [ Chassis Fan 3 Current Speed (%) ] - [ Chassis Fan 3 Min. Duty Cycle (%) ] + [ Chassis Fan 3 Lower Temperature ]
        #           ↓
        #     -  T_SENSOR = [ Chassis Fan 3 Current Speed (%) ] - [ 55.0 ] + [ 15.0 ]
        #           ↓
        #     -  T_SENSOR = [ Chassis Fan 3 Current Speed (%) ] - [ 40.0 ]
        #
        $T_SENSOR_TEMP = ([Double](${Each_Value}.(${_})) - [Double](40.00));
        If (${T_SENSOR_TEMP} -GT 0.0) {
          ${Temp_T_SENSOR}.(${_}) = ${T_SENSOR_TEMP};
        }

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #6") {  <# W_PUMP+ #>
        ${Speed_FAN_PMP}.(${_}) = (${Each_Value}.(${_}));

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #6") {  <# W_PUMP+ #>
        ${Speed_FAN_PMP_PRC}.(${_}) = (${Each_Value}.(${_}));

        # ------------------------------

      } ElseIf (${Each_SensorDescription} -Eq "Mobo Voltages, 3VCC") {  <# + 3.3V PSU voltage #>
        ${Voltage_3VCC}.(${_}) = (${Each_Value}.(${_}));

        # ------------------------------

      }

    }

  }

}

<# ------------------------------ #>
<# Perform action(s) not requiring OHW #>

# Pull SSD temp(s) from S.M.A.R.T. values (if no value exists for it already)
If (([String]::IsNullOrEmpty(${Temp_SSD}.Avg)) -Or ([String]::IsNullOrEmpty(${Temp_SSD}.Max)) -Or ([String]::IsNullOrEmpty(${Temp_SSD}.Min))) {
  $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
  $SSD_SMART_Temperature = (Get-Disk | Get-StorageReliabilityCounter | Where-Object { $_.DeviceId -Eq 0; } | Select-Object -ExpandProperty "Temperature");
  $ErrorActionPreference = $EA_Bak;
  If ([String]::IsNullOrEmpty(${Temp_SSD}.Avg)) {
    ${Temp_SSD}.Avg = (${SSD_SMART_Temperature});
  }
  If ([String]::IsNullOrEmpty(${Temp_SSD}.Max)) {
    ${Temp_SSD}.Max = (${SSD_SMART_Temperature});
  }
  If ([String]::IsNullOrEmpty(${Temp_SSD}.Min)) {
    ${Temp_SSD}.Min = (${SSD_SMART_Temperature});
  }
}

<# ------------------------------ #>

# Output the XML contents to output files (separated by-category, as well as one combined file)
# Write-Output (("${XmlHeader}")+("`n")+(${XmlOutput_Array_All} -join "`n")+("`n")+("${XmlFooter}")) | Out-File -NoNewline "${Logfile_XmlOutput_All}.xml";

@("Avg","Max","Min") | ForEach-Object {

  <# Output the sensor values to each of their individual log files (intended for simplified PRTG parsing via batch file using [ TYPE ... .txt ]) #>

  # ------------------------------

  # Time_Range
  If ([String]::IsNullOrEmpty(${Time_Range}.(${_}))) {
    Write-Output "$(${Time_Range}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Time_Range}.${_}.txt";
  } Else {
    Write-Output "$(${Time_Range}.${_}):OK" | Out-File -NoNewline "${Logfile_Time_Range}.${_}.txt";
  }

  # ------------------------------

  # Clock - CPU
  If ([Math]::Ceiling("$(${Clock_CPU_Core}.(${_}))") -Eq 0) {
    Write-Output "$(${Clock_CPU_Core}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_CPU_Core}.${_}.txt";
  } Else {
    Write-Output "$(${Clock_CPU_Core}.${_}):OK" | Out-File -NoNewline "${Logfile_Clock_CPU_Core}.${_}.txt";
  }
  # Clock - GPU Core
  If ([Math]::Ceiling("$(${Clock_GPU_Core}.(${_}))") -Eq 0) {
    Write-Output "$(${Clock_GPU_Core}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_GPU_Core}.${_}.txt";
  } Else {
    Write-Output "$(${Clock_GPU_Core}.${_}):OK" | Out-File -NoNewline "${Logfile_Clock_GPU_Core}.${_}.txt";
  }
  # Clock - GPU Memory
  If ([Math]::Ceiling("$(${Clock_GPU_Mem}.(${_}))") -Eq 0) {
    Write-Output "$(${Clock_GPU_Mem}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_GPU_Mem}.${_}.txt";
  } Else {
    Write-Output "$(${Clock_GPU_Mem}.${_}):OK" | Out-File -NoNewline "${Logfile_Clock_GPU_Mem}.${_}.txt";
  }
  # Clock - GPU Shader
  If ([String]::IsNullOrEmpty(${Clock_GPU_Shad}.(${_}))) {  # May equal zero without errors
    Write-Output "$(${Clock_GPU_Shad}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Clock_GPU_Shad}.${_}.txt";
  } Else {
    Write-Output "$(${Clock_GPU_Shad}.${_}):OK" | Out-File -NoNewline "${Logfile_Clock_GPU_Shad}.${_}.txt";
  }

  # ------------------------------

  # Fan Speed (RPM) - Water-Pump (W_PUMP+)
  If ([Math]::Ceiling("$(${Speed_FAN_PMP}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_PMP}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_PMP}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_PMP}.${_}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_PMP}.${_}.txt";
  }
  # Fan Speed (RPM) - Radiator (CHA_FAN1)
  If ([Math]::Ceiling("$(${Speed_FAN_RAD}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_RAD}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_RAD}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_RAD}.${_}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_RAD}.${_}.txt";
  }
  # Fan Speed (RPM) - Chassis (CHA_FAN2)
  If ([Math]::Ceiling("$(${Speed_FAN_CHA}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_CHA}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_CHA}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_CHA}.${_}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_CHA}.${_}.txt";
  }
  # Fan Speed (RPM) - SSD (CHA_FAN3)
  If ([Math]::Ceiling("$(${Speed_FAN_SSD}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_SSD}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanSpeed_SSD}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_SSD}.${_}):OK" | Out-File -NoNewline "${Logfile_FanSpeed_SSD}.${_}.txt";
  }

  # ------------------------------

  # Fan Speed (%) - Water-Pump (W_PUMP+)
  If ([Math]::Ceiling("$(${Speed_FAN_PMP_PRC}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_PMP_PRC}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_PMP}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_PMP_PRC}.${_}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_PMP}.${_}.txt";
  }
  # Fan Speed (%) - Radiator (CHA_FAN1)
  If ([Math]::Ceiling("$(${Speed_FAN_RAD_PRC}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_RAD_PRC}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_RAD}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_RAD_PRC}.${_}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_RAD}.${_}.txt";
  }
  # Fan Speed (%) - Chassis (CHA_FAN2)
  If ([Math]::Ceiling("$(${Speed_FAN_CHA_PRC}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_CHA_PRC}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_CHA}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_CHA_PRC}.${_}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_CHA}.${_}.txt";
  }
  # Fan Speed (%) - SSD (CHA_FAN3)
  If ([Math]::Ceiling("$(${Speed_FAN_SSD_PRC}.(${_}))") -Eq 0) {
    Write-Output "$(${Speed_FAN_SSD_PRC}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_FanPercentage_SSD}.${_}.txt";
  } Else {
    Write-Output "$(${Speed_FAN_SSD_PRC}.${_}):OK" | Out-File -NoNewline "${Logfile_FanPercentage_SSD}.${_}.txt";
  }

  # ------------------------------

  # Load - CPU
  If ([String]::IsNullOrEmpty(${Load_CPU}.(${_}))) {  # May equal zero without errors
    Write-Output "$(${Load_CPU}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Load_CPU}.${_}.txt";
  } Else {
    Write-Output "$(${Load_CPU}.${_}):OK" | Out-File -NoNewline "${Logfile_Load_CPU}.${_}.txt";
  }

  # Load - GPU
  If ([String]::IsNullOrEmpty(${Load_GPU}.(${_}))) {  # May equal zero without errors
    Write-Output "$(${Load_GPU}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Load_GPU}.${_}.txt";
  } Else {
    Write-Output "$(${Load_GPU}.${_}):OK" | Out-File -NoNewline "${Logfile_Load_GPU}.${_}.txt";
  }
  # Load - GPU Memory
  If ([String]::IsNullOrEmpty(${GPU_Memory_Load}.(${_}))) {  # May equal zero without errors
    Write-Output "$(${GPU_Memory_Load}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Load_GPU_Memory}.${_}.txt";
  } Else {
    Write-Output "$(${GPU_Memory_Load}.${_}):OK" | Out-File -NoNewline "${Logfile_Load_GPU_Memory}.${_}.txt";
  }

  # ------------------------------

  # Power - CPU
  If ([Math]::Ceiling("$(${Power_CPU}.(${_}))") -Eq 0) {
    Write-Output "$(${Power_CPU}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Power_CPU}.${_}.txt";
  } Else {
    Write-Output "$(${Power_CPU}.${_}):OK" | Out-File -NoNewline "${Logfile_Power_CPU}.${_}.txt";
  }
  # Power - GPU
  If ([Math]::Ceiling("$(${Power_GPU}.(${_}))") -Eq 0) {
    Write-Output "$(${Power_GPU}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Power_GPU}.${_}.txt";
  } Else {
    Write-Output "$(${Power_GPU}.${_}):OK" | Out-File -NoNewline "${Logfile_Power_GPU}.${_}.txt";
  }

  # ------------------------------

  # Temperature (°C) - CPU  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
  If ([Math]::Ceiling("$(${Temp_CPU}.(${_}))") -Eq 0) {
    Write-Output "$(${Temp_CPU}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_CPU}.${_}.txt";
  } Else {
    Write-Output "$(${Temp_CPU}.${_}):OK" | Out-File -NoNewline "${Logfile_Temperature_CPU}.${_}.txt";
  }
  # Temperature (°C) - GPU  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
  If ([Math]::Ceiling("$(${Temp_GPU}.(${_}))") -Eq 0) {
    Write-Output "$(${Temp_GPU}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_GPU}.${_}.txt";
  } Else {
    Write-Output "$(${Temp_GPU}.${_}):OK" | Out-File -NoNewline "${Logfile_Temperature_GPU}.${_}.txt";
  }
  # Temperature (°C) - SSD  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
  If ([Math]::Ceiling("$(${Temp_GPU}.(${_}))") -Eq 0) {
    Write-Output "$(${Temp_SSD}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_SSD}.${_}.txt";
  } Else {
    Write-Output "$(${Temp_SSD}.${_}):OK" | Out-File -NoNewline "${Logfile_Temperature_SSD}.${_}.txt";
  }
  # Temperature (°C) - T_SENSOR  (assume temperature will not reach 0°C, e.g. assume LN2 is not being used)
  If ([Math]::Ceiling("$(${Temp_T_SENSOR}.(${_}))") -Eq 0) {
    Write-Output "$(${Temp_T_SENSOR}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Temperature_T_SENSOR}.${_}.txt";
  } Else {
    Write-Output "$(${Temp_T_SENSOR}.${_}):OK" | Out-File -NoNewline "${Logfile_Temperature_T_SENSOR}.${_}.txt";
  }

  # ------------------------------

  # Voltage (V) - 3VCC (+ 3.3V PSU voltage)
  If ([Math]::Ceiling("$(${Voltage_3VCC}.(${_}))") -Eq 0) {
    Write-Output "$(${Voltage_3VCC}.${_}):${Sensor_ErrorMessage}" | Out-File -NoNewline "${Logfile_Voltage_3VCC}.${_}.txt";
  } Else {
    Write-Output "$(${Voltage_3VCC}.${_}):OK" | Out-File -NoNewline "${Logfile_Voltage_3VCC}.${_}.txt";
  }

  # ------------------------------

}

# ------------------------------
#
# Cleanup old logfiles
#

# Add-Type -AssemblyName "Microsoft.VisualBasic";  <# Required to use Recycle Bin action 'SendToRecycleBin' #>
# | ForEach-Object { [Microsoft.VisualBasic.FileIO.FileSystem]::DeleteFile("$(${_}.FullName)",'OnlyErrorDialogs','SendToRecycleBin'); <# Delete file to the Recycle Bin #> } `

$Retention_Days = "7";
$Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
$EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
Get-ChildItem -Path "${Logfile_Dirname}" -File -Recurse -Force `
| Where-Object { ($_.Name -Like "${Logfile_StartsWith}*") } `
| Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
| Remove-Item -Recurse -Force -Confirm:$False `
;
$ErrorActionPreference = $EA_Bak;


# ------------------------------
#
# Get Data from "Remote Sensor Monitor"
#

$RSM_Dirname="C:\ISO\RemoteSensorMonitor";
$RSM_Host="localhost";
$EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
$RSM_Port=(Get-Content "${RSM_Dirname}\DefaultPort.txt");
$ErrorActionPreference = $EA_Bak;
$RSM_Results="${RSM_Dirname}\results";
If (-Not ([String]::IsNullOrEmpty(${RSM_Port}))) {
  $ProgressPreference=0;
  $RegexPattern_JsonBody='\n((\[(\n|.)+\n\])|(\{(\n|.)+\n\}))';
  # Pull the latest sensor data from "Remote Sensor Monitor"
  $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
  $RSM_HtmlResponse=((Invoke-WebRequest -UseBasicParsing -Uri "http://${RSM_Host}:${RSM_Port}").RawContent);
  $ErrorActionPreference = $EA_Bak;
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
      # Handle invalid characters in sensor names
      $ResultsFile=(("${RSM_Results}\${SensorApp}.${SensorClass}.${SensorName}.txt").Split([IO.Path]::GetInvalidFileNameChars()) -join '_');
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
# 
# Citation(s)
#
#   community.spiceworks.com  |  "[SOLVED] Invalid Global Switch - wmic - Spiceworks General Support - Spiceworks"  |  https://community.spiceworks.com/topic/218342-invalid-global-switch-wmic
# 
#   docs.microsoft.com  |  "DateTime.ParseExact Method (System) | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/api/system.datetime.parseexact?view=net-5.0
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
#   stackoverflow.com  |  "How to convert string to decimal in powershell? - Stack Overflow"  |  https://stackoverflow.com/a/63631813
#
#   stackoverflow.com  |  "powershell max/first/aggregate functions - Stack Overflow"  |  https://stackoverflow.com/a/19170783
# 
#   www.paessler.com  |  "PRTG Manual: Custom Sensors - Standard EXE/Script Sensor"  |  https://www.paessler.com/manuals/prtg/custom_sensors#standard_exescript
# 
# ------------------------------------------------------------