
# -------------------------------------------------------------
#
# dotnet
#		Installation for Linux (specifically Ubuntu 16.04)
#
# -------------------------------------------------------------

# Register Microsoft key and feed

wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb

# Install the .NET SDK

sudo apt install -y apt-transport-https;

sudo apt update -y;

sudo apt install -y dotnet-sdk-2.2;

# -------------------------------------------------------------
#
# Citation(s)
#
#		dotnet.microsoft.com
#			"Install .NET Core SDK on Linux Ubuntu 16.04 - x64"
#			 https://dotnet.microsoft.com/download/linux-package-manager/ubuntu16-04/sdk-current
#
