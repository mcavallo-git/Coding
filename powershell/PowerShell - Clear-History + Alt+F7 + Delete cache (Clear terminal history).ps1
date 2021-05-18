# ------------------------------------------------------------
#
# PowerShell - Clear command prompt history/cache
#
# ------------------------------------------------------------

<# Step 1 #>
	Clear-History; Remove-Item -Path "$((Get-PSReadlineOption).HistorySavePath)" -Force; Clear-Host;

<# Step 2 #>
	<# Press combo-keypress ALT+F7 #>


# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "PowerShell's Clear-History doesn't clear history - Stack Overflow"  |  https://stackoverflow.com/a/36900056
#
#		www.majorgeeks.com  |  "How to View, Save, and Clear Your PowerShell and Command Prompt History - MajorGeeks"  |  https://www.majorgeeks.com/content/page/how_to_viewsaveand_clear_your_powershell_and_command_prompt_history.html
#
# ------------------------------------------------------------