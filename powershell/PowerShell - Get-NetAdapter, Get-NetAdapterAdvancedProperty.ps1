
# Attempt to determine the drivers being used for a given device, then force those drivers back from whence they came (uninstall em)

Get-NetAdapter

Get-NetAdapterAdvancedProperty


# ------------------------------------------------------------
#
# Citation(s)
#
#   docs.microsoft.com  |  "Get-NetAdapter"  |  https://docs.microsoft.com/en-us/powershell/module/netadapter/get-netadapter?view=win10-ps
#
#   docs.microsoft.com  |  "Get-NetAdapterAdvancedProperty"  |  https://docs.microsoft.com/en-us/powershell/module/netadapter/get-netadapteradvancedproperty?view=win10-ps
#
# ------------------------------------------------------------