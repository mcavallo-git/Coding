#
# ipamserver (Windows Feature)
#		|
#		|--> This Feature is included with Windows Server instances, by default
#		|
#		|--> For Windows 10 users, you must install "Remote Server Administration Tools for Windows 10"
#		|--> from the url" https://www.microsoft.com/en-us/download/details.aspx?id=45520
#					|
#					|--> If you dont know which exe to download & install, refer to your current version of Windows by going to:
#									"System Settings"
#										|->"About your pc"
#													|-> "Version" <-- Ignore any numbers after the first period
#													|-> "System type" <-- x86 or x64 processor/os architecture
#																^-- Look for a downloadable exe from aforementioned URL matching both your "Version" and "System type"
#

# Get-IpamAddress -AddressFamily IPv4 -AddressCategory Private -AddressSpace "Default"