#!/bin/bash

# ------------------------------------------------------------
# Setting up Dell EMC OMSA for ESXi host management
# ------------------------------------------------------------

#
# Step 1 --> Install the Dell OMSA backend package onto target ESXi host, then RESTART the ESXi host (required)
#
#   Name:  Dell EMC OpenManage Server Administrator vSphere Installation Bundle (VIB) for ESXi 6.5 U3, v9.4.0
#   URL:   https://dl.dell.com/FOLDER05993176M/1/OM-SrvAdmin-Dell-Web-9.4.0-3776.VIB-ESX65i_A00.zip
#


#
# Step 2 --> Install & run the Dell OMSA software as a service in Windows, then connect to it via its browser-based GUI
#
#   Name:  Dell EMC OpenManage Server Administrator Managed Node for Windows, v9.4.0
#   URL:   https://dl.dell.com/FOLDER06019899M/1/OM-SrvAdmin-Dell-Web-WINX64-9.4.0-3787_A00.exe
#
#   Install by running file "SysMgmtx64.msi" @ [DOWNLOAD]\OpenManage\windows\SystemsManagementx64\
#
#   Open browser to localhost on port 1311 
#

#
# Step 3 --> Adding TLS Certificate to Dell OMSA
#
#   Follow the steps given by @ https://www.dell.com/community/Systems-Management-General/replacing-the-SSL-certificate-in-Dell-OMSA-7-2/m-p/4031998/highlight/true#M16590
#


# ------------------------------------------------------------
# Troubleshooting issues pertaining to the Dell EMC OMSA software/servicece
# ------------------------------------------------------------

#
# Verify that the Windows service is running
#  |--> Run the following command in via PowerShell to show the status of the Dell EMC OMSA service
#
Get-Service | Where-Object { ($_.Name -Eq "Server Administrator") -Or ( $_.DisplayName -Eq "DSM SA Connection Service" ) } | Format-List;


#
# Add a firewall rule for the Dell EMC OMSA Service
#  |--> Run the following command in via PowerShell to show the status of the Dell EMC OMSA service
#
New-NetFirewallRule -DisplayName "Dell OMSA (TCP 1311)" -Description "Dell EMC OpenManage Server Administrator (OMSA) - Allow Inbound TCP Traffic on Port(s) 1311" -Direction Inbound -Action Allow -EdgeTraversalPolicy Allow -Protocol TCP -LocalPort 1311; <# Create a firewall rule to allow 1311 (Dell EMC OMSA) through #>
netsh advfirewall firewall add rule name="My Application" dir=in action=allow program="C:\MyApp\MyApp.exe" enable=yes remoteip=157.60.0.1,172.16.0.0/16,LocalSubnet profile=domain

# ------------------------------------------------------------
#
# Citation(s)
#
#   www.dell.com  |  "Re: replacing the SSL certificate in Dell OMSA 7.2 - Dell Community"  |  https://www.dell.com/community/Systems-Management-General/replacing-the-SSL-certificate-in-Dell-OMSA-7-2/m-p/4031998/highlight/true#M16590
#
#   www.dell.com  |  "Support for PowerEdge R720 | Drivers & Downloads | Dell US"  |  https://www.dell.com/support/home/us/en/19/product-support/product/poweredge-r720/drivers
#
#   docs.microsoft.com  |  "New-NetFirewallRule - Creates a new inbound or outbound firewall rule and adds the rule to the target computer"  |  https://docs.microsoft.com/en-us/powershell/module/netsecurity/new-netfirewallrule
#
# ------------------------------------------------------------