# ------------------------------------------------------------
#
# PowerShell - Try {...} Catch {...} Finally {...}
#
#
# ------------------------------------------------------------

If ($True) {
	# Enchance PowerShell's default error output
	Try {
		# Write-Host "[--- TRY BLOCK - BEGIN ---]" -ForegroundColor ("DarkGray");
		Example_InvalidCommand;
		# Write-Host "[--- TRY BLOCK - END ---]" -ForegroundColor ("DarkGray");
	} Catch {
		Write-Host "[--- CATCH BLOCK - BEGIN SHOWING EXCEPTION ---]" -ForegroundColor ("Red");
		Write-Host "";
		Write-Host "`$_.TargetObject:";
			Write-Host "$($_.TargetObject)" -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "`$_.Exception.Message:";
			Write-Host "$($_.Exception.Message)" -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "`$_.InvocationInfo.PositionMessage:";
			Write-Host "$($_.InvocationInfo.PositionMessage)" -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "`$_.CategoryInfo:";
			Write-Host "$($_.CategoryInfo)" -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "`$_.FullyQualifiedErrorId:";
			Write-Host "$($_.FullyQualifiedErrorId)" -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "`$_.Exception.StackTrace:";
			Write-Host "$($_.Exception.StackTrace)" -ForegroundColor ("Yellow");
		Write-Host "";
		Write-Host "[--- CATCH BLOCK - END SHOWING EXCEPTION ---]" -ForegroundColor ("Red");
	} Finally {
		# Write-Host "[--- FINALLY BLOCK - BEGIN ---]" -ForegroundColor ("DarkGray");
		# Write-Host "[--- FINALLY BLOCK - END ---]" -ForegroundColor ("DarkGray");
	}
}


# ------------------------------------------------------------

# Example - Simple check of a given property on a registry key

Try {
	$RegistryProp = Get-ItemProperty -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\" | Select-Object -ExpandProperty "Version" -ErrorAction Stop;
} Catch {
	$RegistryProp = $Null;
  Write-Host "An error occurred: ";
  Write-Host $_ -BackgroundColor "Black" -ForegroundColor "Yellow";
} Finally {
	If ($RegistryProp -NE $Null) {
		Write-Host "`$RegistryProp: "; $RegistryProp;
	} Else {
		Write-Host "`$RegistryProp is Null";
	}
}


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "About Try Catch Finally"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_try_catch_finally
#
#   jonathanmedd.net  |  "Testing for the Presence of a Registry Key and Value"  |  https://www.jonathanmedd.net/2014/02/testing-for-the-presence-of-a-registry-key-and-value.html
#
#   stackoverflow.com  |  "exception - Printing the error in try catch block in powershell - Stack Overflow"  |  https://stackoverflow.com/q/20619661
#
# ------------------------------------------------------------