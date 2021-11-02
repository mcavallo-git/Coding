
# -------------------------------------------------------------
#
# Linux - Installation of dotnet on Linux (specifically Ubuntu 16.04)
#
# -------------------------------------------------------------

# Register Microsoft key and feed

wget -q https://packages.microsoft.com/config/ubuntu/16.04/packages-microsoft-prod.deb

sudo dpkg -i packages-microsoft-prod.deb

# Install the .NET SDK

sudo apt install -y apt-transport-https;

sudo apt update -y;

sudo apt install -y dotnet-sdk-2.2;


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Install .NET on Linux Distributions | Microsoft Docs"  |  https://docs.microsoft.com/en-us/dotnet/core/install/linux
#
# ------------------------------------------------------------