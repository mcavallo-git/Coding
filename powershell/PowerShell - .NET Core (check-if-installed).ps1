
# Using Powershell:


# Check .NET Core Runtime Version (if-installed):
(Get-ChildItem -Path (Get-Command dotnet).Path.Replace('dotnet.exe', 'shared\Microsoft.NETCore.App')).Name


# Check .NET Core SDK Version (if-installed):
(Get-ChildItem -Path (Get-Command dotnet).Path.Replace('dotnet.exe', 'sdk')).Name


# Download & Install .NET Core Updated Version(s) from:
https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/install


# sed '/^a test$/{$!{N;s/^a test\nPlease do not$/not a test\nBe/;ty;P;D;:y}}' alpha.txt
