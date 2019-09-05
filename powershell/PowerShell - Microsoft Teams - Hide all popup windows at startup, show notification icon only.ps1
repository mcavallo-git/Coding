# ------------------------------------------------------------
#
# Microsoft Teams - Hide all popup windows at startup, show notification icon only
#


# ------------------------------------------------------------
#
# STEP 1 - Close all running instance(s) of Microsoft Teams
#

### PERFORM THIS STEP MANUALLY


# ------------------------------------------------------------
#
# STEP 2 - Rename the Microsoft Teams config-file associated with the current user
#           |--> Note: This config-file determines what email address to connect-to in Microsoft's cloud, what window size to display as on the local workstation, etc.
#

Move-Item `
-Path "${Env:APPDATA}\Microsoft\Teams\desktop-config.json" `
-Destination "${Env:APPDATA}\Microsoft\Teams\desktop-config.json.renamed";


# ------------------------------------------------------------
#
# STEP 3 - Reboot the Workstation
#

### PERFORM THIS STEP MANUALLY


# ------------------------------------------------------------
#
# STEP 4 - Log back in-to the workstation (with the same user which was used previously) & close Microsoft Teams if it is open
#

### PERFORM THIS STEP MANUALLY


# ------------------------------------------------------------
#
# STEP 5 - Remove the newly created JSON config-file & replace it with the old JSON config-file
#

Remove-Item `
-Path "${Env:APPDATA}\Microsoft\Teams\desktop-config.json";

Move-Item `
-Path "${Env:APPDATA}\Microsoft\Teams\desktop-config.json.renamed" `
-Destination "${Env:APPDATA}\Microsoft\Teams\desktop-config.json";


# ------------------------------------------------------------