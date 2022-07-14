Exit 1;

# ------------------------------------------------------------
#
#   PowerShell - Iterating/Looping through iterations in PowerShell using:
#     For(...) {...}
#     ForEach-Object { ... }   (shorthand syntax "% { ... }")
#
# ------------------------------------------------------------

#
#   For(...) Loops   (iterative / integer based)
#


# General Syntax
For (<Init>; <Condition>; <Repeat>) {
	<Statement list>
}


# Single conditional for(...) loop  (based on static start/stop)
For ($i = 0; $i -LT 10; $i++) {
	Write-Host "`$i:$i";
}


# Single conditional for(...) loop  (based on dynamic start/stop)
$DatArray = @(1,"a",2,"b",3,"c");
For ($i=0; ($i -LT $DatArray.Count); $i++) {
	$EachItem = ($DatArray[${i}]);
	Write-Host "`$DatArray[${i}] = ${EachItem}";
}


# Multiple conditional for(...) loop
For (($i = 0), ($j = 0); $i -LT 10 -And $j -LT 10; $i++, $j++) {
	Write-Host "`$i:$i";
	Write-Host "`$j:$j";
}


# "Infinite" for(...) loop
For (;;) {
	Write-Host "Infinite Loop ( Ctrl+C to cancel )";
}


# ------------------------------------------------------------
#
#   PowerShell - Iterating/Looping through iterations in PowerShell using:
#     For(...) {...}
#     ForEach-Object { ... }   (shorthand syntax "% { ... }")
#
# ------------------------------------------------------------


<#   Arrays  @()   #>
$Var = @();
$Var += @("Value 1");
$Var += @("Value 2");
$Var += @("Value 3");
If (($Var.GetType().Name -Eq "Object[]") -And ($Var.GetType().BaseType.Name -Eq "Array")) {
	# Arrays - Option 1:  use [ ForEach-Object ]  (use if you DON'T need the iterator (array key) for each item)
	$Var | ForEach-Object {
		Write-Host "------------------------------";
		Write-Host "Each_Key=$("???")  ///  Each_Val=$(${_})";
	}
	# Arrays - Option 2:  use [ For ]  (use if you DO need the iterator (array key) for each item)
	For ($Each_Key=0; $Each_Key -LT $Var.Count; $Each_Key++) {
		Write-Host "------------------------------";
		Write-Host "Each_Key=$($Each_Key)  ///  Each_Val=$($Var[${Each_Key}])";
	}
}


# ------------------------------------------------------------

<#   Hash Tables  @{}  #>
$Var=@{};
$Var["Property 1"]="Value 1";
$Var["Property 2"]="Value 2";
$Var["Property 3"]="Value 3";
If (($Var.GetType().Name -Eq "Hashtable") -And ($Var.GetType().BaseType.Name -Eq "Object")) {
	$Var.Keys | ForEach-Object {
		Write-Host "------------------------------";
		Write-Host "Each_Key=$(${_})  ///  Each_Val=$($Var[${_}])";
	}
}


# ------------------------------------------------------------

<#   Sort a Hash Table @{}   #>
If ($True) {
$FTypes_Obj=@{};
CMD /C FTYPE | Sort-Object | ForEach-Object {
	$Components=("${_}".Split("="));
	$FileType=(${Components}[0]);
	$OpenCommandString=(${Components}[1..$(${Components}.Count)]);
	$FTypes_Obj.("${FileType}")=("${OpenCommandString}");
}
$FTypes_Sorted_Obj = ($FTypes_Obj.Keys | Sort-Object | ForEach-Object { @{"${_}"="$($FTypes_Obj.("${_}"))";}; });
Write-Host "------------------------------------------------------------";
$FTypes_Sorted_Obj | Format-Table -AutoSize;
<# !!! Note - This ends up as an an unusual hash table scenario, where it performs normally when you to reference the keys and values held within each key (by string value reference) ... #>
Write-Host "------------------------------------------------------------";
${FTypes_Sorted_Obj}.Keys[1];
$FTypes_Sorted_Obj.("$(${FTypes_Sorted_Obj}.Keys[1])");
<# But it ALSO allows you to reference its contained items by integer (iterator) reference as well, which does not commonly work with hash tables (by default) #>
Write-Host "------------------------------------------------------------";
$FTypes_Sorted_Obj.Item(1).Keys;
$FTypes_Sorted_Obj.Item(1).Values;
Write-Host "------------------------------------------------------------";
}


# ------------------------------------------------------------

