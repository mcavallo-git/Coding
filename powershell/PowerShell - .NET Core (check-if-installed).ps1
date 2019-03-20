
# Using Powershell:


# Check .NET Core Runtime Version (if-installed):
(Get-ChildItem -Path (Get-Command dotnet).Path.Replace('dotnet.exe', 'shared\Microsoft.NETCore.App')).Name;
(Get-ChildItem -Path (Get-Command dotnet).Path.Replace('dotnet.exe', 'sdk')).Name;



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

# Download & Install .NET Core Updated Version(s) from:
# https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install

