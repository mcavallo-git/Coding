
# Open Control Panel

$ControlPanelExe="${ENV:SystemRoot}\System32\control.exe";
. "${ControlPanelExe}";


# Open Windows Settings (to the 'Display' page)

$ControlPanelExe="${ENV:SystemRoot}\System32\control.exe";
$DisplaySettings="${ENV:SystemRoot}\System32\desk.cpl";
. "${ControlPanelExe}" "${DisplaySettings}";
