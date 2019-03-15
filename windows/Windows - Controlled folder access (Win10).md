# Windows Controlled folder access
#### Blocks access to any apps which aren't whitelisted (on the 'exclusion list') from accessing items found within the user directory



***
### General Issue
Programs are unable to access the user's documents, pictures, etc. because they're blocked by Controlled folder access

### Specific Issue
Cryptomator throwing 'Cannot Open Storage, see log file for details' (or very similar) error whilst attempting to unlock vaults found within the user directory



***
### General Solution
Add a Controlled folder access exclusion for the software being blocked

### Specific Solution
Add Cryptomator.exe to Controlled folder access' exclusions list



***
### Detailed Walkthrough
* Perform a start-menu search for "Ransomware protection", then clicking it to open its settings page
* Select "Allow an app through Controlled folder access"
* Select "+ Add an allowed app", then "Browse all apps"
* Browse to ```%ProgramFiles%\Cryptomator``` and double click ```Cryptomator.exe``` to add it to Controlled folder access' exclusions list
