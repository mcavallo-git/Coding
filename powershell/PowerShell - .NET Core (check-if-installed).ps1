# Using Powershell:

# Check .NET Core Runtime Version (if-installed):
(dir (Get-Command dotnet).Path.Replace('dotnet.exe', 'shared\Microsoft.NETCore.App')).Name

# Check .NET Core SDK Version (if-installed):
(dir (Get-Command dotnet).Path.Replace('dotnet.exe', 'sdk')).Name
