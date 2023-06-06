# ------------------------------------------------------------
# PowerShell - powercfg-parser (power options, parse output from powercfg.exe)
# ------------------------------------------------------------

If ($True) {
  $NL = "~~NEWLINE~~";
  $Powercfg_SchemeGuid = ([Regex]::Match((powercfg.exe /GETACTIVESCHEME),"Power Scheme GUID:\s+([0-9A-Fa-f]{8}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{12})\s+\(([^\)]+)\)") | ForEach-Object { ${_}.Groups[1].Value; });
  # $Powercfg_SchemeGuid = "SCHEME_CURRENT";
  $Powercfg_Query = (powercfg.exe /QUERY ${Powercfg_SchemeGuid});
  # ------------------------------
  # $Regex_PowerCfg_Parser="^\s{4}Power Setting GUID:\s+([0-9A-Fa-f]{8}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{12})\s+\(([^\)]+)\)\n(?:\s{6}\S[^\n]+\n)*\s{4}Current AC Power Setting Index:\s+(\S+)\n\s{4}Current DC Power Setting Index:\s+(\S+)$";
  # ------------------------------
  # Parse PowerCfg's output into an array of Power Settings
  $PowerSettingsArr = @();
  ((${PowercfgQuery} -join "${NL}") -split "${NL}    Power Setting GUID: ") | ForEach-Object {
    $Each_Repaired = "    Power Setting GUID: ${_}";
    $Each_Settings = ( ${Each_Repaired} -split "${NL}" );
    $Each_Props = @{};
    ${Each_Settings}.Trim() | ForEach-Object {
      If (${_} -Like "Power Setting GUID: *") {
        $Matches = [Regex]::Match(${_},"Power Setting GUID:\s+([0-9A-Fa-f]{8}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{4}[-]?[0-9A-Fa-f]{12})\s+\(([^\)]+)\)");
        ${Each_Props}["Power Setting GUID"] = ( ${Matches}.Groups[1].Value );
        ${Each_Props}["Description"] = ( ${Matches}.Groups[2].Value );
      } ElseIf (${_} -Like "Current AC Power Setting Index: *") {
        $Matches = [Regex]::Match(${_},"Current AC Power Setting Index:\s+(\S+)");
        ${Each_Props}["Current AC Power Setting Index"] = [Int]( ${Matches}.Groups[1].Value );
      } ElseIf (${_} -Like "Current DC Power Setting Index: *") {
        $Matches = [Regex]::Match(${_},"Current DC Power Setting Index:\s+(\S+)\s*$");
        ${Each_Props}["Current DC Power Setting Index"] = [Int]( ${Matches}.Groups[1].Value );
      } ElseIf (${_} -Like "Possible Settings units: *") {
        $Matches = [Regex]::Match(${_},"Possible Settings units:\s+(\S+)\s*$");
        ${Each_Props}["Possible Settings units"] = ( ${Matches}.Groups[1].Value );
        # (${_} -Split " ")[-1];
      }
    }
    If (-Not ([String]::IsNullOrEmpty(${Each_Props}["Power Setting GUID"]))) {
      ${PowerSettingsArr} += ${Each_Props};
    }
    Clear-Variable -Name ("Each_Props");
  }
  ${PowerSettingsArr} | ForEach-Object {
    Write-Host "------------------------------------------------------------";
    ${_} | Format-Table;
  }; Write-Host "------------------------------------------------------------";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   superuser.com  |  "Query current power config settings on Windows 7 - Super User"  |  https://superuser.com/a/1156120
#
# ------------------------------------------------------------