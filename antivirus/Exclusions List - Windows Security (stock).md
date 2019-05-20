

# Windows Security
### Exclusion List

***
## PowerShell - Auto-Exclusions Script
###### Add paths (files/folders) to the exclusion list
###### Note: !!! Requires elevated permissions (run powershell as admin and paste code into terminal) !!!
```Refer to "PowerShell - Add-MpPreference ... .ps1"```

***
## View Exclusion List
###### Manually inspect/add-to the exclusion list, directly
* In Windows 10, perform a start menu search for ```Virus & threat protection``` & open the respective settings page
* Under ```Virus & threat protection settings``` select ```Manage settings```
* Under ```Exclusions``` select ```Add or remove exclusions```
* Iteratively select ```Add an exclusion``` (dropdown), select the desired exclusion-type (file, folder, file-type, or process), and then input the associated  exclusion-path

***
## Citation(s)
[docs.microsoft.com - "Configure and validate exclusions based on file extension and folder location"](https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-defender-antivirus/configure-extension-file-exclusions-windows-defender-antivirus)