<#   List a Hash Table w/ multiple properties (using Format-Table) via [PSCustomObject]  #>
If ($True) {
If (($Host) -And ($Host.UI) -And ($Host.UI.RawUI)) { $Host.UI.RawUI.BufferSize = (New-Object ((($Host.UI.RawUI).BufferSize).GetType().FullName) (16384, $Host.UI.RawUI.BufferSize.Height)); }; <# Update PowerShell console width to 16384 characters #>
$Assocs_Obj=@{};
$FTypes_Obj=@{};
CMD /C ASSOC | Sort-Object | ForEach-Object { $Components=("${_}".Split("=")); $Assocs_Obj.("$(${Components}[0])")=("$(${Components}[1..$(${Components}.Count)]);"); };
CMD /C FTYPE | Sort-Object | ForEach-Object { $Components=("${_}".Split("=")); $FTypes_Obj.("$(${Components}[0])")=("$(${Components}[1..$(${Components}.Count)]);"); };
$Assocs_Resolved_Obj=($Assocs_Obj.Keys | Sort-Object | ForEach-Object {
	$Assoc_Key = "${_}";
	$FType_Key = (${Assocs_Obj}.("${Assoc_Key}") -replace "^((?:(?!;).)+)(;)?$","`$1");
	$FType_Val = (${FTypes_Obj}.("${FType_Key}"));
	[PSCustomObject]@{"Assoc_Key"="${Assoc_Key}";"FType_Key"="${FType_Key}";"FType_Val"="${FType_Val}";};
});
<# Show [ ASSOC + FTYPE ] relationships #>
<# Sort/Organize based on the (DEFAULT) column [ Assoc_Key ] (such as ".txt" of ".js") #>
Write-Host "Sort/Organize based on the (DEFAULT) column [ Assoc_Key ] (such as `".txt`" of `".js`")";
$Assocs_Resolved_Obj | Sort-Object -Property Assoc_Key | Format-Table -AutoSize;
<# Sort/Organize based on the column [ FType_Key ] (such as "txtfile" of "JSFile") #>
Write-Host "Sort/Organize based on the column [ FType_Key ] (such as `"txtfile`" of `"JSFile`")";
$Assocs_Resolved_Obj | Sort-Object -Property FType_Key | Format-Table -AutoSize;
<# Sort/Organize based on the column [ FType_Val ] (such as "txtfile" of "JSFile") #>
Write-Host "Sort/Organize based on the column [ FType_Val ] (such as `"%SystemRoot%\system32\NOTEPAD.EXE %1;`")";
$Assocs_Resolved_Obj | Sort-Object -Property FType_Val | Format-Table -AutoSize;
}


# ------------------------------------------------------------

<#   PSCustomObjects   #>
$Var = ( '{"Key1String":"Val1","Key2String":"Val2","Key3Int":3,"Key4Int":4}' | ConvertFrom-JSON );
If (($Var.GetType().Name -Eq "PSCustomObject") -And ($Var.GetType().BaseType.Name -Eq "Object")) {
	Get-Member -InputObject ($Var) -View ("All") `
	| Where-Object { ("$($_.MemberType)".Contains("Propert")) -Eq $True <# Matches *Property* and *Properties* #>; } `
	| ForEach-Object {
		$Each_Key = "$($_.Name)";
		If ($null -eq ($Var.(${Each_Key}))) {
			$Each_Val="`$Null";
		} Else {
			$Each_Val=$Var.(${Each_Key});
		}
		Write-Host "------------------------------";
		Write-Host "Each_Key=$($Each_Key)  ///  Each_Val=$($Each_Val)";
	};
}


#
# ForEach file in folder
#   |--> Install multiple .NET Core/Framework SDKs as a batch job
#        (Downloaded from https://dotnet.microsoft.com/download/visual-studio-sdks)
#
Get-ChildItem -Path ("${Home}\Downloads\ASP.NET-SDKs\*.msi") -File -Recurse -Force -ErrorAction "SilentlyContinue" `
| ForEach-Object { Start-Process -Filepath ($_.FullName) -ArgumentList (@("/q","/norestart")); };


# ------------------------------------------------------------

# ForEach-Object using '.Keys' method to walk through an object by iterating through its property-names

# Hash Table '.Keys' ForEach-Object loop  -  Example #1
If ($True) {
	$WriteHost_SplatParams = @{};
	$WriteHost_SplatParams.("Object")=("`nParameter splatting demo - Passing parameters to the [ Write-Host ] command`n");
	$WriteHost_SplatParams.("ForegroundColor")=("Yellow");
	$WriteHost_SplatParams.("BackgroundColor")=("Magenta");
	$WriteHost_SplatParams_AsString = (
		($WriteHost_SplatParams.Keys | ForEach-Object {
			Write-Output "-$(${_})";
			Write-Output "`"$(${WriteHost_SplatParams}[${_}])`"";
		}) -replace "`n","``n" -join " "
	);
	Write-Host "Calling [ Write-Host ${WriteHost_SplatParams_AsString}; ]...";
	Write-Host @WriteHost_SplatParams;
}


# Hash Table '.Keys' ForEach-Object loop  -  Example #2
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
#   ridicurious.com  |  "Deep Dive: PowerShell Loops and Iterations | RidiCurious.com"  |  https://ridicurious.com/2019/10/10/powershell-loops-and-iterations/
#
#   social.technet.microsoft.com  |  "sort-object multiple properties - use descending first RRS feed"  |  https://social.technet.microsoft.com/Forums/windowsserver/en-US/e2067689-d28b-4455-9a05-d933e31ab311/sortobject-multiple-properties-use-descending-first?forum=winserverpowershell
#
#   stackoverflow.com  |  "Variables in nested Foreach-Object and Where-Object"  |  https://stackoverflow.com/a/26715697
#
#   superuser.com  |  "Powershell to delete all files with a certain file extension"  |  https://superuser.com/a/1233722
#
# ------------------------------------------------------------