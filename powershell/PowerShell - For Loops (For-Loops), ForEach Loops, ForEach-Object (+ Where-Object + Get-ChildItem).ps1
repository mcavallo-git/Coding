Exit 1;
# ------------------------------------------------------------
#
#   PowerShell - For(...) Loops
#
# ------------------------------------------------------------

#
# For(...) Loops
#   |--> General Syntax
#
###  For (<Init>; <Condition>; <Repeat>)
###  {
###    <Statement list>
###  }


#
# For(...) Loops
#   |--> Single Conditional (Example)
#
For ($i = 0; $i -LT 10; $i++) {
	Write-Host "`$i:$i";
}


#
# For(...) Loops
#   |--> Multiple Conditionals (Example)
#
For (($i = 0), ($j = 0); $i -LT 10 -And $j -LT 10; $i++, $j++) {
	Write-Host "`$i:$i";
	Write-Host "`$j:$j";
}


#
# For(...) Loops
#   |--> Based on size of array
#
$DatArray = @(1,"a",2,"b",3,"c");
For ($i=0; ($i -LT $DatArray.Count); $i++) {
	$EachItem = ($DatArray[${i}]);
	Write-Host "`$DatArray[${i}] = ${EachItem}";
}


#
# For(...) Loops
#   |--> Infinite Loop (Example)
#
For (;;) {
	Write-Host "Infinite Loop ( Ctrl+C to cancel )";
}


#
# ForEach file in folder
#   |--> Install multiple .NET Core/Framework SDKs as a batch job
#        (Downloaded from https://dotnet.microsoft.com/download/visual-studio-sdks)
#
Get-ChildItem -Path ("${Home}\Downloads\ASP.NET-SDKs\*.msi") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
| ForEach-Object { Start-Process -Filepath ($_.FullName) -ArgumentList (@("/q","/norestart")); };


# ------------------------------------------------------------

<# ARRAYS -> use  [ ForEach ] #>

<# Array Example #>
$Var=@('a','b','c','d','e','f');
If (($Var.GetType().Name -Eq "Object[]") -And ($Var.GetType().BaseType.Name -Eq "Array")) {
	ForEach ($EachItem In ${Var}) {
		Write-Host $EachItem;
	}
}

<# Array Example #>
$Var=(Get-Service);
If (($Var.GetType().Name -Eq "Object[]") -And ($Var.GetType().BaseType.Name -Eq "Array")) {
	ForEach ($EachItem In ${Var}) {
		Write-Host $EachItem;
	}
}

# ------------------------------------------------------------

<# OBJECTS -> use  [ ForEach-Object ]  #>
$Var=@{"YOUR"="VAR";"HERE"=".";};
If (($Var.GetType().Name -Eq "Hashtable") -And ($Var.GetType().BaseType.Name -Eq "Object")) {
	$Var | ForEach-Object {
		Write-Output "------------------------------------------------------------";
		$_ | Format-Table;
		Write-Output "------------------------------------------------------------";
	}
}

<#  HASH TABLES -> use  [ Get-Member + Where-Object + ForEach-Object ]  #>
$Var = ( '{"Key1String":"Val1","Key2String":"Val2","Key3Int":3,"Key4Int":4}' | ConvertFrom-JSON );
If ($Var.GetType().Name -Eq "PSCustomObject") {
	Get-Member -InputObject ($Var) -View ("All") `
	| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $True <# Matches *Property* and *Properties* #>; } `
	| ForEach-Object {
		$EACH_KEY = "$($_.Name)";
		If ($Var.(${EACH_KEY}) -eq $Null) {
			$EACH_VAL="`$Null";
		} Else {
			$EACH_VAL=$Var.(${EACH_KEY});
		}
		Write-Host "EACH_KEY=$($EACH_KEY)  ///  EACH_VAL=$($EACH_VAL)";
	};
}


