
# Download & Install .NET Core Updated Version(s) from:
# https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install


# Check if dotnet's Runtime (dotnet.dll) is installed (get version if-so):
(Get-ChildItem -Path (Get-Command dotnet).Path.Replace('dotnet.exe', 'shared\Microsoft.NETCore.App')).Name;
	$DownloadUrl_dotnetRuntime = "https://dotnet.microsoft.com/download/thank-you/dotnet-runtime-2.1.9-windows-x64-installer";

# Check if dotnet's SDK is installed (get version if-so):
(Get-ChildItem -Path (Get-Command dotnet).Path.Replace('dotnet.exe', 'sdk')).Name;
	$DownloadUrl_dotnetSDK = "https://dotnet.microsoft.com/download/thank-you/dotnet-sdk-2.1.505-windows-x64-installer";





# Check [ dotnet ] directly, via --info command
dotnet --info;
$DotNet_InfoVersion = ((dotnet --info)[1]).Replace(' Version:   ',''); $DotNet_InfoVersion;



# Perform an in-depth, extra thorough search for any installs
$AppName_MatchesAllOf = @();
$AppName_MatchesAllOf += "Microsoft ";
$AppName_MatchesAllOf += ".NET Core";

$AppName_Filter = (("Name LIKE '%")+($AppName_MatchesAllOf -Join ("%"))+"%'");

$DotNetCoreApps = (Get-WmiObject -Class Win32_Product -Filter $AppName_Filter);

$DotNetCoreApps | Sort-Object Name | Format-Table Name;



#### App.Uninstall() Non-functional on domain-attached workstation running as local admin (2019-03-20 16:47:22)
# ForEach ($EachApp In ($DotNetCoreApps)) {
	# Write-Host (("Uninstalling Application [ ")+($EachApp.Name)+(" ]"));
	# $EachApp.Uninstall();
# }


# ---------------------------------------------------------------------------------------------------------------------- #
#
# Citation(s)
#
#		docs.microsoft.com, "Get-WmiObject"
#			https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-wmiobject?view=powershell-5.1
#
