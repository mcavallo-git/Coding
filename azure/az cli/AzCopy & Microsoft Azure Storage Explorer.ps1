# ------------------------------------------------------------
#
# Microsoft Azure Migration Tools
#  |
#  |--> Microsoft Azure Storage Explorer (GUI)
#  |     |
#  |     |--> Download (Storage Explorer):  https://go.microsoft.com/fwlink/?LinkId=708343
#  |     |
#  |     |--> HypeNote: AzCopy is actually embedded into this excellent application, side-note - select Dark-Mode (FTW)
#  |
#  |--> AzCopy (CLI)
#        |
#        |--> Pre-Req - Azure PowerShell (CLI) - Download:  https://aka.ms/installazurecliwindows
#        |
#        |--> Download (AzCopy):  https://aka.ms/downloadazcopy-v10-windows
#
#
# ------------------------------------------------------------
#
# !!!  WARNING  !!!
#       |
#       |-->  Azure charges ~ 5-10 cents USD for every gigabyte of egress data which leaves a given Region/Zone
#       |
#       |-->  A charge CAN STILL BE INCURRED even when data is transferred between Azure Storage Accounts (especially in cross-Region scenarios)
#       |----> Make sure to contact Microsoft Azure's cloud-support team directly to discuss any planned/upcoming data migrations
#       |------> Depending on your scenario, they may even waive some (or most) of the accumulated ingress/egress bandwidth charges
#
#
# ------------------------------------------------------------
#
# Storage Explorer
#  |
#  |--> GUI-based Desktop Application for managing Microsoft Azure Storage Accounts
#  |
#  |--> Connect to target Azure Storage Account
#  |       Open "Microsoft Azure Storage Explorer"
#  |        > Right-click "Storage Accounts"
#  |         > Click "Connect to Azure storage..."
#  |          > Choose one of the 6 methods of connecting to your target Azure-storage
#  |             |
#  |             |-> 1) If you want to connect by logging in with your Microsoft account:
#  |             |       |--> Select "Add an Azure Account"
#  |             |       |---> Select desired "Azure environment" to log-into (such as "Azure US Government")
#  |             |       |----> Enter necessary credential(s) & connect to your Azure storage account
#  |             |
#  |             |-> 2) If you want to connect by using a Connection String...
#  |                     |--> Select "Use a connection string"
#  |                     |----> Enter necessary credential(s) & connect to your Azure storage account
#  |
#  |--> Add a "SAS" Access Credential (Temporary & scoped both with respect to decay duration & permissions allotted)
#          Open "Microsoft Azure Storage Explorer"
#           > Open a given Storage Account
#            > Open a container (one level under the Account)
#             > Open 'Blob Containers' within the target container
#              > Right click a target Container and select "Get Shared Access Signature..." from the dropdown options
#               > Set the credential to expire as soon as possible (it will default to 1-day from time of creation)
#                > Copy the full URL given (Container-path + SAS) and use it directly with one or more AzCopy command(s)
#                    -- OR --
#                > Copy the SAS Query-String and use it in the below command(s) for a quick demo of how to use the application
#
# ------------------------------------------------------------
#
# AzCopy
#  |
#  |--> Azure CLI Tool which allows for simplified relocation of Azure Storage Account data EN-MASSE
#  |
#  |--> Can even copy blob-storage containers with VM disks in them to/from/between Azure Storage Accounts (including Cross-Region/Zone)
#

<# Copy a given directory (and all subdirectories) from Azure blob-storage to local Desktop #>
$SAS_QueryString = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt "AzCopy (Pull) --> Enter [ Shared Access Signature (SAS Query string, no question mark) ]")))).Trim();

$URL_WithoutSAS = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt "AzCopy (Pull) --> Enter [ Target URL with no SAS Query String attached (e.g. it should start with https and end just before the '?' in the request-uri) ]")))).Trim();

azcopy cp "${URL_WithoutSAS}?${SAS_QueryString}" "${Home}\Desktop" --recursive=true


<# Benchmark the remote Azure blob-storage #>
$SAS_QueryString = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt "AzCopy (Fetch) --> Enter [ Shared Access Signature (SAS Query string, no question mark) ]")))).Trim();

$URL_WithoutSAS = ([System.Runtime.InteropServices.Marshal]::PtrToStringUni([System.Runtime.InteropServices.Marshal]::SecureStringToCoTaskMemUnicode($(Read-Host -AsSecureString -Prompt "AzCopy (Fetch) --> Enter [ Target URL with no SAS Query String attached (e.g. it should start with https and end just before the '?' in the request-uri) ]")))).Trim();

### Note: Azure charges about $0.10 USD per gigabyte going out of a target Azure zone (egress), be wary about this when benchmarking
azcopy bench "${URL_WithoutSAS}?${SAS_QueryString}" --file-count 5 --size-per-file 2G