# ForEach-Object using '.Keys' method to walk through an object by iterating through its property-names
$CommandString = $MyInvocation.MyCommand.Name;
$PSBoundParameters.Keys | ForEach-Object {
	$CommandString += " -$_";
	If (@('String','Integer','Double').Contains($($PSBoundParameters[$_]).GetType().Name)) {
		$CommandString += " `"$($PSBoundParameters[$_])`"";
	}
};
Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command `"$($CommandString)`"" -Verb RunAs;


# ------------------------------------------------------------
#
# PowerShell - While Loops
#
#   (SEE SEPARATE FILE - "PowerShell - While Loops.ps1" (or similar name)
#
# ------------------------------------------------------------
#
#	Get-ChildItem
#		PowerShell's [ Get-ChildItem ] command is essentially a equivalent to Linux's [ find ] command
#		(barring case-sensitivty by default & much more - just relating at a high-level)
#		
#		Parameters
#				-Directory		returns items with type "System.IO.FileSystemInfo.DirectoryInfo"   (see "DirectoryInfo Class", below)
#				-File					returns items with type "System.IO.FileSystemInfo.FileInfo"   (see "FileInfo Class", below)
#				-Filter				used to perform narrowed, more-specific searches than -Include (second-stage matching, essentially)
#				-Force				searches for hidden & non-hidden items   (may vary depending on provider - see "About Providers", below)
#				-Include			used to perform general searches, commonly with wildcards
#
#
# ------------------------------------------------------------
#
#		Example
#			|--> Overview: Find files with multiple different levels of depth, parent-filenames, basenames, etc. matching multiple different criteria, all in one query
#			|--> Use: Lock-Screen background fix - Used this script to locate files to-be-deleted
#
$Basename="*";
$Parent_1="Settings"; # one step back (first directory name)
$Parent_2="Microsoft.Windows.ContentDeliveryManager_*"; # another step back
$Parent_X="${Env:USERPROFILE}\AppData\Local\Packages\"; # remaining steps-back to the root directory ("/" in linux, or the drive letter, such as "C:\", in Windows)
(`
Get-ChildItem `
-Path ("$Parent_X") `
-Depth (3) `
-File `
-Recurse `
-Force `
-ErrorAction "SilentlyContinue" `
| Where-Object { $_.Directory.Parent.Name -Like "$Parent_2" } `
| Where-Object { $_.Directory.Name -Like "$Parent_1" } `
| Where-Object { $_.Name -Like "$Basename" } `
| ForEach-Object { $_.FullName; } `
);


# ------------------------------------------------------------
#
#		Example
#			|--> Overview: Search for any git-repositories located within the ${HOME} directory (same as %USERPROFILE% on cmd)
#			|--> Note: Syntax performs a lookup by beginning at the users ${HOME} directory and searching for files named "config" who have an immediate-parent directory named ".git"
#			|--> Use: Used for finding git-config files
#
Get-ChildItem -Path "${HOME}" -Filter "config" -File -Recurse -Force -ErrorAction "SilentlyContinue" | Where-Object { $_.Directory.Name -Eq ".git"} | Foreach-Object { $_.Directory.Parent.FullName; }


# ------------------------------------------------------------
#
#		Example
# 		|--> Overview: Search the main drive for files named 'gpg.exe'
#			|--> Note: On windows devices, "/" resolves to the systemdrive (commonly "C:") with a backslash ("\") appended, by default
#			|--> Use: Used for syncing all GnuPG (gpg.exe) configs found on a given workstation, so that they all contain the same config-vals (... e.g. 'synced')
#
Get-ChildItem -Path "/" -Filter "gpg.exe" -File -Recurse -Force -ErrorAction "SilentlyContinue" | Foreach-Object { $_.FullName; }


# ------------------------------------------------------------
#
#	Citation(s)
#
#   docs.microsoft.com  |  "about_For - PowerShell | Microsoft Docs"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_for?view=powershell-5.1
#
#   docs.microsoft.com  |  "about_Providers - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_providers
#
#   docs.microsoft.com  |  "about_Wildcards - PowerShell"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_wildcards
#
#   docs.microsoft.com  |  "DirectoryInfo Class (System.IO)"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.directoryinfo
#
#   docs.microsoft.com  |  "FileInfo Class (System.IO)"  |  https://docs.microsoft.com/en-us/dotnet/api/system.io.fileinfo
#
#   docs.microsoft.com  |  "ForEach-Object"  |  https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object
#
#   social.technet.microsoft.com  |  "sort-object multiple properties - use descending first RRS feed"  |  https://social.technet.microsoft.com/Forums/windowsserver/en-US/e2067689-d28b-4455-9a05-d933e31ab311/sortobject-multiple-properties-use-descending-first?forum=winserverpowershell
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
# ------------------------------------------------------------