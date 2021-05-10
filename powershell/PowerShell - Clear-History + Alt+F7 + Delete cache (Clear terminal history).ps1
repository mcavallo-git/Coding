# ------------------------------------------------------------
#
# PowerShell - Clear command prompt history/cache
#
# ------------------------------------------------------------

<# Step 1 #>
	<# Press combo-keypress ALT+F7 #>

<# Step 2 #>
	Clear-History;

<# Step 3/3 #>
	$HistoryCache = ((Get-PSReadlineOption).HistorySavePath); Remove-Item -Path ("${HistoryCache}") -Force;


# ------------------------------------------------------------
#
#	Citation(s)
#
#		stackoverflow.com  |  "PowerShell's Clear-History doesn't clear history - Stack Overflow"  |  https://stackoverflow.com/a/36900056
#
#		www.majorgeeks.com  |  "How to View, Save, and Clear Your PowerShell and Command Prompt History - MajorGeeks"  |  https://www.majorgeeks.com/content/page/how_to_viewsaveand_clear_your_powershell_and_command_prompt_history.html
#
# ------------------------------------------------------------