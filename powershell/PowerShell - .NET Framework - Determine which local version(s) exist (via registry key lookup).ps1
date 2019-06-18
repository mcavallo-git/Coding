# Query the registry to check for installed versions of .NET Framework (4.5 and higher)

$final_output = @{}; $i=0;

$hashTable = @{};
$hashTable[378389] = '4.5';
$hashTable[378675] = '4.5.1';
$hashTable[379893] = '4.5.2';
$hashTable[393295] = '4.6';
$hashTable[394254] = '4.6.1';
$hashTable[394802] = '4.6.2';
$hashTable[460798] = '4.7';
$hashTable[461308] = '4.7.1';
$hashTable[461808] = '4.7.2';
$hashTable[528040] = '4.8.0';

$final_output[$i++] = "";
$final_output[$i++] = " Installed?  |  .NET Framework";
$final_output[$i++] = "- - - - - - - - - - - - - - - - - -";
foreach($key in $hashTable.Keys | sort) {
	$is_compatible = Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full\' | Get-ItemPropertyValue -Name Release | Foreach-Object { $_ -ge $key };
	$isOn = (&{If($is_compatible) {"True "} Else {"False"}});
	$final_output[$i++] = "      $isOn  |  $(${hashTable}[${key}])";
}
$final_output[$i++] = "";

foreach($key in $($final_output.Keys | sort)) {
	Write-Host "$(${final_output}[${key}])";
}

Start-Sleep 60;

#
#	Citation(s)
#
#	docs.microsoft.com  |  How to: Determine which .NET Framework versions are installed  |  https://docs.microsoft.com/en-us/dotnet/framework/migration-guide/how-to-determine-which-versions-are-installed#ps_a
#
#