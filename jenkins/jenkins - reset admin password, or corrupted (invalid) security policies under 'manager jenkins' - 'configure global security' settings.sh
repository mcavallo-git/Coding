#!/bin/bash
# ------------------------------------------------------------
#
# Please be aware of how to reset access to Jenkins in-case the LDAP auth fails and it is the only available method to verify users.
#           |
#           |--> One simple approach is to lock any form of access to the Jenkins server except your own, then ssh into the server (or open the folder if running via Windows) and edit file "config.xml" in Jenkins' home directory. locate variable "useSecurity" and set it to "false" - after youve made this change, open jenkins disable LDAP, then re-enable "useSecurity" by setting it to "true", and lastly, re-enable external access to the Jenkins server (if originally activated before this quick walkthough)
#
# ------------------------------------------------------------