#
#
# OPTIMIZE VIA  [ azcopy copy ... --overwrite ifSourceNewer ]
#   |--> "To accomplish this, use the azcopy copy command instead, and set the --overwrite flag to ifSourceNewer. AzCopy will compare files as they are copied without performing any up-front scans and comparisons. This provides a performance edge in cases where there are a large number of files to compare." https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-configure#optimize-file-synchronization
#
#
# REVIEW VIA  [ azcopy jobs list ]
#   |--> "Each transfer operation will create an AzCopy job. Use the following command to view the history of jobs" ( View and resume jobs, https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-configure#view-and-resume-jobs )
#
#
# TROUBLESHOOT VIA ...
#   [ azcopy ... --log-level DEBUG  ]  (max verbosity, other options are NONE|DEBUG|INFO|WARNING|ERROR|PANIC|FATAL)
#   [ azcopy jobs show <job-id>                                    ]  <-- To view the job statistics, use the following command
#   [ azcopy jobs show <job-id> --with-status=Failed               ]  <-- To filter the transfers by status, use the following command
#   [ azcopy jobs resume <job-id> --source-sas="<sas-token>"       ]  <-- To resume a failed/canceled job (w/ inline source access-key)
#   [ azcopy jobs resume <job-id> --destination-sas="<sas-token>"  ]  <-- To resume a failed/canceled job (w/ inline destination access-key)
#
#
# REVIEW LOGS FOR ERRORS VIA ...
#  |
#  |    (PowerShell)
#  |--> Select-String UPLOADFAILED .\04dc9ca9-158f-7945-5933-564021086c79.log
#  |
#  |    (ShellScript)
#  |--> grep UPLOADFAILED .\04dc9ca9-158f-7945-5933-564021086c79.log
#
#
#------------------------------------------------------------
#
# From [ a Microsoft Employee ]:
#
# "
#   Really the best way to avoid having to move them 1 by 1 is to leverage AzCopy:
#
#   Here’s az copy:
#   https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-v10
#
#   Here’s the data on using it to copy from one storage account to another:
#   https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-blobs#copy-blobs-between-storage-accounts
#
#   Here’s documentation on how to optimize the throughput of AzCopy:
#   https://docs.microsoft.com/en-us/azure/storage/common/storage-use-azcopy-configure#optimize-throughput
#
#   using the above, you could write a script to move blobs a container at a time to stage out the process if needed.  
#
#   I do also have the storage team looking into options for helping you with moving your larger customers. I will continue to work with them on options.
#
#   My concern with writing a utility to move each blob one at a time is going to be a slow operation especially for your larger customers.
#
#   Thanks,
#   (Signature)
# "
#
#
# ------------------------------------------------------------
#
# Estimated Bandwidths
#
# Reference 0 - ACTUAL (benchmarked) -->  426.436 Mbps throughput  <-- (benchmark quoted an incorrect value of '472.6492 Mbps' )
#    Elapsed Time (Minutes): 3.2684
#    Total Number Of Transfers: 5
#    TotalBytesTransferred: 10737418240
#     ^--> Results from running  [ azcopy bench ]  targeting blob-storage in Azure's Iowa GovCloud on 11-Feb-2020 @ ~ 09:00 PM CST
#    ( 5-files ) * ( 2 GB/file ) * ( 1024 MB/GB ) * ( 8 Bits/Byte ) * ( 1/192.104-seconds ) = 426.436 Mbps
#
# Reference 1 --> 200-500 Mbps throughput
#    (Simialr to previous reference, second-hand information from a trusted source)
#
#
# Reference 2 --> 480 Mbps for multiple 80 GB files
#    Note: user reccommends --parallel-level w/ 15 GB chunks, and states that azcopy runs 'up to 8 threads per processor'
#    "Where are your files located to start with and the blob storage? I can use azcopy to move 80GB files at the average speed of 60MB/s between US East2 (source file location on a linux box) and US East (blob storage location . I'm not sure I would get such good performances across regions. There are recommendations about splitting big files in smaller chunks to use parallelism in transfer, but the value I did see in the docs was 15GB chunks (and the doc was talking about a 200+GB file). I would suggest you split your 1TB in like 50GB chunks first then give it another try. For the parallelism, the number of concurrent operations is equal eight times the number of processors you have. If you are running AzCopy across a low-bandwidth network, you can specify a lower number for --parallel-level to avoid failure caused by resource competition."  |  https://www.reddit.com/r/AZURE/comments/a7tx5y/azure_azcopy_linux/een94i7/
#
#
# Reference 3 --> 2667 Mbps for a 120 GB file
#    120GB/6min ~ 20GB/min = 0.3333GBps = 333MBps = ... (next line) = 2667 Mbps  |  https://www.reddit.com/r/AZURE/comments/ajeppa/extremely_slow_azure_blob_upload/eexvhbq/
#
#
# ------------------------------------------------------------
#
# Citation(s)
#
#   azure.microsoft.com  |  "Pricing - Bandwidth | Microsoft Azure"  |  https://azure.microsoft.com/en-us/pricing/details/bandwidth/
#
#   docs.microsoft.com  |  "Install the Azure CLI for Windows | Microsoft Docs"  |  https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest
#
#   docs.microsoft.com  |  "Microsoft Azure Documentation | Microsoft Docs"  |  https://docs.microsoft.com/en-us/azure/#pivot=sdkstools&panel=sdkstools-all
#
#   stackoverflow.com  |  "PowerShell - Decode System.Security.SecureString to readable password - Stack Overflow"  |  https://stackoverflow.com/a/7469473
#
# ------------------------------------------------------------