# ------------------------------------------------------------
# _PRTG_HardwareSensorReadings.ps1
# ------------------------------------------------------------
# Note: This script is intended to be ran as a Scheduled Task every minute
# ------------------------------------------------------------

# $Benchmark = New-Object System.Diagnostics.Stopwatch;
# $Benchmark.Reset(); # Reuse same benchmark/stopwatch object by resetting it
# $Benchmark.Start();

$Delimiter = ([string][char]0x21FF);

# ------------------------------------------------------------

If ($True) {

  $Clock_CPU_Core = @{Avg="";Max="";Min="";Logfile="Clock-CPU-Core";};
  $Clock_GPU_Core = @{Avg="";Max="";Min="";Logfile="Clock-GPU-Core";};
  $Clock_GPU_Memory = @{Avg="";Max="";Min="";Logfile="Clock-GPU-Memory";};
  $Clock_RAM_DIMMS = @{Avg="";Max="";Min="";Logfile="Clock-RAM";};

  $Load_CPU_Core = @{Avg="";Max="";Min="";Logfile="Load-CPU";};
  $Load_GPU_Core = @{Avg="";Max="";Min="";Logfile="Load-GPU";};
  $Load_GPU_MemoryController = @{Avg="";Max="";Min="";Logfile="Load-GPU-MemoryController";};
  $Load_GPU_MemoryUsage = @{Avg="";Max="";Min="";Logfile="Load-GPU-MemoryUsage";};
  $Load_GPU_Power_TDP_Percentage = @{Avg="";Max="";Min="";Logfile="Load-GPU-Power-TDP-Percentage";};
  $Load_UPS_Total = @{Avg="";Max="";Min="";Logfile="Load-UPS-Total";};

  $Speed_FAN_RPM_AIO_PUMP = @{Avg="";Max="";Min="";Logfile="FanRPM-AIO-Pump";};
  $Speed_FAN_RPM_CHA_FAN1 = @{Avg="";Max="";Min="";Logfile="FanRPM-Radiator";};
  $Speed_FAN_RPM_CHA_FAN2 = @{Avg="";Max="";Min="";Logfile="FanRPM-Chassis";};
  $Speed_FAN_RPM_CHA_FAN3 = @{Avg="";Max="";Min="";Logfile="FanRPM-SSD";};
  $Speed_FAN_RPM_CHIPSET = @{Avg="";Max="";Min="";Logfile="FanRPM-Chipset";};
  $Speed_FAN_RPM_W_PUMP = @{Avg="";Max="";Min="";Logfile="FanRPM-Pump";};

  $Speed_FAN_PRC_CHA_FAN1 = @{Avg="";Max="";Min="";Logfile="FanPercentage-Radiator";};
  $Speed_FAN_PRC_CHA_FAN2 = @{Avg="";Max="";Min="";Logfile="FanPercentage-Chassis";};
  $Speed_FAN_PRC_CHA_FAN3 = @{Avg="";Max="";Min="";Logfile="FanPercentage-SSD";};
  $Speed_FAN_PRC_W_PUMP = @{Avg="";Max="";Min="";Logfile="FanPercentage-Pump";};

  $Power_CPU_Package = @{Avg="";Max="";Min="";Logfile="Power-CPU-Package";};
  $Power_GPU_Total = @{Avg="";Max="";Min="";Logfile="Power-GPU-Total";};
  $Power_UPS_Total = @{Avg="";Max="";Min="";Logfile="Power-UPS-Total";};

  $Lifespan_SSD_RemainingLife = @{Avg="";Max="";Min="";Logfile="SSD-RemainingLife";};
  $Lifespan_SSD_TotalWrites = @{Avg="";Max="";Min="";Logfile="SSD-RemainingLife";};

  $Temp_CPU_Core = @{Avg="";Max="";Min="";Logfile="Temp-CPU-Core";};
  $Temp_GPU_Core = @{Avg="";Max="";Min="";Logfile="Temp-GPU-Core";};
  $Temp_GPU_Hotspot = @{Avg="";Max="";Min="";Logfile="Temp-GPU-Hotspot";};
  $Temp_Motherboard_PCH_CHIPSET = @{Avg="";Max="";Min="";Logfile="Temp-Motherboard-PCH-Chipset";};
  $Temp_Motherboard_T_SENSOR = @{Avg="";Max="";Min="";Logfile="Temp-Motherboard-T_SENSOR";};
  $Temp_RAM_DIMM_0 = @{Avg="";Max="";Min="";Logfile="Temp-RAM-DIMM0";};
  $Temp_RAM_DIMM_1 = @{Avg="";Max="";Min="";Logfile="Temp-RAM-DIMM1";};
  $Temp_RAM_DIMM_2 = @{Avg="";Max="";Min="";Logfile="Temp-RAM-DIMM2";};
  $Temp_RAM_DIMM_3 = @{Avg="";Max="";Min="";Logfile="Temp-RAM-DIMM3";};
  $Temp_SSD = @{Avg="";Max="";Min="";Logfile="Temp-SSD";};

  $Time_Range = @{Avg="";Max="";Min="";Logfile="Time";};

  $Voltage_CPU_Core =         @{Avg="";Max="";Min="";Logfile="Voltage-CPU-Core";};
  $Voltage_GPU_Core =         @{Avg="";Max="";Min="";Logfile="Voltage-GPU-Core";};
  $Voltage_GPU_PCIE_12V =     @{Avg="";Max="";Min="";Logfile="Voltage-GPU-PCIE-12V";};
  $Voltage_Motherboard_03V =  @{Avg="";Max="";Min="";Logfile="Voltage-Motherboard-03V";};
  $Voltage_Motherboard_05V =  @{Avg="";Max="";Min="";Logfile="Voltage-Motherboard-05V";};
  $Voltage_Motherboard_12V =  @{Avg="";Max="";Min="";Logfile="Voltage-Motherboard-12V";};
  $Voltage_Motherboard_VBAT = @{Avg="";Max="";Min="";Logfile="Voltage-Motherboard-CMOS-Battery";};

  $ErrorMessage_HWiNFO = "ERROR - HWiNFO sensor reading returned a null or empty value";
  $ErrorMessage_OHW = "ERROR - Open Hardware Monitor sensor reading returned a null or empty value";

}

# ------------------------------
#
# Get the latest sensor data from HWiNFO64 (via its CSV logfile)
#

