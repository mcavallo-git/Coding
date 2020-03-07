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
#
# Citation(s)
#
#   www.dell.com  |  "Re: replacing the SSL certificate in Dell OMSA 7.2 - Dell Community"  |  https://www.dell.com/community/Systems-Management-General/replacing-the-SSL-certificate-in-Dell-OMSA-7-2/m-p/4031998/highlight/true#M16590
#
#   www.dell.com  |  "Support for PowerEdge R720 | Drivers & Downloads | Dell US"  |  https://www.dell.com/support/home/us/en/19/product-support/product/poweredge-r720/drivers
#
# ------------------------------------------------------------