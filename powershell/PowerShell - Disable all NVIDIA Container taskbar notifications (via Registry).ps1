# ------------------------------------------------------------
# PowerShell - Disable all NVIDIA Container taskbar notifications (via Registry)
# ------------------------------------------------------------

If ($True) {
  $RegistryKey_NotificationApps="Registry::HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Notifications\Settings";
  $RegistryProp_Name="Enabled";
  $RegistryProp_Type="DWord";
  $RegistryProp_Value=0;
  $RegexPattern="^Microsoft\.Explorer\.Notification\.\{[A-F0-9]{8}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{12}\}$";
  Get-ChildItem "${RegistryKey_NotificationApps}" `
  | Where-Object { ([Regex]::Match($_.PSChildName,"${RegexPattern}")).Success; } `
  | ForEach-Object {
    $Each_RegistryKey="Registry::$($_.Name)";
    Try {
      $Each_TestPropertyExists = (Get-ItemPropertyValue -LiteralPath ("${Each_RegistryKey}") -Name ("${RegistryProp_Name}") -ErrorAction ("Stop"));
    } Catch {
      $Each_TestPropertyExists = $Null;
    };
    If ($Null -eq $Each_TestPropertyExists) {
      If ($False) {
        <# DEBUGGING #> Write-Host "Creating property `"${RegistryProp_Name}`" under key ${Each_RegistryKey}...";
      }
      New-ItemProperty -Force -LiteralPath ("${Each_RegistryKey}") -Name ("${RegistryProp_Name}") -PropertyType (${RegistryProp_Type}) -Value (${RegistryProp_Value}) | Out-Null;
    }
  }
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.tenforums.com  |  "Turn On or Off Notifications from Apps and Senders in Windows 10 | Tutorials"  |  https://www.tenforums.com/tutorials/4111-turn-off-notifications-apps-senders-windows-10-a.html
#
# ------------------------------------------------------------