If ($True) {

  $Logfile_Dirname_HWiNFO = "C:\ISO\HWiNFO64";
  $Logfile_Input_StarsWith_HWiNFO = "HWiNFO64-";
  $Logfile_Input_FullPath_HWiNFO = "${Logfile_Dirname_HWiNFO}\Reports\${Logfile_Input_StarsWith_HWiNFO}$(Get-Date -UFormat '%Y-%m-%d').csv";
  If ((Test-Path -PathType "Leaf" -Path ("${Logfile_Input_FullPath_HWiNFO}") -ErrorAction ("SilentlyContinue")) -Eq $False) {

    $ErrorMessage_OHW="ERROR - HWiNFO64 logfile not found: ${Logfile_Input_FullPath_HWiNFO}";

  } Else {

    # Ensure output directories exist
    $EnsureDirExists = "${Logfile_Dirname_HWiNFO}";         If ((Test-Path "${EnsureDirExists}") -NE $True) { New-Item -ItemType ("Directory") -Path ("${EnsureDirExists}") | Out-Null; };
    $EnsureDirExists = "${Logfile_Dirname_HWiNFO}\Sensors"; If ((Test-Path "${EnsureDirExists}") -NE $True) { New-Item -ItemType ("Directory") -Path ("${EnsureDirExists}") | Out-Null; };

    If ($True) {

      $RowCount_HeaderRows=(1);
      $RowCount_DataRows=(60);

      $LogContent_HeaderRows = (Get-Content -Path ("${Logfile_Input_FullPath_HWiNFO}") -TotalCount (${RowCount_HeaderRows}));

      $CsvImport = @{};

      ${CsvImport}["Headers"] = (@("${LogContent_HeaderRows}").Split(",") -Replace "`"", "");
      ${CsvImport}["Values"] = @{};

      $LogContent_DataAndHeaderCheck=(Get-Content -Path ("${Logfile_Input_FullPath_HWiNFO}") -Tail (${RowCount_DataRows}+${RowCount_HeaderRows}));
      $LogContent_DataRows=(${LogContent_DataAndHeaderCheck} | Select-Object -Last ((${LogContent_DataAndHeaderCheck}.Count)-${RowCount_HeaderRows}));

      $DataRows_SensorReadings = @();

      $MinMaxAvg_Results = @{};

      $GetCulture=(Get-Culture);  # Get the system's display format of items such as numbers

    }

    # ------------------------------
    #
    # Store the sensor values into an object organized by header names
    #

    If ($True) {

      For ($i_Row=-1; $i_Row -GE (-1 * ${LogContent_DataRows}.Count); $i_Row--) {
        # Walk through the last minute's worth of sensor data stored in the CSV logfile
        $Each_DataRow=(${LogContent_DataRows}[$i_Row] -Split ",");
        $Each_Row_SensorReadings = @{};
        For ($i_Column=0; $i_Column -LT (${CsvImport}["Headers"].Count); $i_Column++) {
          # Walk through each column on each row
          $Each_ColumnHeader = (${CsvImport}["Headers"][${i_Column}]);
          If (-Not ([String]::IsNullOrEmpty("${Each_ColumnHeader}"))) {
            # Only parse columns that have an indentifying header
            $Each_StringValue=(${Each_DataRow}[${i_Column}] -Replace "`"", "");
            $Each_Value=0.0;
            If (${i_Column} -Eq 0) {
              # Convert [String] to [DateTime] w/o throwing an error
              $Each_Value=(Get-Date -Date (${Each_StringValue}) -UFormat ("%s"));
            } Else {
              # Convert [String] to [Decimal] w/o throwing an error
              If (([Decimal]::TryParse(${Each_StringValue}, [Globalization.NumberStyles]::Float, ${GetCulture}, [Ref]${Each_Value})) -Eq ($True)) {
                # Do Nothing (String-to-Decimal conversion already performed in above "If" statement's conditional block
              }
            }
            # Store each values into an object, push the object to an array (below), then calculate min/max later all-at-once
            ${Each_Row_SensorReadings}.(${Each_ColumnHeader}) = (${Each_Value});
          }
        }
        ${DataRows_SensorReadings} += ${Each_Row_SensorReadings};
      }

    }

    # ------------------------------
    #
    # Calculate min/max/avg values from parsed sensor data
    #

    If ($True) {

      For ($i_Column=0; $i_Column -LT ((${CsvImport}["Headers"]).Count); $i_Column++) {

        $Each_ColumnHeader = (${CsvImport}["Headers"][${i_Column}] -Replace "`"", "");

        $Each_MinMaxAvg = (${DataRows_SensorReadings}.(${Each_ColumnHeader}) | Measure-Object -Average -Maximum -Minimum);

        If (-Not ([String]::IsNullOrEmpty("${Each_ColumnHeader}"))) {

          # Only parse columns that have an indentifying header
          If ($True) {
            # Parse the Header's Name & Units out from each other
            $Each_Header_RegexParsed = ([Regex]::Match(${Each_ColumnHeader},'^(.+) \[([^\]]+)\]$').Captures.Groups);
            If (${Each_Header_RegexParsed}.Count -GE 3) { # 3 because of 2 capture groups plus the $0 capture group (the whole string)
              $Each_Header_Name = ($Each_Header_RegexParsed[1].Value);
              $Each_Header_Units = ($Each_Header_RegexParsed[2].Value);
            } Else {
              # Fallback approach - Use the entire header's string as the name (no units, namely for the 'Date/Time' column)
              $Each_Header_Name = "${Each_ColumnHeader}";
              $Each_Header_Units = "";
            }
            # Hotfix temperature unicode character
            If ("${Each_Header_Units}" -Eq "�C") {
              $Each_Header_Units = "°C";
            };
          }

          # Check for duplicate header names (plausible since HWiNFO loses its sensor classes when exporting to CSV)
          $Each_Header_Name_Unique = "${Each_Header_Name}";
          If ($MinMaxAvg_Results.(${Each_Header_Name_Unique}) -NE $Null) {
            # Continue to append different integers onto the name until we find a unique combination, then set that as the name of this duplicate
            $Temp_NameBackup = "${Each_Header_Name_Unique}";
            For ($i=0; $i -LT 1000; $i++) {
              If ($MinMaxAvg_Results.(${Each_Header_Name_Unique}) -Eq $Null) {
                Break;
              } Else {
                $Each_Header_Name_Unique = "${Temp_NameBackup}${Delimiter}Duplicate #${i}";
              }
            }
          }

          $MinMaxAvg_Results.(${Each_Header_Name_Unique}) = @{};
          $MinMaxAvg_Results.(${Each_Header_Name_Unique}).("Avg") = (${Each_MinMaxAvg}.Average);
          $MinMaxAvg_Results.(${Each_Header_Name_Unique}).("Max") = (${Each_MinMaxAvg}.Maximum);
          $MinMaxAvg_Results.(${Each_Header_Name_Unique}).("Min") = (${Each_MinMaxAvg}.Minimum);
          $MinMaxAvg_Results.(${Each_Header_Name_Unique}).("Units") = ("${Each_Header_Units}");

        }

      }

    }

    # ------------------------------
    #
    # Output the sensor data to header-named files named based on the header column
    #

    If ($True) {

      ${MinMaxAvg_Results}.Keys | ForEach-Object {

        $Each_Header_Name_Unique=("$_");
        $Each_Header_Name=(("${Each_Header_Name_Unique}").Split("${Delimiter}")[0]);

        $Each_MinMaxAvg=(${MinMaxAvg_Results}.(${Each_Header_Name_Unique}));
          $Each_Header_Units=(${Each_MinMaxAvg}.Units);
          $Each_Avg=(${Each_MinMaxAvg}.Avg);
          $Each_Max=(${Each_MinMaxAvg}.Max);
          $Each_Min=(${Each_MinMaxAvg}.Min);

        Clear-Variable LimitMaxWarning,LimitMinWarning,LimitMode -EA:0;

        # PRTG Setup/Prep
        If (${Each_Header_Units} -Eq "%") {
          $UnitCategory = "Percent"; # The unit of the value. The default is Custom. This is useful for PRTG to convert volumes and times.
          $LimitMaxWarning = "100";  # Define an upper error limit for the channel. If enabled, the sensor is set to the Down status if this value is exceeded and the LimitMode is activated.
          $LimitMinWarning = "0";    # Define a lower error limit for the channel. If enabled, the sensor is set to the Down status if this value falls below the defined limit and the LimitMode is activated.
          $LimitMode = 1;            # Define if the limit settings defined above are active. The default is 0 (no; limits inactive). If 0 is used, the limits are written to the channel settings as predefined values, but limits are disabled.
        } ElseIf (${Each_Header_Units} -Eq "RPM") {
          $UnitCategory = "Custom";
          $LimitMaxWarning = "50000";
          $LimitMinWarning = "0";
          $LimitMode = 1;
        } ElseIf (${Each_Header_Units} -Eq "W") {
          $UnitCategory = "Custom";
          $LimitMaxWarning = "2000";
          $LimitMinWarning = "0";
          $LimitMode = 1;
        } ElseIf (${Each_Header_Units} -Eq "V") {
          $UnitCategory = "Custom";
          $LimitMaxWarning = "250";
          $LimitMinWarning = "0.1";
          $LimitMode = 1;
        } ElseIf (${Each_Header_Units} -Eq "MHz") {
          $UnitCategory = "Custom";
          $LimitMinWarning = "0";
          $LimitMode = 1;
        } ElseIf (${Each_Header_Units} -Match ".+C") {
          $Each_Header_Units = (([string]([char]0xB0))+("C")); # Force-set the correct temperature degree unicode character
          $UnitCategory = "Temperature";
          $LimitMaxWarning = "150";
          $LimitMinWarning = "0";
          $LimitMode = 1;
        } Else {
          $UnitCategory = "Custom";
          $LimitMode = 0;
        }

        # Build the output JSON as a hash table / arrays, then convert it to JSON afterward
        $Output_HashTable = @{"prtg"=@{"result"=@();};};

        $EmptyValues = 0;

        # Avg Value  -  Append to JSON output
        If ([String]::IsNullOrEmpty("${Each_Avg}")) {
          $EmptyValues++;
        } Else {
          $Mantissa_Digits = If (([Decimal]"${Each_Avg}") -LT (10.0)) { 3 } ElseIf (([Decimal]"${Each_Avg}") -LT (100.0)) { 2 } ElseIf (([Decimal]"${Each_Avg}") -LT (1000.0)) { 1 } Else { 0 };
          $Append_Result = @{ "value"=([Math]::Round(${Each_Avg},${Mantissa_Digits})); "channel"="${Each_Header_Name} (Avg)"; "unit"="${UnitCategory}"; "float"=1; "decimalmode"=${Mantissa_Digits}; };
          If (${UnitCategory} -Eq "Custom") { $Append_Result += @{ "customunit"="${Each_Header_Units}"; }; };
          $Append_Result += @{ "limitmode"=[int]${LimitMode}; };
          If (-Not ([String]::IsNullOrEmpty("${LimitMaxWarning}"))) { $Append_Result += @{ "limitmaxerror"="${LimitMaxWarning}"; }; };
          If (-Not ([String]::IsNullOrEmpty("${LimitMinWarning}"))) { $Append_Result += @{ "limitminerror"="${LimitMinWarning}"; }; };
          $Output_HashTable.prtg.result += ${Append_Result};
        }

        # Max Value  -  Append to JSON output
        If ([String]::IsNullOrEmpty("${Each_Max}")) {
          $EmptyValues++;
        } Else {
          $Mantissa_Digits = If (([Decimal]"${Each_Max}") -LT (10.0)) { 3 } ElseIf (([Decimal]"${Each_Max}") -LT (100.0)) { 2 } ElseIf (([Decimal]"${Each_Max}") -LT (1000.0)) { 1 } Else { 0 };
          $Append_Result = @{ "value"=([Math]::Round(${Each_Max},${Mantissa_Digits})); "channel"="${Each_Header_Name} (Max)"; "unit"="${UnitCategory}"; "float"=1; "decimalmode"=${Mantissa_Digits}; };
          If (${UnitCategory} -Eq "Custom") { $Append_Result += @{ "customunit"="${Each_Header_Units}"; }; };
          $Append_Result += @{ "limitmode"=[int]${LimitMode}; };
          If (-Not ([String]::IsNullOrEmpty("${LimitMaxWarning}"))) { $Append_Result += @{ "limitmaxerror"="${LimitMaxWarning}"; }; };
          If (-Not ([String]::IsNullOrEmpty("${LimitMinWarning}"))) { $Append_Result += @{ "limitminerror"="${LimitMinWarning}"; }; };
          $Output_HashTable.prtg.result += ${Append_Result};
        }

        # Min Value  -  Append to JSON output
        If ([String]::IsNullOrEmpty("${Each_Min}")) {
          $EmptyValues++;
        } Else {
          $Mantissa_Digits = If (([Decimal]"${Each_Min}") -LT (10.0)) { 3 } ElseIf (([Decimal]"${Each_Min}") -LT (100.0)) { 2 } ElseIf (([Decimal]"${Each_Min}") -LT (1000.0)) { 1 } Else { 0 };
          $Append_Result = @{ "value"=([Math]::Round(${Each_Min},${Mantissa_Digits})); "channel"="${Each_Header_Name} (Min)"; "unit"="${UnitCategory}"; "float"=1; "decimalmode"=${Mantissa_Digits}; };
          If (${UnitCategory} -Eq "Custom") { $Append_Result += @{ "customunit"="${Each_Header_Units}"; }; };
          $Append_Result += @{ "limitmode"=[int]${LimitMode}; };
          If (-Not ([String]::IsNullOrEmpty("${LimitMaxWarning}"))) { $Append_Result += @{ "limitmaxerror"="${LimitMaxWarning}"; }; };
          If (-Not ([String]::IsNullOrEmpty("${LimitMinWarning}"))) { $Append_Result += @{ "limitminerror"="${LimitMinWarning}"; }; };
          $Output_HashTable.prtg.result += ${Append_Result};
        }

        # Error - All values found to be empty, send error in the JSON body (instead of sending empty data)
        If (${EmptyValues} -GE 3) {
          $Output_HashTable = @{"prtg"=@{"error"=1;"text"="${ErrorMessage_HWiNFO}";};};
        }

        $Output_Json = (${Output_HashTable} | ConvertTo-Json -Depth 50 -Compress);

        # Handle invalid characters in sensor names - Note that PRTG does not function if certain unicode characters are in the filename (such as a degree symbol)
        $Output_Basename=(((("${Each_Header_Name}.${Each_Header_Units}.json").Split([System.IO.Path]::GetInvalidFileNameChars()) -join '_') -Replace "[^a-zA-Z0-9-_\[\]\(\)\+\.]","_") -Replace "\.\.",".");
        $Output_Fullpath=("${Logfile_Dirname_HWiNFO}\Sensors\${Output_Basename}");

        # Output the results to sensor-specific files
        Set-Content -LiteralPath ("${Output_Fullpath}") -Value ("${Output_Json}") -NoNewline;

      }

    }

  }

}


## ------------------------------------------------------------
##
## Get the latest sensor data from "HWiNFO64" via "Remote Sensor Monitor"
##  |
##  |--> Setup HWiNFO:
##        > Download HWiNFO:  https://www.hwinfo.com/download/
##         > Subscribe to HWiNFO to get a Personal License ($25.00 as of 05-Jan-2023)
##        > Download Remote Sensor Monitor:  https://www.hwinfo.com/forum/threads/introducing-remote-sensor-monitor-a-restful-web-server.1025/
##        > Setup a Scheduled Task to run HWiNFO & Remote Sensor Monitor at machine startup (not logon)
#
# If ($False) {
#
#   $RSM_Dirname="C:\ISO\RemoteSensorMonitor";
#
#   $DefaultHost="localhost";
#
#   $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
#   $DefaultPort=(Get-Content "${RSM_Dirname}\DefaultPort.txt" -EA:0);
#   $ErrorActionPreference = $EA_Bak;
#
#   If (-Not ([String]::IsNullOrEmpty("${DefaultPort}"))) {
#
#     $ProgressPreference=0;
#
#     # Pull the latest sensor data from "Remote Sensor Monitor"
#     $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
#     $RSM_ResponseObj = (Invoke-WebRequest -UseBasicParsing -Uri ([String]::Format("http://${DefaultHost}:${DefaultPort}")));
#     $RSM_RawContent = (${RSM_ResponseObj}.RawContent);
#     $ErrorActionPreference = $EA_Bak;
#
#     # Parse the JSON response
#     $RSM_RawJSON = (("${RSM_RawContent}".Split("`n") | Select-String -Pattern '^[\s\]\[\{\}]') -join "`n");
#     $RSM_JsonObj = (ConvertFrom-Json -InputObject (${RSM_RawJSON}));
#
#     # Fallback parsing method
#     If ((${RSM_JsonObj}.Length) -Eq 0) {
#       $RegexPattern_JsonBody='\n((\[(\n|.)+\n\])|(\{(\n|.)+\n\}))';
#       If (([Regex]::Match("${RSM_RawContent}","${RegexPattern_JsonBody}").Success) -Eq $True) {
#         $RSM_JsonObj=(([Regex]::Match("${RSM_RawContent}","${RegexPattern_JsonBody}").Captures.Groups[1].Value) | ConvertFrom-Json);
#       }
#     }
#
#     # Check if a valid response was received
#     If ((-Not ([String]::IsNullOrEmpty("${RSM_RawContent}"))) -And ((${RSM_JsonObj}.Count) -GT 1)) {
#
#       # Get local hardware info (for sensor parsing)
#       $Win32_BaseBoard = (Get-CimInstance -ClassName "Win32_BaseBoard");
#       $MotherboardModel = (${Win32_BaseBoard}.Product);  # Motherboard Model
#       If ([String]::IsNullOrEmpty("${MotherboardModel}")) {
#         $MotherboardModel = "${env:COMPUTERNAME}";
#         If ([String]::IsNullOrEmpty("${MotherboardModel}")) {
#           $MotherboardModel = "ERROR - INVALID MOBO MODEL";
#         }
#       }
#
#       # Walk through each item in the JSON response
#       ${RSM_JsonObj} | ForEach-Object {
#
#         # Parse each sensor object
#         $SensorApp = ($_.SensorApp);
#         $SensorClass = ($_.SensorClass);
#         $SensorName = ($_.SensorName);
#         $SensorValue = ($_.SensorValue);
#         $SensorUnit = ($_.SensorUnit);
#         $SensorUpdateTime = ($_.SensorUpdateTime);
#
#         # ------------------------------
#         #
#         # Processor (CPU) Readings
#         #
#         If (${SensorClass} -Match "^CPU \[[^\[]+\]: ") {
#
#           Write-Host "CPU SENSOR:  [${SensorName}]";
#
#                 If (${SensorName} -Match "^Core Clocks$") {                   $Clock_CPU_Core.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Total CPU Usage$") {               $Load_CPU_Core.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^CPU Package Power$") {             $Power_CPU_Package.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^CPU Die \(average\)$") {           $Temp_CPU_Core.HWiNFO=(${SensorValue}); # Averaged temp
#         # } ElseIf (${SensorName} -Match "^CPU \(Tctl\/Tdie\)$") {            $Temp_CPU_Core.HWiNFO=(${SensorValue}); # Highest temp
#         # } ElseIf (${SensorName} -Match "^Core Temperatures$") {             $Temp_CPU_Core.HWiNFO=(${SensorValue}); # Aggregated Avg Temp
#           } ElseIf (${SensorName} -Match "^CPU Core Voltage \(SVI2 TFN\)$") { $Voltage_CPU_Core.HWiNFO=(${SensorValue});
#           }
#
#         # ------------------------------
#         #
#         # Graphics Card (GPU) Readings
#         #
#         } ElseIf (${SensorClass} -Match "^GPU \[[^\[]+\]: ") {
#
#           Write-Host "GPU SENSOR:  [${SensorName}]";
#
#                 If (${SensorName} -Match "^GPU Clock") {                     $Clock_GPU_Core.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Memory Clock") {              $Clock_GPU_Memory.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Core Load") {                 $Load_GPU_Core.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Memory Controller Load") {    $Load_GPU_MemoryController.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Memory Usage") {              $Load_GPU_MemoryUsage.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Power") {                     $Power_GPU_Total.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Temperature") {               $Temp_GPU_Core.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Hot Spot Temperature") {      $Temp_GPU_Hotspot.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU Core Voltage$") {             $Voltage_GPU_Core.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^GPU PCIe \+12V Input Voltage$") { $Voltage_GPU_PCIE_12V.HWiNFO=(${SensorValue});
#           }
#
#         # ------------------------------
#         #
#         # Memory (RAM) Readings
#         #
#         } ElseIf (${SensorClass} -Match "^(Memory Timings)|(DIMM)") {
#
#           Write-Host "MEMORY SENSOR:  [${SensorName}]";
#
#                 If (${SensorName} -Match "^Memory Clock") {          $Clock_RAM_DIMMS.HWiNFO=(${SensorValue});  # Effective data rate is twice this value
#           } ElseIf (${SensorName} -Match "^DIMM\[0\] Temperature") { $Temp_RAM_DIMM_0.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^DIMM\[1\] Temperature") { $Temp_RAM_DIMM_1.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^DIMM\[2\] Temperature") { $Temp_RAM_DIMM_2.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^DIMM\[3\] Temperature") { $Temp_RAM_DIMM_3.HWiNFO=(${SensorValue});
#           }
#
#         # ------------------------------
#         #
#         # Motherboard (Mobo) Readings
#         #
#         } ElseIf (${SensorClass} -Match "${MotherboardModel}") {
#
#           Write-Host "MOBO SENSOR:  [${SensorName}]";
#
#                 If (${SensorName} -Match "^Chipset") {       $Temp_Motherboard_PCH_CHIPSET.HWiNFO=(${SensorValue});
#         # } ElseIf (${SensorName} -Match "\(PCH\)") {        $Temp_Motherboard_PCH_CHIPSET.HWiNFO=(${SensorValue});
#         # } ElseIf (${SensorName} -Match "^Motherboard$") {  $Temp_Motherboard_T_SENSOR.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^T_Sensor$") {     $Temp_Motherboard_T_SENSOR.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^3VCC") {          $Voltage_Motherboard_03V.HWiNFO=(${SensorValue});  # +3.3V PSU Voltage
#           } ElseIf (${SensorName} -Match "^\+5V") {          $Voltage_Motherboard_05V.HWiNFO=(${SensorValue});  # +5V PSU Voltage
#           } ElseIf (${SensorName} -Match "^\+12V") {         $Voltage_Motherboard_12V.HWiNFO=(${SensorValue});  # +12V PSU Voltage
#           } ElseIf (${SensorName} -Match "^VBAT") {          $Voltage_Motherboard_VBAT.HWiNFO=(${SensorValue}); # CMOS Battery Voltage
#         # } ElseIf (${SensorName} -Match "^AUXFANIN4$") {    $Speed_FAN_RPM_AIO_PUMP.HWiNFO=(${SensorValue});   # ???
#           } ElseIf (${SensorName} -Match "^AIO Pump$") {     $Speed_FAN_RPM_AIO_PUMP.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Chassis1$") {     $Speed_FAN_RPM_CHA_FAN1.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Chassis2$") {     $Speed_FAN_RPM_CHA_FAN2.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Chassis3$") {     $Speed_FAN_RPM_CHA_FAN3.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Chipset Fan$") {  $Speed_FAN_RPM_CHIPSET.HWiNFO=(${SensorValue});
#         # } ElseIf (${SensorName} -Match "^CPU$") {          $Speed_FAN_RPM_CPU.HWiNFO=(${SensorValue});
#         # } ElseIf (${SensorName} -Match "^CPU_OPT$") {      $Speed_FAN_RPM_CPU_OPT.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^W_PUMP\+$") {     $Speed_FAN_RPM_W_PUMP.HWiNFO=(${SensorValue});
#           }
#
#         # ------------------------------
#         #
#         # Network Interface Card (NIC) Readings
#         #
#         } ElseIf (${SensorClass} -Match "^Network: ") {
#
#           #       If (${SensorName} -Match "^Total DL") {        $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^Total UP") {        $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^Current DL rate") { $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^Current UP rate") { $_____.HWiNFO=(${SensorValue});
#           # }
#
#         # ------------------------------
#         #
#         # Storage Disk (HDD/SSD) Readings
#         #
#         } ElseIf (${SensorClass} -Match "(Drive)|(S\.M\.A\.R\.T)") {
#
#           Write-Host "SSD SENSOR:  [${SensorName}]";
#
#                 If (${SensorName} -Match "^Drive Temperature") {    $Temp_SSD.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Drive Remaining Life") { $Lifespan_SSD_RemainingLife.HWiNFO=(${SensorValue});
#           } ElseIf (${SensorName} -Match "^Total Host Writes") {    $Lifespan_SSD_TotalWrites.HWiNFO=(${SensorValue});
#           }
#
#         # ------------------------------
#         #
#         # Uninterruptible Power Supply (UPS) Readings
#         #
#         } ElseIf (${SensorClass} -Match "^UPS$") {
#
#           #       If (${SensorName} -Match "^Battery Voltage") {                         $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^Input Voltage") {                           $_____.HWiNFO=(${SensorValue});
#           # } ElseIf ((${SensorName} -Match "^UPS Load") -And (${SensorUnit} -Eq "W")) { $_____.HWiNFO=(${SensorValue});
#           # } ElseIf ((${SensorName} -Match "^UPS Load") -And (${SensorUnit} -Eq "%")) { $_____.HWiNFO=(${SensorValue});
#           # } ElseIf ((${SensorName} -Match "^AC Power") -And (${SensorUnit} -Eq "%")) { $_____.HWiNFO=(${SensorValue});
#           # }
#
#         # ------------------------------
#         #
#         # Windows Readings
#         #
#         } ElseIf (${SensorClass} -Match "^((System)|(Windows ))") {
#
#           #       If (${SensorName} -Match "^Virtual Memory Load") {  $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^Physical Memory Load") { $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^Page File Usage") {      $_____.HWiNFO=(${SensorValue});
#           # }
#
#         # ------------------------------
#         #
#         # Fallthrough Readings
#         #
#         } Else {
#
#           #       If (${SensorName} -Match "^_____") { $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^_____") { $_____.HWiNFO=(${SensorValue});
#           # } ElseIf (${SensorName} -Match "^_____") { $_____.HWiNFO=(${SensorValue});
#           # }
#
#         }
#
#         If ($False) {
#           # Output sensor data directly to file
#           # ------------------------------
#           # Handle invalid characters in sensor names
#           $Results_Basename=(("${SensorApp}.${SensorClass}.${SensorName}.txt").Split([System.IO.Path]::GetInvalidFileNameChars()) -join '_');
#           $Results_Fullpath=("${RSM_Dirname}\Sensors\${Results_Basename}");
#           # Output the results to sensor-specific files
#           If ([String]::IsNullOrEmpty(${SensorValue})) {
#             Set-Content -LiteralPath ("${Results_Fullpath}") -Value (":${ErrorMessage_HWiNFO}") -NoNewline;
#           } Else {
#             Set-Content -LiteralPath ("${Results_Fullpath}") -Value ("${SensorValue}:OK") -NoNewline;
#           }
#
#         }
#         # ------------------------------
#
#       }
#
#     }
#
#   }
#
# }
#
## ------------------------------------------------------------
## ------------------------------------------------------------
## ------------------------------------------------------------
##
## Get the latest sensor data from OHW (OpenHardwareMonitor) via its CSV logfile
## |
## |--> Setup Open Hardware Monitor (OHW):
##       > Download OHW:  https://openhardwaremonitor.org/downloads/
##       > Place OHW's downloaded files into directory "C:\ISO\OpenHardwareMonitor\" (modifiable, below - see variable "${Logfile_Dirname_OHW}")
##       > Setup CSV logging in OHW via "Options" > "Log Sensors" (will have a checkmark next to it if actively logging to CSV)
##       > Setup a Scheduled Task to run OpenHardwareMonitor at machine startup (not logon)
#
# If ($True) {
#
#   # Parse CSV logs output from OHW (Open Hardware Monitor)
#   $Logfile_Dirname_OHW = "C:\ISO\OpenHardwareMonitor";
#   $Logfile_Input_StarsWith_OHW = "OpenHardwareMonitorLog-";
#   $Logfile_Input_FullPath_OHW = "${Logfile_Dirname_OHW}\${Logfile_Input_StarsWith_OHW}$(Get-Date -UFormat '%Y-%m-%d').csv";
#   If ((Test-Path -PathType "Leaf" -Path ("${Logfile_Input_FullPath_OHW}") -ErrorAction ("SilentlyContinue")) -Eq $False) {
#
#     $ErrorMessage_OHW="ERROR - Open Hardware Monitor logfile not found: ${Logfile_Input_FullPath_OHW}";
#
#   } Else {
#
#     # Ensure output directories exist
#     $EnsureDirExists = "${Logfile_Dirname_OHW}";         If ((Test-Path "${EnsureDirExists}") -NE $True) { New-Item -ItemType ("Directory") -Path ("${EnsureDirExists}") | Out-Null; };
#     $EnsureDirExists = "${Logfile_Dirname_OHW}\Sensors"; If ((Test-Path "${EnsureDirExists}") -NE $True) { New-Item -ItemType ("Directory") -Path ("${EnsureDirExists}") | Out-Null; };
#
#     $RowCount_HeaderRows=(2);
#     $RowCount_DataRows=(60);
#
#     $LogContent_HeaderRows = (Get-Content -Path ("${Logfile_Input_FullPath_OHW}") -TotalCount (${RowCount_HeaderRows}));
#
#     $CsvImport = @{};
#     ${CsvImport}["Descriptions"] = (@("$($LogContent_HeaderRows[1])").Split(","));
#     ${CsvImport}["Paths"] = (@("$($LogContent_HeaderRows[0])").Split(","));
#     ${CsvImport}["Paths"][0]="Time";  # OHW leaves the first row's first column blank for whatever reason
#
#     # Avoid random bug where OHW doesn't grab the GPU correctly at logfile creation time, which combines with OHW matching the headers on an existing log's data after said bugged run, which truncates all future data which is in addition to an existing log's header columns (truncates GPU data if GPU data wasn't pulled at time of log creation)
#     $RequiredPath="gpu";
#     If (((${CsvImport}["Paths"] | Where-Object { "${_}" -Like "*${RequiredPath}*" }).Count) -Eq (0)) {
#       # Reset any logged data from a previous run
#       Get-ChildItem -Path ("${Logfile_Dirname_OHW}\Sensors") -File -Recurse -Force -EA:0 `
#         | Where-Object { ($_.Name -Like "*.txt") } `
#         | ForEach-Object { Set-Content -LiteralPath ($_.FullName) -Value (":${ErrorMessage_OHW}") -NoNewline; } `
#       ;
#       # Rename the logfile - Allow OHW to recreate the logfile with updated headers (including (namely) missing gpu header columns)
#       $Dirname = [IO.Path]::GetDirectoryName("${Logfile_Input_FullPath_OHW}");
#       $Basename = [IO.Path]::GetFileNameWithoutExtension("${Logfile_Input_FullPath_OHW}");
#       $Extension = [IO.Path]::GetExtension("${Logfile_Input_FullPath_OHW}");
#       ${Logfile_Renamed_MissingHeaders}=("${Dirname}\${Basename}_MISSING-[${RequiredPath}]-HEADERS_$(Get-Date -Format 'yyyyMMddTHHmmss.fff')${Extension}");
#       Move-Item -Path ("${Logfile_Input_FullPath_OHW}") -Destination ("${Logfile_Renamed_MissingHeaders}") -Force;
#       # End the current run (pick it up later when there's a valid CSV logfile to parse)
#       Exit 1;
#     }
#
#     $LogContent_DataAndHeaderCheck=(Get-Content -Path ("${Logfile_Input_FullPath_OHW}") -Tail (${RowCount_DataRows}+${RowCount_HeaderRows}));
#     $LogContent_DataRows=(${LogContent_DataAndHeaderCheck} | Select-Object -Last ((${LogContent_DataAndHeaderCheck}.Count)-${RowCount_HeaderRows}));
#
#     $DataRows_SensorReadings=@();
#
#     $GetCulture=(Get-Culture);  # Get the system's display format of items such as numbers
#
#     For ($i=0; $i -LT ((${CsvImport}["Paths"]).Count); $i++) {
#
#       $Each_HeaderPath=(${CsvImport}["Paths"][$i]);
#       $Each_HeaderDescription=(${CsvImport}["Descriptions"][$i]);
#       $Updated_HeaderDescription=("");
#
#       # ------------------------------
#       # OHW outputs descriptions which are non-unique - update them to be unique, instead
#       # ------------------------------
#       #
#       # Mobo Readings
#       #
#       If (${Each_HeaderPath} -Match "lpc/.+/control/") {
#         $Updated_HeaderDescription=("Mobo Fans (% PWM), ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "lpc/.+/fan/") {
#         $Updated_HeaderDescription=("Mobo Fans (RPM), ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "lpc/.+/voltage/") {
#         $Updated_HeaderDescription=("Mobo Voltages, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "lpc/.+/temperature/") {
#         $Updated_HeaderDescription=("Mobo Temps, ${Each_HeaderDescription}");
#
#       # ------------------------------
#       #
#       # Processor (CPU) Readings
#       #
#       } ElseIf (${Each_HeaderPath} -Match "cpu/.+/load/") {
#         $Updated_HeaderDescription=("CPU Load, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "cpu/.+/power/") {
#         $Updated_HeaderDescription=("CPU Power, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "cpu/.+/temperature/") {
#         $Updated_HeaderDescription=("CPU Temps, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "cpu/.+/clock/") {
#         $Updated_HeaderDescription=("CPU Clocks, ${Each_HeaderDescription}");
#
#       # ------------------------------
#       #
#       # Memory (RAM) Readings
#       #
#       } ElseIf (${Each_HeaderPath} -Match "/ram/load/") {
#         $Updated_HeaderDescription=("RAM Load, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "/ram/data/") {
#         $Updated_HeaderDescription=("RAM Data, ${Each_HeaderDescription}");
#
#       # ------------------------------
#       #
#       # Graphics Card (GPU) Readings
#       #
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/temperature/") {
#         $Updated_HeaderDescription=("GPU Temps, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/clock/") {
#         $Updated_HeaderDescription=("GPU Clocks, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/control/") {
#         $Updated_HeaderDescription=("GPU Fan (% PWM), ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/fan/") {
#         $Updated_HeaderDescription=("GPU Fan (RPM), ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/smalldata/") {
#         $Updated_HeaderDescription=("GPU Memory, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/load/") {
#         $Updated_HeaderDescription=("GPU Load, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/power/") {
#         $Updated_HeaderDescription=("GPU Power, ${Each_HeaderDescription}");
#
#       } ElseIf (${Each_HeaderPath} -Match "gpu/.+/throughput/") {
#         $Updated_HeaderDescription=("GPU Rx/Tx, ${Each_HeaderDescription}");
#
#       # ------------------------------
#       #
#       # Storage Disk (HDD/SSD) Readings
#       #
#       } ElseIf (${Each_HeaderPath} -Match "hdd/.+/load/") {
#         $Updated_HeaderDescription=("Disk Load, ${Each_HeaderDescription}");
#
#       # ------------------------------
#       }
#
#       If ("${Updated_HeaderDescription}" -NE "") {
#         ${CsvImport}["Descriptions"][$i]=("${Updated_HeaderDescription}");
#       }
#
#     }
#
#     # ------------------------------
#     #
#     # Store the sensor values into an object organized by header names
#     #
#
#     For ($i_Row=-1; $i_Row -GE (-1 * ${LogContent_DataRows}.Count); $i_Row--) {
#       # Walk through the last minute's worth of sensor data stored in the CSV logfile
#       $Each_DataRow=(${LogContent_DataRows}[$i_Row] -Split ",");
#       $Each_Row_SensorReadings = @{"Time"=(${Each_DataRow}[0][0]);};
#       For ($i_Column=0; $i_Column -LT (${CsvImport}["Paths"].Count); $i_Column++) {
#         # Walk through each column on each row
#         $Each_ColumnHeader = (${CsvImport}["Paths"][${i_Column}]);
#         If (-Not ([String]::IsNullOrEmpty("${Each_ColumnHeader}"))) {
#           # Only parse columns that have an indentifying header
#           $Each_StringValue=(${Each_DataRow}[${i_Column}] -Replace "`"", "");
#           $Each_Value=0.0;
#           If (${i_Column} -Eq 0) {
#             # Convert [String] to [DateTime] w/o throwing an error
#             $Each_Value=(Get-Date -Date (${Each_StringValue}) -UFormat ("%s"));
#           } Else {
#             # Convert [String] to [Decimal] w/o throwing an error
#             If (([Decimal]::TryParse(${Each_StringValue}, [Globalization.NumberStyles]::Float, ${GetCulture}, [Ref]${Each_Value})) -Eq ($True)) {
#               # Do Nothing (String-to-Decimal conversion already performed in above "If" statement's conditional block
#             }
#           }
#           # Store each values into an object, push the object to an array (below), then calculate min/max later all-at-once
#           ${Each_Row_SensorReadings}.(${Each_ColumnHeader}) = (${Each_Value});
#         }
#       }
#       ${DataRows_SensorReadings} += ${Each_Row_SensorReadings};
#     }
#
#     # ------------------------------
#     #
#     # Calculate min/max/avg values from parsed sensor data
#     #
#
#     For ($i_Column=0; $i_Column -LT ((${CsvImport}["Paths"]).Count); $i_Column++) {
#
#       $Each_ColumnHeader = (${CsvImport}["Paths"][${i_Column}]);
#
#       $Each_MinMaxAvg = (${DataRows_SensorReadings}.(${Each_ColumnHeader}) | Measure-Object -Average -Maximum -Minimum);
#
#       $Each_SensorDescription = (${CsvImport}["Descriptions"][${i_Column}] -Replace "`"", "");
#
#       $Each_Value = @{};
#       ${Each_Value}.("Avg") = (${Each_MinMaxAvg}.Average);
#       ${Each_Value}.("Max") = (${Each_MinMaxAvg}.Maximum);
#       ${Each_Value}.("Min") = (${Each_MinMaxAvg}.Minimum);
#
#       # ------------------------------------------------------------
#
#       @("Avg","Max","Min") | ForEach-Object {
#
#         # ------------------------------
#
#         If (${Each_SensorDescription} -Eq "Time") {
#           ${Time_Range}.(${_}) = (Get-Date -Date ($((New-Object -Type DateTime -ArgumentList 1970,1,1,0,0,0,0).AddSeconds([Math]::Floor(${Each_Value}.(${_}))))) -UFormat ("%m/%d/%Y %H:%M:%S"));
#
#           # ------------------------------
#
#         } ElseIf (${Each_SensorDescription} -Eq "CPU Clocks, CPU Core #1") {
#           ${Clock_CPU_Core}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "CPU Load, CPU Total") {
#           ${Load_CPU_Core}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "CPU Power, CPU Cores") {
#           ${Power_CPU_Package}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "CPU Temps, CPU Package") {
#           ${Temp_CPU_Core}.(${_}) = (${Each_Value}.(${_}));
#
#           # ------------------------------
#
#         } ElseIf (${Each_SensorDescription} -Eq "GPU Load, GPU Core") {
#           ${Load_GPU_Core}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "GPU Power, GPU Power") {
#           ${Power_GPU_Total}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "GPU Temps, GPU Core") {
#           ${Temp_GPU_Core}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "GPU Load, GPU Memory") {
#           ${Load_GPU_MemoryUsage}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "GPU Clocks, GPU Core") {
#           ${Clock_GPU_Core}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "GPU Clocks, GPU Memory") {
#           ${Clock_GPU_Memory}.(${_}) = (${Each_Value}.(${_}));
#
#           # ------------------------------
#
#         # } ElseIf (${Each_SensorDescription} -Eq "Mobo Temps, Temperature #2") {
#         #   ${Temp_SSD}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #1") {  # Chassis Fan 1
#           ${Speed_FAN_RPM_CHA_FAN1}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #1") {  # Chassis Fan 1
#           ${Speed_FAN_PRC_CHA_FAN1}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #3") {  # Chassis Fan 2
#           ${Speed_FAN_RPM_CHA_FAN2}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #3") {  # Chassis Fan 2
#           ${Speed_FAN_PRC_CHA_FAN2}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #4") {  # Chassis Fan 3
#           ${Speed_FAN_RPM_CHA_FAN3}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #4") {  # Chassis Fan 3
#           ${Speed_FAN_PRC_CHA_FAN3}.(${_}) = (${Each_Value}.(${_}));
#           #
#           #     -  T_SENSOR = [ Chassis Fan 3 Current Speed (%) ] - [ Chassis Fan 3 Min. Duty Cycle (%) ] + [ Chassis Fan 3 Lower Temperature ]
#           #           ↓
#           #     -  T_SENSOR = [ Chassis Fan 3 Current Speed (%) ] - [ 55.0 ] + [ 15.0 ]
#           #           ↓
#           #     -  T_SENSOR = [ Chassis Fan 3 Current Speed (%) ] - [ 40.0 ]
#           #
#           $T_SENSOR_TEMP = ([Double](${Each_Value}.(${_})) - [Double](40.00));
#           If (${T_SENSOR_TEMP} -GT 0.0) {
#             ${Temp_Motherboard_T_SENSOR}.(${_}) = ${T_SENSOR_TEMP};
#           }
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (RPM), Fan #6") {  # W_PUMP+
#           ${Speed_FAN_RPM_W_PUMP}.(${_}) = (${Each_Value}.(${_}));
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Fans (% PWM), Fan Control #6") {  # W_PUMP+
#           ${Speed_FAN_PRC_W_PUMP}.(${_}) = (${Each_Value}.(${_}));
#
#           # ------------------------------
#
#         } ElseIf (${Each_SensorDescription} -Eq "Mobo Voltages, 3VCC") {  # + 3.3V PSU voltage
#           ${Voltage_Motherboard_03V}.(${_}) = (${Each_Value}.(${_}));
#
#           # ------------------------------
#
#         }
#
#       }
#
#     }
#
#   }
#
# }
#
## ------------------------------------------------------------
##
## Get the latest sensor data from NVIDIA's standalone EXE: "nvidia-smi.exe"
##
#
#  If ($False) {
#
#   $FullPath_Exe = "C:\Program Files\NVIDIA Corporation\NVSMI\nvidia-smi.exe";  # nvidia-smi.exe is NVIDIA's "System Management Interface (SMI)" tool which allows for command-line parameters to specify intended output
#
#   $Dirname_RevertTo = ((Get-Location).Path);
#
#   $Dirname_Exe = (Split-Path -Path ("${FullPath_Exe}") -Parent);
#
#   Set-Location -Path ("${Dirname_Exe}");
#
#   $Load_GPU_Core = (nvidia-smi.exe --query-gpu=utilization.gpu --format="csv,nounits,noheader" --id=0);
#
#   # $Temp_GPU_Core = (nvidia-smi.exe --query-gpu=temperature.gpu --format="csv,nounits,noheader" --id=0);
#
#   Set-Location -Path ("${Dirname_RevertTo}");
#
# }
#
## ------------------------------------------------------------
##
## Get the latest sensor data from local disk's S.M.A.R.T. values (if no value exists for it already)
##
#
# If (([String]::IsNullOrEmpty(${Temp_SSD}.Avg)) -Or ([String]::IsNullOrEmpty(${Temp_SSD}.Max)) -Or ([String]::IsNullOrEmpty(${Temp_SSD}.Min))) {
#   $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
#   $SSD_SMART_Temperature = (Get-Disk | Get-StorageReliabilityCounter | Where-Object { $_.DeviceId -Eq 0; } | Select-Object -ExpandProperty "Temperature");
#   $ErrorActionPreference = $EA_Bak;
#   If ([String]::IsNullOrEmpty(${Temp_SSD}.Avg)) {
#     ${Temp_SSD}.Avg = (${SSD_SMART_Temperature});
#   }
#   If ([String]::IsNullOrEmpty(${Temp_SSD}.Max)) {
#     ${Temp_SSD}.Max = (${SSD_SMART_Temperature});
#   }
#   If ([String]::IsNullOrEmpty(${Temp_SSD}.Min)) {
#     ${Temp_SSD}.Min = (${SSD_SMART_Temperature});
#   }
# }
#
# ------------------------------
#
# Cleanup Old Logfiles - HWiNFO
#

If ($True) {
  $Retention_Days = "7";
  $Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
  $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
  Get-ChildItem -Path "${Logfile_Dirname_HWiNFO}" -File -Recurse -Force `
    | Where-Object { ($_.Name -Like "${Logfile_Input_StarsWith_HWiNFO}*") } `
    | Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
    | Remove-Item -Recurse -Force -Confirm:$False `
  ;
  $ErrorActionPreference = $EA_Bak;
}

## ------------------------------
##
## Cleanup Old Logfiles - OHW
##
#
# If ($True) {
#   $Retention_Days = "7";
#   $Retention_OldestAllowedDate = (Get-Date).AddDays([int]${Retention_Days} * -1);
#   $EA_Bak = $ErrorActionPreference; $ErrorActionPreference = 0;
#   Get-ChildItem -Path "${Logfile_Dirname_OHW}" -File -Recurse -Force `
#     | Where-Object { ($_.Name -Like "${Logfile_Input_StarsWith_OHW}*") } `
#     | Where-Object { $_.LastWriteTime -LT ${Retention_OldestAllowedDate} } `
#     | Remove-Item -Recurse -Force -Confirm:$False `
#   ;
#   $ErrorActionPreference = $EA_Bak;
# }
#
# ------------------------------
#
# # Benchmark (KEEP AS FINAL RUNTIME (e.g. keep at the very very end of this script)
#
# $Benchmark.Stop();
# $RunDuration=("$(${Benchmark}.Elapsed)");
# If ([String]::IsNullOrEmpty("${RunDuration}")) {
#   Write-Output ":${ErrorMessage_OHW}" | Out-File -NoNewline "${Logfile_Dirname_OHW}\Sensors\RunDuration.txt";
# } Else {
#   Write-Output "${RunDuration}:OK" | Out-File -NoNewline "${Logfile_Dirname_OHW}\Sensors\RunDuration.txt";
# }
#
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
#   math.stackexchange.com  |  "terminology - What are the numbers before and after the decimal point referred to in mathematics? - Mathematics Stack Exchange"  |  https://math.stackexchange.com/a/64045
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
#   stackoverflow.com  |  "powershell - How to strip illegal characters before trying to save filenames? - Stack Overflow"  |  https://stackoverflow.com/a/52528107
#
#   stackoverflow.com  |  "powershell max/first/aggregate functions - Stack Overflow"  |  https://stackoverflow.com/a/19170783
#
#   www.hwinfo.com  |  "CPU temp sensors explanation | HWiNFO Forum"  |  https://www.hwinfo.com/forum/threads/cpu-temp-sensors-explanation.5597/
#
#   www.paessler.com  |  "Custom Sensors | PRTG Manual"  |  https://www.paessler.com/manuals/prtg/custom_sensors#advanced_elements
#
#   www.paessler.com  |  "PRTG Manual: Custom Sensors - Standard EXE/Script Sensor"  |  https://www.paessler.com/manuals/prtg/custom_sensors#standard_exescript
#
# ------------------------------------------------------------