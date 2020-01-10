
### Determine if target path is a Symbolic Link
If ((Get-Item "${Home}\Documents").Attributes.ToString() -Match "ReparsePoint") {
	Write-Host 	"Is a Symbolic Link / MKLink";
} Else {
	Write-Host 	"Is NOT a Symbolic Link / MKLink";
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   thomasrayner.ca  |  "Quick Tip - Use PowerShell To Detect If A Location Is A Directory Or A Symlink – Thomas Rayner – Writing code & automating IT"  |  https://thomasrayner.ca/quick-tip-use-powershell-to-detect-if-a-location-is-a-directory-or-a-symlink/
#
# ------------------------------------------------------------