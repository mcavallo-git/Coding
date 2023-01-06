
# ------------------------------------------------------------
#
# Set-Variable
#  |
#  |--> Ex) Set the variable  [ $IsLinux ]  (if it isn't already set)
#


SV IsLinux $(If ((Test-Path '/bin') -And (-Not (Test-Path '/Library'))) { 1 } Else { 0 });

# #  ^
# #  Methods BOTH set variable $IsLinux with the same value, but the bottom approach adds the functionality of making $IsLinux a global, read-only variable
# #  v

If (-Not (Get-Variable -Name 'IsLinux' -ErrorAction 'SilentlyContinue')) {
	Set-Variable -Name 'LinuxDirsExist' -Value (0);
	If ((Test-Path '/bin') -And (-Not (Test-Path '/Library'))) {
		Set-Variable -Name 'LinuxDirsExist' -Value (1);
	};
	Set-Variable -Name 'IsLinux' -Scope 'Global' -Visibility 'Public' -Option 'ReadOnly, AllScope' -Value ((Get-Variable -Name 'LinuxDirsExist').Value);
}


# ------------------------------------------------------------
#
# Get-Variable
#  |
#  |--> Ex) Get the value held by variable [ $IsLinux ]
#

(GV IsLinux).Value;

(Get-Variable IsLinux).Value;

(Get-Variable -Name 'IsLinux').Value;


# Note: You may also set object-properties by using Get-Variable (see the following example)
Set-Variable -Name 'URL' -Value 'http://google.com';
Set-Variable -Name 'HTTP_Request' -Value ([System.Net.WebRequest]::Create((Get-Variable -Name 'URL').Value));
((Get-Variable -Name 'HTTP_Request').Value).Timeout=5000;
Set-Variable -Name 'HTTP_Response' -Value (((Get-Variable -Name 'HTTP_Request').Value).GetResponse());
Set-Variable -Name 'HTTP_Status' -Value ([Int]((Get-Variable -Name 'HTTP_Response').Value).StatusCode);


# ------------------------------------------------------------
#
# Clear-Variable
#  |
#  |--> Deletes the value of a variable & KEEPS the variable reference.
#  |
#  |--> Ex) Delete the value-of variable [ $IsLinux ]
#

Clear-Variable -Name 'IsLinux';

If (Get-Variable -Name 'IsLinux' -ErrorAction 'SilentlyContinue') { 1 } Else { 0 };  # <-- Returns 1 because the variable still exists


# ------------------------------------------------------------
#
# Remove-Variable
#  |
#  |--> Deletes the value of a variable & DELETES the variable reference.
#  |
#  |--> Ex) Delete the value-of AND unset variable [ $IsLinux ]
#

Remove-Variable -Name 'IsLinux';

If (Get-Variable -Name 'IsLinux' -ErrorAction 'SilentlyContinue') { 1 } Else { 0 };  # <-- Returns 0 because the variable no-longer exists


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Clear-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/clear-variable?view=powershell-5.1
#
#   docs.microsoft.com  |  "Get-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/remove-variable?view=powershell-5.1
#
#   docs.microsoft.com  |  "Remove-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/get-variable?view=powershell-5.1
#
#   docs.microsoft.com  |  "Set-Variable (Microsoft.PowerShell.Utility) - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/set-variable?view=powershell-5.1
#
# ------------------------------------------------------------